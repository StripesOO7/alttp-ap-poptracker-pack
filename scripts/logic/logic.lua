ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", keyDropLayoutChange)
ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", bossShuffle)
-- ScriptHost:AddWatchForCode("ow_dungeon details handler", "ow_dungeon_details", owDungeonDetails)


alttp_location = {}
alttp_location.__index = alttp_location

accessLVL= {
    [0] = "none",
    [1] = "partial",
    [3] = "inspect",
    [5] = "sequence break",
    [6] = "normal",
    [7] = "cleared"
}

-- Table to store named locations
named_locations = {}
staleness = 0

-- 
function can_reach(name)
    local location
    -- if type(region_name) == "function" then
    --     location = self
    -- else
    if type(name) == "table" then
        -- print(name.name)
        location = named_locations[name.name]
    else 
        location = named_locations[name]
    end
    -- print(location, name)
    -- end
    if location == nil then
        -- print(location, name)
        if type(name) == "table" then
        else
            print("Unknown location : " .. tostring(name))
        end
        return AccessibilityLevel.None
    end
    return location:accessibility()
end

-- creates a lua object for the given name. it acts as a representation of a overworld reagion or indoor locatoin and
-- tracks its connected objects wvia the exit-table
function alttp_location.new(name)
    local self = setmetatable({}, alttp_location)
    if name then
        named_locations[name] = self
        self.name = name
    else
        self.name = self
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

-- markes a 1-way connections between 2 "locations/regions" in the source "locations" exit-table with rules if provided
function alttp_location:connect_one_way(exit, rule)
    if type(exit) == "string" then
        exit = alttp_location.new(exit)
    end
    if rule == nil then
        rule = always
    end
    self.exits[#self.exits + 1] = { exit, rule }
end

-- markes a 2-way connection between 2 locations. acts as a shortcut for 2 connect_one_way-calls 
function alttp_location:connect_two_ways(exit, rule)
    self:connect_one_way(exit, rule)
    exit:connect_one_way(self, rule)
end

-- creates a 1-way connection from a region/location to another one via a 1-way connector like a ledge, hole,
-- self-closing door, 1-way teleport, ...
function alttp_location:connect_one_way_entrance(name, exit, rule)
    if rule == nil then
        rule = always
    end
    self.exits[#self.exits + 1] = { exit, rule }
end

-- creates a connection between 2 locations that is traversable in both ways using the same rules both ways
-- acts as a shortcut for 2 connect_one_way_entrance-calls
function alttp_location:connect_two_ways_entrance(name, exit, rule)
    if exit == nil then -- for ER
        return
    end
    self:connect_one_way_entrance(name, exit, rule)
    exit:connect_one_way_entrance(name, self, rule)
end

-- creates a connection between 2 locations that is traversable in both ways but each connection follow different rules.
-- acts as a shortcut for 2 connect_one_way_entrance-calls
function alttp_location:connect_two_ways_entrance_door_stuck(name, exit, rule1, rule2)
    self:connect_one_way_entrance(name, exit, rule1)
    exit:connect_one_way_entrance(name, self, rule2)
end

-- checks for the accessibility of a regino/location given its own exit requirements
function alttp_location:accessibility()
    if self.staleness < staleness then
        return AccessibilityLevel.None
    else
        return self.accessibility_level
    end
end

-- 
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
            -- print(access)
            if access == 5 then
                access = AccessibilityLevel.SequenceBreak
            elseif access == true then
                access = AccessibilityLevel.Normal
            elseif access == false then
                access = AccessibilityLevel.None
            end
            if key == nil then
                key = keys
            end
            -- print(self.name) 
            print(accessLVL[self.accessibility_level], "from", self.name, "to", location.name, ":", accessLVL[access])
            location:discover(access, key)
        end
    end
end

entry_point = alttp_location.new("entry_point")
lightworld_spawns = alttp_location.new("lightworld_spawns")
darkworld_spawns = alttp_location.new("darkworld_spawns")

entry_point:connect_one_way(lightworld_spawns, function() return openOrStandard() end)
entry_point:connect_one_way(darkworld_spawns, function() return inverted() end)

-- 
function stateChanged()
    staleness = staleness + 1
    entry_point:discover(AccessibilityLevel.Normal, 0)
end

ScriptHost:AddWatchForCode("stateChanged", "*", stateChanged)