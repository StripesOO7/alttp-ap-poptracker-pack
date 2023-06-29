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
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        item.CurrentStage = value + (offset or 0)
    end
end

function updateAga1(segment)
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
    local item = Tracker:FindObjectForCode("bottle")    
    local count = 0
    for i = 0, 3, 1 do
        if ReadU8(segment, 0x7ef35c + i) > 0 then
            count = count + 1
        end
    end
    item.CurrentStage = count
end

function updateToggleItemFromByte(segment, code, address)
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
    local item = Tracker:FindObjectForCode("flute")
    local value = ReadU8(segment, 0x7ef38c)

    local fakeFlute = value & 0x02
    local realFlute = value & 0x01

    if realFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 1
    elseif fakeFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 0
    else
        item.Active = false
    end
end

function updateConsumableItemFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        item.AcquiredCount = value
    else
        print("Couldn't find item: ", code)
    end
end

function updateConsumableItemFromTwoByteSum(segment, code, address, address2)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local value2 = ReadU8(segment, address2)
        item.AcquiredCount = value + value2
    else
        print("Couldn't find item: ", code)
    end
end

function updatePseudoProgressiveItemFromByteAndFlag(segment, code, address, flag, locationCode)
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

function updateSectionChestCountFromRoomSlotList(segment, locationRef, roomSlots, callback)
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
                print(locationRef, roomData, 1 << slot[2])
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

function updateBombIndicatorStatus(status)
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
    local item = Tracker:FindObjectForCode("powder")
    if item then
        if status then
            item.CurrentStage = 1
        else
            item.CurrentStage = 0
        end
    end
end

function updateShovelIndicatorStatus(status)
    local item = Tracker:FindObjectForCode("shovel")
    if item then
        if status then
            item.CurrentStage = 1
        else
            item.CurrentStage = 0
        end
    end
end

function updateMushroomStatus(status)
    local item = Tracker:FindObjectForCode("mushroom")
    if item then
        if status then
            item.CurrentStage = 1
        else
            item.CurrentStage = 0
        end
    end
end

function updateNPCItemFlagsFromMemorySegment(segment)

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
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Left/Stumpy/Stumpy", 0x7ef410, 0x08)
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
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Satan/Visit Satan", 0x7ef411, 0x80, updateBatIndicatorStatus)    

end

function updateOverworldEventsFromMemorySegment(segment)
    
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
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Left/Digging Game/Digging Game",104)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Master Sword Pedestal/Pedestal",128)    
    updateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Zora's Damoain/Zora Ledge",129)    
end

