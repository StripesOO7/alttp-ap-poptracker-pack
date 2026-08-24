-- SP_entrance = alttp_location.new("", nil, nil, "SP", true)
SP_first_room = alttp_location.new("SP_first_room", "SP First Room", nil, "SP", true)
local SP_hallway_before_first_trench = alttp_location.new("SP_hallway_before_first_trench", "SP ", nil, "SP", true)
local SP_first_trench = alttp_location.new("SP_first_trench", "SP 1st Trench", nil, "SP", true)
SP_main_room = alttp_location.new("SP_main_room", "SP Center Room", nil, "SP", true)
local SP_main_room_north_east_ledge = alttp_location.new("SP_main_room_north_east_ledge", "SP Main Room NE Ledge", nil, "SP", true)
local SP_roundabout = alttp_location.new("SP_roundabout", "SP Roundabout", nil, "SP", true)
local SP_second_trench = alttp_location.new("SP_second_trench", "SP 2nd Trench", nil, "SP", true)
local SP_hallway_after_second_trench = alttp_location.new("SP_hallway_after_second_trench", "SP Hallway After 2nd Tranch", nil, "SP", true)
local SP_flooded_room = alttp_location.new("SP_flooded_room", "SP Flooded Room", nil, "SP", true)
local SP_waterfall_room = alttp_location.new("SP_waterfall_room", "SP Waterfall", nil, "SP", true)
local SP_after_waterfall_room = alttp_location.new("SP_after_waterfall_room", "SP Beyond Waterfall", nil, "SP", true)
local SP_boss_room = alttp_location.new("SP_boss_room", "SP Boss Room", nil, "SP", true)

local SP_pot_row = alttp_location.new("SP_pot_row", "SP Pot Row")
local SP_map_chest_ledge = alttp_location.new("SP_map_chest_ledge", "SP Map Chest Ledge")
local SP_flood_first_trench_room = alttp_location.new("SP_flood_first_trench_room", "SP Flood First Trench Room")
local SP_flood_second_trench_room = alttp_location.new("SP_flood_second_trench_room", "SP Flood Second Trench Room")
local SP_big_key_chest_ledge = alttp_location.new("SP_big_key_chest_ledge", "SP big_ ey Chest Ledge")
local SP_shallow_trench = alttp_location.new("SP_shallow_trench", "SP Shallow Trench")
local SP_shallow_trench_big_key_ledge = alttp_location.new("SP_shallow_trench_big_key_ledge", "SP Shallow Trench Big Key Ledge")
local SP_shallow_water_attic = alttp_location.new("SP_shallow_water_attic", "SP Shallow Water Attic")
local SP_main_room_north_ledge = alttp_location.new("SP_main_room_north_ledge", "SP Main Room North Ledge")
local SP_push_statue_room = alttp_location.new("SP_push_statue_room", "SP Push Statue Room")
local SP_tiny_hallway = alttp_location.new("SP_tiny_hallway", "SP Tiny Hallway")
local SP_S_hallway = alttp_location.new("SP_S_hallway", "SP S Hallway")
local SP_C_hallway = alttp_location.new("SP_C_hallway", "SP C Hallway")
local SP_I_hallway = alttp_location.new("SP_I_hallway", "SP I Hallway")
local SP_boss_hallway = alttp_location.new("SP_boss_hallway", "SP Boss Hallway")
local SP_heavy_current = alttp_location.new("SP_heavy_current", "SP Heavy Current")
local SP_drain_switch_room = alttp_location.new("SP_drain_switch_room", "SP Drain Switch Room")
local SP_drain_switch_right_side = alttp_location.new("SP_drain_switch_right_side", "SP Drain Switch Right Side")
local SP_drain_switch_left_side = alttp_location.new("SP_drain_switch_left_side", "SP Drain Switch Left Side")
local SP_basement_shallows_hallway = alttp_location.new("SP_basement_shallows_hallway", "SP Basement Shallows Hallway")
local SP_west_chest_ledge = alttp_location.new("SP_west_chest_ledge", "SP West Chest Ledge")
local SP_flooded_room_balcony = alttp_location.new("SP_flooded_room_balcony", "SP Flooded Room Balcony")
local SP_boss_hallway_ledge = alttp_location.new("SP_boss_hallway_ledge", "SP Boss Hallway Ledge")



