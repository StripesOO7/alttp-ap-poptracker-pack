-- tr_main_entrance = alttp_location.new("")
-- tr_eye_bridge_entrance = alttp_location.new("")
-- tr_laser_entrance = alttp_location.new("")
-- tr_big_chest_entrance = alttp_location.new("")
local tr_square_travel_room = alttp_location.new("tr_square_travel_room")
local tr_compass_room = alttp_location.new("tr_compass_room")
local tr_torch_puzzle = alttp_location.new("tr_torch_puzzle")
local tr_map_room = alttp_location.new("tr_map_room")
local tr_poke_1_room = alttp_location.new("tr_poke_1_room")
local tr_chain_chomps_room = alttp_location.new("tr_chain_chomps_room")
local tr_big_key_room_top_right = alttp_location.new("tr_big_key_room_top_right")
local tr_big_key_room_top_left = alttp_location.new("tr_big_key_room_top_left")
local tr_big_key_room_bottom_right = alttp_location.new("tr_big_key_room_bottom_right")
local tr_big_key_room_bottom_left = alttp_location.new("tr_big_key_room_bottom_left")
local tr_big_key_chest_island = alttp_location.new("tr_big_key_chest_island")
local tr_shooter_after_big_key = alttp_location.new("tr_shooter_after_big_key")
local tr_poke_2_room = alttp_location.new("tr_poke_2_room")
local tr_big_key_door_room = alttp_location.new("tr_big_key_door_room")
local tr_crystalroller_room = alttp_location.new("tr_crystalroller_room")
local tr_travel_maze = alttp_location.new("tr_travel_maze")
local tr_eye_hallway = alttp_location.new("tr_eye_hallway")
local tr_switch_puzzle = alttp_location.new("tr_switch_puzzle")
local tr_boss_room = alttp_location.new("tr_boss_room")

tr_main_entrance_inside:connect_two_ways(tr_square_travel_room, function() return all(has("somaria"), can_interact(tr_main_entrance_inside.worldstate, 1)) end)
tr_square_travel_room:connect_two_ways(tr_compass_room, function() return has("somaria") end)
tr_square_travel_room:connect_two_ways(tr_torch_puzzle, function() 
    return all(
        has("somaria"), 
        has("firerod")
    ) 
end)
tr_square_travel_room:connect_two_ways(tr_poke_1_room, function(keys) 
    return all(
        has("somaria"),
        has("tr_smallkey", keys + 1, 1, keys + 1, 1)
        -- has("tr_smallkey", keys + 1, 3, keys + 1, 4)
    ), KDSreturn(keys + 1, keys + 1) 
end)

tr_compass_room:connect_one_way("TR - Compass Chest")

tr_torch_puzzle:connect_two_ways(tr_map_room)

tr_map_room:connect_one_way("TR - Roller Room Left")
tr_map_room:connect_one_way("TR - Roller Room Right")

