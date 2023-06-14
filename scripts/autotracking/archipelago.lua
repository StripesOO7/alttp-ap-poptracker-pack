ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
--SLOT_DATA = nil

FLAG_CODES = {
    "","","","",
    "glitches_required",
    "","","",
    -- "dark_room_logic",
    "bigkey_shuffle",
    "smallkey_shuffle",
    "map_shuffle",
    "compass_shuffle",
    "progressive",
    "goals",
    "crystals_needed_for_gt",
    "crystals_needed_for_ganon",
    "mode",
    "retro_bow",
    "retro_caves",
    "swordless",
    "item_pool",
    "misery_mire_medallion",
    "turtle_rock_medallion",
    "boss_shuffle",
    "enemy_shuffle",
    "pot_shuffle",
    "shop_shuffle",
    "glitch_boots",
    "triforce_pieces_required"
}

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
                local obj = Tracker:FindObjectForCode(location)
                if obj then
                    if location:sub(1, 1) == "@" then
                        obj.AvailableChestCount = obj.ChestCount
                    else
                        obj.Active = false
                    end
                end
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                end
            end
        end
    end

    Archipelago:SetNotify({"events"})
    Archipelago:Get({"events"})

    if slot_data == nil  then
        print("its fucked")
        return
    end
    -- print(dump_table(slot_data))

    mapToggle={[0]=0,[1]=1}
    mapToggleReverse={[0]=1,[1]=0,[2]=0,[3]=0,[4]=0}
    mapTripleReverse={[0]=2,[1]=1,[2]=0}
    mapDungeonItem={[0]=false,[1]=true,[2]=true,[3]=true,[4]=true,[6]=true}

    -- mapGlitches={[0]=0,[1]=2,[2]=3,[3]=0,[4]=0}
    -- progressive={[]=,}
    mapMode={["open"]=0,["inverted"]=1,["standard"]=2}
    mapGoals={["crystals"]=0,["ganon"]=1,["bosses"]=3,["pedestal"]=4,["ganon_pedestal"]=5,["triforce_hunt"]=6,["ganon_triforce_hunt"]=7,["ice_rod_hunt"]=8,["local_triforce_hunt"]=6,["local_ganon_triforce_hunt"]=7}
    mapDark={["none"]=0,["lamp"]=1,["scornes"]=2} -- none=dark room, lamp=vanilla, scornes = firerod
    -- mapMedalion{["Bombos"]=,["Ether"]=}
    -- retro_caves={[]=}
    mapBosses={[0]=0,[1]=1,[2]=1,[3]=1,[4]=2}
    mapEnemizer={[0]=false,[1]=true,[2]=true}
    -- shop_shuffle={[]=,}


    slotCodes = {
        -- glitches_required={code="glitches", mapping=mapToggleReverse},
        dark_room_logic={code="dark_mode", mapping=mapDark},
        bigkey_shuffle={code="big_keys", mapping=mapDungeonItem},
        smallkey_shuffle={code="small_keys", mapping=mapDungeonItem},
        map_shuffle={code="map", mapping=mapDungeonItem},
        compass_shuffle={code="compass", mapping=mapDungeonItem},
        -- progressive={code="progressive_items", mapping=mapToggle},
        goals={code="goal", mapping=mapGoals},
        crystals_needed_for_gt={code="gt_access", mapping=nil},
        crystals_needed_for_ganon={code="ganon_killable", mapping=nil},
        mode={code="start_option", mapping=mapMode},
        -- retro_bow={code="", mapping=mapToggleReverse},
        -- retro_caves={code="", mapping=mapToggleReverse},
        swordless={code="swordless", mapping=mapDungeonItem},
        -- item_pool={code="", mapping=mapToggle},
        -- misery_mire_medallion={code="", mapping=mapToggle},
        -- turtle_rock_medallion={code="", mapping=mapToggle},
        boss_shuffle={code="boss_shuffle", mapping=mapBosses},
        enemy_shuffle={code="enemizer", mapping=mapEnemizer},
        -- pot_shuffle={code="", mapping=nil},
        shop_shuffle={code="shop_sanity", mapping=nil}
        triforce_pieces_required={code="triforce_pieces_needed", mapping=nil}
        -- glitch_boots={code="glitches", mapping=nil}
    }
    --print(dump_table(slot_data))

    for k,v in pairs(slot_data) do
        -- print(k, v)
        if k == "crystals_needed_for_gt" or k == "crystals_needed_for_ganon" or k == "triforce_pieces_required" then
            Tracker:FindObjectForCode(slotCodes[k].code).AcquiredCount = v
        elseif k == "shop_shuffle" then
            if v ~= "none" then
                Tracker:FindObjectForCode(slotCodes[k].code).Active = true
            elseif v == "none" then
                Tracker:FindObjectForCode(slotCodes[k].code).Active = false
            end
        elseif slotCodes[k] then
            if Tracker:FindObjectForCode(slotCodes[k].code).Type == "toggle" then
                Tracker:FindObjectForCode(slotCodes[k].code).Active = slotCodes[k].mapping[v]
            else 
                Tracker:FindObjectForCode(slotCodes[k].code).CurrentStage = slotCodes[k].mapping[v]
            end
        end
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v or not v[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        end
    else
        print(string.format("onItem: could not find object for code %s", v[1]))
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
        local obj = Tracker:FindObjectForCode(location)
        -- print(location, obj)
        if obj then

            if location:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        else
            print(string.format("onLocation: could not find object for code %s", location))
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

function updateEvents(value)
    if value ~= nil then
        local gyms = 0
        for i, code in ipairs(FLAG_CODES) do
            local bit = value >> (i - 1) & 1
            if i < 9 then
                gyms = gyms + bit
            end
            if #code>0 then
                Tracker:FindObjectForCode(code).Active = bit
            end
        end
        local gymObj = Tracker:FindObjectForCode("gyms")
        gymObj.AcquiredCount = gyms
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("event handler", onEvent)
Archipelago:AddRetrievedHandler("event launch handler", onEventsLaunch)