SP_first_room_1N_door = alttp_location.new("SP_first_room_1N_door", "SP First Room 1N Door", nil, "", true, 40, 4216, 4216, 1060, 1075, {"Swamp Palace Doors", "SP First Room 1N Door", "SP First Room 1N Door"})
SP_pot_row_1N_door = alttp_location.new("SP_pot_row_1N_door", "SP Pot Row 1N Door", nil, "", true, 56, 4216, 4216, 1565, 1595, {"Swamp Palace Doors", "SP Pot Row 1N Door", "SP Pot Row 1N Door"})
SP_pot_row_1W_door = alttp_location.new("SP_pot_row_1W_door", "SP Pot Row 1W Door", nil, "", true, 56, 4070, 4115, 1656, 1656, {"Swamp Palace Doors", "SP Pot Row 1W Door", "SP Pot Row 1W Door"})
SP_pot_row_3W_door = alttp_location.new("SP_pot_row_3W_door", "SP Pot Row 3W Door", nil, "", true, 56, 4070, 4115, 1912, 1912, {"Swamp Palace Doors", "SP Pot Row 3W Door", "SP Pot Row 3W Door"})
SP_map_chest_ledge_2E_door = alttp_location.new("SP_map_chest_ledge_2E_door", "SP Map Chest Ledge 2E Door", nil, "", true, 55, 4050, 4100, 1656, 1656, {"Swamp Palace Doors", "SP Map Chest Ledge 2E Door", "SP Map Chest Ledge 2E Door"})
SP_first_trench_4E_door = alttp_location.new("SP_first_trench_4E_door", "SP First Trench 4E Door", nil, "", true, 55, 4050, 4100, 1912, 1912, {"Swamp Palace Doors", "SP First Trench 4E Door", "SP First Trench 4E Door"})
SP_first_trench_3W_door = alttp_location.new("SP_first_trench_3W_door", "SP First Trench 3W Door", nil, "", true, 55, 3565, 3615, 1912, 1912, {"Swamp Palace Doors", "SP First Trench 3W Door", "SP First Trench 3W Door"})
SP_flood_first_trench_room_1W_door = alttp_location.new("SP_flood_first_trench_room_1W_door", "SP Flood First Trench Room 1W Door", nil, "", true, 55, 3565, 3615, 1656, 1656, {"Swamp Palace Doors", "SP Flood First Trench Room 1W Door", "SP Flood First Trench Room 1W Door"})
SP_main_room_north_ledge_N_door = alttp_location.new("SP_main_room_north_ledge_N_door", "SP Main Room North Ledge N Door", nil, "", true, 54, 3320, 3320, 1520, 1565, {"Swamp Palace Doors", "SP Main Room North Ledge N Door", "SP Main Room North Ledge N Door"})
SP_main_room_north_east_ledge_E_door = alttp_location.new("SP_main_room_north_east_ledge_E_door", "SP Main Room North East Ledge E Door", nil, "", true, 54, 3540, 3590, 1656, 1656, {"Swamp Palace Doors", "SP Main Room North East Ledge E Door", "SP Main Room North East Ledge E Door"})
SP_main_room_1W_door = alttp_location.new("SP_main_room_1W_door", "SP Main Room 1W_door", nil, "", true, 54, 3050, 3095, 1656, 1656, {"Swamp Palace Doors", "SP Main Room 1W_door", "SP Main Room 1W_door"})
SP_main_room_3W_door = alttp_location.new("SP_main_room_3W_door", "SP Main Room 3W_door", nil, "", true, 54, 3050, 3095, 1912, 1912, {"Swamp Palace Doors", "SP Main Room 3W_door", "SP Main Room 3W_door"})
SP_main_room_4E_door = alttp_location.new("SP_main_room_4E_door", "SP Main Room 4E_door", nil, "", true, 54, 3540, 3590, 1912, 1912, {"Swamp Palace Doors", "SP Main Room 4E_door", "SP Main Room 4E_door"})
SP_main_room_S_door = alttp_location.new("SP_main_room_S_door", "SP Main Room S Door", nil, "", true, 54, 3320, 3320, 1995, 2070, {"Swamp Palace Doors", "SP Main Room S Door", "SP Main Room S Door"})
SP_flood_second_trench_room_2E_door = alttp_location.new("SP_flood_second_trench_room_2E_door", "SP Flood Second Trench Room 2E Door", nil, "", true, 53, 3020, 3080, 1656, 1656, {"Swamp Palace Doors", "SP Flood Second Trench Room 2E Door", "SP Flood Second Trench Room 2E Door"})
SP_second_trench_4E_door = alttp_location.new("SP_second_trench_4E_door", "SP Second Trench 4E Door", nil, "", true, 53, 3020, 3080, 1912, 1912, {"Swamp Palace Doors", "SP Second Trench 4E Door", "SP Second Trench 4E Door"})
SP_second_trench_3W_door = alttp_location.new("SP_second_trench_3W_door", "SP Second Trench 3W Door", nil, "", true, 53, 2540, 2590, 1912, 1912, {"Swamp Palace Doors", "SP Second Trench 3W Door", "SP Second Trench 3W Door"})
SP_big_key_chest_ledge_1W_door = alttp_location.new("SP_big_key_chest_ledge_1W_door", "SP Big Key Chest Ledge 1W Door", nil, "", true, 53, 2540, 2595, 1656, 1656, {"Swamp Palace Doors", "SP Big Key Chest Ledge 1W Door", "SP Big Key Chest Ledge 1W Door"})
SP_shallow_trench_3N_door = alttp_location.new("SP_shallow_trench_3N_door", "SP Shallow Trench 3N Door", nil, "", true, 52, 2168, 2169, 1840, 1841, {"Swamp Palace Doors", "SP Shallow Trench 3N Door", "SP Shallow Trench 3N Door"})
SP_shallow_trench_4E_door = alttp_location.new("SP_shallow_trench_4E_door", "SP Shallow Trench 4E Door", nil, "", true, 52, 2520, 2570, 1912, 1912, {"Swamp Palace Doors", "SP Shallow Trench 4E Door", "SP Shallow Trench 4E Door"})
SP_shallow_water_attic_3N_door = alttp_location.new("SP_shallow_water_attic_3N_door", "SP Shallow Water Attic 3N Door", nil, "", true, 84, 2168, 2168, 2855, 2870, {"Swamp Palace Doors", "SP Shallow Water Attic 3N Door", "SP Shallow Water Attic 3N Door"})
SP_shallow_trench_big_key_ledge_2E_door = alttp_location.new("SP_shallow_trench_big_key_ledge_2E_door", "SP Shallow Trench Big Key Ledge 2E Door", nil, "", true, 52, 2520, 2570, 1656, 1656, {"Swamp Palace Doors", "SP Shallow Trench Big Key Ledge 2E Door", "SP Shallow Trench Big Key Ledge 2E Door"})
SP_roundabout_N_door = alttp_location.new("SP_roundabout_N_door", "SP Roundabout N Door", nil, "", true, 70, 3320, 3320, 2030, 2090, {"Swamp Palace Doors", "SP Roundabout N Door", "SP Roundabout N Door"})
SP_push_statue_room_S_door = alttp_location.new("SP_push_statue_room_S_door", "SP Push Statue Room S Door", nil, "", true, 38, 3320, 3320, 1495, 1560, {"Swamp Palace Doors", "SP Push Statue Room S Door", "SP Push Statue Room S Door"})
SP_push_statue_room_4N_door = alttp_location.new("SP_push_statue_room_4N_door", "SP Push Statue Room 4N Door", nil, "", true, 38, 3812, 3812, 1320, 1335, {"Swamp Palace Doors", "SP Push Statue Room 4N Door", "SP Push Statue Room 4N Door"})
SP_tiny_hallway_N_door = alttp_location.new("SP_tiny_hallway_N_door", "SP Tiny Hallway N Door", nil, "", true, 38, 3384, 3384, 1055, 1075, {"Swamp Palace Doors", "SP Tiny Hallway N Door", "SP Tiny Hallway N Door"})
SP_S_hallway_2N_door = alttp_location.new("SP_S_hallway_2N_door", "SP S Hallway 2N Door", nil, "", true, 38, 3496, 3496, 1065, 1080, {"Swamp Palace Doors", "SP S Hallway 2N Door", "SP S Hallway 2N Door"})
SP_drain_switch_room_N_door = alttp_location.new("SP_drain_switch_room_N_door", "SP Drain Switch Room N Door", nil, "", true, 118, 3384, 3384, 3620, 3635, {"Swamp Palace Doors", "SP Drain Switch Room N Door", "SP Drain Switch Room N Door"})
SP_drain_switch_room_2N_door = alttp_location.new("SP_drain_switch_room_2N_door", "SP Drain Switch Room 2N Door", nil, "", true, 118, 3496, 3496, 3615, 3640, {"Swamp Palace Doors", "SP Drain Switch Room 2N Door", "SP Drain Switch Room 2N Door"})
SP_basement_shallows_hallway_1N_door = alttp_location.new("SP_basement_shallows_hallway_1N_door", "SP Basement Shallows Hallway 1N Door", nil, "", true, 118, 3192, 3192, 3565, 3620, {"Swamp Palace Doors", "SP Basement Shallows Hallway 1N Door", "SP Basement Shallows Hallway 1N Door"})
SP_waterfall_room_3S_door = alttp_location.new("SP_waterfall_room_3S_door", "SP Waterfall Room 3S Door", nil, "", true, 102, 3192, 3192, 3530, 3610, {"Swamp Palace Doors", "SP Waterfall Room 3S Door", "SP Waterfall Room 3S Door"})
SP_after_waterfall_room_2N_door = alttp_location.new("SP_after_waterfall_room_2N_door", "SP After Waterfall Room 2N Door", nil, "", true, 102, 3448, 3448, 3105, 3120, {"Swamp Palace Doors", "SP After Waterfall Room 2N Door", "SP After Waterfall Room 2N Door"})
SP_C_hallway_2N_door = alttp_location.new("SP_C_hallway_2N_door", "SP C Hallway 2N Door", nil, "", true, 22, 3448, 3448, 545, 555, {"Swamp Palace Doors", "SP C Hallway 2N Door", "SP C Hallway 2N Door"})
SP_boss_hallway_1N_door = alttp_location.new("SP_boss_hallway_1N_door", "SP Boss Hallway 1N Door", nil, "", true, 22, 3192, 3192, 530, 580, {"Swamp Palace Doors", "SP Boss Hallway 1N Door", "SP Boss Hallway 1N Door"})
SP_boss_room_3S_door = alttp_location.new("SP_boss_room_3S_door", "SP Boss Room 3S Door", nil, "", true, 6, 3192, 3192, 500, 540, {"Swamp Palace Doors", "SP Boss Room 3S Door", "SP Boss Room 3S Door"})
SP_flooded_room_balcony_4N_door =alttp_location.new("SP_flooded_room_balcony_4N_door", "SP Flooded Room Balcony 4N Door", nil, "", true, 118, 3812, 3812, 3870, 3900, {"Swamp Palace Doors", "SP Flooded Room Balcony 4N Door", "SP Flooded Room Balcony 4N Door"})


