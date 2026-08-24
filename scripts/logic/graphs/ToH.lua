-- ToH_entrance = alttp_location.new("", nil, nil, "ToH", true)
local ToH_basement_cage = alttp_location.new("ToH_basement_cage", "ToH Basement Cage", nil, "ToH", true)
local ToH_main_room = alttp_location.new("ToH_main_room", "ToH Main", nil, "ToH", true)
local ToH_big_key_chest = alttp_location.new("ToH_big_key_chest", "ToH Basement Back", nil, "ToH", true)
local ToH_big_chest_room = alttp_location.new("ToH_big_chest_room", "ToH Big Chest Floor", nil, "ToH", true)
local ToH_boss_room = alttp_location.new("ToH_boss_room", "ToH Boss Floor", nil, "ToH", true)
-- local ToH_before_boss_floor = alttp_location.new("ToH_before_boss_floor", "ToH Below Boss", nil, "ToH", true)
ToH_fairy_drop = alttp_location.new("ToH_fairy_drop", "ToH Boss Floor", nil, "ToH", true)
local ToH_above_big_chest = alttp_location.new("ToH_above_big_chest", "ToH Boss Dropdown", nil, "ToH", true)

local ToH_big_chest_platform = alttp_location.new("ToH_big_chest_platform", "ToH Big Chest Platform")
local ToH_tile_room = alttp_location.new("ToH_tile_room", "ToH Tile Room")
local ToH_tridorm_room = alttp_location.new("ToH_tridorm_room", "ToH Tridorm Room")
local ToH_3_hard_head_beatles = alttp_location.new("ToH_3_hard_head_beatles", "ToH 3 Hard Head Beatles")
local ToH_big_key_door_room = alttp_location.new("ToH_big_key_door_room", "ToH Big Key Door Room")
local ToH_startile_wide = alttp_location.new("ToH_startile_wide", "ToH Startile Wide")
local ToH_5F_orange_path = alttp_location.new("ToH_5F_orange_path", "ToH 5F Orange path")

ToH_main_room_1N_door = alttp_location.new("ToH_main_room_1N_door", "ToH Main Room 1N Door", nil, "", true, 119, 3700, 3710, 3640, 3665, {"Tower of Hera Doors", "ToH Main Room 1N Door", "ToH Main Room 1N Door"})
ToH_main_room_3N_door = alttp_location.new("ToH_main_room_3N_door", "ToH Main Room 3N Door", nil, "", true, 119, 3715, 3721, 3920, 3935, {"Tower of Hera Doors", "ToH Main Room 3N Door", "ToH Main Room 3N Door"})
ToH_main_room_4N_door = alttp_location.new("ToH_main_room_4N_door", "ToH Main Room 4N Door", nil, "", true, 119, 3940, 3950, 3920, 3935, {"Tower of Hera Doors", "ToH Main Room 4N Door", "ToH Main Room 4N Door"})
ToH_basement_cage_3N_door = alttp_location.new("ToH_basement_cage_3N_door", "ToH Basement Cage 3N Door", nil, "", true, 135, 3720, 3721, 4400, 4420, {"Tower of Hera Doors", "ToH Basement Cage 3N Door", "ToH Basement Cage 3N Door"})
ToH_tile_room_1N_door = alttp_location.new("ToH_tile_room_1N_door", "ToH Tile Room 1N Door", nil, "", true, 135, 3700, 3710, 4135, 4150, {"Tower of Hera Doors", "ToH Tile Room 1N Door", "ToH Tile Room 1N Door"})
ToH_3_hard_head_beatles_4N_door = alttp_location.new("ToH_3_hard_head_beatles_4N_door", "ToH 3 Hard Head Beatles 4N Door", nil, "", true, 49, 870, 880, 1840, 1860, {"Tower of Hera Doors", "ToH 3 Hard Head Beatles 4N Door", "ToH 3 Hard Head Beatles 4N Door"})
ToH_startile_wide_2N_door = alttp_location.new("ToH_startile_wide_2N_door", "ToH Startile Wide 2N Door", nil, "", true, 49, 945, 960, 1645, 1670, {"Tower of Hera Doors", "ToH Startile Wide 2N Door", "ToH Startile Wide 2N Door"})
ToH_big_chest_room_1N_door = alttp_location.new("ToH_big_chest_room_1N_door", "ToH Big Chest Room 1N Door", nil, "", true, 39, 3635, 3645, 1140, 1165, {"Tower of Hera Doors", "ToH Big Chest Room 1N Door", "ToH Big Chest Room 1N Door"})
ToH_big_chest_room_2N_door = alttp_location.new("ToH_big_chest_room_2N_door", "ToH Big Chest Room 2N Door", nil, "", true, 39, 4015, 4035, 1135, 1155, {"Tower of Hera Doors", "ToH Big Chest Room 2N Door", "ToH Big Chest Room 2N Door"})
ToH_5F_orange_path_1N_door = alttp_location.new("ToH_5F_orange_path_1N_door", "ToH 5F Orange Path 1N Door", nil, "", true, 23, 3635, 3645, 625, 650, {"Tower of Hera Doors", "ToH 5F Orange Path 1N Door", "ToH 5F Orange Path 1N Door"})
ToH_5F_orange_path_2N_door = alttp_location.new("ToH_5F_orange_path_2N_door", "ToH 5F Orange Path 2N Door", nil, "", true, 23, 4005, 4010, 620, 660, {"Tower of Hera Doors", "ToH 5F Orange Path 2N Door", "ToH 5F Orange Path 2N Door"})
ToH_boss_room_2N_door = alttp_location.new("ToH_boss_room_2N_door", "ToH Boss Room 2N Door", nil, "", true, 7, 4005, 4010, 105, 125, {"Tower of Hera Doors", "ToH Boss Room 2N Door", "ToH Boss Room 2N Door"})


