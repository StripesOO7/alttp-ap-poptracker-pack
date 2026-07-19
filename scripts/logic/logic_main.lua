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
PLAYER_ID = -1
TEAM_NUMBER = -1
local ER_STATE = false
ER_STAGE = 0
DOORS_STATE = true
---@type table<string, alttp_location_new_return>
NAMED_LOCATIONS = {}
---@type string[]
NAMED_LOCATIONS_KEYS = {}
---@type table< integer, table< integer, table< integer, {[1]:string, [2]: string?}? >? >? >
ENTRANCE_MAPPING = {} -- structure --> ENTRANCE_MAPPING[<roomnumber>][<x-coord>][<y-coord>] = location name
NAMED_ENEMIES = {}
NAMED_DMG_CLASSES = {}
Current_Dungeon = nil



local stale = true
local accessibilityCache = {}
local accessibilityCacheComplete = false
-- local currentParent = nil
-- local currentLocation = nil
local indirectConnections = {}

---simple helper to insert into tables and create them if not already present
---@param er_table table table to insert into
---@param key string|integer|boolean key to use to insert into the table
---@param value any value to insert into the table
function Table_insert_at(er_table, key, value)
    if er_table[key] == nil then
        er_table[key] = {}
    end
    table.insert(er_table[key], value)
end

--- checks if a given location is reacable in any way from any of the starting points and returns an accessibilityLevel
--- @param name string
--- @return accessibilityLevel
function CanReach(name)
    if stale then
        stale = false
        accessibilityCacheComplete = false
        accessibilityCache = {}
        indirectConnections = {}
        while not accessibilityCacheComplete do
            accessibilityCacheComplete = true
            Entry_point:discover(ACCESS_NORMAL, 0)
            for dst, parents in pairs(indirectConnections) do
                if dst:accessibility() < ACCESS_NORMAL then
                    for parent, src in pairs(parents) do
                        -- print("Checking indirect " .. src.name .. " for " .. parent.name .. " -> " .. dst.name)
                        parent:discover(parent:accessibility(), parent.keys, parent.worldstate)
                    end
                end
            end
        end
    end

    local location = NAMED_LOCATIONS[name]
    if location == nil then
        return ACCESS_NONE
    end
    return location:accessibility()
end


---@class alttp_location_new_return
---@field accessibility function
---@field connect_one_way function
---@field connect_one_way_entrance function
---@field connect_two_ways function
---@field connect_two_ways_entrance function
---@field connect_two_ways_entrance_door_stuck function
---@field connect_two_ways_stuck function
---@field discover function
---@field name string
---@field shortname string
---@field locationsection string[]
---@field map string
---@field deadEndOrDungeonOrConnector boolean
---@field side string
---@field interactable boolean
---@field inside_dungeon boolean
---@field deadendColorBackup boolean
---@field room integer
---@field x integer
---@field y integer
---@field baseWorldstate "light"|"dark"|""
---@field worldstate "light"|"dark"|""
---@field exits table<integer, {[1]:alttp_location_new_return, [2]:function}>
---@field keys integer


-- creates a lua object for the given name. it acts as a representation of an overworld region or indoor location and tracks its connected objects via the exit-table
---@param name string
---@param shortname? string short name of the created location for display purposes. Defaults to name if omitted
---@param origin? string
---@param map? string
---@param inside_dungeon? boolean
---@param room? integer
---@param x? integer
---@param yMin? integer
---@param yMax? integer
---@param xMax? integer
---@param LocationSection? string[]
---@param deadEndOrDungeonOrConnector? string
---@param deadendLocationCheck? string[]
---@return alttp_location_new_return
function alttp_location.new(name, shortname, origin, map, inside_dungeon, room, x, yMin, yMax, xMax, LocationSection, deadEndOrDungeonOrConnector, deadendLocationCheck)
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
    self.map = map
    self.deadEndOrDungeonOrConnector = deadEndOrDungeonOrConnector or false
    if string.find(self.name, "_inside") then
        self.side = "inside"
    elseif string.find(self.name, "_outside") then
        self.side = "outside"
    else
        self.side = ""
    end
    self.interactable = false
    if inside_dungeon then
        self.inside_dungeon = true
    else
        self.inside_dungeon = false
    end
    self.deadendColorBackup = deadendLocationCheck
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
                table.insert(ENTRANCE_MAPPING[room][x_range][y_range], origin)
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
    self.baseWorldstate = origin
    self.worldstate = origin
    -- print(self.worldstate)
    -- print("------")
    self.exits = {}
    self.keys = math.huge

    return self
