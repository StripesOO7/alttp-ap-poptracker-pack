-- ep_entrance = alttp_location.new("", nil, nil, true)
local ep_cannonball_room = alttp_location.new("ep_cannonball_room", "EP Cannonballs", nil, true)
local ep_main_room_top = alttp_location.new("ep_main_room_top", "EP Main Room", nil, true)
local ep_map_chest_room = alttp_location.new("ep_map_chest_room", "EP Map Chest", nil, true)
local ep_compass_chest_room = alttp_location.new("ep_compass_chest_room", "EP Compass Room", nil, true)
local ep_main_room_bottom = alttp_location.new("ep_main_room_bottom", "EP Big Chest Room", nil, true)
local ep_dark_square_room = alttp_location.new("ep_dark_square_room", "EP Dark Sqaure", nil, true)
local ep_big_key_chest_room = alttp_location.new("ep_big_key_chest_room", "EP Big Key", nil, true)
local ep_dark_eyegore_room = alttp_location.new("ep_dark_eyegore_room", "EP Dark Eyegore", nil, true)
local ep_boss_room = alttp_location.new("ep_boss_room", "EP Boss Room", nil, true)

ep_entrance_inside:connect_two_ways(ep_cannonball_room, function() return CanInteract(ep_entrance_inside) end)

ep_cannonball_room:connect_two_ways(ep_main_room_top)
ep_cannonball_room:connect_one_way("EP - Cannonball Chest")

ep_main_room_top:connect_two_ways(ep_compass_chest_room)
ep_main_room_top:connect_two_ways(ep_map_chest_room)

ep_map_chest_room:connect_one_way("EP - Map Chest")

ep_compass_chest_room:connect_two_ways(ep_main_room_bottom)
ep_compass_chest_room:connect_one_way("EP - Compass Chest")

ep_main_room_bottom:connect_two_ways(ep_dark_square_room, function() return DarkRooms(false) end)
ep_main_room_bottom:connect_two_ways(ep_dark_eyegore_room, function()
    return ALL(
        DarkRooms(true),
        "ep_bigkey"
    )
end)
ep_main_room_bottom:connect_one_way("EP - Big Chest", function() return Has("ep_bigkey") end)

ep_dark_square_room:connect_two_ways(ep_big_key_chest_room, function(keys)
    -- if Has("ep_bigkey") == 6 then
    --     return Has("ep_smallkey", keys, 0, keys + 1, 2), KDSreturn(keys, keys + 1)
    -- else
        return Has("ep_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1)
    -- end
end)
ep_dark_square_room:connect_one_way("EP - Dark Square Key Drop")

ep_big_key_chest_room:connect_one_way(ep_main_room_bottom)
ep_big_key_chest_room:connect_one_way("EP - Big Key Chest")

ep_dark_eyegore_room:connect_two_ways(ep_boss_room, function(keys)
    return ALL(
        Has("ep_smallkey", keys, 0, keys + 1, 2),
        EnemizerCheck("bow")
    ), KDSreturn(keys, keys + 1)
end)
ep_dark_eyegore_room:connect_one_way("EP - Dark Eyegore Key Drop")

ep_boss_room:connect_one_way("EP - Boss", function() return GetBossRef("ep_boss") end)