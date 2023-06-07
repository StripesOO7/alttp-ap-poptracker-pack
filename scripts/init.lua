local variant = Tracker.ActiveVariantUID
IS_UNLABELLED = variant:find("maps-u")

Tracker:AddItems("items/items.json")
Tracker:AddItems("items/keys.json")
Tracker:AddItems("items/labels.json")
Tracker:AddItems("items/dungeon_bosses.json")
Tracker:AddItems("items/dungeon_items.json")
-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Maps
if Tracker.ActiveVariantUID == "maps-u" then
    Tracker:AddMaps("maps/maps-u.json")  
else
    Tracker:AddMaps("maps/maps.json")  
end  
-- Locations
Tracker:AddLocations("locations/darkworld.json")
Tracker:AddLocations("locations/lightworld.json")
Tracker:AddLocations("locations/HC.json")
Tracker:AddLocations("locations/AT.json")
Tracker:AddLocations("locations/EP.json")
Tracker:AddLocations("locations/DP.json")
Tracker:AddLocations("locations/ToH.json")
Tracker:AddLocations("locations/PoD.json")
Tracker:AddLocations("locations/SP.json")
Tracker:AddLocations("locations/SW.json")
Tracker:AddLocations("locations/TT.json")
Tracker:AddLocations("locations/MM.json")
Tracker:AddLocations("locations/IP.json")
Tracker:AddLocations("locations/TR.json")
Tracker:AddLocations("locations/GT.json")

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
