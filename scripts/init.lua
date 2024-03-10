local variant = Tracker.ActiveVariantUID
IS_UNLABELLED = variant:find("maps-u")

-- Items
ScriptHost:LoadScript("scripts/items.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic_helpers.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")

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
ScriptHost:LoadScript("scripts/layouts.lua")

-- Locations
ScriptHost:LoadScript("scripts/locations.lua")


-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
