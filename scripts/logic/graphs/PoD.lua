-- Pod_entrance = alttp_location.new("", nil, nil, "PoD", true)
-- local PoD_three_way_room = alttp_location.new("", nil, nil, "PoD", true)
local PoD_three_way_room_left = alttp_location.new("PoD_three_way_room_left", "PoD 3-Way Left", nil, "PoD", true)
local PoD_three_way_room_middle = alttp_location.new("PoD_three_way_room_middle", "PoD 3-Way Center", nil, "PoD", true)
local PoD_three_way_room_right = alttp_location.new("PoD_three_way_room_right", "PoD 3-Way Right", nil, "PoD", true)
PoD_shooter_room = alttp_location.new("PoD_shooter_room", "PoD Shooter", nil, "PoD", true) -- not local because of kiki skip
local PoD_teleporter_room = alttp_location.new("PoD_teleporter_room", "PoD Teleporter", nil, "PoD", true)
local PoD_mimic_room = alttp_location.new("PoD_mimic_room", "PoD Mimics", nil, "PoD", true)
local PoD_switch_room_top = alttp_location.new("PoD_switch_room_top", "PoD Hammer Ledge", nil, "PoD", true)
local PoD_switch_room_bottom = alttp_location.new("PoD_switch_room_bottom", "PoD Hammer Floor", nil, "PoD", true)
local PoD_arena = alttp_location.new("PoD_arena", "PoD Arena", nil, "PoD", true)
local PoD_big_key_chest_room = alttp_location.new("PoD_big_key_chest_room", "PoD Big Key Chest", nil, "PoD", true)
local Pod_basement_ledge = alttp_location.new("Pod_basement_ledge", "PoD Basement Ledge", nil, "PoD", true)
local Pod_basement_floor = alttp_location.new("Pod_basement_floor", "PoD Basement Floor", nil, "PoD", true)
local PoD_big_key_chest_ledge = alttp_location.new("PoD_big_key_chest_ledge", "PoD Big Key Ledge", nil, "PoD", true)
local PoD_collapsing_bridge = alttp_location.new("PoD_collapsing_bridge", "PoD Collapsing Bridge", nil, "PoD", true)
local PoD_dark_maze = alttp_location.new("PoD_dark_maze", "PoD Dark Maze", nil, "PoD", true)
local PoD_compass_room = alttp_location.new("PoD_compass_room", "PoD compass Room", nil, "PoD", true)
local PoD_dark_basement = alttp_location.new("PoD_dark_basement", "PoD Dark Basement", nil, "PoD", true)
local PoD_harmless_hellway = alttp_location.new("PoD_harmless_hellway", "PoD Harmless Hellway", nil, "PoD", true)
local PoD_boss_room = alttp_location.new("PoD_boss_room", "PoD Boss Room", nil, "PoD", true)

PoD_entrance_inside:connect_two_ways(PoD_three_way_room_left, function() return CanInteract(PoD_entrance_inside) end)
PoD_entrance_inside:connect_two_ways(PoD_three_way_room_middle, function() return CanInteract(PoD_entrance_inside) end)
PoD_entrance_inside:connect_two_ways(PoD_three_way_room_right, function() return CanInteract(PoD_entrance_inside) end)
PoD_three_way_room_middle:connect_two_ways(PoD_three_way_room_right)

PoD_three_way_room_left:connect_two_ways(PoD_shooter_room)
PoD_three_way_room_middle:connect_two_ways(PoD_big_key_chest_room, function(keys)
    if not (PoD_switch_room_bottom:accessibility() > 5 and PoD_switch_room_top:accessibility() > 5) then
        return Has("Pod_smallkey", keys + 1, 1, keys + 1, 1), keys + 1
    else
        return ALL(
            PoD_switch_room_bottom:accessibility(),
            PoD_switch_room_top:accessibility(),
            Has("Pod_smallkey", keys, 0, keys, 0)
        ), keys
    end
end)
PoD_three_way_room_right:connect_two_ways(PoD_teleporter_room)
PoD_big_key_chest_room:connect_one_way(Pod_basement_ledge, function() return Has("bombs") end)
PoD_big_key_chest_room:connect_one_way(Pod_basement_floor)
PoD_shooter_room:connect_one_way("PoD - Shooter Room", function() return CanInteract(PoD_shooter_room) end)

