local variant = Tracker.ActiveVariantUID
IS_UNLABELLED = variant:find("maps-u")

-- Items
require("scripts/items_import.lua")

-- Logic
require("scripts/logic/logic_helpers.lua")
require("scripts/logic/logic_main.lua")
require("scripts/logic_import.lua")

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
require("scripts/layouts_import.lua")

-- Locations
require("scripts/locations_import.lua")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    require("scripts/autotracking.lua")
end
