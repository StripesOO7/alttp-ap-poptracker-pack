require("scripts/autotracking/item_mapping")
require("scripts/autotracking/location_mapping")

CUR_INDEX = -1
SLOT_DATA = nil
SKIP_BOSSSHUFFLE = false
ALL_LOCATIONS = {}
TROLL_PLAYER= false
DATE_CHECK_PASSED = false

MANUAL_CHECKED = true
ROOM_SEED = "default"

local FIRSTSTAGE = {
    [73] = 80, --fightersword
    [4] = 4, --blue shield
    [11] = 11, --bow+arrow 
    [27] = 27 -- power glove
}
local SECONDSTAGE = {
    [5] = 5, --red shield
    [34] = 34, --blue mail
    [28] = 28, --titans mitts
    [80] = 80, --master sword
    [59] = 59 --silver bow
}
local THIRDSTAGE = {
    [2] = 2, --tempered sword
    [6] = 6, --mirror shield
    [35] = 35 --red mail
}

TROLL_LOOKUP = {
    ["solarcell"] = true,
    ["earthor"] = true,
}

local MEDALLIONS = {
    [15] = "bombos",
    [16] = "ether",
    [17] = "quake"
}

local KEYRINGS = {
    [194] = true,
    [195] = true,
    [202] = true,
    [192] = true,
    [196] = true,
    [198] = true,
    [203] = true,
    [200] = true,
    [197] = true,
    [201] = true,
    [199] = true,
    [204] = true,
    [205] = true
}

if Highlight then
    HIGHLIGHT_LEVEL= {
        [0] = Highlight.Unspecified,
        [10] = Highlight.NoPriority,
        [20] = Highlight.Avoid,
        [30] = Highlight.Priority,
        [40] = Highlight.None,
        [100] = Highlight.Unspecified,
        [101] = Highlight.Priority,
        [102] = Highlight.NoPriority,
        [103] = Highlight.Priority,
        [104] = Highlight.Avoid,
        [105] = Highlight.Priority,
        [106] = Highlight.NoPriority,
        [107] = Highlight.Priority,
    }

    HINTS_PRIORITY_LOOKUP = {} 
    -- table for lookups on the section to behighlighted
    -- structure 
    -- {
    --     ["@path/to/section1"] = {
    --         [location ID] = hint status,
    --         [location ID] = hint stauts,
    --         },
    --     ["@path/to/section2"] = {
    --         [location ID] = hint status,
    --         [location ID] = hint stauts,
    --         }
    -- }

    HINT_PRIO_MAPPING = {
        [0] = 1,
        [10] = 3,
        [20] = 2,
        [30] = 4,
        [40] = 0,
        [100] = 1,
        [101] = 4,
        [102] = 3,
        [103] = 4,
        [104] = 2,
        [105] = 4,
        [106] = 3,
        [107] = 4,
    }

end



---@param start_date number //build_time_obj() return aka unix timestamp
---@param end_date number //build_time_obj() return aka unix timestamp
---@param target_date number //build_time_obj() return aka unix timestamp
function Check_Date_Range(start_date, end_date, target_date)
    local one_day = 86400
    local check_result = false
    for day_obj = start_date, end_date, one_day do
        check_result = Check_Date(day_obj, target_date)
        if check_result then
            return true
        end
    end
end

---@param target_date number //build_time_obj() return aka unix timestamp
---@param reference_time number? //build_time_obj() return aka unix timestamp
function Check_Date(reference_time, target_date)
    local today = os.date("*t")
    local reference_day =  os.date("*t", target_date)
    if reference_time then
        today = os.date("*t", reference_time)
    end
    return today.year == reference_day.year and 
    today.month == reference_day.month and 
    today.day == reference_day.day
end

---@param year number?
---@param month number?
---@param day number?
---@param hour number?
---@param minute number?
---@param second number?
function Build_Time_Obj(year, month, day, hour, minute, second)
    local today = os.date("*t", os.time())
    return os.time(
        {
            year = year or today.year,
            month = month or today.month,
            day = day or today.day,
            hour = hour or 0,
            min = minute or 0,
            sec = second or 0
        }
    )
end

