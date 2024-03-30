-- pod_entrance = alttp_location.new("")
-- local pod_three_way_room = alttp_location.new("")
local pod_three_way_room_left = alttp_location.new("pod_three_way_room_left")
local pod_three_way_room_middle = alttp_location.new("pod_three_way_room_middle")
local pod_three_way_room_right = alttp_location.new("pod_three_way_room_right")
local pod_shooter_room = alttp_location.new("pod_shooter_room")
local pod_teleporter_room = alttp_location.new("pod_teleporter_room")
local pod_mimic_room = alttp_location.new("pod_mimic_room")
local pod_switch_room_top = alttp_location.new("pod_switch_room_top")
local pod_switch_room_bottom = alttp_location.new("pod_switch_room_bottom")
local pod_arena = alttp_location.new("pod_arena")
local pod_big_key_chest_room = alttp_location.new("pod_big_key_chest_room")
local pod_basement_ledge = alttp_location.new("pod_basement_ledge")
local pod_basement_floor = alttp_location.new("pod_basement_floor")
local pod_big_key_chest_ledge = alttp_location.new("pod_big_key_chest_ledge")
local pod_collapsin_bridge = alttp_location.new("pod_collapsin_bridge")
local pod_dark_maze = alttp_location.new("pod_dark_maze")
local pod_compass_room = alttp_location.new("pod_compass_room")
local pod_dark_basement = alttp_location.new("pod_dark_basement")
local pod_harmless_hellway = alttp_location.new("pod_harmless_hellway")
local pod_boss_room = alttp_location.new("pod_boss_room")


pod_entrance:connect_two_ways(pod_three_way_room_left)
pod_entrance:connect_two_ways(pod_three_way_room_middle)
pod_entrance:connect_two_ways(pod_three_way_room_right)
pod_three_way_room_middle:connect_two_ways(pod_three_way_room_right)

pod_three_way_room_left:connect_two_ways(pod_shooter_room)
pod_three_way_room_middle:connect_two_ways(pod_big_key_chest_room, function(keys) 
    return any(
        has("pod_smallkey", keys + 1, 6, keys + 1, 6),
        all(
            pod_switch_room_top.accessibility_level,
            has("pod_smallkey", keys + 1, 4, keys + 1, 4)
        )
    ), KDSreturn(keys + 1, keys + 1) 
end)
pod_three_way_room_right:connect_two_ways(pod_teleporter_room)
pod_big_key_chest_room:connect_one_way(pod_basement_ledge, function() return has("bombs") end)
pod_big_key_chest_room:connect_one_way(pod_basement_floor)
pod_shooter_room:connect_one_way("PoD - Shooter Room")

pod_basement_ledge:connect_one_way(pod_basement_floor)
pod_basement_ledge:connect_two_ways(pod_big_key_chest_ledge, function(keys) 
    return has("pod_smallkey", keys + 1, 6, keys + 1, 6), KDSreturn(keys + 1, keys + 1) 
end)

pod_big_key_chest_ledge:connect_one_way(pod_basement_floor)
pod_big_key_chest_ledge:connect_one_way("PoD - Big Key Chest")

pod_basement_floor:connect_one_way(pod_teleporter_room)
pod_basement_floor:connect_one_way("PoD - Stalfos Basement")

pod_teleporter_room:connect_two_ways(pod_mimic_room, function() 
    return any(
        has("boots"),
        has("bombs")
    ) 
end)

pod_mimic_room:connect_two_ways(pod_switch_room_top, function() return enemizerCheck("bow") end)

pod_switch_room_top:connect_one_way(pod_switch_room_bottom, function() return has("hammer") end)
pod_switch_room_top:connect_one_way("PoD - Map Chest")
pod_switch_room_top:connect_one_way("PoD - Arena Ledge", function() return has("bombs") end)

pod_switch_room_bottom:connect_two_ways(pod_boss_room, function(keys) 
    return all(
        has("bow"),
        darkRooms(),
        any(
            all(
                has("pod_smallkey", keys + 1, 4, keys + 1, 4),
                pod_switch_room_top.accessibility_level,
                has("hammer")
            ),
            has("pod_smallkey", keys + 1, 6, keys + 1, 6)
        )
    )
end)
pod_switch_room_bottom:connect_two_ways(pod_arena)

pod_big_key_chest_room:connect_two_ways(pod_arena)

pod_arena:connect_one_way(pod_collapsin_bridge, function(keys) 
    if pod_switch_room_top.accessibility_level > 5 then
        return all(
            has("pod_smallkey", keys, 4, keys, 4),
            pod_switch_room_top.accessibility_level,
            has("hammer"),
            any(
                has("bombs"),
                has('bow'),
                has("somaria")
            )
        ), KDSreturn(keys, keys + 1)
    else
        return all(
            has("pod_smallkey", keys + 1, 4, keys + 1, 4),
            any(
                has("bombs"),
                has('bow'),
                has("somaria")
            )
        ), KDSreturn(keys + 1, keys + 1)
    end
end)
pod_arena:connect_one_way("PoD - Arena Bridge")

pod_collapsin_bridge:connect_two_ways(pod_dark_maze, function(keys) 
    return all(
        pod_compass_room.accessibility_level,
        darkRooms(),
        has("pod_smallkey", keys + 1, 6, keys + 1, 6)
    ), KDSreturn(keys + 1, keys + 1)
end)
pod_collapsin_bridge:connect_two_ways(pod_compass_room, function() return pod_collapsin_bridge.accessibility_level end)

pod_dark_maze:connect_one_way("PoD - Dark Maze Top")
pod_dark_maze:connect_one_way("PoD - Dark Maze Bottom")
pod_dark_maze:connect_one_way("PoD - Big Chest", function() 
    return all(
        has("pod_bigkey"), 
        has("bombs")
    ) 
end)

pod_compass_room:connect_two_ways(pod_dark_basement, function() return darkRooms() end)
pod_compass_room:connect_two_ways(pod_harmless_hellway, function(keys) 
    return has("pod_smallkey", keys + 1, 6, keys + 1, 6), KDSreturn(keys + 1, keys + 1) 
end)
pod_compass_room:connect_one_way("PoD - Compass Chest")

pod_dark_basement:connect_one_way("PoD - Dark Basement Left")
pod_dark_basement:connect_one_way("PoD - Dark Basement Right")

pod_harmless_hellway:connect_one_way(pod_arena)
pod_harmless_hellway:connect_one_way("PoD - Harmless Hellway")

pod_boss_room:connect_one_way("PoD - Boss", function() return getBossRef("pod_boss") end)