SP_entrance_inside:connect_two_ways(SP_first_room, function()
    return ALL(
        CanInteract(SP_entrance_inside),
        "flippers",
        CanReach("Dam_inside"),
        CanInteract(Dam_inside),
        ANY(
            CanChangeWorldWithMirror,
            Tracker:FindObjectForCode("er_tracking").CurrentStage > 0
        )
    )
end)

SP_first_room:connect_one_way("SP - Entrance Chest", function() return ALL(DealDamage, CanInteract(SP_first_room)) end)
SP_first_room:connect_two_ways(SP_first_room_1N_door)
SP_first_room_1N_door:connect_two_ways_entrance("", SP_pot_row_1N_door, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SP_pot_row_1N_door:connect_two_ways(SP_pot_row)

SP_hallway_before_first_trench:connect_one_way("SP - Pot Row Key")
SP_hallway_before_first_trench:connect_one_way("SP - Pot Row Pot #1")
SP_hallway_before_first_trench:connect_one_way("SP - Pot Row Pot #2")
SP_hallway_before_first_trench:connect_one_way("SP - Pot Row Pot #3")

SP_pot_row:connect_two_ways(SP_pot_row_1W_door)
SP_pot_row_1W_door:connect_two_ways_entrance("", SP_map_chest_ledge_2E_door, function() return Has("bombs") end)
SP_map_chest_ledge_2E_door:connect_two_ways(SP_map_chest_ledge)
SP_map_chest_ledge:connect_one_way("SP - Map chest")

SP_pot_row:connect_two_ways(SP_pot_row_3W_door)
SP_pot_row_3W_door:connect_two_ways_entrance("", SP_first_trench_4E_door)
SP_first_trench_4E_door:connect_two_ways(SP_first_trench)

SP_first_trench:connect_one_way("SP - Tench 1 Pot Key")
SP_first_trench:connect_one_way("SP - Trench 1 Key Ledge Pot #2")
SP_first_trench:connect_two_ways(SP_flood_first_trench_room, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            Has("smallkey", keys, 1, keys, 2),
            CheckGlitches(1),
            "bombs",
            "hookshot"
        ),
        ALL(
            "hammer",
            Has("smallkey", keys, 1, keys + 1, 3)
        )
    ), KDSreturn(keys, keys + 1)