ToH_entrance_inside:connect_two_ways(ToH_main_room, function()
    return ALL(
        CanInteract(ToH_entrance_inside),
        ANY(
            DealDamage,
            "redboomerang",
            "blueboomerang",
            "icerod"
        )
    )
end)
ToH_main_room:connect_two_ways(ToH_big_key_chest, function(keys, Current_Dungeon) return ALL(Has("smallkey", keys + 1, 1, keys + 1, 1), CanInteract(ToH_main_room)), keys + 1 end)
ToH_main_room:connect_one_way("ToH - Map Chest", function() return CanInteract(ToH_main_room) end)

ToH_main_room:connect_two_ways(ToH_main_room_1N_door)
ToH_main_room_1N_door:connect_two_ways_entrance("", ToH_tile_room_1N_door)
ToH_tile_room_1N_door:connect_two_ways(ToH_tile_room)

ToH_tile_room:connect_one_way("ToH - Tile Room Pot #1")
ToH_tile_room:connect_one_way("ToH - Tile Room Pot #2")
ToH_tile_room:connect_one_way("ToH - Tile Room Pot #3")
ToH_tile_room:connect_one_way("ToH - Tile Room Pot #4")
ToH_tile_room:connect_one_way("ToH - Tile Room Pot #5")
ToH_tile_room:connect_one_way("ToH - Tile Room Pot #6")

ToH_tile_room:connect_two_ways_stuck(ToH_tridorm_room, function() return CanInteract(ToH_tile_room) end)
ToH_tridorm_room:connect_two_ways(ToH_big_key_chest, function() return CanInteract(ToH_tridorm_room) end)
ToH_big_key_chest:connect_one_way("ToH - Big Key Chest", function() return Has("firesource") end)
ToH_big_key_chest:connect_one_way("ToH - Torches Pot #7")
ToH_big_key_chest:connect_one_way("ToH - Torches Pot #8")

ToH_main_room:connect_two_ways(ToH_main_room_3N_door)
ToH_main_room_3N_door:connect_two_ways_entrance("", ToH_basement_cage_3N_door)
ToH_basement_cage_3N_door:connect_two_ways(ToH_basement_cage)
ToH_basement_cage:connect_one_way("ToH - Basement Cage", function() return CanInteract(ToH_basement_cage) end)

