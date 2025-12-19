--logic main
ScriptHost:AddWatchForCode("ER_Setting_Changed", "er_full", EmptyLocationTargets)
-- ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
ScriptHost:AddWatchForCode("keydropshuffle handler", "key_drop_shuffle", KeyDropLayoutChange)
ScriptHost:AddWatchForCode("boss handler", "boss_shuffle", BossShuffle)
ScriptHost:AddWatchForCode("set smallkey stage global", "small_keys", SetSmallKeyGlobal)

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
--logic_helpers
ScriptHost:AddWatchForCode("settings maps_setting", "maps_setting", GiveAll)
ScriptHost:AddWatchForCode("settings compass_shuffle", "compass_setting", GiveAll)
ScriptHost:AddWatchForCode("settings smallkeys_setting", "smallkeys_setting", GiveAll)
ScriptHost:AddWatchForCode("settings bigkeys_setting", "bigkeys_setting", GiveAll)


ScriptHost:AddWatchForCode("set shop cost-type", "shuffle_cost_type", SetCostType)
ScriptHost:AddWatchForCode("set shop default inventory", "shop_sanity", SetShopInventory)
ScriptHost:AddWatchForCode("set prize shuffles", "prize_shuffle", SetPrizeShuffle)
SetPrizeShuffle()


ScriptHost:AddWatchForCode("set all autofill", "autofill_all_settings", setAllAutofill)

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

for _, code in pairs({"autofill_dungeon_settings", "autofill_goal_reqs", "autofill_medallions", "autofill_modes", "autofill_misc", "autofill_sanities"}) do
    ScriptHost:AddWatchForCode("settings ".. code, code, autoFill)
end
ScriptHost:AddWatchForCode("glitches changed", "glitches", UpdateCanInteract)

for _, code in pairs(MISC_MANUAL_ITEMS) do
    ScriptHost:AddWatchForCode("manual storage watch for " .. code, code, AddManualItemStorage)
end
ScriptHost:AddWatchForCode("Enable/Disable Route Mode", "route_mode", ChangeRouteMode)