end

---function to give a default value during rule evaluations of no other rule got specified. 
---@return integer
local function always()
    return ACCESS_NORMAL
end

---marks a 1-way connections between 2 "locations/regions" in the source "locations" exit-table with rules if provided
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule? function
function alttp_location:connect_one_way(exit, rule)
    -- used for actual check-locations so you dont have to predefine them and just reference them by name in the graph(s)
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

---marks a 2-way connection between 2 locations. acts as a shortcut for 2 connect_one_way-calls
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule? function
function alttp_location:connect_two_ways(exit, rule)
    -- print(exit.name, self.name)
    self:connect_one_way(exit, rule)
    exit:connect_one_way(self, rule)
end

-- creates a 1-way connection from a region/location to another one via a 1-way connector like a ledge, hole,
-- self-closing door, 1-way teleport, ...
---@param name string arbitrary name for the connection. isnt used anywhere
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule? function
function alttp_location:connect_one_way_entrance(name, exit, rule)
    if rule == nil then
        rule = always
    end
    -- print(name, "wann wird das aufgerufen?", exit.name)
    self.exits[#self.exits + 1] = { exit, rule }
end

-- creates a connection between 2 locations that is traversable in both ways using the same rules both ways
-- acts as a shortcut for 2 connect_one_way_entrance-calls
---@param name string arbitrary name for the connection. isnt used anywhere
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule? function
function alttp_location:connect_two_ways_entrance(name, exit, rule)
    if exit == nil then -- for ER
        return
    end
    print(self.name)
    self:connect_one_way_entrance(name, exit, rule)
    exit:connect_one_way_entrance(name, self, rule)
end

-- creates a connection between 2 locations that is traversable in both ways but each connection follow different rules.
-- acts as a shortcut for 2 connect_one_way_entrance-calls
---@param name string arbitrary name for the connection. isnt used anywhere
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule1? function
---@param rule2? function
function alttp_location:connect_two_ways_entrance_door_stuck(name, exit, rule1, rule2)
    print(self.name)
    self:connect_one_way_entrance(name, exit, rule1)
    exit:connect_one_way_entrance(name, self, rule2)
end

-- technically redundant but well
-- creates a connection between 2 locations that is traversable in both ways but each connection follow different rules.
-- acts as a shortcut for 2 connect_one_way-calls
---@param exit string|alttp_location_new_return alttp_location_new_return or code/name
---@param rule1? function
---@param rule2? function
function alttp_location:connect_two_ways_stuck(exit, rule1, rule2)
    self:connect_one_way(exit, rule1)
    exit:connect_one_way(self, rule2)
end

---checks for the accessibility of a regino/location given its own exit requirements
---@return 0|1|2|3|4|5|6|7
function alttp_location:accessibility()
    -- only executed when run from a rules within a connection
    -- if currentLocation ~= nil and currentParent ~= nil then
    --     if indirectConnections[currentLocation] == nil then
    --         indirectConnections[currentLocation] = {}
    --     end
    --     indirectConnections[currentLocation][currentParent] = self
    -- end
    -- up to here
    local res = accessibilityCache[self] --[[@as 0|1|2|3|4|5|6|7]] -- get accessibilty lvl set in discover for a given location
    if res == nil then
        res = ACCESS_NONE
        accessibilityCache[self] = res
    end
    return res
end

-- lookup to get which reference table to use for further ER lookups
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

---function to start walking the graph them this location
---@param accessibility 0|1|2|3|4|5|6|7
---@param keys integer
---@param worldstate ""|"light"|"dark"
-- -@param Current_Dungeon ""|"at"|"hc"|"ep"|"dp"|"toh"|"sw"|"tt"|"sp"|"ip"|"mm"|"tr"|"pod"|"gt"
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
            -- if (string.sub(exit_name, -7,-1) == "_inside" and string.sub(location_name, -8,-1) == "_outside") or
            -- (string.sub(location_name, -7,-1) == "_inside" and string.sub(exit_name, -8,-1) == "_outside") then
            if ER_STATE then
                if (exit[1].side == "inside" and self.side == "outside") then
                    -- print("type1")
                    local temp
                    local er_setting_stage = (Tracker:FindObjectForCode("er_tracking") --[[@as JsonItem]]).CurrentStage
                    local er_check_result = er_check[er_setting_stage](location_name)
                    -- print(er_setting_stage, er_check_result)
                    if er_check_result then -- dungeons ER
                        temp = NAMED_ER_CONNECTIONS["from_" .. location_name]
                        if temp ~= nil then 
                            temp = temp.ItemState
                            if temp.Target ~= nil then
                                location = NAMED_LOCATIONS[temp.TargetBaseName]
                                -- print("exit connection is fucked")
                                -- return
                            end
                        else
                            location = Empty_location
                        end
                        -- print("temp", temp) 
                        
                    end
                    if location == nil then -- and er_check_result then
                        location = Empty_location
                    end
                    -- if location ~= nil and location ~= Empty_location then
                        -- print(self.name, exit[1].name, location.name)
                    -- print("change dungeon state from :", Current_Dungeon, "to: ", Dungeon_key_mapping[self.name] or
                    -- Dungeon_key_mapping[exit[1].name] or nil)
                        -- print("1", Dungeon_key_mapping[self.name], self.name)
                        -- print("2", Dungeon_key_mapping[location.name], location.name)
                        -- print("3", Dungeon_key_mapping[self.name] or Dungeon_key_mapping[location.name] or nil)
                        -- print("4", (Dungeon_key_mapping[self.name] or Dungeon_key_mapping[location.name]) or nil)
                        -- print("5", Dungeon_key_mapping[self.name] or (Dungeon_key_mapping[location.name] or nil))
                        Current_Dungeon = Dungeon_key_mapping[self.name] or Dungeon_key_mapping[location.name] or nil
                    -- end
                elseif (self.side == "inside" and exit[1].side == "outside") then
                    -- print("type2")
                    local temp
                    local er_setting_stage = (Tracker:FindObjectForCode("er_tracking") --[[@as JsonItem]]).CurrentStage
                    local er_check_result = er_check[er_setting_stage](location_name)
                    if er_check_result then -- dungeons ER
                        temp = NAMED_ER_CONNECTIONS["from_" .. location_name]
                        if temp ~= nil then 
                            temp = temp.ItemState
                            if temp.Target ~= nil then
                                location = NAMED_LOCATIONS[temp.TargetBaseName]
                                -- print("exit connection is fucked")
                                -- return
                            end
                        else
                            location = Empty_location
                        end
                        -- print("temp", temp) 
                        
                    end
                    if location == nil and er_check_result then
                        location = Empty_location
                    end
                    -- if location ~= nil and location ~= Empty_location then
                        -- print("change dungeon state from :", Current_Dungeon, "to: ", Dungeon_key_mapping[exit[1].name]
                        -- or Dungeon_key_mapping[self.name] or nil)
                        -- print("6", Dungeon_key_mapping[location.name], location.name)
                        -- print("7", Dungeon_key_mapping[self.name], self.name)
                        -- print("8", Dungeon_key_mapping[location.name] or Dungeon_key_mapping[self.name] or nil)
                        -- print("9", (Dungeon_key_mapping[location.name] or Dungeon_key_mapping[self.name]) or nil)
                        -- print("0", Dungeon_key_mapping[location.name] or (Dungeon_key_mapping[self.name] or nil))
                        -- Current_Dungeon = Dungeon_key_mapping[location.name] or Dungeon_key_mapping[self.name] or nil
                        Current_Dungeon = nil
                    -- end
                end
            else
                if (exit[1].side == "inside" and self.side == "outside") then
                    Current_Dungeon = Dungeon_key_mapping[self.name] or Dungeon_key_mapping[exit[1].name] or nil
                elseif (self.side == "inside" and exit[1].side == "outside") then
                    Current_Dungeon = nil
                end
            end
            -- print(Current_Dungeon)
            
            if DOORS_STATE then
                if (exit[1].side == "door" and self.side == "door") then
                    local temp
                    -- local doors_setting_stage = (NAMED_DOORS_CONNECTIONS("doors_tracking") --[[@as JsonItem]]).CurrentStage
                    -- local doors_check_result = doors_check[doors_setting_stage](location_name)
                    local doors_check_result = true
                    if doors_check_result then -- dungeons ER
                        temp = NAMED_DOORS_CONNECTIONS("from_" .. location_name).ItemState
                        -- print("temp", temp) 
                        if temp ~= nil and temp.Target ~= nil then
                            location = NAMED_LOCATIONS[temp.TargetBaseName]
                        else
                            -- print("exit connection is fucked")
                            -- return
                        end
                    end
                    if location == nil and doors_check_result then
                        location = Empty_location
                    end
                end
            else
                -- if (exit[1].side == "inside" and self.side == "outside") then
                --     Current_Dungeon = Dungeon_key_mapping[self.name] or Dungeon_key_mapping[exit[1].name] or nil
                -- elseif (self.side == "inside" and exit[1].side == "outside") then
                --     Current_Dungeon = nil
                -- end
            end

            if location == nil then
                location = exit[1] or Empty_location-- exit name
            end
            if worldstate == nil then
                worldstate = self.worldstate
            end
            if self.worldstate == location.worldstate and worldstate ~= self.worldstate then
                worldstate = self.worldstate
            end
            -- print(worldstate, location.worldstate, location.name, exit[1].name, Current_Dungeon)
            if location.worldstate == nil then
                location.worldstate = worldstate
            end
            
            local oldAccess = location:accessibility() -- get most recent accessibilty level for exit
            local oldKey = location.keys or 0
            if oldAccess < accessibility then -- if new accessibility from above is higher then currently stored one, so is more accessible then before
                local rule = exit[2] -- get rules to check
                -- print(self.name, exit[1].name, Current_Dungeon)
                -- currentParent, currentLocation = self, location -- just set for ":accessibilty()" check within rules
                local access, key = rule(keys, Current_Dungeon)
                if type(access) == "function" then
                    access = access()
                end
                local parent_access = self:accessibility()
                if type(access) == "boolean" then --
                    access = A(access)
                end
                if access > parent_access then
                    access = parent_access
                end
                -- currentParent, currentLocation = nil, nil -- just set for ":accessibilty()" check within rules

                if access == nil then
                    print("Warning: " .. self.name .. " -> " .. location.name .. " rule returned nil")
                    access = ACCESS_NONE
                end
                -- print("access", access)
                if key == nil then
                    key = keys
                end
                if access > oldAccess or (access == oldAccess and key < oldKey) then -- not sure about the <
                    -- print(self.name, "to", location.name)
                    -- print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access], "with worldstate:", worldstate)
                    -- print("lower:", self.worldstate, worldstate, location.worldstate, Current_Dungeon)
                    -- if Current_Dungeon == nil then
                    --     print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access], "no current dungeon")--, "with worldstate:", worldstate)
                    -- else
                    --     print(accessLVL[self:accessibility()], "from", self.name, "to", location.name, ":", accessLVL[access], "in dungeon: ", Current_Dungeon)--, "with worldstate:", worldstate)
                    -- end
                    location:discover(access, key, worldstate)
                end
            end
        end
    end
