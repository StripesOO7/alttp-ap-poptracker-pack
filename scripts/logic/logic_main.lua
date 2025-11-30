-- ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", KeyDropLayoutChange)
-- ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", BossShuffle)
-- ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
-- ScriptHost:AddWatchForCode("ow_dungeon details handler", "ow_dungeon_details", owDungeonDetails)

alttp_location = {}
alttp_location.__index = alttp_location

local accessLVL= {
    [0] = "none",
    [1] = "partial",
    [3] = "inspect",
    [5] = "sequence break",
    [6] = "normal",
    [7] = "cleared",
    [false] = "none",
    [true] = "normal",
}

-- Table to store named locations
local ER_STATE = false
ER_STAGE = 0
NAMED_LOCATIONS = {}
NAMED_LOCATIONS_KEYS = {}
ENTRANCE_MAPPING = {} -- structure --> ENTRANCE_MAPPING[<roomnumber>][<x-coord>][<y-coord>] = location name
local stale = true
local accessibilityCache = {}
local accessibilityCacheComplete = false
local currentParent = nil
local currentLocation = nil
local indirectConnections = {}

function Table_insert_at(er_table, key, value)
    if er_table[key] == nil then
        er_table[key] = {}
    end
    table.insert(er_table[key], value)
end

--
function CanReach(name)
    -- if type(name) == "table" then
    --     -- print("-----------")
    --     -- print("start CanREach for", name.name)
    -- -- else
    --     -- print("start CanREach for", name)
    -- end
    local location
    if stale then
        stale = false
        accessibilityCacheComplete = false
        accessibilityCache = {}
        indirectConnections = {}
        while not accessibilityCacheComplete do
            accessibilityCacheComplete = true
            entry_point:discover(ACCESS_NORMAL, 0, nil)
            for dst, parents in pairs(indirectConnections) do
                if dst:accessibility() < ACCESS_NORMAL then
                    for parent, src in pairs(parents) do
                        -- print("Checking indirect " .. src.name .. " for " .. parent.name .. " -> " .. dst.name)
                        parent:discover(parent:accessibility(), parent.keys, parent.worldstate)
                    end
                end
            end
        end
        --entry_point:discover(ACCESS_NORMAL, 0) -- since there is no code to track indirect connections, we run it twice here
        --entry_point:discover(ACCESS_NORMAL, 0)
    end
    -- if type(region_name) == "function" then
    --     location = self
    -- else
    -- print(type(name))
    -- if type(name) == "table" then
    --     print(name.name)
    --     -- location = NAMED_LOCATIONS[name.name]
    --     name = name.name
    -- end
    location = NAMED_LOCATIONS[name]
    -- print(location, name)
    -- end
    if location == nil then
        -- print(location, name)
        -- if type(name) == "table" then
        -- else
        --     print("Unknown location : " .. tostring(name))
        -- end
        return ACCESS_NONE
    end
    return location:accessibility()
end

-- creates a lua object for the given name. it acts as a representation of a overworld reagion or indoor locatoin and
-- tracks its connected objects wvia the exit-table
function alttp_location.new(name, shortname, origin, room, x, yMin, yMax, xMax, LocationSection, deadEndOrDungeonOrConnector)
    if shortname == nil then
        shortname = name
    end
    local self = setmetatable({}, alttp_location)
    if name then
        NAMED_LOCATIONS[name] = self
        table.insert(NAMED_LOCATIONS_KEYS, name)
        self.name = name
        self.shortname = shortname
    else
        NAMED_LOCATIONS[name] = self
        self.name = tostring(self)
        self.shortname = shortname
        table.insert(NAMED_LOCATIONS_KEYS, self.name)
    end
    self.locationsection = LocationSection
    self.deadEndOrDungeonOrConnector = deadEndOrDungeonOrConnector or false
    if string.find(self.name, "_inside") then
        self.side = "inside"
    elseif string.find(self.name, "_outside") then
        self.side = "outside"
    else
        self.side = nil
    end
    self.interactable = false
    if room ~= nil then
        -- print(name)
        -- NAMED_LOCATIONS["from_"..name] = self
        -- NAMED_LOCATIONS["to_"..name] = self
        self.room = room
        self.x = x
        self.y = yMin
        -- self.cave = cave -- boolean
        -- 20 pixel tolerance
        Table_insert_at(ENTRANCE_MAPPING, room, {})
        local x_min = x
        local x_max = x
        if xMax ~= nil then
            x_max = xMax -- As far as I can tell this is only ever used for the ganon dropdown
        end
        for x_range = x_min-2, x_max+2 do
            local y_min_range = yMin-30
            local y_max_range = yMin+30
            if yMax ~= nil then
                y_min_range = yMin-2
                y_max_range = yMax+2
            end
            for y_range = y_min_range, y_max_range do
                Table_insert_at(ENTRANCE_MAPPING[room], x_range, {})
                Table_insert_at(ENTRANCE_MAPPING[room][x_range], y_range, nil)
                -- print(self.name, origin == nil)
                table.insert(ENTRANCE_MAPPING[room][x_range][y_range], self.name)
                table.insert(ENTRANCE_MAPPING[room][x_range][y_range], origin == nil)
            end
        end
    -- else
    --     if name then
    --         NAMED_LOCATIONS[name] = self
    --         table.insert(NAMED_LOCATIONS_KEYS, name)
    --         self.name = name
    --         self.shortname = shortname
    --     else
    --         NAMED_LOCATIONS[name] = self
    --         self.name = tostring(self)
    --         self.shortname = shortname
    --         table.insert(NAMED_LOCATIONS_KEYS, self.name)
    --     end
       
    end
    -- print("------")
    -- print(origin)
    self.worldstate = origin
    -- print(self.worldstate)
    -- print("------")
    self.exits = {}
    self.keys = math.huge

    return self