end)

SP_flood_first_trench_room:connect_two_ways(SP_flood_first_trench_room_1W_door)
SP_flood_first_trench_room_1W_door:connect_two_ways_entrance("", SP_main_room_north_east_ledge_E_door)
SP_main_room_north_east_ledge_E_door:connect_two_ways(SP_main_room_north_east_ledge)

SP_main_room_north_east_ledge:connect_one_way("SP - Hub Dead Ledge Pot #1")
SP_main_room_north_east_ledge:connect_one_way("SP - Hub Dead Ledge Pot #1")

SP_first_trench:connect_two_ways(SP_first_trench_3W_door)
SP_first_trench_3W_door:connect_two_ways_entrance("", SP_main_room_4E_door)

SP_main_room_4E_door:connect_two_ways(SP_main_room)

SP_main_room:connect_one_way("SP - Hookshot Pot Key", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Hub Side Ledges Pot #3", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Hub Side Ledges Pot #4", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Hub Side Ledges Pot #5", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Hub Side Ledges Pot #6", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Big Chest", function() return Has("bigkey") end)

SP_main_room:connect_two_ways(SP_main_room_S_door)
SP_main_room_S_door:connect_two_ways_entrance("", SP_roundabout_N_door)
SP_roundabout_N_door:connect_two_ways(SP_roundabout)

SP_roundabout:connect_one_way("SP - Compass Chest")
SP_roundabout:connect_one_way("SP - Donut Top Pot #1")
SP_roundabout:connect_one_way("SP - Donut Top Pot #2")

SP_main_room:connect_two_ways(SP_main_room_1W_door)
SP_main_room_1W_door:connect_two_ways_entrance("", SP_flood_second_trench_room_2E_door, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 5),
            CheckGlitches(1)
        ),
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 6)
        )
    ), KDSreturn(keys, keys + 1)