--- Function for prepare custom LuaItems for caching, check for mischieve/traps, subscribe to datastorage 
function PreOnClear()
    PLAYER_ID = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
    if PLAYER_ID > -1 then
        for key, _ in pairs(TROLL_LOOKUP) do
            if string.find(string.lower(Archipelago:GetPlayerAlias(PLAYER_ID)), key, 1, true) ~= nil then
                TROLL_PLAYER = true
                break
            end
        end
        -- local target_day = Build_Time_Obj(nil, 3 , 29)
        local start_day_range = Build_Time_Obj(nil, 3 , 31)
        local end_day_range = Build_Time_Obj(nil, 4 , 5)
        DATE_CHECK_PASSED = Check_Date_Range(start_day_range, end_day_range, os.time())
        -- example checks for days between christmas and new years
        -- DATE_CHECK_PASSED = Check_Date(nil, target_day)
        if TROLL_PLAYER == false and DATE_CHECK_PASSED then
            TROLL_PLAYER = true
        end
        if #ALL_LOCATIONS > 0 then
            ALL_LOCATIONS = {}
        end
        for _, value in pairs(Archipelago.MissingLocations) do
            table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
        end

        for _, value in pairs(Archipelago.CheckedLocations) do
            table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
        end
        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({HINTS_ID})
        Archipelago:Get({HINTS_ID})
    end


    -- local temp_seed = tostring(#ALL_LOCATIONS).."_"..tostring(Archipelago.TeamNumber).."_"..tostring(Archipelago.PlayerNumber)
    -- print(Archipelago.Seed)
    -- local storage_location = custom_storage_item.MANUAL_LOCATIONS
    -- local storage_location_order = custom_storage_item.MANUAL_LOCATIONS_ORDER
    local seed_base = (Archipelago.Seed or tostring(#ALL_LOCATIONS)).."_"..Archipelago.TeamNumber.."_"..Archipelago.PlayerNumber
    if ROOM_SEED == "default" or ROOM_SEED ~= seed_base then -- seed is default or from previous connection

        ROOM_SEED = seed_base --something like 2345_0_12
        for _, custom_item_code in pairs({"manual_location_storage",  "manual_er_storage", "manual_misc_items_storage"}) do
            local custom_storage_item = Tracker:FindObjectForCode(custom_item_code).ItemState
            if custom_storage_item then
                if #custom_storage_item.MANUAL_LOCATIONS > 10 then
                    custom_storage_item.MANUAL_LOCATIONS[custom_storage_item.MANUAL_LOCATIONS_ORDER[1]] = nil
                    table.remove(custom_storage_item.MANUAL_LOCATIONS_ORDER, 1)
                end
                if custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] == nil then
                    custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] = {}
                    table.insert(custom_storage_item.MANUAL_LOCATIONS_ORDER, ROOM_SEED)
                end
            end
        end
    else -- seed is from previous connection
        -- do nothing
    end
    if TROLL_PLAYER then
        print("----------------load traps----------------")
        -- ScriptHost:LoadScript("scripts/logic/traps.lua")
        require("scripts/logic/traps")
    end
end
(JsonItem|Location|LocationSection|LuaItem)?
---@param location string String of the Location or LocatioSection to reset
---@param location_obj JsonItem|LocationSection Tracker:Findobject(location)retrun object
---@param custom_storage_item table|LuaItem Reference for the custom LuaItem CachesItems
function LocationReset(location, location_obj, custom_storage_item)
    if location:sub(1, 1) == "@" then
        ---@cast location_obj LocationSection
        if custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED][location_obj.FullID] then
            location_obj.AvailableChestCount = custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED][location_obj.FullID]
        else
            location_obj.AvailableChestCount = location_obj.ChestCount
        end
        location_obj.Highlight = HIGHLIGHT_LEVEL[40]
    else
        ---@cast location_obj JsonItem
        location_obj.Active = false
    end
end