end

local function always()
    return ACCESS_NORMAL
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
        -- if exit.worldstate == nil then --or exit.worldstate ~= self.worldstate then
        --     exit.worldstate = self.worldstate
        -- end
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
    -- if exit.worldstate == nil then --or exit.worldstate ~= self.worldstate then
    --     exit.worldstate = self.worldstate
    -- end
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

-- technically redundant but well
-- creates a connection between 2 locations that is traversable in both ways but each connection follow different rules.
-- acts as a shortcut for 2 connect_one_way-calls
function alttp_location:connect_two_ways_stuck(exit, rule1, rule2)
    self:connect_one_way(exit, rule1)
    exit:connect_one_way(self, rule2)
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
        res = ACCESS_NONE
        accessibilityCache[self] = res
    end
    return res
end

--
local er_check = {
    [0] = function(location_name)
        return false end,
    [1] = function(location_name) --print("dungeons ER", ER_DUNGEONS[self.name] ~= nil)
        -- if self.cave == true then
            return ER_DUNGEONS["from_" .. location_name] ~= nil
        -- else
        --     return ER_DUNGEONS["to_" .. self.name] ~= nil
        -- end

        end,
    [2] = function(location_name) --print("full ER", NAMED_ENTRANCES[self.name] ~= nil)
        -- if self.cave == true then
            return NAMED_ENTRANCES["from_" .. location_name] ~= nil
        -- else
        --     return NAMED_ENTRANCES["to_" .. self.name] ~= nil
        --  end
        end,
    [3] = function(location_name) --print("!!!!!!!!!!!!!!!!!! YOU ABSOLUTELY SHOUlD NOT BE ABLE TO SEE THIS!!!!!!!!!!!!!!!!")
        -- print(location_name)
        -- print(NAMED_ENTRANCES["from_" .. location_name])
        return NAMED_ENTRANCES["from_" .. location_name] ~= nil end
}

