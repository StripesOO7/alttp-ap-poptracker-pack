ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil

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

-- SLOT_DATA = {}

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then return 1 end
    end
    return 0
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end


function onClear(slot_data)
    --SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, location_array in pairs(LOCATION_MAPPING) do
        for _, location in pairs(location_array) do
            if location then
                local location_obj = Tracker:FindObjectForCode(location)
                if location_obj then
                    if location:sub(1, 1) == "@" then
                        location_obj.AvailableChestCount = location_obj.ChestCount
                    else
                        location_obj.Active = false
                    end
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
                    if item[2] == "toggle" then
                        if item_code == "bombos" or item_code == "ether" or item_code == "quake" then
                            item_obj.CurrentStage = 0
                        end
                        item_obj.Active = false
                        if item_obj == "shop_shuffle" then
                            item_obj.AcquiredCount = 0
                        end
                    elseif item[2] == "progressive" then
                        item_obj.CurrentStage = 0
                        item_obj.Active = false
                    elseif item[2] == "consumable" then
                        if item_obj.MinCount then
                            item_obj.AcquiredCount = item_obj.MinCount
                        else
                            item_obj.AcquiredCount = 0
                        end
                    elseif item[2] == "progressive_toggle" then
                        item_obj.CurrentStage = 0
                        item_obj.Active = false
                    end
                end
            end
        end
    end
    PLAYER_ID = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
    SLOT_DATA = slot_data
    if Tracker:FindObjectForCode("autofill_settings").Active == true then
        autoFill(slot_data)
    end
    bossShuffle()
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
            if item[2] == "toggle" then
                -- print("toggle")
                item_obj.Active = true
                if (SECONDSTAGE[item_id] == item_id and item_obj.CurrentStage < 2) then -- red shield, blue mail, titans, master sword
                    item_obj.CurrentStage = 2
                elseif (THIRDSTAGE[item_id] == item_id and item_obj.CurrentStage < 3 ) then -- tempered sword, red mail, mirror shield
                    item_obj.CurrentStage = 3
                elseif (item_id == 3  and item_obj.CurrentStage < 4) then --golden sword
                    item_obj.CurrentStage = 4
                end
            elseif item[2] == "progressive" then
                -- print("progressive")
                if item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            elseif item[2] == "consumable" then
                -- print("consumable")
                if item_id == 76 or item_id == 77 then -- +50/70 capacity upgrades
                    item_obj.AcquiredCount = item_obj.MaxCount
                else
                    item_obj.AcquiredCount = item_obj.AcquiredCount + item_obj.Increment
                end
            elseif item[2] == "progressive_toggle" then
                -- print("progressive_toggle")
                if (item_id == 88 and item_obj.CurrentStage < 2) then -- red shield, blue mail, titans, master sword
                    item_obj.CurrentStage = 2
                elseif (item_id == 59 and item_obj.CurrentStage < 2) then -- red shield, blue mail, titans, master sword
                    item_obj.Active = true
                    item_obj.CurrentStage = 2
                elseif item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            end
        else
            print(string.format("onItem: could not find object for code %s", item_code[1]))
        end
    end
    canFinish()
    calcHeartpieces()
end

--called when a location gets cleared
function onLocation(location_id, location_name)
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
    canFinish()
    calcHeartpieces()
end

function onEvent(key, value, old_value)
    updateEvents(value)
end

function onEventsLaunch(key, value)
    updateEvents(value)
end