---@param item table table of the ItemCode and extra parameters from the Item_Mapping.lau
---@param item_obj JsonItem Tracker:Findobject(item)retrun object
---@param item_code string Reference for the custom LuaItem CachesItems
function ItemReset(item, item_obj, item_code)
    ---@cast item_obj JsonItem
    item_obj.CurrentStage = 0
    if item[2] == "toggle" then
        if MEDALLIONS[item_code] ~= nil then
            item_obj.CurrentStage = 0
        end
        item_obj.Active = false
        if item_obj == "shop_shuffle" then
            item_obj.AcquiredCount = 0
        end
    elseif item[2] == "progressive" then
        item_obj.CurrentStage = 0
        item_obj.Active = false
    elseif ({["consumable"] = true, ["combined_consumable"] = true, ["keyring"] = true})[item[2]] then
        if item_obj.MinCount then
            item_obj.AcquiredCount = item_obj.MinCount
        else
            item_obj.AcquiredCount = 0
        end
    elseif ({["progressive_toggle"] = true, ["split_toggle"] = true})[item[2]] then
        item_obj.CurrentStage = 0
        item_obj.Active = false
    end
end

---@param slot_data table Slotdata send from AP server for the specific user/slot
function onClear(slot_data)
    MANUAL_CHECKED = false

    ScriptHost:RemoveOnFrameHandler("Trap Handler")
    
    local custom_storage_item = Tracker:FindObjectForCode("manual_location_storage").ItemState
    if custom_storage_item == nil then
        CreateLuaManualStorageItem("manual_location_storage")
        custom_storage_item = Tracker:FindObjectForCode("manual_location_storage").ItemState
    end
    local er_custom_storage_item = Tracker:FindObjectForCode("manual_er_storage").ItemState
    if er_custom_storage_item == nil then
        CreateLuaManualStorageItem("manual_er_storage")
        er_custom_storage_item = Tracker:FindObjectForCode("manual_er_storage").ItemState
    end

    local manual_misc_items_storage = Tracker:FindObjectForCode("manual_misc_items_storage").ItemState
    if manual_misc_items_storage == nil then
        CreateLuaManualStorageItem("manual_misc_items_storage")
        manual_misc_items_storage = Tracker:FindObjectForCode("manual_misc_items_storage").ItemState
    end

    PreOnClear()
    
    ScriptHost:RemoveWatchForCode("StateChanged")
    ScriptHost:RemoveOnLocationSectionHandler("location_section_change_handler")
    -- ScriptHost:RemoveOnLocationSectionChangedHandler("location_section_change_handler")
    --SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, location_array in pairs(LOCATION_MAPPING) do
        for _, location in pairs(location_array) do
            if location then
                local location_obj = Tracker:FindObjectForCode(location)
                if location_obj then
                    LocationReset(location, location_obj, custom_storage_item)
                end
            end
        end
    end
    -- reset items
    for _, item in pairs(ITEM_MAPPING) do
        for _, item_code in pairs(item[1]) do
            if item_code and item[2] then
                local item_obj = Tracker:FindObjectForCode(item_code)
                if item_obj then
                    ItemReset(item, item_obj, item_code)
                    -- clear_item_type[item[2]](item_obj, item_code) --alternate version
                end
            end
        end
    end
    SLOT_DATA = slot_data

    autoFill(slot_data)
    Bombless()
    if SKIP_BOSSSHUFFLE == false then
        BossShuffle()
    end

    if manual_misc_items_storage.MANUAL_LOCATIONS[ROOM_SEED] then
        for dungeon_code, item_state in pairs(manual_misc_items_storage.MANUAL_LOCATIONS[ROOM_SEED]) do -- redo location based on savestate for seed
            Tracker:FindObjectForCode(dungeon_code).CurrentStage = item_state
        end
    else
        manual_misc_items_storage.MANUAL_LOCATIONS[ROOM_SEED] = {}
    end

    print("reset er connections")
    EmptyLocationTargets()
    
    ScriptHost:RemoveWatchForCode("StateChanged")
    ScriptHost:RemoveOnLocationSectionHandler("location_section_change_handler")
    -- ScriptHost:RemoveOnLocationSectionChangedHandler("location_section_change_handler")
    -- print(dump_table(er_custom_storage_item.MANUAL_LOCATIONS))
    -- print(dump_table(er_custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED]))
    if er_custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] then
        for source_name, targe_name in pairs(er_custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED]) do -- redo location based on savestate for seed
            local source = Tracker:FindObjectForCode(source_name)
            local target = Tracker:FindObjectForCode(targe_name)
            _SetLocationOptions(source,target)
            _SetLocationOptions(target,source)
        end
    else
        er_custom_storage_item.MANUAL_LOCATIONS[ROOM_SEED] = {}
    end
    
    ScriptHost:AddOnFrameHandler("load handler", OnFrameHandler)
    MANUAL_CHECKED = true
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local item = ITEM_MAPPING[item_id]
    if not item or not item[1] then
        print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    for _, item_code in pairs(item[1]) do
        -- print(item[1], item[2])
        local item_obj = Tracker:FindObjectForCode(item_code)
        if item_obj then
            -- set_item_type[item[2]](item_id, item_obj) --alternate version
            if item[2] == "toggle" then
                -- print("toggle")
                item_obj.Active = true
            elseif item[2] == "progressive" then
                -- print("progressive")
                if item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            elseif item[2] == "consumable" then
                item_obj.AcquiredCount = item_obj.AcquiredCount + item_obj.Increment
            elseif item[2] == "combined_consumable" then
                -- print("combined_consumable")
                item_obj.AcquiredCount = item_obj.MaxCount -- +50/70 capacity upgrades
            elseif item[2] == "split_toggle" then
            -- print("split_toggle")
                item_obj.Active = true
                if (FIRSTSTAGE[item_id] ~= nil and item_obj.CurrentStage < 1) then -- blue shield, fighter sword, powergloves, bow+arrows 
                    item_obj.CurrentStage = 1
                elseif (SECONDSTAGE[item_id] ~= nil and item_obj.CurrentStage < 2) then -- red shield, blue mail, titans, master sword
                    item_obj.CurrentStage = 2
                elseif (THIRDSTAGE[item_id] ~= nil and item_obj.CurrentStage < 3 ) then -- tempered sword, red mail, mirror shield
                    item_obj.CurrentStage = 3
                elseif (item_id == 3  and item_obj.CurrentStage < 4) then --golden sword
                    item_obj.CurrentStage = 4
                elseif ((item_id == 88 or item_id == 59) and item_obj.CurrentStage < 2) then -- silver arrows or silvers+bow
                    item_obj.CurrentStage = 2
                end
            elseif item[2] == "progressive_toggle" then
                -- print("progressive_toggle")
                if item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            elseif item[2] == "keyring" then
                item_obj.AcquiredCount = item_obj.MaxCount
            end
        else
            print(string.format("onItem: could not find object for code %s", item_code[1]))
        end
    end
    CanFinish()
    CalcHeartpieces()
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    MANUAL_CHECKED = false
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end
    
    for _, location in pairs(location_array) do
        local location_obj = Tracker:FindObjectForCode(location)
        -- print(location, location_obj)
        if location_obj then

            if location:sub(1, 1) == "@" then
                location_obj.AvailableChestCount = location_obj.AvailableChestCount - 1
            else
                location_obj.Active = true
            end
            -- if location:sub(-9, -1) == "Key Drops" then
            --     smallkey = Tracker:FindObjectForCode(location:sub(2, 3).."_smallkey")
            --     smallkey.AcquiredCount = smallkey.AcquiredCount + 1
            -- end
            -- x,_ = string.find(location, "universal")
            -- if x > 0 and Tracker:FindObjectForCode("small_keys").CurrentStage == 2 then
            --     universal = Tracker:FindObjectForCode("universal_keys")
            --     universal.AcquiredCount = universal.AcquiredCount + 1
            --     smallkey = Tracker:FindObjectForCode(location:sub(1, x-2).."_smallkey")
            --     smallkey.AcquiredCount = smallkey.AcquiredCount + 1
            -- end

            -- Tracker:FindObjectForCode("universal_keys").Active
        else
            print(string.format("onLocation: could not find location_object for code %s", location))
        end
    end
    CanFinish()
    CalcHeartpieces()
    MANUAL_CHECKED = true