end)
SP_flood_second_trench_room_2E_door:connect_two_ways(SP_flood_second_trench_room)

SP_main_room:connect_two_ways(SP_main_room_3W_door)
SP_main_room_3W_door:connect_two_ways_entrance("", SP_second_trench_4E_door)
SP_second_trench_4E_door:connect_two_ways(SP_second_trench)

SP_second_trench:connect_one_way("SP - Trench 2 Pot Key")
SP_second_trench:connect_one_way("SP - Trench 2 Departure Pot #7")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #8")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #9")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #10")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #11")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #12")
SP_second_trench:connect_one_way("SP - Trench 2 Pots Pot #13")

-- SP_flood_second_trench_room:connect_two_ways(SP_second_trench)
SP_second_trench:connect_two_ways(SP_second_trench_3W_door)
SP_second_trench_3W_door:connect_two_ways_entrance("", SP_shallow_trench_4E_door)
SP_shallow_trench_4E_door:connect_two_ways(SP_shallow_trench)
SP_shallow_trench:connect_two_ways(SP_shallow_trench_3N_door)

SP_shallow_trench_3N_door:connect_two_ways_entrance(SP_shallow_water_attic_3N_door)
SP_shallow_water_attic_3N_door:connect_two_ways(SP_shallow_water_attic)

