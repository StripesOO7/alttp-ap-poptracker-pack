ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", keyDropLayoutChange)
ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", bossShuffle)
-- ScriptHost:AddWatchForCode("ow_dungeon details handler", "ow_dungeon_details", owDungeonDetails)


alttp_location = {}
alttp_location.__index = alttp_location

local accessLVL= {
    [0] = "none",
    [1] = "partial",
    [3] = "inspect",
    [5] = "sequence break",
    [6] = "normal",
    [7] = "cleared"
}

-- Table to store named locations
NAMED_LOCATIONS = {}
local stale = true
local accessibilityCache = {}
local accessibilityCacheComplete = false
local currentParent = nil
local currentLocation = nil
local indirectConnections = {}


-- 
function CanReach(name)
    local location
    if stale then
        stale = false
        accessibilityCacheComplete = false
        accessibilityCache = {}
        indirectConnections = {}
        while not accessibilityCacheComplete do
            accessibilityCacheComplete = true
            entry_point:discover(AccessibilityLevel.Normal, 0)
            for dst, parents in pairs(indirectConnections) do
                if dst:accessibility() < AccessibilityLevel.Normal then
                    for parent, src in pairs(parents) do
                        -- print("Checking indirect " .. src.name .. " for " .. parent.name .. " -> " .. dst.name)
                        parent:discover(parent:accessibility(), parent.keys)
                    end
                end
            end
        end
        --entry_point:discover(AccessibilityLevel.Normal, 0) -- since there is no code to track indirect connections, we run it twice here
        --entry_point:discover(AccessibilityLevel.Normal, 0)
    end
    -- if type(region_name) == "function" then
    --     location = self
    -- else
    if type(name) == "table" then
        -- print(name.name)
        location = NAMED_LOCATIONS[name.name]
    else 
        location = NAMED_LOCATIONS[name]
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
function alttp_location.new(name, shortname, outside)
    if shortname == nil then
        shortname = name
    end
    if outside == nil then
        outside = true
    end
    local self = setmetatable({}, alttp_location)
    if name then
        NAMED_LOCATIONS[name] = self
        self.name = name
        self.shortname = shortname
    else
        self.name = self
        self.shortname = shortname
    end
    
    self.exits = {}
    self.keys = math.huge
    if outside ~= nil then
        if outside then
            self.side = true --outside
        else
            self.side = true --inside
        end
    end
    return self
end

local function always()
    return AccessibilityLevel.Normal
end

