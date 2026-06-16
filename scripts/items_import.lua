Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/labels.json")
Tracker:AddItems("items/dungeon_bosses.json")
-- Tracker:AddItems("items/dungeon_items_kds.json")
Tracker:AddItems("items/dungeon_items.json")
Tracker:AddItems("items/doors_static_images.json")
Tracker:AddItems("items/shops_bottles_pulls.json")


local variant = Tracker.ActiveVariantUID

if variant == "Map Tracker ALTTPR Race Mode - SNES" then
    local ER_tracking = Tracker:FindObjectForCode("er_tracking_method") --[[@as JsonItem]]
    ER_tracking.Active = false
    ER_tracking.IgnoreUserInput = true
    local Map_switch = Tracker:FindObjectForCode("ui_hint") --[[@as JsonItem]]
    Map_switch.Active = false
    Map_switch.IgnoreUserInput = true
    local route_mode = Tracker:FindObjectForCode("route_mode") --[[@as JsonItem]]
    route_mode.Active = false
    route_mode.IgnoreUserInput = true
end