end

Entry_point = alttp_location.new("Entry_point", "Save & Quit")
Lightworld_spawns = alttp_location.new("Lightworld_spawns", nil, "light")
Darkworld_spawns = alttp_location.new("Darkworld_spawns", nil, "dark")

Entry_point:connect_one_way(Lightworld_spawns, OpenOrStandard)
Entry_point:connect_one_way(Darkworld_spawns, Inverted)

CachedValues = {}
function ClearCache()
    CachedValues = {}
end

---helperfunction that is used to force a grpah update on every state change within poptracker.
function StateChanged()
    if Archipelago then
        PLAYER_ID = Archipelago.PlayerNumber
    end
    if PLAYER_ID == -1 then
        ROOM_SEED = "default"
    else
        ROOM_SEED = (Archipelago.Seed or tostring(#ALL_LOCATIONS)).."_"..TEAM_NUMBER.."_"..PLAYER_ID
    end
    ClearCache()
    UpdateCanInteract()
    stale = true
end

---helper function that gets called when a locationSection has changed state. 
---checks if the interaction was from the server or manual. 
---if manual puts it into a cache for keeping that locationSection toggled when reconnecting
---@param location LocationSection
function LocationHandler(location)
    if MANUAL_CHECKED then
        local custom_storage_item = (Tracker:FindObjectForCode("manual_location_storage") --[[@as LuaItem]]).ItemState
        if not custom_storage_item then
            return
        end
        if PLAYER_ID == -1 then -- not connected
            if ROOM_SEED ~= "default" then -- seed is from previous connection
                ROOM_SEED = "default"
                custom_storage_item.MANUAL_LOCATIONS["default"] = {}
            else -- seed is default
            end
        end
        local full_path = location.FullID
        if not custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] then
            custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] = {}
        end
        if location.AvailableChestCount < location.ChestCount then --add to list
            -- print("add to list")
            custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED][full_path] = location.AvailableChestCount
        else --remove from list of set back to max chestcount
            -- print("remove from list")
            custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED][full_path] = nil
        end
    end