function alttp_location:discover(accessibility, keys, worldstate)
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

            -- local exit_name = exit[1].name
            local location_name = self.name
            -- if (string.sub(exit_name, -7,-1) == "_inside" and string.sub(location_name, -8,-1) == "_outside") or (string.sub(location_name, -7,-1) == "_inside" and string.sub(exit_name, -8,-1) == "_outside") then
            if ER_STATE and (exit[1].side == "inside" and self.side == "outside") or (self.side == "inside" and exit[1].side == "outside") then
                local temp
                local er_setting_stage = Tracker:FindObjectForCode("er_tracking").CurrentStage
                local er_check_result = er_check[er_setting_stage](location_name)
                if er_check_result then -- dungeons ER
                    -- print("from_" .. self.name)
                    temp = Tracker:FindObjectForCode("from_" .. location_name)
                    -- temp = Tracker:FindObjectForCode(self.name)
                    -- print(self.name, "to er_dungeons[self.name]: -->", ER_DUNGEONS[self.name])
                   
                    if temp ~= nil and temp.ItemState.Target ~= nil then
                        -- -- print(NAMED_LOCATIONS[string.gsub(temp.ItemState.Target, "to_", "")])
                        -- local stripped_target_name = string.gsub(temp.ItemState.Target, "to_", "")
                        -- -- print("stripped_target_name", stripped_target_name)
                        -- -- local stripped_target_name = temp.ItemState.Target
                        -- -- if self.worldstate then
                        -- --     print(stripped_target_name)
                        -- --     location = NAMED_LOCATIONS[stripped_target_name]
                        -- -- else
                        -- print("stripped_target_name", stripped_target_name)
                        -- print("temp.ItemState.TargetBaseName", temp.ItemState.TargetBaseName)
                        location = NAMED_LOCATIONS[temp.ItemState.TargetBaseName]
                    else
                        -- print("exit connection is fucked")
                        -- return
                    end
                end
                if location == nil and er_check_result then
                    location = empty_location
                end
            end

            if location == nil then
                location = exit[1] or empty_location-- exit name
            end
            if worldstate == nil then
                worldstate = self.worldstate
            end
            if self.worldstate == location.worldstate and worldstate ~= self.worldstate then
                worldstate = self.worldstate
            end
            if location.worldstate == nil then
                location.worldstate = worldstate
            end
            
            local oldAccess = location:accessibility() -- get most recent accessibilty level for exit
            local oldKey = location.keys or 0
            if oldAccess < accessibility then -- if new accessibility from above is higher then currently stored one, so is more accessible then before
                local rule = exit[2] -- get rules to check

                currentParent, currentLocation = self, location -- just set for ":accessibilty()" check within rules
                local access, key = rule(keys)
                local parent_access = currentParent:accessibility()
                if type(access) == "boolean" then --
                    access = A(access)
                end
                -- print(self.name, type(access), type(parent_access), location.name)
                if access > parent_access then
                    access = parent_access
                end
                currentParent, currentLocation = nil, nil -- just set for ":accessibilty()" check within rules

                if access == nil then
                    print("Warning: " .. self.name .. " -> " .. location.name .. " rule returned nil")
                    access = ACCESS_NONE
                end
                -- print(access, self.name)
                -- print(access, true, access == true, 0 == true)
                            -- if access == 5 then
                            --     access = ACCESS_SEQUENCEBREAK
                            -- elseif access == 3 then
                            --     access = ACCESS_INSPECT
                            -- end
                
                -- elseif access == true then
                --     access = ACCESS_NORMAL
                -- elseif access == false then
                --     access = ACCESS_NONE
                -- end
               
                if key == nil then
                    key = keys
                end
                if access > oldAccess or (access == oldAccess and key < oldKey) then -- not sure about the <
                    -- print(self.name, "to", location.name)
                    -- print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access], "with worldstate:", worldstate)
                    -- print("lower:", self.worldstate, worldstate, location.worldstate)
                    -- print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access])--, "with worldstate:", worldstate)
                    location:discover(access, key, worldstate)
                end
            end
        end
    end
end

entry_point = alttp_location.new("entry_point")
lightworld_spawns = alttp_location.new("lightworld_spawns", nil, "light")
darkworld_spawns = alttp_location.new("darkworld_spawns", nil, "dark")

entry_point:connect_one_way(lightworld_spawns, OpenOrStandard)
entry_point:connect_one_way(darkworld_spawns, Inverted)

--
function StateChanged()
    PrecalcCanInteract()
    stale = true
end

function LocationHandler(location)
    if MANUAL_CHECKED then
        local custom_storage_item = Tracker:FindObjectForCode("manual_location_storage")
        if not custom_storage_item then
            return
        end
        if Archipelago.PlayerNumber == -1 then -- not connected
            if ROOM_SEED ~= "default" then -- seed is from previous connection
                ROOM_SEED = "default"
                custom_storage_item.ItemState.MANUAL_LOCATIONS["default"] = {}
            else -- seed is default
            end
        end
        local full_path = location.FullID
        if not custom_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED] then
            custom_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED] = {}
        end
        if location.AvailableChestCount < location.ChestCount then --add to list
            -- print("add to list")
            custom_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED][full_path] = location.AvailableChestCount
        else --remove from list of set back to max chestcount
            -- print("remove from list")
            custom_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED][full_path] = nil
        end
    end
    -- local custom_storage_item = Tracker:FindObjectForCode("manual_location_storage")
    -- print(dump_table(custom_storage_item.ItemState.MANUAL_LOCATIONS))
    ForceUpdate()
