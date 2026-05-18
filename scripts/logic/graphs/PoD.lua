-- pod_entrance = alttp_location.new("", nil, nil, true)
-- local pod_three_way_room = alttp_location.new("", nil, nil, true)
local pod_three_way_room_left = alttp_location.new("pod_three_way_room_left", "PoD 3-Way Left", nil, true)
local pod_three_way_room_middle = alttp_location.new("pod_three_way_room_middle", "PoD 3-Way Center", nil, true)
local pod_three_way_room_right = alttp_location.new("pod_three_way_room_right", "PoD 3-Way Right", nil, true)
pod_shooter_room = alttp_location.new("pod_shooter_room", "PoD Shooter", nil, true) -- not local because of kiki skip
local pod_teleporter_room = alttp_location.new("pod_teleporter_room", "PoD Teleporter", nil, true)
local pod_mimic_room = alttp_location.new("pod_mimic_room", "PoD Mimics", nil, true)
local pod_switch_room_top = alttp_location.new("pod_switch_room_top", "PoD Hammer Ledge", nil, true)
local pod_switch_room_bottom = alttp_location.new("pod_switch_room_bottom", "PoD Hammer Floor", nil, true)
local pod_arena = alttp_location.new("pod_arena", "PoD Arena", nil, true)
local pod_big_key_chest_room = alttp_location.new("pod_big_key_chest_room", "PoD Big Key Chest", nil, true)
local pod_basement_ledge = alttp_location.new("pod_basement_ledge", "PoD Basement Ledge", nil, true)
local pod_basement_floor = alttp_location.new("pod_basement_floor", "PoD Basement Floor", nil, true)
local pod_big_key_chest_ledge = alttp_location.new("pod_big_key_chest_ledge", "PoD Big Key Ledge", nil, true)
local pod_collapsing_bridge = alttp_location.new("pod_collapsing_bridge", "PoD Collapsing Bridge", nil, true)
local pod_dark_maze = alttp_location.new("pod_dark_maze", "PoD Dark Maze", nil, true)
local pod_compass_room = alttp_location.new("pod_compass_room", "PoD compass Room", nil, true)
local pod_dark_basement = alttp_location.new("pod_dark_basement", "PoD Dark Basement", nil, true)
local pod_harmless_hellway = alttp_location.new("pod_harmless_hellway", "PoD Harmless Hellway", nil, true)
local pod_boss_room = alttp_location.new("pod_boss_room", "PoD Boss Room", nil, true)

pod_entrance_inside:connect_two_ways(pod_three_way_room_left, function() return CanInteract(pod_entrance_inside) end)
pod_entrance_inside:connect_two_ways(pod_three_way_room_middle, function() return CanInteract(pod_entrance_inside) end)
pod_entrance_inside:connect_two_ways(pod_three_way_room_right, function() return CanInteract(pod_entrance_inside) end)
pod_three_way_room_middle:connect_two_ways(pod_three_way_room_right)

pod_three_way_room_left:connect_two_ways(pod_shooter_room)
pod_three_way_room_middle:connect_two_ways(pod_big_key_chest_room, function(keys)
    if not (pod_switch_room_bottom:accessibility() > 5 and pod_switch_room_top:accessibility() > 5) then
        return Has("pod_smallkey", keys + 1, 1, keys + 1, 1), keys + 1
    else
        return ALL(
            pod_switch_room_bottom:accessibility(),
            pod_switch_room_top:accessibility(),
            Has("pod_smallkey", keys, 0, keys, 0)
        ), keys
    end
end)
pod_three_way_room_right:connect_two_ways(pod_teleporter_room)
pod_big_key_chest_room:connect_one_way(pod_basement_ledge, function() return Has("bombs") end)
pod_big_key_chest_room:connect_one_way(pod_basement_floor)
pod_shooter_room:connect_one_way("PoD - Shooter Room", function() return CanInteract(pod_shooter_room) end)

pod_basement_ledge:connect_one_way(pod_basement_floor)
pod_basement_ledge:connect_two_ways(pod_big_key_chest_ledge, function(keys)
    return Has("pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Dark Maze Top/Dark Maze Top"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Dark Maze Top/Dark Maze Top"), 6), keys + 1
end)

pod_big_key_chest_ledge:connect_one_way(pod_basement_floor)
pod_big_key_chest_ledge:connect_one_way("PoD - Big Key Chest")

pod_basement_floor:connect_one_way(pod_teleporter_room)
pod_basement_floor:connect_one_way("PoD - Stalfos Basement")

pod_teleporter_room:connect_two_ways(pod_mimic_room, function()
    return ALL(
        ANY(
            "boots",
            "bombs"
        ),
        CanInteract(pod_teleporter_room)
    )
end)

pod_mimic_room:connect_two_ways(pod_switch_room_top, function(keys) return EnemizerCheck("bow"), keys + 1 end)

pod_switch_room_top:connect_one_way(pod_switch_room_bottom, function() return Has("hammer") end)
pod_switch_room_top:connect_one_way("PoD - Map Chest")
pod_switch_room_top:connect_one_way("PoD - Arena Ledge", function() return Has("bombs") end)

pod_switch_room_bottom:connect_two_ways(pod_boss_room, function(keys)
    return ALL(
        "bow",
        "hammer",
        DarkRooms(false),
        "pod_bigkey",
        Has("pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Harmless Hellway/Harmless Hellway"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Harmless Hellway/Harmless Hellway"), 6)
    ), keys + 1
end)
pod_switch_room_bottom:connect_two_ways(pod_arena, HitRanged)

pod_big_key_chest_room:connect_two_ways(pod_arena)

pod_arena:connect_one_way(pod_collapsing_bridge, function(keys)
    if Tracker:FindObjectForCode("bow").Active then
        return Has("pod_smallkey", keys + 1, 4, keys + 1, 4), keys + 1
    else
        return Has("pod_smallkey", keys + 1, 3, keys + 1, 3), keys + 1
    end
end)
pod_arena:connect_one_way("PoD - Arena Bridge")

pod_collapsing_bridge:connect_two_ways(pod_dark_maze, function(keys)
    return ALL(
        pod_compass_room:accessibility(),
        DarkRooms(false),
        Has("lamp"),
        Has("pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Big Key Chest/Big Key Chest"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Big Key Chest/Big Key Chest"), 6)
    ), keys + 1
end)
pod_collapsing_bridge:connect_two_ways(pod_compass_room, function() return pod_collapsing_bridge:accessibility() end)

pod_dark_maze:connect_one_way("PoD - Dark Maze Top")
pod_dark_maze:connect_one_way("PoD - Dark Maze Bottom")
pod_dark_maze:connect_one_way("PoD - Big Chest", function()
    return ALL(
        "pod_bigkey",
        "bombs"
    )
end)

pod_compass_room:connect_two_ways(pod_dark_basement, function() return DarkRooms(true) end)
pod_compass_room:connect_two_ways(pod_harmless_hellway, function(keys)
    return Has("pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Boss/Boss Item"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Boss/Boss Item"), 6), keys + 1
end)
pod_compass_room:connect_one_way("PoD - Compass Chest")

pod_dark_basement:connect_one_way("PoD - Dark Basement Left")
pod_dark_basement:connect_one_way("PoD - Dark Basement Right")

pod_harmless_hellway:connect_one_way(pod_arena)
pod_harmless_hellway:connect_one_way("PoD - Harmless Hellway")

pod_boss_room:connect_one_way("PoD - Boss", function() return GetBossRef("pod_boss") end)