SP_shallow_water_attic:connect_one_way("SP -Attic Pot #1")
SP_shallow_water_attic:connect_one_way("SP -Attic Pot #2")
SP_shallow_water_attic:connect_one_way("SP -Attic Pot #3")
SP_shallow_water_attic:connect_one_way("SP -Attic Pot #4")

SP_shallow_water_attic:connect_one_way(SP_shallow_trench_big_key_ledge)

SP_shallow_trench_big_key_ledge:connect_one_way("SP - Barrier Ledge Pot #1")
SP_shallow_trench_big_key_ledge:connect_one_way("SP - Barrier Ledge Pot #2")

SP_shallow_trench_big_key_ledge:connect_two_ways(SP_shallow_trench_big_key_ledge_2E_door)
SP_big_key_chest_ledge_1W_door:connect_two_ways_entrance("", SP_big_key_chest_ledge_1W_door)

SP_big_key_chest_ledge_1W_door:connect_two_ways(SP_big_key_chest_ledge)
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Chest")
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Ledge Pot #2")
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Ledge Pot #3")
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Ledge Pot #4")
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Ledge Pot #5")
SP_big_key_chest_ledge:connect_one_way("SP - Big Key Ledge Pot #6")

SP_shallow_trench_big_key_ledge:connect_one_way(SP_shallow_trench)

SP_shallow_water_attic:connect_one_way(SP_west_chest_ledge)
SP_west_chest_ledge:connect_one_way("SP - West Chest")
SP_west_chest_ledge:connect_one_way(SP_shallow_trench)


SP_main_room:connect_two_ways_stuck(SP_main_room_north_ledge, function() return Has("hookshot") end)

SP_main_room_north_ledge:connect_one_way("SP - Hub North Ledge Pot #7")
SP_main_room_north_ledge:connect_one_way("SP - Hub North Ledge Pot #8")

SP_main_room_north_ledge:connect_two_ways(SP_main_room_north_ledge_N_door)
SP_main_room_north_ledge_N_door:connect_two_ways_entrance("", SP_push_statue_room_S_door, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 4),
            CheckGlitches(1),
            "hookshot"
        ),
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
            "hookshot"
        )
    ), KDSreturn(keys, keys + 1)
end)

SP_push_statue_room_S_door:connect_two_ways(SP_push_statue_room)

SP_push_statue_room:connect_one_way("SP - Push Statue Pot #3")
SP_push_statue_room:connect_one_way("SP - Push Statue Pot #4")
SP_push_statue_room:connect_one_way("SP - Push Statue Pot #5")

SP_push_statue_room:connect_two_ways(SP_tiny_hallway)

SP_tiny_hallway:connect_one_way("SP - Shooters Pot #1")
SP_tiny_hallway:connect_one_way("SP - Shooters Pot #2")

SP_tiny_hallway:connect_two_ways(SP_tiny_hallway_N_door)
SP_tiny_hallway_N_door:connect_two_ways_entrance("", SP_drain_switch_room_N_door)
SP_drain_switch_room_N_door:connect_two_ways(SP_drain_switch_left_side)
SP_drain_switch_left_side:connect_two_ways_stuck(SP_drain_switch_room, function() return CanReach("SP_drain_switch_right_side") end)

