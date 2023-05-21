local variant = Tracker.ActiveVariantUID
IS_UNLABELLED = variant:find("maps-u")

Tracker:AddItems("items/items.json")
-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Maps
if Tracker.ActiveVariantUID == "maps-u" then
    Tracker:AddMaps("maps/maps-u.json")  
else
    Tracker:AddMaps("maps/maps.json")  
end  
-- Locations
Tracker:AddLocations("locations/locations.json")
if PopVersion and PopVersion >= "0.23.0" then
    Tracker:AddLocations("locations/dungeons.json")
end

-- Layout
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
