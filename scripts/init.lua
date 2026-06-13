local variant = Tracker.ActiveVariantUID
require("os")
-- Items
require("scripts.items_import")

-- Logic
require("scripts.logic.logic_helpers")
KeyDropLayoutChange()
Bombless()
require("scripts.logic.logic_main")
require("scripts.logic_import")

-- Maps
Tracker:AddMaps("maps/maps.json")

-- Layout
require("scripts.layouts_import")

-- Locations
require("scripts.locations_import")

-- AutoTracking for Poptracker
require("scripts.autotracking")

function OnFrameHandler()
    ScriptHost:RemoveOnFrameHandler("load handler")
    -- stuff
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
    ChangeERMap()
    ChangeERLayout()
    ForceUpdate()
end
require("scripts/watches")
ScriptHost:AddOnFrameHandler("load handler", OnFrameHandler)