SP_push_statue_room:connect_two_ways(SP_S_hallway)
SP_S_hallway:connect_two_ways(SP_S_hallway_2N_door)
SP_S_hallway_2N_door:connect_two_ways_entrance("", SP_drain_switch_room_2N_door)
SP_drain_switch_room_2N_door:connect_two_ways(SP_drain_switch_right_side)

SP_drain_switch_right_side:connect_one_way("SP - Drain Right Pot #1")
SP_drain_switch_right_side:connect_one_way(SP_drain_switch_left_side)

SP_drain_switch_room:connect_two_ways(SP_basement_shallows_hallway)
SP_basement_shallows_hallway:connect_two_ways(SP_basement_shallows_hallway_1N_door)

SP_push_statue_room:connect_two_ways(SP_push_statue_room_4N_door)
SP_push_statue_room_4N_door:connect_two_ways_entrance("", SP_flooded_room_balcony_4N_door)
SP_flooded_room_balcony_4N_door:connect_two_ways(SP_flooded_room_balcony)
SP_flooded_room_balcony:connect_two_ways(SP_flooded_room, function() return CanReach("SP_drain_switch_right_side") end)

SP_flooded_room:connect_one_way("SP - Flooded Room Left")
SP_flooded_room:connect_one_way("SP - Flooded Room Right")
SP_flooded_room:connect_one_way("SP - Flooded Spot Pot #2")
SP_flooded_room:connect_one_way("SP - Flooded Spot Pot #3")
SP_flooded_room:connect_two_ways_stuck(SP_basement_shallows_hallway, function() return CanReach("SP_drain_switch_right_side") end)

SP_basement_shallows_hallway_1N_door:connect_two_ways_entrance("", SP_waterfall_room_3S_door)
SP_waterfall_room_3S_door:connect_two_ways(SP_waterfall_room)

SP_waterfall_room:connect_one_way("SP - Waterfall Room")
SP_waterfall_room:connect_one_way("SP - Refill Pot #1")
SP_waterfall_room:connect_one_way("SP - Refill Pot #2")
SP_waterfall_room:connect_one_way("SP - Refill Pot #3")
SP_waterfall_room:connect_one_way("SP - Refill Pot #4")
SP_waterfall_room:connect_one_way("SP - Refill Pot #5")
SP_waterfall_room:connect_one_way("SP - Refill Pot #6")
SP_waterfall_room:connect_one_way("SP - Behind Waterfall Pot #7")
SP_waterfall_room:connect_one_way("SP - Behind Waterfall Pot #8")
SP_waterfall_room:connect_one_way("SP - Behind Waterfall Pot #9")
SP_waterfall_room:connect_one_way("SP - Behind Waterfall Pot #10")

SP_waterfall_room:connect_two_ways(SP_after_waterfall_room)
SP_after_waterfall_room:connect_two_ways(SP_after_waterfall_room_2N_door)

SP_after_waterfall_room_2N_door:connect_two_ways_entrance("", SP_C_hallway)
SP_C_hallway:connect_two_ways_stuck(SP_heavy_current, nil, function() return Has("flippers") end)

-- SP_heavy_current:connect_two_ways(SP_I_hallway, function() return Has("bombs") end)
SP_heavy_current:connect_one_way("SP - Waterway Pot Key", function() return Has("flippers") end)
SP_heavy_current:connect_two_ways_stuck(SP_I_hallway, function() return ALL("flippers", "bombs") end)

SP_I_hallway:connect_one_way("SP - I Pot #1")
SP_I_hallway:connect_one_way("SP - I Pot #2")
SP_I_hallway:connect_one_way("SP - I Pot #3")
SP_I_hallway:connect_one_way("SP - I Pot #4")
SP_I_hallway:connect_one_way("SP - I Pot #5")
SP_I_hallway:connect_one_way("SP - I Pot #6")
SP_I_hallway:connect_one_way("SP - I Pot #7")
SP_I_hallway:connect_one_way("SP - I Pot #8")