-- local custom_storage_item = Tracker:FindObjectForCode("manual_location_storage")
-- print(Dump_table(custom_storage_item.ItemState.MANUAL_LOCATIONS))
    ForceUpdate()
end

--function to force an update even if the interaction within poptracker noramlly would not call for a state update
function ForceUpdate(...)
    -- UpdateCanInteract()
    local update = Tracker:FindObjectForCode("update")
    if update == nil then
        return
    end
    update.Active = not update.Active
    -- print(Dump_table(CAN_INTERACT))
end

FOUND = false
ALREADY_VISITED = {}
PATH = {}
STEPS = -1
---Traverses the graph from start to finish and if a path is found applies the nodes as badge texts to the 40 route mode items
---@param start alttp_location_new_return
---@param finish alttp_location_new_return
function GetRoute(start, finish)
    ALREADY_VISITED = {}
    PATH = {}
    PATH[0] = start.shortname
    FindPath(start, finish, 0)
    for i=0,40 do
        (Tracker:FindObjectForCode("solidblack"..tostring(i))--[[@as JsonItem]]).BadgeText = ""
    end
    if #PATH > 1 then
        for i=STEPS, #PATH do
            PATH[i] = nil
        end
        for index, location_name in pairs(PATH) do
            local black_tile = Tracker:FindObjectForCode("solidblack"..tostring(index)) --[[@as JsonItem]]
            black_tile.BadgeText = location_name
            -- Tracker:FindObjectForCode("solidblack"..tostring(i)):SetOverlayColor("#FF0000")
            black_tile:SetOverlayFontSize(16)
            black_tile.BadgeTextColor = "FFFFFFFF"
            black_tile:SetOverlayAlign("left")
        end
    else
        local black_tile = Tracker:FindObjectForCode("solidblack0") --[[@as JsonItem]]
        black_tile.BadgeText = "No Route Found"
        -- Tracker:FindObjectForCode("solidblack"..tostring(i)):SetOverlayColor("#FF0000")
        black_tile:SetOverlayFontSize(16)
        black_tile.BadgeTextColor = "FFFFFFFF"
        black_tile:SetOverlayAlign("left")
    end
    -- print(Dump_table(PATH))
    Tracker:UiHint("ActivateTab", "Route")
    FOUND = false
    ALREADY_VISITED = {}
    PATH = {}
    STEPS = -1