Pod_basement_ledge:connect_one_way(Pod_basement_floor)
Pod_basement_ledge:connect_two_ways(PoD_big_key_chest_ledge, function(keys)
    return Has("Pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Dark Maze Top/Dark Maze Top"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Dark Maze Top/Dark Maze Top"), 6), keys + 1
end)

PoD_big_key_chest_ledge:connect_one_way(Pod_basement_floor)
PoD_big_key_chest_ledge:connect_one_way("PoD - Big Key Chest")

Pod_basement_floor:connect_one_way(PoD_teleporter_room)
Pod_basement_floor:connect_one_way("PoD - Stalfos Basement")

PoD_teleporter_room:connect_two_ways(PoD_mimic_room, function()
    return ALL(
        ANY(
            "boots",
            "bombs"
        ),
        CanInteract(PoD_teleporter_room)
    )
end)

PoD_mimic_room:connect_two_ways(PoD_switch_room_top, function(keys) return EnemizerCheck("bow"), keys + 1 end)

PoD_switch_room_top:connect_one_way(PoD_switch_room_bottom, function() return Has("hammer") end)
PoD_switch_room_top:connect_one_way("PoD - Map Chest")
PoD_switch_room_top:connect_one_way("PoD - Arena Ledge", function() return Has("bombs") end)

PoD_switch_room_bottom:connect_two_ways(PoD_boss_room, function(keys)
    return ALL(
        "bow",
        "hammer",
        DarkRooms(false),
        "Pod_bigkey",
        Has("Pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Harmless Hellway/Harmless Hellway"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Harmless Hellway/Harmless Hellway"), 6)
    ), keys + 1
end)
PoD_switch_room_bottom:connect_two_ways(PoD_arena, HitRanged)

PoD_big_key_chest_room:connect_two_ways(PoD_arena)

PoD_arena:connect_one_way(PoD_collapsing_bridge, function(keys)
    if Tracker:FindObjectForCode("bow").Active then
        return Has("Pod_smallkey", keys + 1, 4, keys + 1, 4), keys + 1
    else
        return Has("Pod_smallkey", keys + 1, 3, keys + 1, 3), keys + 1
    end
end)
PoD_arena:connect_one_way("PoD - Arena Bridge")

PoD_collapsing_bridge:connect_two_ways(PoD_dark_maze, function(keys)
    return ALL(
        PoD_compass_room:accessibility(),
        DarkRooms(false),
        Has("lamp"),
        Has("Pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Big Key Chest/Big Key Chest"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Harmless Hellway/Harmless Hellway", "@Palace of Darkness/Boss/Boss Item", "@Palace of Darkness/Big Key Chest/Big Key Chest"), 6)
    ), keys + 1
end)
PoD_collapsing_bridge:connect_two_ways(PoD_compass_room, function() return PoD_collapsing_bridge:accessibility() end)

PoD_dark_maze:connect_one_way("PoD - Dark Maze Top")
PoD_dark_maze:connect_one_way("PoD - Dark Maze Bottom")
PoD_dark_maze:connect_one_way("PoD - Big Chest", function()
    return ALL(
        "Pod_bigkey",
        "bombs"
    )
end)

PoD_compass_room:connect_two_ways(PoD_dark_basement, function() return DarkRooms(true) end)
PoD_compass_room:connect_two_ways(PoD_harmless_hellway, function(keys)
    return Has("Pod_smallkey", keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Boss/Boss Item"), 6, keys + CountDoneDeadends(1, "@Palace of Darkness/Big Key Chest/Big Key Chest", "@Palace of Darkness/Dark Maze Top/Dark Maze Top", "@Palace of Darkness/Boss/Boss Item"), 6), keys + 1
end)
PoD_compass_room:connect_one_way("PoD - Compass Chest")

PoD_dark_basement:connect_one_way("PoD - Dark Basement Left")
PoD_dark_basement:connect_one_way("PoD - Dark Basement Right")

PoD_harmless_hellway:connect_one_way(PoD_arena)
PoD_harmless_hellway:connect_one_way("PoD - Harmless Hellway")

PoD_boss_room:connect_one_way("PoD - Boss", function() return GetBossRef("Pod_boss") end)