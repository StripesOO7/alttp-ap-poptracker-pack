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

ToH_main_room_1N_door = alttp_location.new("ToH_main_room_1N_door", "ToH Main Room 1N Door")
ToH_main_room_3N_door = alttp_location.new("ToH_main_room_3N_door", "ToH Main Room 3N Door")
ToH_main_room_4N_door = alttp_location.new("ToH_main_room_4N_door", "ToH Main Room 4N Door")
ToH_basement_cage_3N_door = alttp_location.new("ToH_basement_cage_3N_door", "ToH Basement Cage 3N Door")
ToH_tile_room_1N_door = alttp_location.new("ToH_tile_room_1N_door", "ToH Tile Room 1N Door")
ToH_3_hard_head_beatles_4N_door = alttp_location.new("ToH_3_hard_head_beatles_4N_door", "ToH 3 Hard Head Beatles 4N Door")
ToH_startile_wide_2N_door = alttp_location.new("ToH_startile_wide_2N_door", "ToH Startile Wide 2N Door")
ToH_big_chest_room_1N_door = alttp_location.new("ToH_big_chest_room_1N_door", "ToH Big Chest Room 1N Door")
ToH_big_chest_room_2N_door = alttp_location.new("ToH_big_chest_room_2N_door", "ToH Big Chest Room 2N Door")
ToH_5F_orange_path_1N_door = alttp_location.new("ToH_5F_orange_path_1N_door", "ToH 5F Orange Path 1N Door")
ToH_5F_orange_path_2N_door = alttp_location.new("ToH_5F_orange_path_2N_door", "ToH 5F Orange Path 2N Door")
ToH_boss_room_2N_door = alttp_location.new("ToH_boss_room_2N_door", "ToH Boss Room 2N Door")

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

ToH_tile_room:connect_two_ways_stuck(ToH_tridorm_room, function() return CanInteract(ToH_tile_room) end)
ToH_tridorm_room:connect_two_ways(ToH_big_key_chest, function() return CanInteract(ToH_tridorm_room) end)
ToH_big_key_chest:connect_one_way("ToH - Big Key Chest", function() return Has("firesource") end)

ToH_main_room:connect_two_ways(ToH_main_room_3N_door)
ToH_main_room_3N_door:connect_two_ways_entrance("", ToH_basement_cage_3N_door)
ToH_basement_cage_3N_door:connect_two_ways(ToH_basement_cage)
ToH_basement_cage:connect_one_way("ToH - Basement Cage", function() return CanInteract(ToH_basement_cage) end)

ToH_main_room:connect_two_ways(ToH_main_room_4N_door)
ToH_main_room_4N_door:connect_two_ways_entrance("", ToH_3_hard_head_beatles_4N_door)
ToH_3_hard_head_beatles_4N_door:connect_two_ways(ToH_3_hard_head_beatles)

ToH_3_hard_head_beatles:connect_two_ways_stuck(ToH_big_key_door_room, function() return ALL(CanInteract(ToH_3_hard_head_beatles), DealDamage) end)
ToH_3_hard_head_beatles:connect_one_way(ToH_main_room)
ToH_big_key_door_room:connect_two_ways_stuck(ToH_startile_wide, function() return Has("bigkey") end)
ToH_big_key_door_room:connect_one_way(ToH_main_room)
ToH_startile_wide:connect_two_ways(ToH_startile_wide_2N_door)
ToH_startile_wide:connect_one_way(ToH_main_room)

ToH_startile_wide_2N_door:connect_two_ways_entrance("", ToH_big_chest_room_2N_door)
ToH_big_chest_room_2N_door:connect_two_ways(ToH_big_chest_room)

ToH_big_chest_room:connect_one_way("ToH - Compass Chest")
ToH_big_chest_room:connect_two_ways(ToH_big_chest_room_1N_door)
ToH_big_chest_room:connect_one_way(ToH_startile_wide)
ToH_big_chest_room:connect_one_way(ToH_big_chest_platform, function() return Has("hookshot") end)

ToH_big_chest_platform:connect_one_way("ToH - Big Chest", function() return Has("bigkey") end)
ToH_big_chest_platform:connect_one_way(ToH_big_chest_room)

ToH_big_chest_room_1N_door:connect_two_ways_entrance("", ToH_5F_orange_path_1N_door)
ToH_5F_orange_path_1N_door:connect_two_ways(ToH_5F_orange_path)
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