tr_poke_1_room:connect_two_ways(tr_chain_chomps_room, function(keys) return has("tr_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)
-- tr_poke_1_room:connect_two_ways(tr_chain_chomps_room, function(keys) return has("tr_smallkey", keys, 3, keys + 1, 5), KDSreturn(keys, keys + 1) end)
tr_poke_1_room:connect_one_way("TR - Poke 1 Key Drop")

tr_chain_chomps_room:connect_two_ways(tr_big_key_room_top_right, function(keys) return has("tr_smallkey", keys + 1, 2, keys + 1, 3), KDSreturn(keys + 1, keys + 1) end)
-- tr_chain_chomps_room:connect_two_ways(tr_big_key_room_top_right, function(keys) return has("tr_smallkey", keys + 1, 3, keys + 1, 5), KDSreturn(keys + 1, keys + 1) end)
-- tr_big_key_room_top_right:connect_one_way(tr_chain_chomps_room, function(keys) return has("tr_smallkey", keys, 3, keys, 5), KDSreturn(keys, keys + 1) end)
tr_chain_chomps_room:connect_one_way("TR - Chain Chomp Chest")

tr_big_key_room_top_right:connect_two_ways(tr_big_key_room_top_left)
tr_big_key_room_top_right:connect_two_ways(tr_shooter_after_big_key)

tr_big_key_room_top_left:connect_two_ways(tr_poke_2_room)

tr_poke_2_room:connect_two_ways(tr_big_key_room_bottom_left, function(keys) return has("tr_smallkey", keys + countDoneDeadends(0, "@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right", "@Turtle Rock Back/Boss/Boss Item"), 4, keys + countDoneDeadends(1, "@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right", "@Turtle Rock Back/Boss/Boss Item"), 6), KDSreturn(keys, keys + 1) end)
-- tr_poke_2_room:connect_two_ways(tr_big_key_room_bottom_left, function(keys) return has("tr_smallkey", keys, 3, keys + 1, 5), KDSreturn(keys, keys + 1) end)
tr_poke_2_room:connect_one_way("TR - Poke 2 Key Drop")

tr_big_key_room_bottom_left:connect_two_ways(tr_big_key_room_bottom_right)
tr_big_key_room_bottom_left:connect_two_ways(tr_big_key_chest_island)


tr_big_key_room_bottom_right:connect_one_way(tr_big_key_room_top_right)
tr_big_key_room_bottom_right:connect_two_ways(tr_big_key_chest_island)

tr_big_key_chest_island:connect_one_way("TR - Big Key Chest")

tr_shooter_after_big_key:connect_two_ways(tr_big_key_door_room)
tr_shooter_after_big_key:connect_two_ways(tr_laser_entrance_inside, function() return all(has("bombs"), can_interact(tr_shooter_after_big_key.worldstate, 1)) end)

tr_big_chest_entrance_inside:connect_one_way(tr_big_key_door_room, function() 
    return all(
        any(
            has("boots"),
            has("hookshot"),
            has("somaria")
        ),
        can_interact(tr_big_chest_entrance_inside.worldstate, 1)
    )
end)
tr_big_chest_entrance_inside:connect_one_way("TR - Big Chest", function() 
    return all(
        has("tr_bigkey"),
        any(
            has("somaria"),
            has("hookshot")
        ),
        can_interact(tr_big_chest_entrance_inside.worldstate, 1)
    ) 
end)

tr_big_key_door_room:connect_one_way(tr_crystalroller_room, function() return has("tr_bigkey") end)
tr_crystalroller_room:connect_one_way(tr_big_key_door_room, function(keys) return has("tr_smallkey", keys + 1, 3, keys + 1, 4), KDSreturn(keys + 1, keys + 1) end)
-- tr_crystalroller_room:connect_one_way(tr_big_key_door_room, function(keys) return has("tr_smallkey", keys + 1, 4, keys + 1, 6), KDSreturn(keys + 1, keys + 1) end)

tr_crystalroller_room:connect_one_way(tr_travel_maze, function(keys) return has("tr_smallkey", keys + countDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 3, keys + countDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 5), KDSreturn(keys + 1, keys + 1) end)
-- tr_crystalroller_room:connect_one_way(tr_travel_maze, function(keys) return has("tr_smallkey", keys + 1, 3, keys + 1, 5), KDSreturn(keys + 1, keys + 1) end)
tr_travel_maze:connect_one_way(tr_crystalroller_room, function(keys) 
    return all(
        has("tr_smallkey", keys, 3, keys, 5),
        darkRooms(),
        has("somaria"),
        can_interact(tr_travel_maze.worldstate, 1)
    ), KDSreturn(keys, keys + 1) 
end)
tr_crystalroller_room:connect_one_way("TR - Crystalroller Chest")

tr_travel_maze:connect_two_ways(tr_eye_hallway, function() 
    return all(
        has("somaria"),
        darkRooms()
    ) 
end)

tr_eye_hallway:connect_two_ways(tr_eye_bridge_entrance_inside)
tr_eye_hallway:connect_two_ways(tr_switch_puzzle, function(keys) 
    return all(
        has("tr_smallkey", keys + countDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 4, keys + countDoneDeadends(1, "@Turtle Rock Front/Big Key Chest/Big Key Chest"), 6),
        can_interact(tr_eye_hallway.worldstate, 1)
    ), KDSreturn(keys + 1, keys + 1) end)
-- tr_eye_hallway:connect_two_ways(tr_switch_puzzle, function(keys) return has("tr_smallkey", keys + 1, 3, keys + 1, 5), KDSreturn(keys + 1, keys + 1) end)

tr_eye_bridge_entrance_inside:connect_one_way("TR - Eyebridge Top Right", function() return can_interact(tr_eye_bridge_entrance_inside.worldstate, 1) end)
tr_eye_bridge_entrance_inside:connect_one_way("TR - Eyebridge Top Left", function() return can_interact(tr_eye_bridge_entrance_inside.worldstate, 1) end)
tr_eye_bridge_entrance_inside:connect_one_way("TR - Eyebridge Bottom Right", function() return can_interact(tr_eye_bridge_entrance_inside.worldstate, 1) end)
tr_eye_bridge_entrance_inside:connect_one_way("TR - Eyebridge Bottom Left", function() return can_interact(tr_eye_bridge_entrance_inside.worldstate, 1) end)

tr_switch_puzzle:connect_two_ways(tr_boss_room, function() return all(has("somaria"),has("tr_bigkey")) end)

tr_boss_room:connect_one_way("TR - Boss", function() return getBossRef("tr_boss") end)