function autoFill()
    if SLOT_DATA == nil  then
        print("its fucked")
        return
    end
    print(dump_table(SLOT_DATA))

    -- mapGlitcheMode = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4} -- noGlitches, minor, overworld, hybrid_major, no_logic
    mapDarkRoomLogic = {[0]=0, [1]=1, [2]=2, ["none"]=2,["lamp"]=0,["troches"]=1} --lamp, torches, none
    mapGoal = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=6, [7]=5, [8]=6, ["crystals"]=1,["ganon"]=0,["bosses"]=2,["pedestal"]=3,["ganonpedestal"]=4,["triforcehunt"]=5,["ganontriforcehunt"]=6,["localtriforcehunt"]=5,["localganontriforcehunt"]=6} --slow, fast, AD, ped, ped+ganon, tfh, local_tfh, tfh+ganon, local tfh+ganon
    -- mapEntranceRandomizer = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=6, [7]=7, [8]=8} --vanilla, dungeon simple, dungeon full, dungeon crossed, simple, restriced, full, crossed, insanity
    -- mapTriforcePiecesAvailable = {} --range 1-90
    -- mapTriforcePiecesRequiered = {} --range 1-90
    mapDungeonItem = {[0]=0, [1]=1, [2]=1, [3]=1, [4]=1, [5]=2, [6]=0} --og dungeon, own dungeons,
    -- mapStartMode = {[0]=0, [1]=1, [2]=2} --standard, open, inverted
    -- mapItemPool = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapItemFunctionality = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapEnemyHealth = {[0]=0, [1]=1, [2]=2, [3]=3} --easy, normal. hard, expert
    -- mapEnemyDmg = {[0]=0, [1]=1, [2]=2} --default, shuffled, chaos
    -- mapMedallions = {[0]="ether", [1]="bombos", [2]="quake"} -- ether, bombos, quake
    mapMedallions = {[0]="ether", [1]="bombos", [2]="quake", ["Ether"]="ether", ["Bombos"]="bombos", ["Quake"]="quake"} -- ether, bombos, quake
    -- mapCrystalGanon = {} -- range 0-7
    -- mapGTCrystals = {} -- range 0-7
    -- mapRandomizeShopInventory = {} -- range 0-30
    -- mapShuffleShopInventories = {[0]=false, [1]=true} -- false, true
    -- mapRandomizeShopPrices = {[0]=false, [1]=true} -- false, true
    -- mapRandomizeCostType = {[0]=false, [1]=true} -- false, true
    -- mapIncludeWitchhut = {[0]=false, [1]=true} -- false, true
    -- mapShopPriceModifier = {} -- range 0-400
    -- mapShuffleCapacityUpgrades = {[0]=0, [1]=1, [2]=2} -- off, on, combined into one
    mapBosses = {[0]=0, [1]=1, [2]=1, [3]=1, [4]=2} -- vanilla, basic, full, chaos, singularity
    -- mapEnemizer = {[0]=false, [1]=true} -- false, true
    -- mapProgressive = {[0]=0, [1]=1, [2]=2} -- off, grouped,_random, on
    -- mapSwordless = {[0]=false, [1]=true} -- false, true
    -- mapBomblessStart = {[0]=false, [1]=true} -- false, true
    -- mapRetroBow = {[0]=false, [1]=true} -- false, true
    -- mapRetroCave = {[0]=false, [1]=true} -- false, true

    mapStages = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5, [6]=6, [7]=7, [8]=8, ["open"]=1,["inverted"]=2,["standard"]=0}
    mapToggle = {[0]=false, [1]=true, [2]=true,[3]=true,[4]=true,[6]=true} -- false, true

    slotCodes = {
        crystals_needed_for_gt = {code="gt_access", mapping=nil}, 
        crystals_needed_for_ganon = {code="ganon_killable", mapping=nil}, 
        triforce_pieces_required = {code="triforce_pieces_needed", mapping=nil},
        -- open_pyramid = {code="", mapping=},
        -- triforce_pieces_mode = {code="", mapping=}, 
        -- triforce_pieces_percentage = {code="", mapping=}, 
        -- triforce_pieces_available = {code="triforce_pieces_needed", mapping=}, 
        -- triforce_pieces_extra = {code="", mapping=}


        big_key_shuffle = {code="big_keys", mapping=mapDungeonItem}, 
        small_key_shuffle = {code="small_keys", mapping=mapDungeonItem}, 
        compass_shuffle = {code="compass", mapping=mapDungeonItem}, 
        map_shuffle = {code="map", mapping=mapDungeonItem},
        boss_shuffle = {code="boss_shuffle", mapping=mapBosses}, 
        -- progressive = {code="progressive_items", mapping=mapStages}, 


        -- retro_bow = {code="", mapping=}, 
        retro_caves = {code="retro_caves", mapping=mapToggle}, 


        -- pot_shuffle = {code="pot_shuffle", mapping=}, 
        key_drop_shuffle = {code="key_drop_shuffle", mapping=mapToggle},
        bombless_start = {code="bombless", mapping=mapToggle},
        dark_room_logic = {code="dark_mode", mapping=mapDarkRoomLogic},
        swordless = {code="swordless", mapping=mapToggle}, 
        shop_item_slots = {code="shop_sanity", mapping=nil},
        -- randomize_shop_inventories = {code="", mapping=mapToggle}, 
        -- shuffle_shop_inventories = {code="", mapping=mapToggle}, 
        shuffle_capacity_upgrades = {code="shop_shuffle_capacity", mapping=mapToggle},
        -- entrance_shuffle = {code="entrance_shuffle", mapping=}, 


        goal = {code="goal", mapping=mapGoal}, 
        mode = {code="start_option", mapping=mapStages},
        enemy_shuffle = {code="enemizer", mapping=mapToggle}, 
    }


    -- print(dump_table(SLOT_DATA))
    -- print(Tracker:FindObjectForCode("autofill_settings").Active)
    if Tracker:FindObjectForCode("autofill_settings").Active == true then
        for settings_name , settings_value in pairs(SLOT_DATA) do
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
            if settings_name == "shop_item_slots" then
                if settings_value > 0 then
                    Tracker:FindObjectForCode("shop_sanity").Active = true
                    Tracker:FindObjectForCode("shop_sanity").AcquiredCount = settings_value
                else
                    Tracker:FindObjectForCode("shop_sanity").Active = false
                    Tracker:FindObjectForCode("shop_sanity").AcquiredCount = settings_value 
                end
            elseif slotCodes[settings_name] then
                item = Tracker:FindObjectForCode(slotCodes[settings_name].code)
                if item.Type == "toggle" then
                    -- print("toggle", settings_name, settings_value)
                    item.Active = slotCodes[settings_name].mapping[settings_value]
                elseif slotCodes[settings_name].mapping == nil then
                    -- print("toggle", settings_name, settings_value)
                    item.AcquiredCount = settings_value
                else 
                    -- print("else", settings_name, settings_value)
                    -- print(k,v,Tracker:FindObjectForCode(slotCodes[k].code).CurrentStage, slotCodes[k].mapping[v])
                    item.CurrentStage = slotCodes[settings_name].mapping[settings_value]
                end
            end
        end
        if SLOT_DATA["mm_medalion"] == SLOT_DATA["tr_medalion"] then
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["mm_medalion"]]).CurrentStage = 3
        else
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["mm_medalion"]]).CurrentStage = 2
            Tracker:FindObjectForCode(mapMedallions[SLOT_DATA["tr_medalion"]]).CurrentStage = 1
        end
        goal_check()
    end
