local variant = Tracker.ActiveVariantUID
IS_UNLABELLED = variant:find("maps-u")

-- Items
require("scripts/items_import")

-- Logic
require("scripts/logic/logic_helpers")
require("scripts/logic/logic_main")
require("scripts/logic_import")

-- Maps
if Tracker.ActiveVariantUID == "maps-u" then
    Tracker:AddMaps("maps/maps-u.json")
else
    Tracker:AddMaps("maps/maps.json")
end

if PopVersion and PopVersion >= "0.23.0" then
    Tracker:AddLocations("locations/dungeons.json")
end

-- Layout
require("scripts/layouts_import")

-- Locations
require("scripts/locations_import")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    require("scripts/autotracking")
end

function OnFrameHandler()
    ScriptHost:RemoveOnFrameHandler("load handler")
    -- stuff
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    ForceUpdate()
end
ScriptHost:AddOnFrameHandler("load handler", OnFrameHandler)