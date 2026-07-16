local variant = Tracker.ActiveVariantUID

-- Items
require("scripts.items_import")
require("scripts.autotracking.item_mapping")
-- Locations
require("scripts.locations_import")
require("scripts.autotracking.location_mapping")

-- Logic
require("scripts.logic.logic_helpers")
KeyDropLayoutChange()
Bombless()
require("scripts.logic.logic_main")
require("scripts.logic_import")

-- Maps
require("scripts.maps_import")

-- Layout
require("scripts.layouts_import")

-- Locations
require("scripts.locations_import")

-- AutoTracking for Poptracker
require("scripts.autotracking")

-- LuaItems
require("scripts.luaitems_import")

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