end

function ForceUpdate(...)
    -- UpdateCanInteract()
    local update = Tracker:FindObjectForCode("update")
    if update == nil then
        return
    end
    update.Active = not update.Active
    -- print(dump_table(CAN_INTERACT))
end

function EmptyLocationTargets()
    MANUAL_CHECKED = false
    local er_tracking = Tracker:FindObjectForCode("er_tracking")
    local er_custom_storage_item = Tracker:FindObjectForCode("manual_er_storage")
    ER_STAGE = er_tracking.CurrentStage
    ER_STATE = er_tracking.CurrentStage > 0
    if Archipelago.PlayerNumber == -1 then -- not connected
        if ROOM_SEED ~= "default" then -- seed is from previous connection
            ROOM_SEED = "default"
            er_custom_storage_item.ItemState.MANUAL_LOCATIONS["default"] = {}
        else -- seed is default
        end
    end
    if not (Tracker.BulkUpdate == true) then
        ScriptHost:RemoveWatchForCode("StateChanged")
        ScriptHost:RemoveOnLocationSectionHandler("location_section_change_handler")
        -- local er_tracking = Tracker:FindObjectForCode("er_tracking")
        if er_tracking == nil then
            print("item with code 'er_tracking' not found")
            return
        end
        ER_STATE = er_tracking.CurrentStage > 0
        print(er_tracking.CurrentStage)
        if er_tracking.CurrentStage == 0 then
            print("run discorver")
            entry_point:discover(ACCESS_NORMAL, 0)
            print("finshed discover")
        elseif er_tracking.CurrentStage == 1 then
            print("dungeons er")
            for name, inside in pairs(NAMED_ENTRANCES) do
                local source = Tracker:FindObjectForCode(name)
                local target_outside = Tracker:FindObjectForCode(string.gsub(name, "_inside", "_outside"))
                local target_inside = Tracker:FindObjectForCode(string.gsub(name, "_outside", "_inside"))
                if ER_DUNGEONS[name] == nil then
                    --location is NOT in DUNGEONS ER so preset targets
                    if inside then
                        _SetLocationOptions(source, target_outside)
                        _SetLocationOptions(target_outside, source)
                    else
                        _SetLocationOptions(source, target_inside)
                        _SetLocationOptions(target_inside, source)
                    end
                else
                    -- location is in DUNGEONS ER
                    _UnsetLocationOptions(Tracker:FindObjectForCode(name))
                    Tracker:FindObjectForCode(name).ItemState.Target = nil
                end
            end
            for name, _ in pairs(ER_DUNGEONS) do
                -- print(name)
                -- print(Tracker:FindObjectForCode(name).ItemState.Target)
                _UnsetLocationOptions(Tracker:FindObjectForCode(name))
                Tracker:FindObjectForCode(name).ItemState.Target = nil
            end
           
        elseif er_tracking.CurrentStage > 1 then
            print("full or insanity er")
            for name, _ in pairs(NAMED_ENTRANCES) do
                -- print(name)
                -- print(Tracker:FindObjectForCode(name).ItemState.Target)
                local location_reset = Tracker:FindObjectForCode(name)
                if location_reset then
                    _UnsetLocationOptions(location_reset)
                    location_reset.ItemState.Target = nil
                end
                -- Tracker:FindObjectForCode(name).worldstate = nil
            end
            Tracker:UiHint("ActivateTab", "Entrances")
        -- else
        --     print("insanity ER is not supported you troll")
        end
        for name, inside in pairs(PERMANENT_CONNECTIONS) do
            local source = Tracker:FindObjectForCode(name)
            local target_outside = Tracker:FindObjectForCode(string.gsub(name, "_inside", "_outside"))
            local target_inside = Tracker:FindObjectForCode(string.gsub(name, "_outside", "_inside"))
            if inside then
                _SetLocationOptions(source, target_outside)
                _SetLocationOptions(target_outside, source)
            else
                _SetLocationOptions(source, target_inside)
                _SetLocationOptions(target_inside, source)
            end
        end
        ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
        ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
        ForceUpdate()
    else
        print("skipped ER reset")
    end
    MANUAL_CHECKED = true
end

-- ScriptHost:AddWatchForCode("ER_Setting_Changed", "er_full", EmptyLocationTargets)
-- ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
-- ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)