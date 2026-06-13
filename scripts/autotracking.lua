-- Configuration --------------------------------------
-- ENABLE_DEBUG_LOG = true
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

require("scripts.autotracking.settings")
-- loads the AP autotracking code

local variant = Tracker.ActiveVariantUID
if  variant == "Map Tracker - AP" then
    require("scripts.autotracking.archipelago")
    require("scripts.autotracking.SNESautotracking_functions")

end
-- loads the SNES autotrecking codes
if  variant == "Map Tracker - SNES" or
    variant == "Map Tracker ALTTPR Race Mode - SNES" then
    require("scripts.autotracking.SNESautotracking_functions")
    require("scripts.autotracking.SNESautotracking_ROMdata")
    Tracker.AllowDeferredLogicUpdate = true
end

require("scripts.autotracking.luaitems")
require("scripts.autotracking.doors")