ToH_main_room:connect_two_ways(ToH_main_room_4N_door)
ToH_main_room_4N_door:connect_two_ways_entrance("", ToH_3_hard_head_beatles_4N_door)
ToH_3_hard_head_beatles_4N_door:connect_two_ways(ToH_3_hard_head_beatles)

ToH_3_hard_head_beatles:connect_one_way("ToH - Beetles Pot #1")
ToH_3_hard_head_beatles:connect_one_way("ToH - Beetles Pot #2")

ToH_3_hard_head_beatles:connect_two_ways_stuck(ToH_big_key_door_room, function() return ALL(CanInteract(ToH_3_hard_head_beatles), DealDamage) end)
ToH_3_hard_head_beatles:connect_one_way(ToH_main_room)
ToH_big_key_door_room:connect_two_ways_stuck(ToH_startile_wide, function() return Has("bigkey") end)
ToH_big_key_door_room:connect_one_way(ToH_main_room)
ToH_startile_wide:connect_two_ways(ToH_startile_wide_2N_door)
ToH_startile_wide:connect_one_way(ToH_main_room)

ToH_startile_wide_2N_door:connect_two_ways_entrance("", ToH_big_chest_room_2N_door)
ToH_big_chest_room_2N_door:connect_two_ways(ToH_big_chest_room)

ToH_big_chest_room:connect_one_way("ToH - Compass Chest")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #1")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #2")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #3")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #4")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #5")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #6")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #7")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #8")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #9")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #10")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #11")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #12")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #13")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #14")
ToH_big_chest_room:connect_one_way("ToH - 4F Pot #15")

ToH_big_chest_room:connect_two_ways(ToH_big_chest_room_1N_door)
ToH_big_chest_room:connect_one_way(ToH_startile_wide)
ToH_big_chest_room:connect_one_way(ToH_big_chest_platform, function() return Has("hookshot") end)

ToH_big_chest_platform:connect_one_way("ToH - Big Chest", function() return Has("bigkey") end)
ToH_big_chest_platform:connect_one_way(ToH_big_chest_room)

ToH_big_chest_room_1N_door:connect_two_ways_entrance("", ToH_5F_orange_path_1N_door)
ToH_5F_orange_path_1N_door:connect_two_ways(ToH_5F_orange_path)

ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #1")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #2")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #3")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #4")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #5")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #6")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #7")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #8")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #9")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #10")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #11")
ToH_5F_orange_path:connect_one_way("ToH - 5F Pot Block Pot #12")

ToH_5F_orange_path:connect_two_ways(ToH_5F_orange_path_2N_door)
ToH_5F_orange_path:connect_one_way(ToH_fairy_drop)
ToH_5F_orange_path:connect_one_way(ToH_big_chest_platform)
ToH_5F_orange_path:connect_one_way(ToH_big_chest_room)

ToH_fairy_drop:connect_one_way(ToH_above_big_chest)

ToH_5F_orange_path_2N_door:connect_two_ways_entrance("", ToH_boss_room_2N_door)
ToH_boss_room_2N_door:connect_two_ways(ToH_boss_room)
ToH_boss_room:connect_one_way("ToH - Boss", function() return GetBossRef("toh_boss") end)
ToH_boss_room:connect_one_way(ToH_big_chest_room)
ToH_boss_room:connect_one_way(ToH_startile_wide)


---

-- ToH_main_room:connect_two_ways(ToH_big_chest_room, function()
--     return ALL(
--         ANY(
--             "bigkey",
--             ALL(
--                 CheckGlitches(2),
--                 "hookshot"
--             ) -- hera pot
--         ),
--         CanInteract(ToH_main_room)
--     )
-- end)

-- ToH_big_key_chest:connect_one_way("ToH - Big Key Chest", function() return Has("firesource") end)

-- ToH_big_chest_room:connect_two_ways(ToH_above_big_chest)
-- ToH_big_chest_room:connect_one_way("ToH - Compass Chest")


-- ToH_fairy_drop:connect_one_way(ToH_above_big_chest)

-- ToH_boss_room:connect_one_way("ToH - Boss", function() return GetBossRef("toh_boss") end)