SP_heavy_current:connect_two_ways_stuck(SP_boss_hallway_ledge, function() return Has("flippers") end)
SP_boss_hallway_ledge:connect_two_ways(SP_boss_hallway, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
            CheckGlitches(1)
        ),
        ALL(
            Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 6)
        )
    ), KDSreturn(keys, keys + 1)
end)

SP_boss_hallway:connect_two_ways(SP_boss_hallway_1N_door)
SP_boss_hallway_1N_door:connect_two_ways_entrance("", SP_boss_room_3S_door)
SP_boss_room_3S_door:connect_two_ways(SP_boss_room)

SP_boss_room:connect_one_way("SP - Boss", function() return GetBossRef("sp_boss") end)


---

-- SP_entrance_inside:connect_two_ways(SP_first_room, function()
--     return ALL(
--         CanInteract(SP_entrance_inside),
--         "flippers",
--         CanReach("Dam_inside"),
--         CanInteract(Dam_inside),
--         ANY(
--             CanChangeWorldWithMirror,
--             Tracker:FindObjectForCode("er_tracking").CurrentStage > 0
--         )
--     )
-- end)

-- SP_first_room:connect_two_ways(SP_hallway_before_first_trench, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
-- SP_first_room:connect_one_way("SP - Entrance Chest", function() return ALL(DealDamage, CanInteract(SP_first_room)) end)

-- SP_hallway_before_first_trench:connect_two_ways(SP_first_trench, function(keys, Current_Dungeon) return Has("smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)

-- SP_hallway_before_first_trench:connect_one_way("SP - Map chest", function() return Has("bombs") end)

-- SP_first_trench:connect_two_ways(SP_main_room, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             Has("smallkey", keys, 1, keys, 2),
--             CheckGlitches(1),
--             "bombs",
--             "hookshot"
--         ),
--         ALL(
--             "hammer",
--             Has("smallkey", keys, 1, keys + 1, 3)
--         )
--     ), KDSreturn(keys, keys + 1)
-- end)
-- SP_first_trench:connect_one_way("SP - Tench 1 Pot Key")

-- SP_main_room:connect_two_ways(SP_roundabout)
-- SP_main_room:connect_two_ways(SP_second_trench)
-- SP_main_room:connect_two_ways(SP_flooded_room, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 4),
--             CheckGlitches(1),
--             "hookshot"
--         ),
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
--             "hookshot"
--         )
--     ), KDSreturn(keys, keys + 1)
-- end)
-- SP_main_room:connect_one_way("SP - Hookshot Pot Key", function() return Has("hookshot") end)
-- SP_main_room:connect_one_way("SP - Big Chest", function() return Has("bigkey") end)

-- SP_second_trench:connect_two_ways(SP_hallway_after_second_trench, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 5),
--             CheckGlitches(1)
--         ),
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 6)
--         )
--     ), KDSreturn(keys, keys + 1)
-- end)
-- SP_second_trench:connect_one_way("SP - Trench 2 Pot Key")

-- SP_hallway_after_second_trench:connect_one_way("SP - West Chest")
-- SP_hallway_after_second_trench:connect_one_way("SP - Big Key Chest")

-- SP_roundabout:connect_one_way("SP - Compass Chest")

-- SP_flooded_room:connect_two_ways(SP_waterfall_room)
-- SP_flooded_room:connect_one_way("SP - Flooded Room Left")
-- SP_flooded_room:connect_one_way("SP - Flooded Room Right")

-- SP_waterfall_room:connect_two_ways(SP_after_waterfall_room)
-- SP_waterfall_room:connect_one_way("SP - Waterfall Room")

-- SP_after_waterfall_room:connect_two_ways(SP_boss_room, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
--             CheckGlitches(1)
--         ),
--         ALL(
--             Has("smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 6)
--         )
--     ), KDSreturn(keys, keys + 1)
-- end)
-- SP_after_waterfall_room:connect_one_way("SP - Waterway Pot Key")

-- SP_boss_room:connect_one_way("SP - Boss", function() return GetBossRef("sp_boss") end)