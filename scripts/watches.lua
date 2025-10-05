--logic main
ScriptHost:AddWatchForCode("ER_Setting_Changed", "er_full", EmptyLocationTargets)
-- ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", ForceUpdate)
ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", KeyDropLayoutChange)
ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", BossShuffle)

-- SNES_ROMdata
-- ScriptHost:AddMemoryWatch("LTTP Overworld Event Data", 0x7ef280, 0x82, updateOverworldEventsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP NPC Item Data", 0x7ef410, 2, updateNPCItemFlagsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Heart Piece Data", 0x7ef448, 1, updateHeartPiecesFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Heart Container Data", 0x7ef36c, 1, updateHeartContainersFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, updateItemsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Room Data", 0x7ef000, 0x250, updateRoomsFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Chest Key Data", 0x7ef4e0, 32, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Keydrop Data", 0x7ef37c, 32, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Room Keydrop Data", 0x7ef000, 0x250, updateChestKeysFromMemorySegment)
-- ScriptHost:AddMemoryWatch("LTTP Upgrade updater", 0x7ef370, 2, updateBowAndBombUpgrade)

--SNES_functions
ScriptHost:AddMemoryWatch("LTTP In-Game status", 0x7e0010, 0x250, updateInGameStatusFromMemorySegment, 250)
if Tracker.ActiveVariantUID == "Map Tracker - AP" then
    ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, updateAga1)
end

--luaitems
ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_setings)

--archipelago
ScriptHost:AddWatchForCode("bombless start handler", "bombless", bombless)
ScriptHost:AddWatchForCode("goal handler", "goal", goal_check)
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)

Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)

ScriptHost:AddWatchForCode("settings autofill_dungeon_settings", "autofill_dungeon_settings", autoFill)
ScriptHost:AddWatchForCode("settings autofill_goal_reqs", "autofill_goal_reqs", autoFill)
ScriptHost:AddWatchForCode("settings autofill_medallions", "autofill_medallions", autoFill)
ScriptHost:AddWatchForCode("settings autofill_modes", "autofill_modes", autoFill)
ScriptHost:AddWatchForCode("settings autofill_misc", "autofill_misc", autoFill)
ScriptHost:AddWatchForCode("settings autofill_sanities", "autofill_sanities", autoFill)