-- markes a 1-way connections between 2 "locations/regions" in the source "locations" exit-table with rules if provided
function alttp_location:connect_one_way(exit, rule)
    if type(exit) == "string" then
        local existing = NAMED_LOCATIONS[exit]
        if existing then
            print("Warning: " .. exit .. " defined multiple times")  -- not sure if it's worth fixing in data or simply allowing this
            exit = existing
        else
            exit = alttp_location.new(exit)
        end
    end
    if rule == nil then
        rule = always
    end
    self.exits[#self.exits + 1] = { exit, rule }
end

-- markes a 2-way connection between 2 locations. acts as a shortcut for 2 connect_one_way-calls 
function alttp_location:connect_two_ways(exit, rule)
    -- print(exit.name, self.name)
    self:connect_one_way(exit, rule)
    exit:connect_one_way(self, rule)
end

-- creates a 1-way connection from a region/location to another one via a 1-way connector like a ledge, hole,
-- self-closing door, 1-way teleport, ...
function alttp_location:connect_one_way_entrance(name, exit, rule)
    if rule == nil then
        rule = always
    end
    -- print(name, "wann wird das aufgerufen?", exit.name)
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
    -- only executed when run from a rules within a connection
    if currentLocation ~= nil and currentParent ~= nil then
        if indirectConnections[currentLocation] == nil then
            indirectConnections[currentLocation] = {}
        end
        indirectConnections[currentLocation][currentParent] = self
    end
    -- up to here
    local res = accessibilityCache[self] -- get accessibilty lvl set in discover for a given location
    if res == nil then
        res = AccessibilityLevel.None
        accessibilityCache[self] = res
    end
    return res
end

-- 
function alttp_location:discover(accessibility, keys)
    -- checks if given Accessbibility is higer then last stored one
    -- prevents walking in circles
    if accessibility > self:accessibility() then
        self.keys = math.huge -- resets keys used up to this point
        accessibilityCache[self] = accessibility
        accessibilityCacheComplete = false -- forces CanReach tu run again/further
    end
    if keys < self.keys then
        self.keys = keys -- sets current amout of keys used
    end

    if accessibility > 0 then -- if parent-location was accessible
        for _, exit in pairs(self.exits) do -- iterate over current watched locations exits
            local location
            -- print("name:", exit[1].name)
            -- print("self:", self.name)
            -- print(string.sub(exit[1].name, -7,-1), string.sub(exit[1].name, -8,-1))
            -- print("er_tracking", Tracker:FindObjectForCode("er_tracking"),
            -- local er_setting_stage
            -- er_setting_stage = Tracker:FindObjectForCode("er_tracking").CurrentStage
            local er_check = {
                    [0] = function() return false end,
                    [1] = function() print("simple ER", ER_SIMPLE[self.name] ~= nil) return ER_SIMPLE[self.name] ~= nil end,
                    [2] = function() print("full ER", NAMED_ENTRANCES[self.name] ~= nil) return NAMED_ENTRANCES[self.name] ~= nil end,
                    [3] = function() print("!!!!!!!!!!!!!!!!!! YOU ABSOLUTELY SHOUlD NOT BE ABLE TO SEE THIS!!!!!!!!!!!!!!!!")return INSANITY_ENTRANCES[self.name] ~= nil end
                }



            if (string.sub(exit[1].name, -7,-1) == "_inside" and string.sub(self.name, -8,-1) == "_outside") or (string.sub(self.name, -7,-1) == "_inside" and string.sub(exit[1].name, -8,-1) == "_outside") then
                local temp
                local er_setting_stage
                er_setting_stage = Tracker:FindObjectForCode("er_tracking").CurrentStage
                if er_check[er_setting_stage]() then -- simple ER
                    temp = Tracker:FindObjectForCode(self.name)
                    print(self.name, "to er_simple[self.name]: -->", ER_SIMPLE[self.name])
                    -- print("############ entering simple ER ############")
                    -- print(NAMED_LOCATIONS[temp.ItemState.Target])
                    if temp ~= nil then
                        location = NAMED_LOCATIONS[temp.ItemState.Target]
                    else
                        print("exit connection is fucket")
                        return
                    end
                end
                if location == nil and er_check[er_setting_stage]() then
                    location = empty_location
                end
            end

            if location == nil then
                location = exit[1] -- exit name
            end
            if location == nil then
                print("location retrieval is fucked")
                location = empty_location
                -- return
            end
            -- print(location)
            local oldAccess = location:accessibility() -- get most recent accessibilty level for exit
            local oldKey = location.keys or 0
            if oldAccess < accessibility then -- if new accessibility from above is higher then currently stored one, so is more accessible then before
                local rule = exit[2] -- get rules to check

                currentParent, currentLocation = self, location -- just set for ":accessibilty()" check within rules
                local access, key = rule(keys)
                local parent_access = currentParent:accessibility()
                if type(access) == "boolean" then
                    access = A(access)
                end
                if access > parent_access then
                    access = parent_access
                end
                currentParent, currentLocation = nil, nil -- just set for ":accessibilty()" check within rules

                -- print(access)
                if access == 5 then
                    access = AccessibilityLevel.SequenceBreak
                elseif access == 3 then
                    access = AccessibilityLevel.Inspect
                elseif access == true then
                    access = AccessibilityLevel.Normal
                elseif access == false then
                    access = AccessibilityLevel.None
                end
                if access == nil then
                    print("Warning: " .. self.name .. " -> " .. location.name .. " rule returned nil")
                    access = AccessibilityLevel.None
                end
                if key == nil then
                    key = keys
                end
                if access > oldAccess or (access == oldAccess and key < oldKey) then -- not sure about the <
                    print(self.name) 
                    print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access])
                    location:discover(access, key)
                end
            end
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
    stale = true
    -- require("scripts/logic/logic_helpers")
    -- require("scripts/logic/logic_main")
    -- require("scripts/logic_import")
end

function forceUpdate()
    local update = Tracker:FindObjectForCode("AP_item")
    update.Active = not update.Active
end

function emptyLocationTargets()
    local er_tracking = Tracker:FindObjectForCode("er_tracking")
    print(er_tracking.CurrentStage)
    if er_tracking.CurrentStage == 0 then
        print("run discorver")
        entry_point:discover(AccessibilityLevel.Normal, 0)
        print("finshed discover")
    elseif er_tracking.CurrentStage == 1 then
        print("simple er")
        for name, _ in pairs(ER_SIMPLE) do
            -- print(name)
            -- print(Tracker:FindObjectForCode(name).ItemState.Target)
            Tracker:FindObjectForCode(name).ItemState.Target = nil
        end
    elseif er_tracking.CurrentStage == 2 then
        print("full er")
        for name, _ in pairs(NAMED_ENTRANCES) do
            -- print(name)
            -- print(Tracker:FindObjectForCode(name).ItemState.Target)
            Tracker:FindObjectForCode(name).ItemState.Target = nil
        end
    else
        print("insanity ER is not supported you troll")
    end
end

ScriptHost:AddWatchForCode("stateChanged", "*", stateChanged)
ScriptHost:AddWatchForCode("ER_Setting_Changed", "er_tracking", emptyLocationTargets)
ScriptHost:AddOnLocationSectionChangedHandler("location/section_change_handler", forceUpdate)