end

---helper functoin to GetRoute to find the actual, possible shortes, path on from Start to Finish without considering
---s&q/respawns
---@param start alttp_location_new_return
---@param finish alttp_location_new_return
---@param stage integer
---@return boolean
function FindPath(start, finish, stage)
    ---@type alttp_location_new_return[]
    local next_sweep = {Entry_point}
    local res = false
    local any_true = false
    stage = stage + 1
    -- print(stage, start.name)
    -- print(start.name)
    -- print("start.name, finish", start.name, finish.name)
    if FOUND and ALREADY_VISITED[finish.name] > stage then
        FOUND = false
    end
    if not FOUND  or (stage < #PATH) then
        if ALREADY_VISITED[start.name] ~= nil then
            -- print("ALREADY_VISITED " .. start.name, ALREADY_VISITED[start.name], stage)
            if ALREADY_VISITED[start.name] > stage then
                -- print("ALREADY_VISITED " .. start.name, ALREADY_VISITED[start.name], stage)
                -- stage = ALREADY_VISITED[start.name]
                ALREADY_VISITED[start.name] = stage
            -- print("already visited " .. start.name)
            else
                return false
            end
        else
            ALREADY_VISITED[start.name] = stage
        end
        if start.name == finish.name then
            -- print("FOUND", stage)
            FOUND = true
            STEPS = stage
            -- print(Dump_table(path))
            return true
        end
        for _, exit in pairs(start.exits) do
            local location
            local location_name = start.name
            if ER_STATE and (exit[1].side == "inside" and start.side == "outside") or (start.side == "inside" and exit[1].side == "outside") then
                local temp
                local er_setting_stage = Tracker:FindObjectForCode("er_tracking").CurrentStage
                local er_check_result = er_check[er_setting_stage](location_name)
                if er_check_result then -- dungeons ER
                    temp = (Tracker:FindObjectForCode("from_" .. location_name) --[[@as LuaItem]]).ItemState
                   
                    if temp ~= nil and temp.Target ~= nil then
                        location = NAMED_LOCATIONS[temp.TargetBaseName]
                    else
                        -- print("exit connection is fucked")
                        -- return
                    end
                end
                if location == nil and er_check_result then
                    location = Empty_location
                end
            end
            if location == nil then
                location = exit[1] or Empty_location
            end
            local rules = exit[2]
            local access, key = rules(location.keys)
            if type(access) == "boolean" then
                access = A(access)
            end
            if location:accessibility() > 4 and access > 4 then
                table.insert(next_sweep, location)
            end
        end
        for _, loc in pairs(next_sweep) do
            res = FindPath(loc, finish, stage)
            if res == true then
                PATH[stage] = loc.shortname
                any_true = true
            end
        end
        return any_true
    end
    return false
end --Test_path(location, finish, stage)

---functio to set and reset all connections to their base state or ER-stage defined defaults
function EmptyLocationTargets()
    MANUAL_CHECKED = false
    local er_tracking = Tracker:FindObjectForCode("er_tracking") --[[@as JsonItem]]
    local er_custom_storage_item = (Tracker:FindObjectForCode("manual_er_storage") --[[@as LuaItem]]).ItemState
    ER_STAGE = er_tracking.CurrentStage
    ER_STATE = er_tracking.CurrentStage > 0
    if PLAYER_ID == -1 then -- not connected
        if ROOM_SEED ~= "default" and er_custom_storage_item then -- seed is from previous connection
            ROOM_SEED = "default"
            er_custom_storage_item.MANUAL_LOCATIONS["default"] = {}
        else -- seed is default
        end
    end
    if not (Tracker.BulkUpdate == true) then
        ScriptHost:RemoveWatchForCode("StateChanged")
        -- ScriptHost:RemoveOnLocationSectionHandler("location_section_change_handler")
        ScriptHost:RemoveOnLocationSectionChangedHandler("location_section_change_handler")
        -- local er_tracking = Tracker:FindObjectForCode("er_tracking")
        if er_tracking == nil then
            print("item with code 'er_tracking' not found")
            return
        end
        ER_STATE = er_tracking.CurrentStage > 0
        -- print(er_tracking.CurrentStage)
        if er_tracking.CurrentStage == 0 then
            -- print("run discorver")
            -- Entry_point:discover(ACCESS_NORMAL, 0, nil)
            -- print("finshed discover")
        elseif er_tracking.CurrentStage == 1 then
            -- print("dungeons er")
            for name, inside in pairs(NAMED_ENTRANCES) do
                local source = Tracker:FindObjectForCode(name) --[[@as LuaItem]]
                local target_outside = Tracker:FindObjectForCode(string.gsub(name, "_inside", "_outside")) --[[@as LuaItem]]
                local target_inside = Tracker:FindObjectForCode(string.gsub(name, "_outside", "_inside")) --[[@as LuaItem]]
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
                    _UnsetLocationOptions(Tracker:FindObjectForCode(name) --[[@as LuaItem]])
                end
            end
            for name, _ in pairs(ER_DUNGEONS) do
                -- print(name)
                -- print(Tracker:FindObjectForCode(name).ItemState.Target)
                _UnsetLocationOptions(Tracker:FindObjectForCode(name) --[[@as LuaItem]])
            end
           
        elseif er_tracking.CurrentStage > 1 then
            print("full or insanity er")
            for name, _ in pairs(NAMED_ENTRANCES) do
                -- print(name)
                -- print(Tracker:FindObjectForCode(name).ItemState.Target)
                local location_reset = Tracker:FindObjectForCode(name) --[[@as LuaItem]]
                if location_reset then
                    _UnsetLocationOptions(location_reset)
                end
                -- Tracker:FindObjectForCode(name).worldstate = nil
            end
            Tracker:UiHint("ActivateTab", "Entrances")
        -- else
        --     print("insanity ER is not supported you troll")
        end
        for name, inside in pairs(PERMANENT_CONNECTIONS) do
            local source = Tracker:FindObjectForCode(name) --[[@as LuaItem]]
            local target_outside = Tracker:FindObjectForCode(string.gsub(name, "_inside", "_outside")) --[[@as LuaItem]]
            local target_inside = Tracker:FindObjectForCode(string.gsub(name, "_outside", "_inside")) --[[@as LuaItem]]
            if inside then
                _SetLocationOptions(source, target_outside)
                _SetLocationOptions(target_outside, source)
            else
                _SetLocationOptions(source, target_inside)
                _SetLocationOptions(target_inside, source)
            end
        end
        for _, location in pairs(NAMED_LOCATIONS) do
            local location_obj
            if PopVersion < "0.32.0" then
                location_obj = NAMED_LOCATIONS[location]
            else
                location_obj = location
            end
            location_obj.worldstate = location_obj.baseWorldstate
            -- if location_obj.worldstate ~= location_obj.baseWorldstate then
            --     location_obj.worldstate = location_obj.baseWorldstate
            -- end
        end
        ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
        ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
        ForceUpdate()
    else
        print("skipped ER reset")
    end
    print("run discorver")
    Current_Dungeon = nil
    Entry_point:discover(ACCESS_NORMAL, 0, nil)
    print("finshed discover")
    MANUAL_CHECKED = true
end

-- ScriptHost:AddWatchForCode("ER_Setting_Changed", "er_full", EmptyLocationTargets)
-- ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
-- ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)