end

function onEvent(key, value, old_value)
    updateEvents(value)
end

function onEventsLaunch(key, value)
    updateEvents(value)
end

---function to handle conversion of SLOT_DATA values into states for setting-items
function autoFill()
    if SLOT_DATA == nil  then
        print("its fucked")
        return
    end
    print(dump_table(SLOT_DATA))

    -- mapGlitcheMode = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4} -- noGlitches, minor, overworld, hybrid_major, no_logic
    local mapDarkRoomLogic = {[0]=0, [1]=1, [2]=2, ["none"]=2,["lamp"]=0,["troches"]=1} --lamp, torches, none
    local mapGoal = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=5, [7]=6, [8]=6, ["crystals"]=1,["ganon"]=0,["bosses"]=2,["pedestal"]=3,["ganonpedestal"]=4,["triforcehunt"]=5,["ganontriforcehunt"]=6,["localtriforcehunt"]=5,["localganontriforcehunt"]=6} --slow, fast, AD, ped, ped+ganon, tfh, local_tfh, tfh+ganon, local tfh+ganon
    -- mapEntranceRandomizer = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=6, [7]=7, [8]=8} --vanilla, dungeon simple, dungeon full, dungeon crossed, simple, restriced, full, crossed, insanity
    -- mapTriforcePiecesAvailable = {} --range 1-90
    -- mapTriforcePiecesRequiered = {} --range 1-90
    local mapDungeonItem = {[0]=0, [1]=1, [2]=1, [3]=1, [4]=1, [5]=2, [6]=0} --og dungeon, own dungeons,
    local mapDungeonItemSetting = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=6, [6]=5} --og dungeon, own dungeons,
    -- mapStartMode = {[0]=0, [1]=1, [2]=2} --standard, open, Inverted
    -- mapItemPool = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapItemFunctionality = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapEnemyHealth = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapEnemyDmg = {[0]=0, [1]=1, [2]=2} --default, shuffled, chaos
    -- mapMedallions = {[0]="ether", [1]="bombos", [2]="quake"} -- ether, bombos, quake
    local mapMedallions = {[0]="ether", [1]="bombos", [2]="quake", ["Ether"]="ether", ["Bombos"]="bombos", ["Quake"]="quake"} -- ether, bombos, quake
    -- mapCrystalGanon = {} -- range 0-7
    -- mapGTCrystals = {} -- range 0-7
    -- mapRandomizeShopInventory = {} -- range 0-30
    -- mapShuffleShopInventories = {[0]=false, [1]=true} -- false, true
    -- mapRandomizeShopPrices = {[0]=false, [1]=true} -- false, true
    -- mapRandomizeCostType = {[0]=false, [1]=true} -- false, true
    -- mapIncludeWitchhut = {[0]=false, [1]=true} -- false, true
    -- mapShopPriceModifier = {} -- range 0-400
    -- mapShuffleCapacityUpgrades = {[0]=0, [1]=1, [2]=2} -- off, on, combined into one
    local mapBosses = {[0]=0, [1]=1, [2]=1, [3]=1, [4]=2} -- vanilla, basic, full, chaos, singularity
    -- mapEnemizer = {[0]=false, [1]=true} -- false, true
    -- mapProgressive = {[0]=0, [1]=1, [2]=2} -- off, grouped,_random, on
    -- mapSwordless = {[0]=false, [1]=true} -- false, true
    -- mapBomblessStart = {[0]=false, [1]=true} -- false, true
    -- mapRetroBow = {[0]=false, [1]=true} -- false, true
    -- mapRetroCave = {[0]=false, [1]=true} -- false, true
    local mapDungeon = {
        ["Eastern Palace"] = {"ep_boss", "ep"},
        ["Desert Palace"] = {"dp_boss", "dp"},
        ["Tower of Hera"] = {"toh_boss", "toh"},
        ["Palace of Darkness"] = {"pod_boss", "pod"},
        ["Swamp Palace"] = {"sp_boss", "sp"},
        ["Skull Woods"] = {"sw_boss", "sw"},
        ["Thieves Town"] = {"tt_boss", "tt"},
        ["Thieves\' Town"] = {"tt_boss", "tt"},
        ["Ice Palace"] = {"ip_boss", "ip"},
        ["Misery Mire"] = {"mm_boss", "mm"},
        ["Turtle Rock"] = {"tr_boss", "tr"},
        ["Ganons Tower - top"] = {"gt_boss",},
        ["Ganons Tower - bottom"] = {"gt_ice",},
        ["Ganons Tower - middle"] = {"gt_lanmo"},
    }
    local mapBoss = {
        ["Armos Knights"] = 1,
        ["Lanmola"] = 2,
        ["Moldorm"] = 3,
        ["Helmasaur King"] = 4,
        ["Arrghus"] = 5,
        ["Mothula"] = 6,
        ["Blind"] = 7,
        ["Kholdstare"] = 8,
        ["Vitreous"] = 9,
        ["Trinexx"] = 10
    }
    local mapRewards = {
        ["Crystal 1"] = 1,
        ["Crystal 2"] = 1,
        ["Crystal 3"] = 1,
        ["Crystal 4"] = 1,
        ["Crystal 5"] = 2,
        ["Crystal 6"] = 2,
        ["Crystal 7"] = 1,
        ["Green Pendant"] = 4,
        ["Blue Pendant"] = 3,
        ["Red Pendant"] = 3,
    }
    local mapEntranceShuffle = {
        [0] = 0,
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 2,
        [5] = 2,
        [6] = 2,
        [7] = 2,
        [8] = 3
    }

    local mapStages = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=6, [7]=7, [8]=8, ["open"]=1,["inverted"]=2,["standard"]=0}
    local mapToggle = {[0]=false, [1]=true, [2]=true,[3]=true,[4]=true,[6]=true} -- false, true

    local slotCodes = {
        crystals_needed_for_gt = {codes={"gt_access"}, mappings={nil}, autofill="autofill_goal_reqs",},
        crystals_needed_for_ganon = {codes={"ganon_killable"}, mappings={nil}, autofill="autofill_goal_reqs",},
        triforce_pieces_required = {codes={"triforce_pieces_needed"}, mappings={nil}, autofill="autofill_goal_reqs",},
        open_pyramid = {codes={"pyramid_state"}, mappings={mapToggle}, autofill="autofill_goal_reqs",},
        -- triforce_pieces_mode = {codes={""}, mapping, autofill="",=},
        -- triforce_pieces_percentage = {codes={""}, mapping, autofill="",=},
        -- triforce_pieces_available = {codes={"triforce_pieces_needed", mapping, autofill="",=},
        -- triforce_pieces_extra = {codes={""}, mapping, autofill="",=}
        big_key_shuffle = {codes={"big_keys", "bigkeys_setting"}, mappings={mapDungeonItem, mapDungeonItemSetting}, autofill="autofill_dungeon_settings",},
        small_key_shuffle = {codes={"small_keys", "smallkeys_setting"}, mappings={mapDungeonItem, mapDungeonItemSetting}, autofill="autofill_dungeon_settings",},
        compass_shuffle = {codes={"compass", "compass_setting"}, mappings={mapDungeonItem, mapDungeonItemSetting}, autofill="autofill_dungeon_settings",},
        map_shuffle = {codes={"map", "maps_setting"}, mappings={mapDungeonItem, mapDungeonItemSetting}, autofill="autofill_dungeon_settings",},
        boss_shuffle = {codes={"boss_shuffle"}, mappings={mapBosses}, autofill="autofill_dungeon_settings",},
        -- progressive = {codes={"progressive_items"}, mappings={mapStages}, autofill="",},


        -- retro_bow = {codes={""}, mapping, autofill="",=},
        retro_caves = {codes={"retro_caves"}, mappings={mapToggle}, autofill="autofill_modes",},
        item_functionality = {codes={"item_mode"}, mappings={mapToggle}, autofill="autofill_modes",},


        -- pot_shuffle = {codes={"pot_shuffle"}, mapping, autofill="",=},
        key_drop_shuffle = {codes={"key_drop_shuffle"}, mappings={mapToggle}, autofill="autofill_dungeon_settings",},
        bombless_start = {codes={"bombless"}, mappings={mapToggle}, autofill="autofill_modes",},
        dark_room_logic = {codes={"dark_mode"}, mappings={mapDarkRoomLogic}, autofill="autofill_modes",},
        swordless = {codes={"swordless"}, mappings={mapToggle}, autofill="autofill_modes",},
        shop_item_slots = {codes={"shop_sanity"}, mappings={nil}, autofill="autofill_sanities",},
        -- randomize_shop_inventories = {codes={""}, mappings={mapToggle}, autofill="autofill_sanities",},
        -- shuffle_shop_inventories = {codes={""}, mappings={mapToggle}, autofill="autofill_sanities",},
        shuffle_capacity_upgrades = {codes={"shop_shuffle_capacity"}, mappings={mapToggle}, autofill="autofill_misc",},
        entrance_shuffle = {codes={"er_tracking"}, mappings={mapEntranceShuffle}, autofill="autofill_misc",},
        goal = {codes={"goal"}, mappings={mapGoal}, autofill="autofill_goal_reqs",},
        mode = {codes={"start_option"}, mappings={mapStages}, autofill="autofill_modes",},
        enemy_shuffle = {codes={"enemizer"}, mappings={mapToggle}, autofill="autofill_misc",},
    }

    -- print(dump_table(SLOT_DATA))
    -- print(Tracker:FindObjectForCode("autofill_settings").Active)
    for settings_name , settings_value in pairs(SLOT_DATA) do
        if type(settings_value) == "table" then
            if settings_name == "bosses" then
                if Tracker:FindObjectForCode("autofill_dungeon_settings").Active then
                    SKIP_BOSSSHUFFLE = true
                    for dungeon, boss in pairs(settings_value) do
                        Tracker:FindObjectForCode(mapDungeon[dungeon][1]).CurrentStage = mapBoss[boss]
                    end
                end
            elseif settings_name == "prizes" then
                for dungeon, reward in pairs(settings_value) do
                    Tracker:FindObjectForCode(mapDungeon[dungeon][2]).CurrentStage = mapRewards[reward]
                end
               
            end
           
        -- print(k, v)
        -- if settings_name == "crystals_needed_for_gt"
        -- or settings_name == "crystals_needed_for_ganon"
        -- or settings_name == "triforce_pieces_required" then
        --     Tracker:FindObjectForCode(slotCodes[settings_name].code).AcquiredCount = settings_value

        -- elseif settings_name == "shop_shuffle" then
        --     item = Tracker:FindObjectForCode(slotCodes[settings_name].code)
        --     if settings_value ~= "none" then
        --         item.Active = true
        --     elseif settings_value == "none" then
        --         item.Active = false
        --     end
        else
            if settings_name == "shop_item_slots" and Tracker:FindObjectForCode(slotCodes[settings_name].autofill).Active then
                Tracker:FindObjectForCode("shop_sanity").Active = (settings_value > 0)
                Tracker:FindObjectForCode("shuffle_item_slots").BadgeText = settings_value
            elseif slotCodes[settings_name] then
                for index, _ in ipairs(slotCodes[settings_name].codes) do
                   
                    -- print("settings_name", settings_name)
                    -- print("slotCodes[settings_name]", slotCodes[settings_name])
                    -- print("slotCodes[settings_name].code", slotCodes[settings_name].code)
                    -- print("slotCodes[settings_name].code", slotCodes[settings_name].code[1])
                    -- print("slotCodes[settings_name].autoFill", slotCodes[settings_name].autofill)
                    print("<--------------------------------->")
                    if Tracker:FindObjectForCode(slotCodes[settings_name].autofill).Active then
                        print("settings_name", settings_name)
                        local item = Tracker:FindObjectForCode((slotCodes[settings_name].codes)[index])
                        if item.Type == "toggle" then
                            -- print("toggle", settings_name, settings_value)
                            item.Active = (slotCodes[settings_name].mappings[index])[settings_value]
                        elseif slotCodes[settings_name].mappings[index] == nil then
                            -- print("toggle", settings_name, settings_value)
                            item.AcquiredCount = settings_value
                        else
                            -- print("else", settings_name, settings_value)
                            -- print(k,v,Tracker:FindObjectForCode(slotCodes[k].code).CurrentStage, slotCodes[k].mapping[v])
                            item.CurrentStage = (slotCodes[settings_name].mappings[index])[settings_value]
                        end
                    end
                end
            end
        end
    end
    if Tracker:FindObjectForCode("autofill_medallions").Active then
        for _, medallion in pairs({"bombos", "ether", "quake"}) do
            Tracker:FindObjectForCode(medallion).CurrentStage = 0
        end
        if SLOT_DATA["mm_medalion"] == SLOT_DATA["tr_medalion"] then
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["mm_medalion"]]).CurrentStage = 3
        else
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["mm_medalion"]]).CurrentStage = 2
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["tr_medalion"]]).CurrentStage = 1
        end
    end
    goal_check()
