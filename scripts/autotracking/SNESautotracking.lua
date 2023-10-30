-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = false
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

function autotracker_started()
    -- Invoked when the auto-tracker is activated/connected
end

AUTOTRACKER_IS_IN_TRIFORCE_ROOM = false
AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY = false

U8_READ_CACHE = 0
U8_READ_CACHE_ADDRESS = 0

U16_READ_CACHE = 0
U16_READ_CACHE_ADDRESS = 0

-- function autofillSettings(segment)

--     FLAG_CODES = {
--         -- "","","","",
--         -- "glitches_required",
--         -- "","","",
--         -- "dark_room_logic",
--         {"bigkey_shuffle","0x18016A", --  0x02
--         {"smallkey_shuffle","0x18016A", --  0x00 oder 0x01
--         {"map_shuffle","0x18016A", --  0x04
--         {"compass_shuffle","0x18016A", --  0x08
--         -- "progressive",
--         {"goals","0x18003E", --  0x01, 0x02, 0x03, 0x04, 0x05, 0x06
--         {"crystals_needed_for_gt","0x18005E", -- 
--         {"crystals_needed_for_ganon","0x18005F", -- 
--         {"mode","0x180032", "0x18004A", -- ,  0x01 for inverted
--         -- "retro_bow",
--         -- "retro_caves",
--         {"swordless","0x180043", -- , 0xFF
--         -- "item_pool",
--         {"misery_mire_medallion","0x180022", -- 0x00, 0x01, 0x02
--         {"turtle_rock_medallion","0x180023", -- , ??0x180165??
--         -- "boss_shuffle",
--         {"enemy_shuffle","0x180211", --  0x01
--         -- "pot_shuffle",
--         {"shop_shuffle","0x186560", --watch RAM on shop entry ??0x186560??
--         -- "glitch_boots",
--         {"triforce_pieces_required","0x180163"} -- 
--     } 

--     for i, j in pairs(FLAG_CODES) do
--         print(i, j)
--         print(j[1], j[2])
--         print(segment:ReadUInt8(j[2]))
--         print(
--         (segment:ReadUInt8(j[2])>> 0)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 1)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 2)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 3)& 0x01,
--         (segment:ReadUInt8(j[2])>> 4)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 5)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 6)& 0x01, 
--         (segment:ReadUInt8(j[2])>> 7)& 0x01
--     )
--     end
--     -- entrance shuffle on/off 0x18004C
--     -- gametype 0x180211
--     -- if world.goal[player] in ['pedestal', 'triforcehunt', 'localtriforcehunt', 'icerodhunt']:
--     -- rom.write_byte(0x18003E, 0x01)  # make ganon invincible
--     -- elif world.goal[player] in ['ganontriforcehunt', 'localganontriforcehunt']:
--     --     rom.write_byte(0x18003E, 0x05)  # make ganon invincible until enough triforce pieces are collected
--     -- elif world.goal[player] in ['ganonpedestal']:
--     --     rom.write_byte(0x18003E, 0x06)
--     -- elif world.goal[player] in ['bosses']:
--     --     rom.write_byte(0x18003E, 0x02)  # make ganon invincible until all bosses are beat
--     -- elif world.goal[player] in ['crystals']:
--     --     rom.write_byte(0x18003E, 0x04)  # make ganon invincible until all crystals
--     -- else:
--     --     rom.write_byte(0x18003E, 0x03)  # make ganon invincible until all crystals and aga 2 are collected
--     mapToggle={[0]=0,[1]=1}
--     mapToggleReverse={[0]=1,[1]=0,[2]=0,[3]=0,[4]=0}
--     mapTripleReverse={[0]=2,[1]=1,[2]=0}
--     mapDungeonItem={[0]=false,[1]=true,[2]=true,[3]=true,[4]=true,[6]=true}

--     -- mapGlitches={[0]=0,[1]=2,[2]=3,[3]=0,[4]=0}
--     -- progressive={[]=,}
--     mapMode={["open"]=0,["inverted"]=1,["standard"]=2}
--     mapGoals={["crystals"]=0,["ganon"]=1,["bosses"]=3,["pedestal"]=4,["ganon_pedestal"]=5,["triforce_hunt"]=6,["ganon_triforce_hunt"]=7,["ice_rod_hunt"]=8,["local_triforce_hunt"]=6,["local_ganon_triforce_hunt"]=7}
--     mapDark={["none"]=0,["lamp"]=1,["scornes"]=2} -- none=dark room, lamp=vanilla, scornes = firerod
--     mapMedalion={["Bombos"]="bombos",["Ether"]="ether",["Quake"]="quake"}
--     -- retro_caves={[]=}
--     mapBosses={[0]=0,[1]=1,[2]=1,[3]=1,[4]=2}
--     mapEnemizer={[0]=false,[1]=true,[2]=true}
--     -- shop_shuffle={[]=,}

--     slotCodes = {
--         -- glitches_required={code="glitches", mapping=mapToggleReverse},
--         dark_room_logic={code="dark_mode", mapping=mapDark},
--         bigkey_shuffle={code="big_keys", mapping=mapDungeonItem},
--         smallkey_shuffle={code="small_keys", mapping=mapDungeonItem},
--         map_shuffle={code="map", mapping=mapDungeonItem},
--         compass_shuffle={code="compass", mapping=mapDungeonItem},
--         -- progressive={code="progressive_items", mapping=mapToggle},
--         goal={code="goal", mapping=mapGoals},
--         crystals_needed_for_gt={code="gt_access", mapping=nil},
--         crystals_needed_for_ganon={code="ganon_killable", mapping=nil},
--         mode={code="start_option", mapping=mapMode},
--         -- retro_bow={code="", mapping=mapToggleReverse},
--         -- retro_caves={code="", mapping=mapToggleReverse},
--         swordless={code="swordless", mapping=mapDungeonItem},
--         -- item_pool={code="", mapping=mapToggle},
--         me_medallion={code="", mapping=mapMedalion},
--         tr_medallion={code="", mapping=mapMedalion},
--         boss_shuffle={code="boss_shuffle", mapping=mapBosses},
--         enemy_shuffle={code="enemizer", mapping=mapEnemizer},
--         -- pot_shuffle={code="", mapping=nil},
--         shop_shuffle={code="shop_sanity", mapping=nil},
--         triforce_pieces_required={code="triforce_pieces_needed", mapping=nil}
--         -- glitch_boots={code="glitches", mapping=nil}
--     }

--     if Tracker:FindObjectForCode("autofill_settings") > 0 then
--         for k,v in pairs(slot_data) do
--             -- print(k, v)
--             if k == "crystals_needed_for_gt" or k == "crystals_needed_for_ganon" or k == "triforce_pieces_required" then
--                 Tracker:FindObjectForCode(slotCodes[k].code).AcquiredCount = v
--             elseif k == "shop_shuffle" then
--                 if v ~= "none" then
--                     Tracker:FindObjectForCode(slotCodes[k].code).Active = true
--                 elseif v == "none" then
--                     Tracker:FindObjectForCode(slotCodes[k].code).Active = false
--                 end
--             elseif k == "mm_medalion" then
--                 mm_medal = Tracker:FindObjectForCode(mapMedalion[v]).CurrentStage
--                 Tracker:FindObjectForCode(mapMedalion[v]).CurrentStage = mm_medal + 2
--             elseif k == "tr_medalion" then
--                 tr_medal = Tracker:FindObjectForCode(mapMedalion[v]).CurrentStage
--                 Tracker:FindObjectForCode(mapMedalion[v]).CurrentStage = tr_medal + 1
--             elseif slotCodes[k] then
--                 if Tracker:FindObjectForCode(slotCodes[k].code).Type == "toggle" then
--                     Tracker:FindObjectForCode(slotCodes[k].code).Active = slotCodes[k].mapping[v]
--                 else 
--                     -- print(k,v,Tracker:FindObjectForCode(slotCodes[k].code).CurrentStage, slotCodes[k].mapping[v])
--                     Tracker:FindObjectForCode(slotCodes[k].code).CurrentStage = slotCodes[k].mapping[v]
--                 end
--             end
--         end
--     else
--         return
--     end
-- end

function InvalidateReadCaches()
    U8_READ_CACHE_ADDRESS = 0
    U16_READ_CACHE_ADDRESS = 0
end

function ReadU8(segment, address)
    if U8_READ_CACHE_ADDRESS ~= address then
        U8_READ_CACHE = segment:ReadUInt8(address)
        U8_READ_CACHE_ADDRESS = address        
    end

    return U8_READ_CACHE
end

function ReadU16(segment, address)
    if U16_READ_CACHE_ADDRESS ~= address then
        U16_READ_CACHE = segment:ReadUInt16(address)
        U16_READ_CACHE_ADDRESS = address        
    end

    return U16_READ_CACHE
end

function isInGame()
    return AutoTracker:ReadU8(0x7e0010, 0) > 0x05
end

function updateInGameStatusFromMemorySegment(segment)
    sleep(0.015)

    local mainModuleIdx = segment:ReadUInt8(0x7e0010)

    local wasInTriforceRoom = AUTOTRACKER_IS_IN_TRIFORCE_ROOM
    AUTOTRACKER_IS_IN_TRIFORCE_ROOM = (mainModuleIdx == 0x19 or mainModuleIdx == 0x1a)

    if AUTOTRACKER_IS_IN_TRIFORCE_ROOM and not wasInTriforceRoom then
        ScriptHost:AddMemoryWatch("LTTP Statistics", 0x7ef420, 0x46, updateStatisticsFromMemorySegment)
    end

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        if mainModuleIdx > 0x05 then
            print("Current Room Index: ", segment:ReadUInt16(0x7e00a0))
            print("Current OW   Index: ", segment:ReadUInt16(0x7e008a))
        end
        return false
    end

    return true
end

function updateProgressiveItemFromByte(segment, code, address, offset)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        item.CurrentStage = value + (offset or 0)
    end
end

function updateAga1(segment)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("aga1")
    local value = ReadU8(segment, 0x7ef3c5)
    if value >= 3 then
        item.Active = true
    else
        item.Active = false
    end
end

function testFlag(segment, address, flag)
    local value = ReadU8(segment, address)
    local flagTest = value & flag

    if flagTest ~= 0 then
        return true
    else
        return false
    end    
end

function updateProgressiveBow(segment)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("bow")

    if testFlag(segment, 0x7ef38e, 0x80) and ReadU8(segment, 0x7ef340) > 0 then
        item.Active = true
    else
        item.Active = false
    end

    if testFlag(segment, 0x7ef38e, 0x40) then
        item.CurrentStage = 1
    else
        item.CurrentStage = 0
    end
end

function updateBottles(segment)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("bottle")    
    local count = 0
    for i = 0, 3, 1 do
        if ReadU8(segment, 0x7ef35c + i) > 0 then
            count = count + 1
        end
    end
    item.CurrentStage = count
end

function updateBowAndBombUpgrade(segment)
    sleep(0.015)
    local value = segment:ReadU8(0x7ef370)
    Tracker:FindObjectForCode("bombs").AcquiredCount = 10 + value
    local value = segment:ReadU8(0x7ef371)
    Tracker:FindObjectForCode("bow").AcquiredCount = 30 + value
end

function updateToggleItemFromByte(segment, code, address)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value > 0 then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateToggleItemFromByteAndFlag(segment, code, address, flag)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(item.Name, code, flag)
        end

        local flagTest = value & flag

        if flagTest ~= 0 then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateToggleFromRoomSlot(segment, code, slot)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    local item_boss
    if code == "gt_ice" or code == "gt_lanmo" then
        item_boss = Tracker:FindObjectForCode(code)
    else
        item_boss = Tracker:FindObjectForCode(code .. "_boss")
    end
    if item then
        local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))
        
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(roomData)
        end

        item.Active = (roomData & (1 << slot[2])) ~= 0
        item_boss.Active = (roomData & (1 << slot[2])) ~= 0
    end
end

function updateFlute(segment)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("flute")
    local value = ReadU8(segment, 0x7ef38c)

    local fakeFlute = value & 0x02
    local realFlute = value & 0x01

    if realFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 2
    elseif fakeFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 1
    else
        item.Active = false
    end
end

function updateConsumableItemFromByte(segment, code, address, roomSlots)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local keyDropCount = 0

        if Tracker:FindObjectForCode("key_drop_shuffle").Active then
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(roomData, 1 << slot[2], roomData & (1 << slot[2]), item.AcquiredCount)
                end
                    
                if (roomData & (1 << slot[2])) ~= 0 then
                    keyDropCount = keyDropCount + 1
                end
            end
        end

        item.AcquiredCount = value + keyDropCount
    else
        print("Couldn't find item: ", code)
    end
end

function updateConsumableItemFromTwoByteSum(segment, code, address, address2, roomSlots)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local value2 = ReadU8(segment, address2)
        local keyDropCount = 0

        if  Tracker:FindObjectForCode("key_drop_shuffle").Active then
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(roomData, 1 << slot[2], roomData & (1 << slot[2]), item.AcquiredCount)
                end
                    
                if (roomData & (1 << slot[2])) ~= 0 then
                    keyDropCount = keyDropCount + 1
                end
            end
        end
        item.AcquiredCount = value + value2 + keyDropCount
    else
        print("Couldn't find item: ", code)
    end
end

function updatePseudoProgressiveItemFromByteAndFlag(segment, code, address, flag, locationCode)
    sleep(0.015)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local flagTest = value & flag

        local isCleared = false
        if locationCode then
            local location = Tracker:FindObjectForCode(locationCode)
            if location then
                if location.AvailableChestCount == 0 then
                    isCleared = true
                end
            end
        end

        if isCleared then
            item.CurrentStage = math.max(2, item.CurrentStage)
        elseif flagTest ~= 0 then
            item.CurrentStage = math.max(1, item.CurrentStage)
        else
            item.CurrentStage = 0
        end    
    end
end

function updateSectionChestCountFromByteAndFlag(segment, locationRef, address, flag, callback)
    sleep(0.015)
    local location = Tracker:FindObjectForCode(locationRef)
    if location then
        -- Do not auto-track this the user has manually modified it
        if location.Owner.ModifiedByUser then
            return
        end

        local value = ReadU8(segment, address)
        
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(locationRef, value)
        end

        if (value & flag) ~= 0 then
            location.AvailableChestCount = 0
            if callback then
                callback(true)
            end
        else
            location.AvailableChestCount = location.ChestCount
            if callback then
                callback(false)
            end
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Couldn't find location", locationRef)
    end
end

function updateSectionChestCountFromOverworldIndexAndFlag(segment, locationRef, index, callback)
    updateSectionChestCountFromByteAndFlag(segment, locationRef, 0x7ef280 + index, 0x40, callback)
end

local clock = os.clock
function sleep(n)-- seconds
local t0 = clock()
while clock() - t0 <= n do end
end

function updateSectionChestCountFromRoomSlotList(segment, locationRefList, roomSlots, callback)
    sleep(0.015)
    for h,locationRef in pairs(locationRefList) do
        local location = Tracker:FindObjectForCode(locationRef)
        if location then
            -- Do not auto-track this the user has manually modified it
            if location.Owner.ModifiedByUser then
                return
            end

            local clearedCount = 0
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(locationRef, roomData, 1 << slot[2], roomData & (1 << slot[2]), location.AvailableChestCount)
                end
                    
                if (roomData & (1 << slot[2])) ~= 0 then
                    clearedCount = clearedCount + 1
                end
            end

            location.AvailableChestCount = location.ChestCount - clearedCount

            if callback then
                callback(clearedCount > 0)
            end
        end
    end
end

function updateBombIndicatorStatus(status)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("big_bomb")
    if item then
        if status then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateBatIndicatorStatus(status)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("powder")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end

function updateShovelIndicatorStatus(status)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("shovel")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end

function updateMushroomStatus(status)
    sleep(0.015)
    local item = Tracker:FindObjectForCode("mushroom")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end

function updateNPCItemFlagsFromMemorySegment(segment)
    sleep(0.015)

    if not isInGame() then
        return false
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end

    InvalidateReadCaches()
    
    updateSectionChestCountFromByteAndFlag(segment, "@Light Death Mountain Left Bottom/Rescue Old Man/Rescue Old Man", 0x7ef410, 0x01) --?
    updateSectionChestCountFromByteAndFlag(segment, "@Dark Death Mountain Left/Rescue Old Man/Rescue Old Man", 0x7ef410, 0x01)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Zora's Damoain/King Zora (Scam)", 0x7ef410, 0x02)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Sick Kid/Sick Kid", 0x7ef410, 0x04)
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Bottom/Stumpy/Stumpy", 0x7ef410, 0x08)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Sahasrahla's Hut/Sahasrahla's Item", 0x7ef410, 0x10)
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Right/Catfish/Catfish Item", 0x7ef410, 0x20)
    -- 0x40 is unused
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Library/Library", 0x7ef410, 0x80)

    updateSectionChestCountFromByteAndFlag(segment, "@Light Death Mountain Left Top/Ether Tablet/Ether Tablet", 0x7ef411, 0x01)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Bombos Tablet/Bombos Tablet", 0x7ef411, 0x02)
    -- @todo Find the Location where the Dwarven Smiths check is stored
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Left/Breadsmiths/Rescue Dwarf", 0x7ef411, 0x04)
    -- 0x08 is no longer relevant
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Lost Woods/Mushroom", 0x7ef411, 0x10)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Potion Shop (Witch Hut)/Deliver Mushroom (Brew Drugs)", 0x7ef411, 0x20, updateMushroomStatus)
    -- 0x40 is unused
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Magic Bat/Visit Satan", 0x7ef411, 0x80, updateBatIndicatorStatus)    

end

function updateOverworldEventsFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end    

    InvalidateReadCaches()

    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Light Death Mountain Left Bottom/Spectacle Rock/Top Item",3)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Light Death Mountain Right/Floating Island/Item on Floating Island",5)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Race/Race",40)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Flute Spot/Flute Spot",42, updateShovelIndicatorStatus)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Desert Ledge/Ledge Item",48)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Lake Hylia/Lake Island",53)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Dam/Sunken Treasure",59)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Left/Bumper Cave/Bumper Cave Item",74)
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Bumper Cave/Bumper Cave Item",74)  
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Right/Pyramid Ledge/Pyramid Ledge Item",91)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Bottom/Digging Game/Digging Game",104)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Master Sword Pedestal/Pedestal",128)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Zora's Damoain/Zora Ledge",129)    
end

function updateRoomsFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateToggleFromRoomSlot(segment, "ep", { 200, 11 })
        updateToggleFromRoomSlot(segment, "dp", { 51, 11 })
        updateToggleFromRoomSlot(segment, "toh", { 7, 11 })
        updateToggleFromRoomSlot(segment, "pod", { 90, 11 })
        updateToggleFromRoomSlot(segment, "sp", { 6, 11 })
        updateToggleFromRoomSlot(segment, "sw", { 41, 11 })
        updateToggleFromRoomSlot(segment, "tt", { 172, 11 })
        updateToggleFromRoomSlot(segment, "ip", { 222, 11 })
        updateToggleFromRoomSlot(segment, "mm", { 144, 11 })
        updateToggleFromRoomSlot(segment, "tr", { 164, 11 })
        -- todo find correct RAM position for tracking defeat of GT refights
        updateToggleFromRoomSlot(segment, "gt", { 78, 11 })
        updateToggleFromRoomSlot(segment, "gt_ice", { 28, 11 })
        updateToggleFromRoomSlot(segment, "gt_lanmo", { 108, 11 })
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end    
-- 255 light DM shop
-- 265 witch shop
-- 274 lake hylia shop, dark dm shop, 
-- 271 dark witch shop, dark lumberjack, dark kak, dark lake hylia
-- 272 dark red shield shop
-- 287 light kak shop
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Link's House/Chest"}, { { 0, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Link's House/Chest", "@Darkworld Bottom/Link's House/Chest"}, { { 260, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Kakariko Well/Well Items"}, { { 47, 5 }, { 47, 6 }, { 47, 7 }, { 47, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Kakariko Well/Back Chest"}, { { 47, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Hookshot Cave/Bottom Right Chest"}, { { 60, 7 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Hookshot Cave/remaining Chests"}, { { 60, 4 }, { 60, 5 }, { 60, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Secret Passage/Secret Passage Chest"}, { { 85, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Lost Woods - Hideout/Hideout"}, { { 225, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Lumberjacks/Tree"}, { { 226, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Left Bottom/Spectacle Rock/Item inside"}, { { 234, 10 } })        
    updateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Paradox Cave/Lower"}, { { 239, 4 }, { 239, 5 }, { 239, 6 }, { 239, 7 }, { 239, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Superbunny Cave/Superbunny Chest"}, { { 248, 4 }, { 248, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Spiral Cave/Spiral Cave Item"}, { { 254, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Paradox Cave/Upper"}, { { 255, 4 }, { 255, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Backside Pub/Backside Pub"}, { { 259, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Bottom/Link's House/Chest"}, { { 260, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Sahasrahla's Hut/Back Items"}, { { 261, 4 }, { 261, 5 }, { 261, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Brewery (Glory Hole)/Brewery"}, { { 262, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Chest Game (Money Making Game)/Chest Game"}, { { 262, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Chicken Hut/Chicken Hut"}, { { 264, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Aginah's Cave/Aginah's Cave"}, { { 266, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Dam/Dam Chest"}, { { 267, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Mimic Cave/Mimic Cave Chest"}, { { 268, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Swamp/Mire Shed/Shed"}, { { 269, 4 }, { 269, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/King's Tomb/King's Tomb"}, { { 275, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Waterfall Fairy/Chest"}, { { 276, 4 }, { 276, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Right/Big Bomb Fairy/Boom"}, { { 278, 4 }, { 278, 5 } }, updateBombIndicatorStatus)
    updateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Left/Spike Cave/Spike Cave Chest"}, { { 279, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Graveyard Ledge/Graveyard Ledge"}, { { 283, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Cave 45/Cave 45"}, { { 283, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/C-Shaped House/C-Shaped House"}, { { 284, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Blind's Hideout/Hideout"}, { { 285, 5 }, { 285, 6 }, { 285, 7 }, { 285, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Blind's Hideout/Back Chest"}, { { 285, 4 } })   
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Bottom/Hype Cave/Hype"}, { { 286, 4 }, { 286, 5 }, { 286, 6 }, { 286, 7 }, { 286, 10 } }) 
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Ice Rod Cave/Ice Rod Chest"}, { { 288, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Mini Moldorm Cave/Mini Moldorm Chest"}, { { 291, 4 }, { 291, 5 }, { 291, 6 }, { 291, 7 }, { 291, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Bonk Pile/Bonk Pile Chest"}, { { 292, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Checkerboard Cave/Checkerboard Cave Item"}, { { 294, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Peg Cave/Peg Cave"}, { { 295, 10 } })


    -- Hyrule Castle & Escape
    updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Key Drops"}, { { 113, 10 }, { 114, 10 }, { 128, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Map Chest"}, { { 114, 4 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Zelda's Chest"}, { { 128, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Key Drops"}, { { 33, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Secret Room"}, {  { 17, 4 }, { 17, 5 }, { 17, 6 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@CE/Sanctuary/Sanctuary Chest"}, { { 18, 4 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Boomerang Chest","@Hyrule Castle/Boomerang Chest/Boomerang Chest"}, { { 113, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Boomerang Guard Key Drop/Boomerang Guard Key Drop"}, { { 113, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Map Chest","@Hyrule Castle/Map Chest/Map Chest"}, { { 114, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Map Guard Key Drop/Map Guard Key Drop"}, { { 114, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Zelda's Chest","@Hyrule Castle/Zelda's Chest/Zelda's Chest"}, { { 128, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Big Key Drop/Big Key Drop"}, { { 128, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Dark Cross","@Castle Escape/Dark Cross/Dark Cross"}, { { 50, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Key Rat Key Drop/Key Rat Key Drop"}, { { 33, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle & Sanctuary/Escape"}, { { 113, 4 },{ 114, 4 },{ 128, 4 },{ 50, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Left/Secret Passage Left"}, {  { 17, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Middle/Secret Passage Middle"}, { { 17, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Right/Secret Passage Right"}, {  { 17, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@CE/Sanctuary/Sanctuary Chest","@Sanctuary/Sanctuary Chest/Sanctuary Chest"}, { { 18, 4 } })

    -- Agahni's Tower
    updateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Key Drops", "@AT-inverted/Agahnim's Tower/Key Drops"}, { { 176, 10 }, { 208, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Front","@Agahnim's Tower/Front/Front", "@AT-inverted/Agahnim's Tower/Front"}, { { 224, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Maze Chest","@Agahnim's Tower/Maze Chest/Maze Chest", "@AT-inverted/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Agahnim's Tower/Circle of Pots Key Drop/Circle of Pots Key Drop"}, { { 176, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Agahnim's Tower/Dark Archer Key Drop/Dark Archer Key Drop"}, { { 208, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@AT-inverted/Agahnim's Tower/Room 03"}, { { 224, 4 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@AT-inverted/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
    
    

    -- Eastern palace
    updateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Dungeon Chest"}, { { 185, 4 }, { 168, 4 }, { 169, 4 }, { 170, 4 }, { 184, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Key Drops"}, { { 186, 10 }, { 153, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Dark Square Pot Key/Dark Square Pot Key"}, { { 186, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Dark Eyegore Key Drop/Dark Eyegore Key Drop"}, { { 153, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Compass Chest/Compass Chest"}, { { 168, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Big Chest/Big Chest"}, { { 169, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Map Chest/Map Chest"}, { { 170, 4 } })
    updateSectionChestCountFromRoomSlotList(segment,  {"@Eastern Palace/Cannonball Chest/Cannonball Chest"}, { { 185, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Big Key Chest/Big Key Chest"}, { { 184, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Boss Item", "@Eastern Palace/Boss/Boss Item"}, { { 200, 11 } })

    --Desert Palace
    updateSectionChestCountFromRoomSlotList(segment, {"@DP/Desert Palace/Dungeon Chest"}, { { 133, 4 },{ 115, 4 },{ 115, 5 },{ 116, 4 },{ 117, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@DP Back/Desert Palace Back/Key Drops"}, { { 67, 10 }, { 83, 10 }, { 99, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"}, { { 67, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key"}, { { 83, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Desert Tiles 1 Pot Key/Desert Tiles 1 Pot Key"}, { { 99, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Compass Chest/Compass Chest"}, { { 133, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Big Chest/Big Chest"}, { { 115, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Torch/Torch"}, { { 115, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Map Chest/Map Chest"}, { { 116, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Big Key Chest/Big Key Chest"}, { { 117, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@DP Back/Desert Palace Back/Boss Item","@Desert Palace Back/Boss/Boss Item"}, { { 51, 11 } })

    -- Tower of Hera
    updateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Lower"}, { { 119, 4 },{ 135, 4 },{ 135, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Upper"}, { { 39, 4 },{ 39, 5 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Boss Item"}, { { 7, 11 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Big Key Chest/Big Key Chest"}, { { 119, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Map Chest/Map Chest"}, { { 135, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Basement Cage/Basement Cage"}, { { 135, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Compass Chest/Compass Chest"}, { { 39, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Big Chest/Big Chest"}, { { 39, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Boss Item","@Tower of Hera/Boss/Boss Item"}, { { 7, 11 } })

    -- Palace of Darkness
    updateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Dungeon Chest"}, { 
        { 58, 4 },{ 42, 4 },{ 42, 5 },{ 43, 4 },{ 25, 4 },{ 25, 5 },{ 26, 4 },
        { 26, 5 },{ 26, 6 },{ 9, 4 },{ 10, 4 },{ 106, 4 },{ 106, 5 } 
    })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Boss Item"}, { { 90, 11 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Big Key Chest/Big Key Chest"}, { { 58, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/The Arena Bridge/Bridge"}, { { 42, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/The Arena Ledge/Ledge"}, { { 42, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Map Chest/Map Chest"}, { { 43, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Maze Top/Dark Maze Top"}, { { 25, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Maze Bottom/Dark Maze Bottom"}, { { 25, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Big Chest/Big Chest"}, { { 26, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Compass Chest/Compass Chest"}, { { 26, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Harmless Hellway/Harmless Hellway"}, { { 26, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Shooter Room/Shooter Room"}, {  { 9, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Stalfos Basement/Stalfos Basement"}, { { 10, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Basement Left/Dark Basement Left"}, {{ 106, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Basement Right/Dark Basement Right"}, {{ 106, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Boss Item","@Palace of Darkness/Boss/Boss Item"}, { { 90, 11 } })

    -- Swamp Palace
    updateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Key Drops"}, { { 53, 10 }, { 54, 10 }, { 55, 10 }, { 56, 10 }, { 22, 10 } }) -- entrance
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Waterway Pot Key/Waterway Pot Key"}, { { 22, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Trench 2 Pot Key/Trench 2 Pot Key"}, { { 53, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Hookshot Pot Key/Hookshot Pot Key"}, { { 54, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Trench 1 Pot Key/Trench 1 Pot Key"}, { { 55, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Pot Row Pot Key/Pot Row Pot Key"}, { { 56, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Dungeon Chest"}, { { 55, 4 } }) --bombable wall
    updateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Dungeon Chest"}, { 
        { 40, 4 },{ 55, 4 },{ 54, 4 },{ 53, 4 },{ 52, 4 },{ 70, 4 },{ 118, 4 },{ 118, 5 },{ 102, 4 } 
    })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Boss Item"}, { { 6, 11 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Entrance/Entrance"}, { { 40, 4 } }) -- entrance
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Map Chest/Map Chest"}, { { 55, 4 } }) --bombable wall
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Big Chest/Big Chest"}, { { 54, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Big Key Chest/Big Key Chest"}, { { 53, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/West Chest/West Chest"}, { { 52, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Compass Chest/Compass Chest"}, { { 70, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Flooded Room Left/Flooded Room Left"}, { { 118, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Flooded Room Right/Flooded Room Right"}, { { 118, 5 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Waterfall Room/Waterfall Room"}, { { 102, 4 } })
    
    updateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Boss Item","@Swamp Palace/Boss/Boss Item"}, { { 6, 11 } })

    -- Skull Woods
    updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Front/Dungeon Chest"}, { 
        { 103, 4 },{ 104, 4 },{ 87, 4 },{ 87, 5 },{ 88, 4 },{ 88, 5 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Front/Key Drops", "@Skull Woods Front/West Lobby Pot Key/West Lobby Pot Key"}, { { 86, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Key Drops", "@Skull Woods Back/Spike Corner Key Drop/Spike Corner Key Drop"}, { { 57, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Dungeon Chest"}, { { 89, 4 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Boss Item"}, { { 41, 11 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Compass Chest/Compass Chest"}, { { 103, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Pinball Room/Pinball Room"}, { { 104, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Big Key Chest/Big Key Chest"}, { { 87, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Pot Prison/Pot Prison"}, { { 87, 5 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Big Chest/Big Chest"}, { { 88, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Map Chest/Map Chest"}, { { 88, 5 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Dungeon Chest","@Skull Woods Back/Bridge Room/Bridge Room"}, { { 89, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Boss Item","@Skull Woods Back/Boss/Boss Item"}, { { 41, 11 } })

    -- Thieves Town
    updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Front"}, { { 203, 4 }, { 219, 4 }, { 219, 5 }, { 220, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Back"}, { { 101, 4 }, { 69, 4 }, { 68, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Key Drops"}, { { 171, 10}, { 188, 10 } })
    
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Spike Switch Pot Key/Spike Switch Pot Key"}, { { 171, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Hallway Pot Key/Hallway Pot Key"}, { { 188, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Back"}, { { 68, 4 } }) --big chest
    -- updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Boss Item"}, { { 172, 11 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Ambush Chest/Ambush Chest"}, { { 203, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Map Chest/Map Chest"}, { { 219, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Big Key Chest/Big Key Chest"}, { { 219, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Compass Chest/Compass Chest"}, { { 220, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Attic/Attic"}, { { 101, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Blind's Cell/Blind's Cell"}, { { 69, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Big Chest/Big Chest"}, { { 68, 4 } }) --big chest
    updateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Boss Item","@Thieves Town Back/Boss/Boss Item"}, { { 172, 11 } })

    -- Ice Palace
    updateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Dungeon Chest"}, { 
        { 174, 4 },{ 158, 4 },{ 126, 4 },{ 95, 4 },{ 63, 4 },{ 46, 4 },{ 31, 4 }
    })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Boss Item"}, { { 222, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Key Drops"}, { { 14, 10 }, { 62, 10 }, { 63, 10 }, { 159, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Jelly Key Drop/Jelly Key Drop"}, { { 14, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Conveyor Key Drop/Conveyor Key Drop"}, { { 62, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Hammer Block Key Drop/Hammer Block Key Drop"}, { { 63, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Many Pots Pot Key/Many Pots Pot Key"}, { { 159, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Iced T Room/Iced T Room"}, { { 174, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Big Chest/Big Chest"}, { { 158, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Freezor Chest/Freezor Chest"}, { { 126, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Spike Room/Spike Room"}, { { 95, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Map Chest/Map Chest"}, { { 63, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Compass Chest/Compass Chest"}, { { 46, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Big Key Chest/Big Key Chest"}, { { 31, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Boss Item","@Ice Palace/Boss/Boss Item"}, { { 222, 11 } })

    -- Misery Mire
    updateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Dungeon Chest"}, { 
        { 162, 4 },{ 179, 4 },{ 193, 4 },{ 194, 4 },{ 195, 4 },{ 195, 5 },{ 209, 4 }
    })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Boss Item"}, { { 144, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Key Drops"}, { { 161, 10 }, { 179, 10 }, { 193, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"}, { { 161, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Spikes Pot Key/Spikes Pot Key"}, { { 179, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop"}, { { 193, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Bridge Chest/Bridge Chest"}, { { 162, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Spike Chest/Spike Chest"}, { { 179, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Compass Chest/Compass Chest"}, { { 193, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Main Lobby/Main Lobby"}, { { 194, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Map Chest/Map Chest"}, { { 195, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Big Chest/Big Chest"}, { { 195, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Big Key Chest/Big Key Chest"}, { { 209, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Boss Item","@Misery Mire/Boss/Boss Item"}, { { 144, 11 } })

    -- @todo: split TR into  completable w/o bosskey
    -- Turtle Rock
    updateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Front/Dungeon Chest"}, { 
        { 214, 4 },{ 182, 4 },{ 183, 4 },{ 183, 5 },{ 20, 4 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Dungeon Chest"}, { 
       { 213, 4 },{ 213, 5 },{ 213, 6 },{ 213, 7 },{ 36, 4 },{ 4,4 }
    })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Boss Item"}, { { 164, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Front/Key Drops"}, { { 19, 10 }, { 182, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Pokey 1 Key Drop/Pokey 1 Key Drop"}, { { 182, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Pokey 2 Key Drop/Pokey 2 Key Drop"}, { { 19, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Compass Chest/Compass Chest"}, { { 214, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Chain Chomps/Chain Chomps"}, { { 182, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Map Chest/Map Chest"}, { { 183, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Roller Room Right/Roller Room Right"}, { { 183, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Big Key Chest/Big Key Chest"}, { { 20, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Top Left/Eye Bridge Top Left"}, { { 213, 4 }, })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right"}, { { 213, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Bottom Left/Eye Bridge Bottom Left"}, { { 213, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Bottom Right/Eye Bridge Bottom Right"}, { { 213, 7 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Big Chest/Big Chest"}, { { 36, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Crystalroller Room/Crystalroller Room"}, { { 4,4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Boss Item","@Turtle Rock Back/Boss/Boss Item"}, { { 164, 11 } })
    
    -- @todo: split GT into right/left side
    -- Ganon's Tower
    updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Key Drops", "@GT-inverted/Ganon's Tower/Key Drops"}, {
        { 138, 10 }, { 155, 10 }, { 61, 10 }, { 123, 10 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Leftside"}, {
        { 140, 4 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 }, 
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Leftside"}, {
        { 140, 4 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 }, 
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Rightside"}, {
       { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Rightside"}, {
       { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Big Chest + Ice refight"}, {
       { 140, 7 }, { 140, 8 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {
       { 140, 7 }, { 140, 8 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
    })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 }, { 61, 5 }, { 61, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 }, { 61, 5 }, { 61, 6 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })

    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Conveyor Cross Pot Key/Conveyor Cross Pot Key"}, {{ 138, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Double Switch Pot Key/Double Switch Pot Key"}, {{ 155, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Key Drop/Mini Helmasaur Key Drop"}, {{ 61, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key"}, {{ 123, 10 } })

    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Bob's Torch/Bob's Torch", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 140, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 125, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Top Left/Randomizer Room Top Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Bottom Left/Randomizer Room Bottom Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Bottom Right/Randomizer Room Bottom Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 7 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Top Left/DMs Room Top Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Top Right/DMs Room Top Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Bottom Left/DMs Room Bottom Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Bottom Right/DMs Room Bottom Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 7 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 139, 4 } })
    
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Hope Room Left/Hope Room Left", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 140, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Hope Room Right/Hope Room Right", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 140, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Tile Room/Tile Room", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 141, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Top Right/Compass Room Top Right", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Bottom Left/Compass Room Bottom Left", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Bottom Right/Compass Room Bottom Right", "@GT-inverted/Ganon's Tower/Rightside"}, { { 157, 7 } })
    
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Bob's Chest/Bob's Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 140, 7 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Chest/Big Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 140, 8 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Chest/Big Key Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 4 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Room Left/Big Key Room Left", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 5 }})
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Room Right/Big Key Room Right", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 6 }})
    
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Room Left/Mini Helmasaur Room Left", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Room Right/Mini Helmasaur Room Right", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 6 } })
    
    updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Validation Chest/Validation Chest", "@GT-inverted/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })
    
    -- updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Ice Boss"}, { { 295, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Lanmo Refight"}, { { 295, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Boss"}, { { 295, 10 } })


end

function updateItemsFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        updateProgressiveItemFromByte(segment, "sword",  0x7ef359, 0)
        updateProgressiveItemFromByte(segment, "shield", 0x7ef35a, 0)
        updateProgressiveItemFromByte(segment, "armor",  0x7ef35b, 0)
        updateProgressiveItemFromByte(segment, "glove",  0x7ef354, 0)

        updateToggleItemFromByte(segment, "hookshot",   0x7ef342)
        updateToggleItemFromByte(segment, "bombs",      0x7ef343)
        updateToggleItemFromByte(segment, "firerod",    0x7ef345)
        updateToggleItemFromByte(segment, "icerod",     0x7ef346)
        updateToggleItemFromByte(segment, "bombos",     0x7ef347)
        updateToggleItemFromByte(segment, "ether",      0x7ef348)
        updateToggleItemFromByte(segment, "quake",      0x7ef349)
        updateToggleItemFromByte(segment, "lamp",       0x7ef34a)
        updateToggleItemFromByte(segment, "hammer",     0x7ef34b)
        updateToggleItemFromByte(segment, "bug_net",    0x7ef34d)
        updateToggleItemFromByte(segment, "book",       0x7ef34e)
        updateToggleItemFromByte(segment, "somaria",    0x7ef350)
        updateToggleItemFromByte(segment, "byrna",      0x7ef351)
        updateToggleItemFromByte(segment, "cape",       0x7ef352)
        updateToggleItemFromByte(segment, "boots",      0x7ef355)
        updateToggleItemFromByte(segment, "flippers",   0x7ef356)
        updateToggleItemFromByte(segment, "pearl",      0x7ef357)
        updateToggleItemFromByte(segment, "half_magic", 0x7ef37b)

        updateToggleItemFromByteAndFlag(segment, "blueboomerang", 0x7ef38c, 0x80) -- blue banana
        updateToggleItemFromByteAndFlag(segment, "redboomerang",  0x7ef38c, 0x40) --  red banana
        updateToggleItemFromByteAndFlag(segment, "shovel", 0x7ef38c, 0x04)
        updateToggleItemFromByteAndFlag(segment, "powder", 0x7ef38c, 0x10)
        updateToggleItemFromByteAndFlag(segment, "mushroom", 0x7ef38c, 0x20)
        updateToggleItemFromByteAndFlag(segment, "mirror", 0x7ef353, 0x02)

        updateProgressiveBow(segment)
        updateBottles(segment)
        updateFlute(segment)
        updateAga1(segment)

        updateToggleItemFromByteAndFlag(segment, "gt_bigkey",  0x7ef366, 0x04)
        updateToggleItemFromByteAndFlag(segment, "tr_bigkey",  0x7ef366, 0x08)
        updateToggleItemFromByteAndFlag(segment, "tt_bigkey",  0x7ef366, 0x10)
        updateToggleItemFromByteAndFlag(segment, "toh_bigkey", 0x7ef366, 0x20)
        updateToggleItemFromByteAndFlag(segment, "ip_bigkey",  0x7ef366, 0x40)    
        updateToggleItemFromByteAndFlag(segment, "sw_bigkey",  0x7ef366, 0x80)
        updateToggleItemFromByteAndFlag(segment, "mm_bigkey",  0x7ef367, 0x01)
        updateToggleItemFromByteAndFlag(segment, "pod_bigkey", 0x7ef367, 0x02)
        updateToggleItemFromByteAndFlag(segment, "sp_bigkey",  0x7ef367, 0x04)
        updateToggleItemFromByteAndFlag(segment, "dp_bigkey",  0x7ef367, 0x10)
        updateToggleItemFromByteAndFlag(segment, "ep_bigkey",  0x7ef367, 0x20)
        updateToggleItemFromByteAndFlag(segment, "hc_bigkey",  0x7ef367, 0x40)

        updateToggleItemFromByteAndFlag(segment, "gt_map",  0x7ef368, 0x04)
        updateToggleItemFromByteAndFlag(segment, "tr_map",  0x7ef368, 0x08)
        updateToggleItemFromByteAndFlag(segment, "tt_map",  0x7ef368, 0x10)
        updateToggleItemFromByteAndFlag(segment, "toh_map", 0x7ef368, 0x20)
        updateToggleItemFromByteAndFlag(segment, "ip_map",  0x7ef368, 0x40)    
        updateToggleItemFromByteAndFlag(segment, "sw_map",  0x7ef368, 0x80)
        updateToggleItemFromByteAndFlag(segment, "mm_map",  0x7ef369, 0x01)
        updateToggleItemFromByteAndFlag(segment, "pod_map", 0x7ef369, 0x02)
        updateToggleItemFromByteAndFlag(segment, "sp_map",  0x7ef369, 0x04)
        updateToggleItemFromByteAndFlag(segment, "dp_map",  0x7ef369, 0x10)
        updateToggleItemFromByteAndFlag(segment, "ep_map",  0x7ef369, 0x20)
        updateToggleItemFromByteAndFlag(segment, "hc_map",  0x7ef369, 0x40)

        updateToggleItemFromByteAndFlag(segment, "gt_compass",  0x7ef364, 0x04)
        updateToggleItemFromByteAndFlag(segment, "tr_compass",  0x7ef364, 0x08)
        updateToggleItemFromByteAndFlag(segment, "tt_compass",  0x7ef364, 0x10)
        updateToggleItemFromByteAndFlag(segment, "toh_compass", 0x7ef364, 0x20)
        updateToggleItemFromByteAndFlag(segment, "ip_compass",  0x7ef364, 0x40)    
        updateToggleItemFromByteAndFlag(segment, "sw_compass",  0x7ef364, 0x80)
        updateToggleItemFromByteAndFlag(segment, "mm_compass",  0x7ef365, 0x01)
        updateToggleItemFromByteAndFlag(segment, "pod_compass", 0x7ef365, 0x02)
        updateToggleItemFromByteAndFlag(segment, "sp_compass",  0x7ef365, 0x04)
        updateToggleItemFromByteAndFlag(segment, "dp_compass",  0x7ef365, 0x10)
        updateToggleItemFromByteAndFlag(segment, "ep_compass",  0x7ef365, 0x20)
        updateToggleItemFromByteAndFlag(segment, "hc_compass",  0x7ef365, 0x40)
        -- updateToggleItemFromByteAndFlag(segment, "hc_compass",  0x7ef365, 0x40)
      
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end    

    --  It may seem unintuitive, but these locations are controlled by flags stored adjacent to the item data,
    --  which makes it more efficient to update them here.
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Secret Passage/Link's Uncle", 0x7ef3c6, 0x01)    
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Hobo/Hobo", 0x7ef3c9, 0x01)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Bottle Merchant/Get Scammed (100 Rupees)", 0x7ef3c9, 0x02)
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Bottom/Purple Chest Return/Purple Chest Return", 0x7ef3c9, 0x10)

end

function updateChestKeysFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        --0x7ef37c-0x7ef389 shows only current keys in invetory
        -- if Tracker:FindObjectForCode("key_drop_shuffle").Active == true then
        --     updateConsumableItemFromByte(segment, "live_hc_smallkey", 0x7ef37c)
        --     updateConsumableItemFromByte(segment, "live_ep_smallkey", 0x7ef37e)
        --     updateConsumableItemFromByte(segment, "live_dp_smallkey", 0x7ef37f)
        --     updateConsumableItemFromByte(segment, "live_at_smallkey", 0x7ef380)
        --     updateConsumableItemFromByte(segment, "live_sp_smallkey", 0x7ef381)
        --     updateConsumableItemFromByte(segment, "live_pod_smallkey",0x7ef382)
        --     updateConsumableItemFromByte(segment, "live_mm_smallkey", 0x7ef383)
        --     updateConsumableItemFromByte(segment, "live_sw_smallkey", 0x7ef384)
        --     updateConsumableItemFromByte(segment, "live_ip_smallkey", 0x7ef385)
        --     updateConsumableItemFromByte(segment, "live_toh_smallkey",0x7ef386)
        --     updateConsumableItemFromByte(segment, "live_tt_smallkey", 0x7ef387)
        --     updateConsumableItemFromByte(segment, "live_tr_smallkey", 0x7ef388)
        --     updateConsumableItemFromByte(segment, "live_gt_smallkey", 0x7ef389)
        -- else
            -- Pending small key from chests tracking update
            -- Sewers is unused by the game - this is here for reference sake
            -- updateConsumableItemFromByte(segment, "sewers_smallkey",  0x7ef4e0)
            updateConsumableItemFromTwoByteSum(segment, "hc_smallkey", 0x7ef4e0, 0x7ef4e1, {  })
            updateConsumableItemFromByte(segment, "ep_smallkey",  0x7ef4e2, {  })
            updateConsumableItemFromByte(segment, "dp_smallkey",  0x7ef4e3, {  })
            updateConsumableItemFromByte(segment, "at_smallkey",  0x7ef4e4, {  })
            updateConsumableItemFromByte(segment, "sp_smallkey",  0x7ef4e5, {  })
            updateConsumableItemFromByte(segment, "pod_smallkey", 0x7ef4e6, {  })
            updateConsumableItemFromByte(segment, "mm_smallkey",  0x7ef4e7, {  })
            updateConsumableItemFromByte(segment, "sw_smallkey",  0x7ef4e8, {  })
            updateConsumableItemFromByte(segment, "ip_smallkey",  0x7ef4e9, {  })
            updateConsumableItemFromByte(segment, "toh_smallkey", 0x7ef4ea, {  })
            updateConsumableItemFromByte(segment, "tt_smallkey",  0x7ef4eb, {  })
            updateConsumableItemFromByte(segment, "tr_smallkey",  0x7ef4ec, {  })
            updateConsumableItemFromByte(segment, "gt_smallkey",  0x7ef4ed, {  })
        -- end
            updateConsumableItemFromTwoByteSum(segment, "hc_smallkey_drop", 0x7ef4e0, 0x7ef4e1, { { 113, 10 }, { 114, 10 }, { 33, 10 } })
            updateConsumableItemFromByte(segment, "ep_smallkey_drop",  0x7ef4e2, { { 186, 10 }, { 153, 10 } })
            updateConsumableItemFromByte(segment, "dp_smallkey_drop",  0x7ef4e3, { { 67, 10 }, { 83, 10 }, { 99, 10 } })
            updateConsumableItemFromByte(segment, "at_smallkey_drop",  0x7ef4e4, { { 176, 10 }, { 208, 10 } })
            updateConsumableItemFromByte(segment, "sp_smallkey_drop",  0x7ef4e5, { { 53, 10 }, { 54, 10 }, { 55, 10 }, { 56, 10 }, { 22, 10 } })
            updateConsumableItemFromByte(segment, "pod_smallkey_drop", 0x7ef4e6, {  })
            updateConsumableItemFromByte(segment, "mm_smallkey_drop",  0x7ef4e7, { { 161, 10 }, { 179, 10 }, { 193, 10 } })
            updateConsumableItemFromByte(segment, "sw_smallkey_drop",  0x7ef4e8, { { 86, 10 }, { 57, 10 } })
            updateConsumableItemFromByte(segment, "ip_smallkey_drop",  0x7ef4e9, { { 14, 10 }, { 62, 10 }, { 63, 10 }, { 159, 10 } })
            updateConsumableItemFromByte(segment, "toh_smallkey_drop", 0x7ef4ea, {  })
            updateConsumableItemFromByte(segment, "tt_smallkey_drop",  0x7ef4eb, { { 171, 10}, { 188, 10 } })
            updateConsumableItemFromByte(segment, "tr_smallkey_drop",  0x7ef4ec, { { 19, 10 }, { 182, 10 } })
            updateConsumableItemFromByte(segment, "gt_smallkey_drop",  0x7ef4ed, { { 138, 10 }, { 155, 10 }, { 61, 10 }, { 123, 10 } })
    end
end

function updateHeartPiecesFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end
    
    -- containers.AcquiredCount = maxHealth - (pieces.AcquiredCount // 4)
    

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateConsumableItemFromByte(segment, "heartpieces", 0x7ef448, {})
        local pieces = Tracker:FindObjectForCode("heartpieces")
        pieces.CurrentStage = pieces.AcquiredCount % 4
    end
end

function updateHeartContainersFromMemorySegment(segment)
    sleep(0.015)
    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        local pieces = Tracker:FindObjectForCode("heartpieces")
        local containers = Tracker:FindObjectForCode("heartcontainer")

        if pieces and containers then
            
            local maxHealth = (ReadU8(segment, 0x7ef36c) // 8) - 3
            
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print("Pieces: ", pieces.AcquiredCount)
                print("Max Health: ", maxHealth)
            end

            containers.AcquiredCount = maxHealth - (pieces.AcquiredCount // 4)
            pieces.CurrentStage = pieces.AcquiredCount % 4
        end
    end
end

AUTOTRACKER_STATS_MARKDOWN_FORMAT = [===[
### Post-Game Summary

Stat | Value
--|-
**Collection Rate** | %d/216
**Deaths** | %d
**Bonks** | %d
**Total Time** | %02d:%02d:%02d.%02d
]===]

function read32BitTimer(segment, baseAddress)
    local timer = 0;
    timer = timer | (ReadU8(segment, baseAddress + 3) << 24)
    timer = timer | (ReadU8(segment, baseAddress + 2) << 16)
    timer = timer | (ReadU8(segment, baseAddress + 1) << 8)
    timer = timer | (ReadU8(segment, baseAddress + 0) << 0)

    local hours = timer // (60 * 60 * 60)
    local minutes = (timer % (60 * 60 * 60)) // (60 * 60)
    local seconds = (timer % (60 * 60)) // (60)
    local frames = timer % 60

    return hours, minutes, seconds, frames
end

function updateStatisticsFromMemorySegment(segment)

    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if not AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY then
        -- Read completion timer
        local hours, minutes, seconds, frames = read32BitTimer(segment, 0x7ef43e)

        local collection_rate = ReadU8(segment, 0x7ef423)
        local deaths = ReadU8(segment, 0x7ef449)
        local bonks = ReadU8(segment, 0x7ef420)

        local markdown = string.format(AUTOTRACKER_STATS_MARKDOWN_FORMAT, collection_rate, deaths, bonks, hours, minutes, seconds, frames)
        ScriptHost:PushMarkdownNotification(NotificationType.Celebration, markdown)
    end

    AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY = true

    return true
end

-- Run the in-game status check more frequently (every 250ms) to catch save/quit scenarios more effectively
ScriptHost:AddMemoryWatch("LTTP In-Game status", 0x7e0010, 0x90, updateInGameStatusFromMemorySegment, 250)
ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, updateItemsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Room Data", 0x7ef000, 0x250, updateRoomsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Overworld Event Data", 0x7ef280, 0x82, updateOverworldEventsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP NPC Item Data", 0x7ef410, 2, updateNPCItemFlagsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Heart Piece Data", 0x7ef448, 1, updateHeartPiecesFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Heart Container Data", 0x7ef36c, 1, updateHeartContainersFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Upgrade updater", 0x7ef370, 2, updateBowAndBombUpgrade)
ScriptHost:AddMemoryWatch("LTTP Chest Key Data", 0x7ef4e0, 32, updateChestKeysFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Keydrop Data", 0x7ef37c, 32, updateChestKeysFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Room Keydrop Data", 0x7ef000, 0x250, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Settings", 0x180000, 250, autofillSettings)