end


function bombless()
    bombs = Tracker:FindObjectForCode("bombs")
    if Tracker:FindObjectForCode("bombless").Active == false then
        bombs.AcquiredCount = bombs.AcquiredCount + 10
    else
        if bombs.AcquiredCount > 9 then
            bombs.AcquiredCount = bombs.AcquiredCount - 10
        end
    end
end

function goal_check()
    if SLOT_DATA ~= nil then
        local goal = Tracker:FindObjectForCode("goal")
        local ganon = Tracker:FindObjectForCode("ganon_killable")
        local triforce = Tracker:FindObjectForCode("triforce_pieces_needed")
        if goal.CurrentStage == 3 or 
        goal.CurrentStage == 5 or 
        goal.CurrentStage == 6 then
            ganon.AcquiredCount=0
            triforce.AcquiredCount=SLOT_DATA["triforce_pieces_required"]
        else
            ganon.AcquiredCount=SLOT_DATA["crystals_needed_for_ganon"]
            triforce.AcquiredCount=0
        end
    end
end

ScriptHost:AddWatchForCode("bombless start handler", "bombless", bombless)
ScriptHost:AddWatchForCode("goal handler", "goal", goal_check)
ScriptHost:AddWatchForCode("settings autofill handler", "autofill_settings", autoFill)
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