end


function goal_check()
    if SLOT_DATA ~= nil  and Tracker:FindObjectForCode("autofill_goal_reqs").Active then
        local goal = Tracker:FindObjectForCode("goal")
        local ganon = Tracker:FindObjectForCode("ganon_killable")
        local triforce = Tracker:FindObjectForCode("triforce_pieces_needed")
        local goal_stage = goal.CurrentStage
        if goal_stage == 3 or
        goal_stage == 5 or
        goal_stage == 6 then
            ganon.AcquiredCount=0
            triforce.AcquiredCount=SLOT_DATA["triforce_pieces_required"]
        else
            ganon.AcquiredCount=SLOT_DATA["crystals_needed_for_ganon"]
            triforce.AcquiredCount=0
        end
    end
end


function OnNotify(key, value, old_value)
    if value ~= old_value and key == HINTS_ID then
        Tracker.BulkUpdate = true
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                if hint.status == 0 then
                    UpdateHints(hint.location, 100+hint.item_flags)
                else
                    UpdateHints(hint.location, hint.status)
                end
            end
        end
        Tracker.BulkUpdate = false
    end
end

function OnNotifyLaunch(key, value)
    if key == HINTS_ID then
        Tracker.BulkUpdate = true
        for _, hint in ipairs(value) do
            if hint.finding_player == Archipelago.PlayerNumber then
                if hint.status == 0 then
                    UpdateHints(hint.location, 100+hint.item_flags)
                else
                    UpdateHints(hint.location, hint.status)
                end
            end
        end
        Tracker.BulkUpdate = false
    end
