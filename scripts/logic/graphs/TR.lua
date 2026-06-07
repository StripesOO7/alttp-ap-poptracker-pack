-- TR_main_entrance = alttp_location.new("", nil, nil, "TR", true)
-- TR_eye_bridge_entrance = alttp_location.new("", nil, nil, "TR", true)
-- TR_laser_entrance = alttp_location.new("", nil, nil, "TR", true)
-- TR_big_chest_entrance = alttp_location.new("", nil, nil, "TR", true)
local TR_square_travel_room = alttp_location.new("TR_square_travel_room", "TR Sqaure Travel", nil, "TR", true)
local TR_compass_room = alttp_location.new("TR_compass_room", "TR Compass Room", nil, "TR", true)
local TR_torch_puzzle = alttp_location.new("TR_torch_puzzle", "TR Torch Puzzle", nil, "TR", true)
local TR_map_room = alttp_location.new("TR_map_room", "TR Map Room", nil, "TR", true)
local TR_poke_1_room = alttp_location.new("TR_poke_1_room", "TR Poke 1", nil, "TR", true)
local TR_chain_chomps_room = alttp_location.new("TR_chain_chomps_room", "TR Chain Chomps", nil, "TR", true)
local TR_big_key_room_top_right = alttp_location.new("TR_big_key_room_top_right", "TR Pipes Top Right", nil, "TR", true)
local TR_big_key_room_top_left = alttp_location.new("TR_big_key_room_top_left", "TR Pipes Top Left", nil, "TR", true)
local TR_big_key_room_bottom_right = alttp_location.new("TR_big_key_room_bottom_right", "TR Pipes Bottom Right", nil, "TR", true)
local TR_big_key_room_bottom_left = alttp_location.new("TR_big_key_room_bottom_left", "TR Pipes Bottom Left", nil, "TR", true)
local TR_big_key_chest_island = alttp_location.new("TR_big_key_chest_island", "TR Pipis Center", nil, "TR", true)
local TR_shooter_after_big_key = alttp_location.new("TR_shooter_after_big_key", "TR Shooter Room", nil, "TR", true)
local TR_poke_2_room = alttp_location.new("TR_poke_2_room", "TR Poke 2", nil, "TR", true)
local TR_big_key_door_room = alttp_location.new("TR_big_key_door_room", "TR Big Key Door", nil, "TR", true)
local TR_crystalroller_room = alttp_location.new("TR_crystalroller_room", "TR Crystalroller", nil, "TR", true)
local TR_travel_maze = alttp_location.new("TR_travel_maze", "TR Dark Maze", nil, "TR", true)
local TR_side_eye_hallway = alttp_location.new("TR_side_eye_hallway", "TR Side Eye Hallway", nil, "TR", true)
local TR_switch_puzzle = alttp_location.new("TR_switch_puzzle", "TR Switch Puzzle", nil, "TR", true)
local TR_pokes_after_big_door = alttp_location.new("TR_pokes_after_big_door", "TR Pokes After Big Door", nil, "TR", true)
local TR_laser_entrance_room = alttp_location.new("TR_laser_entrance_room", "TR Laser Entrance Room", nil, "TR", true)
local TR_eye_bridge_room = alttp_location.new("TR_eye_bridge_room", "TR Eye-Bridge Room", nil, "TR", true)
local TR_boss_room = alttp_location.new("TR_boss_room", "TR Boss Room", nil, "TR", true)

TR_main_entrance_inside:connect_two_ways(TR_square_travel_room, function() return ALL("somaria", CanInteract(TR_main_entrance_inside)) end)
TR_square_travel_room:connect_two_ways(TR_compass_room, function() return ALL("somaria", CanInteract(TR_square_travel_room)) end)
TR_square_travel_room:connect_two_ways(TR_torch_puzzle, function()
    return ALL(
        "somaria",
        "firerod",
        CanInteract(TR_square_travel_room)
    )
end)
TR_square_travel_room:connect_two_ways(TR_poke_1_room, function(keys)
    return ALL(
        "somaria",
        CanInteract(TR_square_travel_room),
        Has("tr_smallkey", keys + 1, 1, keys + 1, 1)
        -- Has("tr_smallkey", keys + 1, 3, keys + 1, 4)
    ), keys + 1
end)