function updateRoomsFromMemorySegment(segment)

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

    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Link's House/Chest", { { 0, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Kakariko Well/Well Items", { { 47, 5 }, { 47, 6 }, { 47, 7 }, { 47, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Kakariko Well/Back Chest", { { 47, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Dark Death Mountain Right/Hookshot Cave/Bottom Right Chest", { { 60, 7 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Dark Death Mountain Right/Hookshot Cave/remaining Chests", { { 60, 4 }, { 60, 5 }, { 60, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Secret Passage/Secret Passage Chest", { { 85, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Lost Woods - Hideout/Hideout", { { 225, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Lumberjacks/Tree", { { 226, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Light Death Mountain Left Bottom/Spectacle Rock/Item inside", { { 234, 10 } })        
    updateSectionChestCountFromRoomSlotList(segment, "@Light Death Mountain Right/Paradox Cave/Lower", { { 239, 4 }, { 239, 5 }, { 239, 6 }, { 239, 7 }, { 239, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Dark Death Mountain Right/Superbunny Cave/Superbunny Chest", { { 248, 4 }, { 248, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Light Death Mountain Right/Spiral Cave/Spiral Cave Item", { { 254, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Light Death Mountain Right/Paradox Cave/Upper", { { 255, 4 }, { 255, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Backside Pub/Backside Pub", { { 259, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/Link's House/Chest", { { 260, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Sahasrahla's Hut/Back Items", { { 261, 4 }, { 261, 5 }, { 261, 6 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/Brewery (Glory Hole)/Brewery", { { 262, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/Chest Game (Money Making Game)/Chest Game", { { 262, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Chicken Hut/Chicken Hut", { { 264, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "Lightworld/Aginah's Cave/Aginah's Cave", { { 266, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Dam/Dam Chest", { { 267, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Light Death Mountain Right/Mimic Cave/Mimic Cave Chest", { { 268, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Swamp/Mire Shed/Shed", { { 269, 4 }, { 269, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/King's Tomb/King's Tomb", { { 275, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Waterfall Fairy/Chest", { { 276, 4 }, { 276, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Right/Big Bomb Fairy/Boom", { { 278, 4 }, { 278, 5 } }, updateBombIndicatorStatus)
    updateSectionChestCountFromRoomSlotList(segment, "@Dark Death Mountain Left/Spike Cave/Spike Cave Chest", { { 279, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Graveyard Ledge/Graveyard Ledge", { { 283, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Cave 45/Cave 45", { { 283, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/C-Shaped House/C-Shaped House", { { 284, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Blind's Hideout/Hideout", { { 285, 5 }, { 285, 6 }, { 285, 7 }, { 285, 8 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Blind's Hideout/Back Chest", { { 285, 4 } })   
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/Hype Cave/Hype", { { 286, 4 }, { 286, 5 }, { 286, 6 }, { 286, 7 }, { 286, 10 } }) 
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Ice Rod Cave/Ice Rod Chest", { { 288, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Mini Moldorm Cave/Mini Moldorm Chest", { { 291, 4 }, { 291, 5 }, { 291, 6 }, { 291, 7 }, { 291, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Bonk Pile/Bonk Pile Chest", { { 292, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Lightworld/Checkerboard Cave/Checkerboard Cave Item", { { 294, 9 } })
    updateSectionChestCountFromRoomSlotList(segment, "@Darkworld Left/Peg Cave/Peg Cave", { { 295, 10 } })



    updateSectionChestCountFromRoomSlotList(segment, "@HC/Hyrule Castle/Boomerang Chest", { { 113, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@HC/Hyrule Castle/Map Chest", { { 114, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@HC/Hyrule Castle/Zelda's Chest", { { 128, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@CE/Castle Escape/Dark Cross", { { 50, 4 } })
    -- updateSectionChestCountFromRoomSlotList(segment, "@Hyrule Castle & Sanctuary/Escape", { { 113, 4 },{ 114, 4 },{ 128, 4 },{ 50, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@CE/Castle Escape/Secret Room", {  { 17, 4 },{ 17, 5 },{ 17, 6 }, })
    updateSectionChestCountFromRoomSlotList(segment, "@CE/Sanctuary/Sanctuary Chest", { { 18, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@AT/Agahnim's Tower/Room 03", { { 224, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@AT-inverted/Agahnim's Tower/Room 03", { { 224, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@AT/Agahnim's Tower/Maze Chest", { { 208, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@AT-inverted/Agahnim's Tower/Maze Chest", { { 208, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@EP/Eastern Palace/Dungeon Chest", { { 185, 4 }, { 168, 4 }, { 169, 4 }, { 170, 4 }, { 184, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@EP/Eastern Palace/Boss Item", { { 200, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@DP/Desert Palace/Dungeon Chest", { { 133, 4 },{ 115, 4 },{ 115, 5 },{ 116, 4 },{ 117, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@DP Back/Desert Palace Back/Boss Item", { { 51, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@ToH/Tower of Hera/Lowe", { { 119, 4 },{ 135, 4 },{ 135, 10 } })
    updateSectionChestCountFromRoomSlotList(segment, "@ToH/Tower of Hera/Upper", { { 39, 4 },{ 39, 5 } })
    updateSectionChestCountFromRoomSlotList(segment, "@ToH/Tower of Hera/Boss Item", { { 7, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@PoD/Palace of Darkness/Dungeon Chest", { 
        { 58, 4 },{ 42, 4 },{ 42, 5 },{ 43, 4 },{ 25, 4 },{ 25, 5 },{ 26, 4 },
        { 26, 5 },{ 26, 6 },{ 9, 4 },{ 10, 4 },{ 106, 4 },{ 106, 5 } 
    })
    updateSectionChestCountFromRoomSlotList(segment, "@PoD/Palace of Darkness/Boss Item", { { 90, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@SP/Swamp Palace/Dungeon Chest", { { 40, 4 } }) -- entrance
    updateSectionChestCountFromRoomSlotList(segment, "@SP/Swamp Palace/Dungeon Chest", { { 55, 4 } }) --bombable wall
    updateSectionChestCountFromRoomSlotList(segment, "@SP/Swamp Palace/Dungeon Chest", { 
        { 54, 4 },{ 53, 4 },{ 52, 4 },{ 70, 4 },{ 118, 4 },{ 118, 5 },{ 102, 4 } 
    })
    updateSectionChestCountFromRoomSlotList(segment, "@SP/Swamp Palace/Boss Item", { { 6, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@SW/Skull Woods Front/Dungeon Chest", { 
        { 103, 4 },{ 104, 4 },{ 87, 4 },{ 87, 5 },{ 88, 4 },{ 88, 5 }
     })
    updateSectionChestCountFromRoomSlotList(segment, "@SW/Skull Woods Back/Dungeon Chest", { { 89, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@SW/Skull Woods Back/Boss Item", { { 41, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@TT/Thieves Town/Front", { { 203, 4 }, { 219, 4 }, { 219, 5 }, { 220, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@TT/Thieves Town/Back", { { 101, 4 }, { 69, 4 } })
    updateSectionChestCountFromRoomSlotList(segment, "@TT/Thieves Town/Back", { { 68, 4 } }) --big chest
    updateSectionChestCountFromRoomSlotList(segment, "@TT/Thieves Town/Boss Item", { { 172, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@IP/Ice Palace/Dungeon Chest", { 
        { 174, 4 },{ 158, 4 },{ 126, 4 },{ 95, 4 },{ 63, 4 },{ 46, 4 },{ 31, 4 }
     })
    updateSectionChestCountFromRoomSlotList(segment, "@IP/Ice Palace/Boss Item", { { 222, 11 } })
    updateSectionChestCountFromRoomSlotList(segment, "@MM/Misery Mire/Dungeon Chest", { 
        { 162, 4 },{ 179, 4 },{ 193, 4 },{ 194, 4 },{ 194, 5 },{ 196, 4 },{ 209, 4 }
     })
    updateSectionChestCountFromRoomSlotList(segment, "@MM/Misery Mire/Boss Item", { { 144, 11 } })
    -- @todo: split TR into  completable w/o bosskey
    updateSectionChestCountFromRoomSlotList(segment, "@TR/Turtle Rock Front/Dungeon Chest", { 
        { 214, 4 },{ 182, 4 },{ 183, 4 },{ 183, 5 },{ 20, 4 }
     })
     pdateSectionChestCountFromRoomSlotList(segment, "@TR/Turtle Rock Back/Dungeon Chest", { 
       { 213, 4 },{ 213, 5 },{ 213, 6 },{ 213, 7 },{ 36, 4 },{ 4,4 }
     })
    updateSectionChestCountFromRoomSlotList(segment, "@TR/Turtle Rock Back/Boss Item", { { 164, 11 } })
    -- @todo: split GT into right/left side
    updateSectionChestCountFromRoomSlotList(segment, "@GT/Ganon's Tower/Leftside", {
        { 140, 4 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 }, 
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
     })
    updateSectionChestCountFromRoomSlotList(segment, "@GT-inverted/Ganon's Tower/Leftside", {
        { 140, 4 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 }, 
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
     })
     updateSectionChestCountFromRoomSlotList(segment, "@GT/Ganon's Tower/Rightside", {
        { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
     })
     updateSectionChestCountFromRoomSlotList(segment, "@GT-inverted/Ganon's Tower/Rightside", {
        { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
     })
     updateSectionChestCountFromRoomSlotList(segment, "@GT/Ganon's Tower/Big Chest + Ice refight", {
        { 140, 7 }, { 140, 8 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
     })
     updateSectionChestCountFromRoomSlotList(segment, "@GT-inverted/Ganon's Tower/Big Chest + Ice refight", {
        { 140, 7 }, { 140, 8 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
     })
     updateSectionChestCountFromRoomSlotList(segment, "@GT/Ganon's Tower/GT Top + Lanmo refight", { { 61, 4 }, { 61, 5 }, { 61, 6 } })
     updateSectionChestCountFromRoomSlotList(segment, "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight", { { 61, 4 }, { 61, 5 }, { 61, 6 } })
     updateSectionChestCountFromRoomSlotList(segment, "@GT/Ganon's Tower/GT Top Moldorm refight", { { 77, 4 }  })
     updateSectionChestCountFromRoomSlotList(segment, "@GT-inverted/Ganon's Tower/GT Top Moldorm refight", { { 77, 4 }  })

    -- updateSectionChestCountFromRoomSlotList(segment, "@Ganon's Tower/Ice Boss", { { 295, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, "@Ganon's Tower/Lanmo Refight", { { 295, 10 } })
    -- updateSectionChestCountFromRoomSlotList(segment, "@Ganon's Tower/Boss", { { 295, 10 } })


end

function updateItemsFromMemorySegment(segment)

    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        updateProgressiveItemFromByte(segment, "sword",  0x7ef359, 1)
        updateProgressiveItemFromByte(segment, "shield", 0x7ef35a, 0)
        updateProgressiveItemFromByte(segment, "armor",  0x7ef35b, 0)
        updateProgressiveItemFromByte(segment, "gloves", 0x7ef354, 0)

        updateToggleItemFromByte(segment, "hookshot",  0x7ef342)
        updateToggleItemFromByte(segment, "bombs",     0x7ef343)
        updateToggleItemFromByte(segment, "firerod",   0x7ef345)
        updateToggleItemFromByte(segment, "icerod",    0x7ef346)
        updateToggleItemFromByte(segment, "bombos",    0x7ef347)
        updateToggleItemFromByte(segment, "ether",     0x7ef348)
        updateToggleItemFromByte(segment, "quake",     0x7ef349)
        updateToggleItemFromByte(segment, "lamp",      0x7ef34a)
        updateToggleItemFromByte(segment, "hammer",    0x7ef34b)
        updateToggleItemFromByte(segment, "bug_net",       0x7ef34d)
        updateToggleItemFromByte(segment, "book",      0x7ef34e)
        updateToggleItemFromByte(segment, "somaria",   0x7ef350)
        updateToggleItemFromByte(segment, "byrna",     0x7ef351)
        updateToggleItemFromByte(segment, "cape",      0x7ef352)
        updateToggleItemFromByte(segment, "boots",     0x7ef355)
        updateToggleItemFromByte(segment, "flippers",  0x7ef356)
        updateToggleItemFromByte(segment, "pearl",     0x7ef357)
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
      
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end    

    --  It may seem unintuitive, but these locations are controlled by flags stored adjacent to the item data,
    --  which makes it more efficient to update them here.
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Secret Passage/Link's Uncle", 0x7ef3c6, 0x01)    
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Hobo/Hobo", 0x7ef3c9, 0x01)
    updateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Bottle Merchant/Get Scammed (100 Rupees)", 0x7ef3c9, 0x02)
    updateSectionChestCountFromByteAndFlag(segment, "@Darkworld Left/Purple Chest Return/Purple Chest Return", 0x7ef3c9, 0x10)

end

function updateChestKeysFromMemorySegment(segment)

    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        -- Pending small key from chests tracking update
        -- Sewers is unused by the game - this is here for reference sake
        -- updateConsumableItemFromByte(segment, "sewers_smallkey",  0x7ef4e0)
        updateConsumableItemFromTwoByteSum(segment, "hc_smallkey", 0x7ef4e0, 0x7ef4e1)
        updateConsumableItemFromByte(segment, "dp_smallkey",  0x7ef4e3)
        updateConsumableItemFromByte(segment, "at_smallkey",  0x7ef4e4)
        updateConsumableItemFromByte(segment, "sp_smallkey",  0x7ef4e5)
        updateConsumableItemFromByte(segment, "pod_smallkey", 0x7ef4e6)
        updateConsumableItemFromByte(segment, "mm_smallkey",  0x7ef4e7)
        updateConsumableItemFromByte(segment, "sw_smallkey",  0x7ef4e8)
        updateConsumableItemFromByte(segment, "ip_smallkey",  0x7ef4e9)
        updateConsumableItemFromByte(segment, "toh_smallkey", 0x7ef4ea)
        updateConsumableItemFromByte(segment, "tt_smallkey",  0x7ef4eb)
        updateConsumableItemFromByte(segment, "tr_smallkey",  0x7ef4ec)
        updateConsumableItemFromByte(segment, "gt_smallkey",  0x7ef4ed)
       
    end
end

function updateHeartPiecesFromMemorySegment(segment)

    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateConsumableItemFromByte(segment, "heartpieces", 0x7ef448)
    end
end

function updateHeartContainersFromMemorySegment(segment)

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
ScriptHost:AddMemoryWatch("LTTP Chest Key Data", 0x7ef4e0, 32, updateChestKeysFromMemorySegment)