end

function UpdateHints(locationID, status)
    if Highlight then
        -- print(locationID, status)
        local location_table = LOCATION_MAPPING[locationID]
        for _, location in ipairs(location_table) do
            if location:sub(1, 1) == "@" then
                local obj = Tracker:FindObjectForCode(location)
                if obj == nil then
                    print(string.format("No object found for code: %s", location))
                    return
                end
                if obj.ChestCount > 1 then
                    if HINTS_PRIORITY_LOOKUP[location] == nil then
                        HINTS_PRIORITY_LOOKUP[location] = {}
                    end
                    
                    HINTS_PRIORITY_LOOKUP[location][locationID] = status
                    local amount_of_entries = 0
                    for _, saved_status in pairs(HINTS_PRIORITY_LOOKUP[location]) do
                        amount_of_entries = amount_of_entries + 1
                    end
                    if amount_of_entries > 1 then
                        local max_status = 0
                        for _, saved_status in pairs(HINTS_PRIORITY_LOOKUP[location]) do
                            if HINT_PRIO_MAPPING[max_status] < HINT_PRIO_MAPPING[saved_status] and saved_status ~= 0 and saved_status ~= 100 then 
                                max_status = saved_status
                            end
                        end
                        status = max_status
                    end
                end
                if TROLL_PLAYER and HIGHLIGHT_LEVEL[status] == Highlight.Avoid then
                    obj.Highlight = HIGHLIGHT_LEVEL[30]
                else
                    obj.Highlight = HIGHLIGHT_LEVEL[status]
                end
            end
        end
    end
end


-- ScriptHost:AddWatchForCode("bombless start handler", "bombless", bombless)
-- ScriptHost:AddWatchForCode("goal handler", "goal", goal_check)
-- Archipelago:AddClearHandler("clear handler", onClear)
-- Archipelago:AddItemHandler("item handler", onItem)
-- Archipelago:AddLocationHandler("location handler", onLocation)

-- Archipelago:AddSetReplyHandler("notify handler", OnNotify)
-- Archipelago:AddRetrievedHandler("notify launch handler", OnNotifyLaunch)

-- ScriptHost:AddWatchForCode("settings autofill_dungeon_settings", "autofill_dungeon_settings", autoFill)
-- ScriptHost:AddWatchForCode("settings autofill_goal_reqs", "autofill_goal_reqs", autoFill)
-- ScriptHost:AddWatchForCode("settings autofill_medallions", "autofill_medallions", autoFill)
-- ScriptHost:AddWatchForCode("settings autofill_modes", "autofill_modes", autoFill)
-- ScriptHost:AddWatchForCode("settings autofill_misc", "autofill_misc", autoFill)
-- ScriptHost:AddWatchForCode("settings autofill_sanities", "autofill_sanities", autoFill)