TR_compass_room:connect_one_way("TR - Compass Chest")

TR_torch_puzzle:connect_two_ways(TR_map_room)

TR_map_room:connect_one_way("TR - Roller Room Left")
TR_map_room:connect_one_way("TR - Roller Room Right")

TR_poke_1_room:connect_two_ways(TR_chain_chomps_room, function(keys) return Has("tr_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)
-- TR_poke_1_room:connect_two_ways(TR_chain_chomps_room, function(keys) return Has("tr_smallkey", keys, 3, keys + 1, 5), KDSreturn(keys, keys + 1) end)
TR_poke_1_room:connect_one_way("TR - Poke 1 Key Drop", function() return ALL(DealDamage, CanInteract(TR_poke_1_room)) end)

TR_chain_chomps_room:connect_two_ways(TR_big_key_room_top_right, function(keys)
    return ALL(
        Has("tr_smallkey", keys + 1, 2, keys + 1, 3),
        HitRanged
    ), keys + 1
end)
-- TR_chain_chomps_room:connect_two_ways(TR_big_key_room_top_right, function(keys) return Has("tr_smallkey", keys + 1, 3, keys + 1, 5), keys + 1 end)
-- TR_big_key_room_top_right:connect_one_way(TR_chain_chomps_room, function(keys) return Has("tr_smallkey", keys, 3, keys, 5), KDSreturn(keys, keys + 1) end)
TR_chain_chomps_room:connect_one_way("TR - Chain Chomp Chest", function() return HitRanged() end)

TR_big_key_room_top_right:connect_two_ways(TR_big_key_room_top_left)
TR_big_key_room_top_right:connect_two_ways(TR_shooter_after_big_key)

TR_big_key_room_top_left:connect_two_ways(TR_poke_2_room)

TR_poke_2_room:connect_two_ways(TR_big_key_room_bottom_left, function(keys)
    return ALL(
        DealDamage,
        Has("tr_smallkey", keys + CountDoneDeadends(0, "@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right", "@Turtle Rock Back/Boss/Boss Item"), 4, keys + CountDoneDeadends(1, "@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right", "@Turtle Rock Back/Boss/Boss Item"), 6), KDSreturn(keys, keys + 1)
    )
end)
-- TR_poke_2_room:connect_two_ways(TR_big_key_room_bottom_left, function(keys) return Has("tr_smallkey", keys, 3, keys + 1, 5), KDSreturn(keys, keys + 1) end)
TR_poke_2_room:connect_one_way("TR - Poke 2 Key Drop", function() return ALL(DealDamage, CanInteract(TR_poke_2_room)) end)

TR_big_key_room_bottom_left:connect_two_ways(TR_big_key_room_bottom_right)
TR_big_key_room_bottom_left:connect_two_ways(TR_big_key_chest_island)


TR_big_key_room_bottom_right:connect_one_way(TR_big_key_room_top_right)
TR_big_key_room_bottom_right:connect_two_ways(TR_big_key_chest_island)

TR_big_key_chest_island:connect_one_way("TR - Big Key Chest", function() return CanInteract(TR_big_key_chest_island) end)

TR_shooter_after_big_key:connect_two_ways(TR_big_key_door_room, function() return DealDamage() end)
TR_shooter_after_big_key:connect_one_way(TR_laser_entrance_room, function()
    return ALL(
        DealDamage,
        CanInteract(TR_shooter_after_big_key)
    )
end)
TR_laser_entrance_room:connect_one_way(TR_shooter_after_big_key, function() return CanInteract(TR_shooter_after_big_key) end)
TR_laser_entrance_inside:connect_two_ways(TR_laser_entrance_room, function()
    return ANY(
        ALL(
            "bombs",
            CanInteract(TR_shooter_after_big_key)
        ),
        ER_STAGE > 0,
        Inverted
    )
end)

TR_big_chest_entrance_inside:connect_one_way(TR_big_key_door_room, function()
    return ALL(
        ANY(
            -- "boots",
            "hookshot",
            "somaria"
        ),
        CanInteract(TR_big_chest_entrance_inside)
    )
end)
TR_big_chest_entrance_inside:connect_one_way("TR - Big Chest", function()
    return ALL(
        "tr_bigkey",
        ANY(
            "somaria",
            "hookshot"
        ),
        CanInteract(TR_big_chest_entrance_inside)
    )
end)

TR_big_key_door_room:connect_one_way(TR_pokes_after_big_door, function() return Has("tr_bigkey") end)
TR_pokes_after_big_door:connect_one_way(TR_big_key_door_room, function(keys)
    return ALL(
        HitRanged,
        Has("tr_smallkey", keys + 1, 3, keys + 1, 4)
    ), keys + 1
end)
TR_pokes_after_big_door:connect_two_ways(TR_crystalroller_room, function() return ANY("bombs", "boots") end)
-- TR_crystalroller_room:connect_one_way(TR_big_key_door_room, function(keys)
--     return ALL(
--         HitRanged,
--         Has("tr_smallkey", keys + 1, 3, keys + 1, 4)
--     ), keys + 1
-- end)
-- TR_crystalroller_room:connect_one_way(TR_big_key_door_room, function(keys) return Has("tr_smallkey", keys + 1, 4, keys + 1, 6), keys + 1 end)

TR_crystalroller_room:connect_one_way(TR_travel_maze, function(keys) return Has("tr_smallkey", keys + CountDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 3, keys + CountDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 5), keys + 1 end)
-- TR_crystalroller_room:connect_one_way(TR_travel_maze, function(keys) return Has("tr_smallkey", keys + 1, 3, keys + 1, 5), keys + 1 end)
TR_travel_maze:connect_one_way(TR_crystalroller_room, function(keys)
    return ALL(
        Has("tr_smallkey", keys, 3, keys, 5),
        DarkRooms(false),
        "somaria",
        CanInteract(TR_travel_maze)
    ), KDSreturn(keys, keys + 1)
end)

TR_crystalroller_room:connect_one_way("TR - Crystalroller Chest", function() 
    return ALL(
        HitRanged,
        CanInteract(TR_crystalroller_room)
    )
end)

TR_travel_maze:connect_two_ways(TR_side_eye_hallway, function()
    return ALL(
        "somaria",
        DarkRooms(false),
        CanInteract(TR_travel_maze)
    )
end)

TR_side_eye_hallway:connect_two_ways(TR_eye_bridge_room)
TR_side_eye_hallway:connect_two_ways(TR_switch_puzzle, function(keys)
    return ALL(
        Has("tr_smallkey", keys + CountDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 4, keys + CountDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 6),
        CanInteract(TR_side_eye_hallway)
    ), keys + 1 end)
-- Tr_eye_hallway:connect_two_ways(TR_switch_puzzle, function(keys) return Has("tr_smallkey", keys + 1, 3, keys + 1, 5), keys + 1 end)

TR_eye_bridge_room:connect_one_way("TR - Eyebridge Top Right", function()
    return ALL(
        CanInteract(TR_eye_bridge_room),
        ANY(
            "byrna",
            "cape",
            "mirrorshield"
        )
    )
end)
TR_eye_bridge_room:connect_one_way("TR - Eyebridge Top Left", function()
    return ALL(
        CanInteract(TR_eye_bridge_room),
        ANY(
            "byrna",
            "cape",
            "mirrorshield"
        )
    )
end)
TR_eye_bridge_room:connect_one_way("TR - Eyebridge Bottom Right", function()
    return ALL(
        CanInteract(TR_eye_bridge_room),
        ANY(
            "byrna",
            "cape",
            "mirrorshield"
        )
    )
end)
TR_eye_bridge_room:connect_one_way("TR - Eyebridge Bottom Left", function()
    return ALL(
    CanInteract(TR_eye_bridge_room),
    ANY(
            "byrna",
            "cape",
            "mirrorshield"
        )
    )
end)

TR_eye_bridge_entrance_inside:connect_two_ways(TR_eye_bridge_room, function()
    return ANY(
        ALL(
            "bombs",
            CanInteract(TR_eye_bridge_entrance_inside)
        ),
        ER_STAGE > 0,
        Inverted
    )
end)

TR_switch_puzzle:connect_two_ways(TR_boss_room, function() return ALL("somaria","tr_bigkey") end)

TR_boss_room:connect_one_way("TR - Boss", function() return GetBossRef("tr_boss") end)