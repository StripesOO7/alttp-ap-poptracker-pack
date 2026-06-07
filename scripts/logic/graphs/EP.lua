-- EP_entrance = alttp_location.new("", nil, nil, "EP", true)
local EP_cannonball_room = alttp_location.new("EP_cannonball_room", "EP Cannonballs", nil, "EP", true)
local EP_main_room_top = alttp_location.new("EP_main_room_top", "EP Main Room", nil, "EP", true)
local EP_map_chest_room = alttp_location.new("EP_map_chest_room", "EP Map Chest", nil, "EP", true)
local EP_compass_chest_room = alttp_location.new("EP_compass_chest_room", "EP Compass Room", nil, "EP", true)
local EP_main_room_bottom = alttp_location.new("EP_main_room_bottom", "EP Big Chest Room", nil, "EP", true)
local EP_dark_square_room = alttp_location.new("EP_dark_square_room", "EP Dark Sqaure", nil, "EP", true)
local EP_big_key_chest_room = alttp_location.new("EP_big_key_chest_room", "EP Big Key", nil, "EP", true)
local EP_dark_eyegore_room = alttp_location.new("EP_dark_eyegore_room", "EP Dark Eyegore", nil, "EP", true)
local EP_boss_room = alttp_location.new("EP_boss_room", "EP Boss Room", nil, "EP", true)

EP_entrance_inside:connect_two_ways(EP_cannonball_room, function() return CanInteract(EP_entrance_inside) end)

EP_cannonball_room:connect_two_ways(EP_main_room_top)
EP_cannonball_room:connect_one_way("EP - Cannonball Chest")

EP_main_room_top:connect_two_ways(EP_compass_chest_room)
EP_main_room_top:connect_two_ways(EP_map_chest_room)

EP_map_chest_room:connect_one_way("EP - Map Chest")

EP_compass_chest_room:connect_two_ways(EP_main_room_bottom)
EP_compass_chest_room:connect_one_way("EP - Compass Chest")

EP_main_room_bottom:connect_two_ways(EP_dark_square_room, function() return DarkRooms(false) end)
EP_main_room_bottom:connect_two_ways(EP_dark_eyegore_room, function()
    return ALL(
        DarkRooms(true),
        "ep_bigkey"
    )
end)
EP_main_room_bottom:connect_one_way("EP - Big Chest", function() return Has("ep_bigkey") end)

EP_dark_square_room:connect_two_ways(EP_big_key_chest_room, function(keys)
    -- if Has("ep_bigkey") == 6 then
    --     return Has("ep_smallkey", keys, 0, keys + 1, 2), KDSreturn(keys, keys + 1)
    -- else
        return Has("ep_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1)
    -- end
end)
EP_dark_square_room:connect_one_way("EP - Dark Square Key Drop")

EP_big_key_chest_room:connect_one_way(EP_main_room_bottom)
EP_big_key_chest_room:connect_one_way("EP - Big Key Chest")

EP_dark_eyegore_room:connect_two_ways(EP_boss_room, function(keys)
    return ALL(
        Has("ep_smallkey", keys, 0, keys + 1, 2),
        EnemizerCheck("bow")
    ), KDSreturn(keys, keys + 1)
end)
EP_dark_eyegore_room:connect_one_way("EP - Dark Eyegore Key Drop")

EP_boss_room:connect_one_way("EP - Boss", function() return GetBossRef("ep_boss") end)