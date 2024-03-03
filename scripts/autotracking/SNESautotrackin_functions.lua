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

room_lookuptable = {
    [14] = "Ice Palace",
    [17] = "Castle Escape",
    [18] = "Castle Escape",
    [35] = "Turtle Rock",
    [36] = "Turtle Rock",
    [40] = "Swamp Palace",
    [74] = "Palace of Darkness",
    [86] = "Skull Woods",
    [87] = "Skull Woods",
    [88] = "Skull Woods",
    [89] = "Skull Woods",
    [96] = "Hyrule Castle",
    [97] = "Hyrule Castle",
    [98] = "Hyrule Castle",
    [99] = "Desert Palace",
    [103] = "Skull Woods",
    [104] = "Skull Woods",
    [107] = "Ganon's Tower - Top",
    [119] = "Tower of Hera",
    [131] = "Desert Palace",
    [132] = "Desert Palace",
    [133] = "Desert Palace",
    [140] = "Ganon's Tower - Bottom",
    [152] = "Misery Mire",
    [201] = "Eastern Palace",
    [213] = "Turtle Rock",
    [214] = "Turtle Rock",
    [219] = "Thieves Town",
    [224] = "Agahnim's Tower",
}

function updateUI(segment, mainModuleIdx)
    if mainModuleIdx > 0x05 then
        new_ow_room = segment:ReadUInt16(0x7e008a)
        if new_ow_room == 0 then
            new_dungeon_room = segment:ReadUInt16(0x7e00a0)
        else
            dungeon_room = 0
            new_dungeon_room = 0
        end

        if new_ow_room > 0 then -- and ow_room ~= new_ow_room then
            ow_room = new_ow_room
            changeTab("Overworld")
        elseif new_dungeon_room > 0 and dungeon_room ~= new_dungeon_room then
            dungeon_room = new_dungeon_room
            changeTab(room_lookuptable[dungeon_room])
        end
        -- print("Current Room Index: ", new_dungeon_room)
        -- print("Current OW   Index: ", new_ow_room)
        -- print(room_lookuptable[dungeon_room])
    end
end

function changeTab(target_tab)
    if Tracker:FindObjectForCode("ui_hint").Active and target_tab ~= nil then
        print(ow_room, dungeon_room, Tracker:FindObjectForCode("ui_hint").Active, target_tab)
        Tracker:UiHint("ActivateTab", target_tab)
    end
end

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
    if Tracker:FindObjectForCode("ui_hint") then
        updateUI(segment, mainModuleIdx)
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


-- ScriptHost:AddMemoryWatch("LTTP In-Game Rooms", 0x7e0010, 0x90,  updateInGameRoomsFromMemorySegment, 250)
ScriptHost:AddMemoryWatch("LTTP In-Game status", 0x7e0010, 0x90, updateInGameStatusFromMemorySegment, 250)
-- ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, updateItemsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Room Data", 0x7ef000, 0x250, updateRoomsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Overworld Event Data", 0x7ef280, 0x82, updateOverworldEventsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP NPC Item Data", 0x7ef410, 2, updateNPCItemFlagsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Heart Piece Data", 0x7ef448, 1, updateHeartPiecesFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Heart Container Data", 0x7ef36c, 1, updateHeartContainersFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Upgrade updater", 0x7ef370, 2, updateBowAndBombUpgrade)
-- ScriptHost:AddMemoryWatch("LTTP Chest Key Data", 0x7ef4e0, 32, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Keydrop Data", 0x7ef37c, 32, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Room Keydrop Data", 0x7ef000, 0x250, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Settings", 0x180000, 250, autofillSettings)
