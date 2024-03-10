ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", keyDropLayoutChange)
ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", bossShuffle)
-- ScriptHost:AddWatchForCode("ow_dungeon details handler", "ow_dungeon_details", owDungeonDetails)


alttp_location = {}
alttp_location.__index = alttp_location

-- Table to store named locations
named_locations = {}
staleness = 0

function can_reach(name)
    local location
    if type(region_name) == "function" then
        location = self
    else
        location = named_locations[name]
    end
    if location == nil then
        print("Unknown location : " .. name)
        return AccessibilityLevel.None
    end
    return location:accessibility()
end

function alttp_location.new(name)
    local self = setmetatable({}, alttp_location)
    if name then
        named_locations[name] = self
    end
    self.exits = {}
    self.staleness = -1
    self.keys = math.huge
    self.accessibility_level = AccessibilityLevel.None
    return self
end

local function always()
    return AccessibilityLevel.Normal
end

function alttp_location:connect_one_way(exit, rule)
    if type(exit) == "string" then
        exit = alttp_location.new(exit)
    end
    if rule == nil then
        rule = always
    end
    self.exits[#self.exits + 1] = { exit, rule }
end

function alttp_location:connect_two_ways(exit, rule)
    self:connect_one_way(exit, rule)
    exit:connect_one_way(self, rule)
end

function alttp_location:connect_one_way_entrance(name, exit, rule)
    if rule == nil then
        rule = always
    end
    self.exits[#self.exits + 1] = { exit, rule }
end

function alttp_location:connect_two_ways_entrance(name, exit, rule)
    if exit == nil then -- for ER
        return
    end
    self:connect_one_way_entrance(name, exit, rule)
    exit:connect_one_way_entrance(name, self, rule)
end

function alttp_location:connect_two_ways_entrance_door_stuck(name, exit, rule1, rule2)
    self:connect_one_way_entrance(name, exit, rule1)
    exit:connect_one_way_entrance(name, self, rule2)
end

function alttp_location:accessibility()
    if self.staleness < staleness then
        return AccessibilityLevel.None
    else
        return self.accessibility_level
    end
end

function alttp_location:discover(accessibility, keys)
    local change = false
    if accessibility > self:accessibility() then
        change = true
        self.staleness = staleness
        self.accessibility_level = accessibility
        self.keys = math.huge
    end
    if keys < self.keys then
        self.keys = keys
        change = true
    end

    if change then
        for _, exit in pairs(self.exits) do
            local location = exit[1]
            local rule = exit[2]

            local access, key = rule(keys)

            if access == true then
                access = AccessibilityLevel.Normal
            elseif access == false then
                access = AccessibilityLevel.None
            end
            if key == nil then
                key = keys
            end

            location:discover(access, key)
        end
    end
end

entry_point = alttp_location.new()

function stateChanged()
    staleness = staleness + 1
    entry_point:discover(AccessibilityLevel.Normal, 0)
end

ScriptHost:AddWatchForCode("stateChanged", "*", stateChanged)