-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true and ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
-------------------------------------------------------
print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING)
    print("Enable AP Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP)
    print("Enable SNES Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES)
end
print("---------------------------------------------------------------------")
print("")

ScriptHost:LoadScript("scripts/autotracking/settings.lua")
-- loads the AP autotracking code
if  Tracker.ActiveVariantUID == "Map Tracker - AP" or 
    Tracker.ActiveVariantUID == "Map Tracker /w detailed ow-Dungeons - AP" or 
    Tracker.ActiveVariantUID == "Entrance Randomizer Tracker - AP" or 
    Tracker.ActiveVariantUID == "Entrance Randomizer Tracker /w Pot-shuffle - AP" then
    ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
    ScriptHost:LoadScript("scripts/autotracking/SNESautotrackin_functions.lua")
end
-- loads the SNES autotrecking codes
if  Tracker.ActiveVariantUID == "Map Tracker - SNES" or 
Tracker.ActiveVariantUID == "Map Tracker /w detailed ow-Dungeons - SNES" or 
Tracker.ActiveVariantUID == "Entrance Randomizer Tracker - SNES" or 
Tracker.ActiveVariantUID == "Entrance Randomizer Tracker /w Pot-shuffle - SNES" then
    ScriptHost:LoadScript("scripts/autotracking/SNESautotrackin_functions.lua")
    ScriptHost:LoadScript("scripts/autotracking/SNESautotracking_ROMdata.lua")
end

