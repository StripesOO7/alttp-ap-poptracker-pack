tr_main_entrance = alttp_location.new()
tr_eye_bridge_entrance = alttp_location.new()
tr_laser_entrance = alttp_location.new()
tr_big_chest_entrance = alttp_location.new()
local tr_square_travel_room = alttp_location.new()
local tr_compass_room = alttp_location.new()
local tr_torch_puzzle = alttp_location.new()
local tr_map_room = alttp_location.new()
local tr_poke_1_room = alttp_location.new()
local tr_chain_chomps_room = alttp_location.new()
local tr_big_key_room_top_right = alttp_location.new()
local tr_big_key_room_top_left = alttp_location.new()
local tr_big_key_room_bottom_right = alttp_location.new()
local tr_big_key_room_bottom_left = alttp_location.new()
local tr_shooter_after_big_key = alttp_location.new()
local tr_poke_2_room = alttp_location.new()
local tr_big_key_door_room = alttp_location.new()
local tr_crystalroller_room = alttp_location.new()
local tr_travel_maze = alttp_location.new()
local tr_eye_hallway = alttp_location.new()
local tr_switch_puzzle = alttp_location.new()
local tr_boss_room = alttp_location.new()

tr_main_entrance:connect_two_ways(tr_square_travel_room, function() return has("somaria") end)
tr_square_travel_room:connect_two_ways(tr_compass_room, function() return has("somaria") end)
tr_square_travel_room:connect_two_ways(tr_torch_puzzle, function() return has("somaria") end)
tr_square_travel_room:connect_two_ways(tr_poke_1_room, function(keys) 
    return all(
        has("somaria"),
        has("tr_smallkey", keys + 1, 3, keys + 1, 4)
    ) 
end)

tr_compass_room:connect_one_way("TR - Compass Chest")

tr_torch_puzzle:connect_two_ways(tr_map_room)

tr_map_room:connect_one_way("TR - Roller Room Left")
tr_map_room:connect_one_way("TR - Roller Room Right")

tr_poke_1_room:connect_two_ways(tr_chain_chomps_room, function(keys) return has("tr_smallkeys", keys, 3, keys + 1, 5) end)
tr_poke_1_room:connect_one_way("TR - Poke 1 Key Drop")

tr_chain_chomps_room:connect_one_way(tr_big_key_room_top_right, function(keys) return has("tr_smallkeys", keys + 1, 3, keys + 1, 5) end)
tr_big_key_room_top_right:connect_one_way(tr_chain_chomps_room, function(keys) return has("tr_smallkeys", keys, 3, keys, 5) end)
tr_chain_chomps_room:connect_one_way("TR - Chain Chomp Chest")

tr_big_key_room_top_right:connect_two_ways(tr_big_key_room_top_left)
tr_big_key_room_top_right:connect_two_ways(tr_shooter_after_big_key)

tr_big_key_room_top_left:connect_two_ways(tr_poke_2_room)

tr_poke_2_room:connect_two_ways(tr_big_key_room_bottom_left, function(keys) return has("tr_smallkeys", keys, 3, keys + 1, 5) end)
tr_poke_2_room:connect_one_way("TR - Poke 2 Key Drop")

tr_big_key_room_bottom_left:connect_two_ways(tr_big_key_room_bottom_right)
tr_big_key_room_bottom_left:connect_one_way("TR - Big Key Chest")

tr_big_key_room_bottom_right:connect_one_way(tr_big_key_room_top_right)
tr_big_key_room_bottom_right:connect_one_way("TR - Big Key Chest")

tr_shooter_after_big_key:connect_two_ways(tr_big_key_door_room)
tr_shooter_after_big_key:connect_two_ways(tr_laser_entrance)

tr_big_chest_entrance:connect_one_way(tr_big_key_door_room, function() 
    return any(
        has("boots"),
        has("hookshot"),
        has("somaria")
    ) 
end)
tr_big_chest_entrance:connect_one_way("TR - Big Chest", function() 
    return all(
        has("tr_bigkey"),
        any(
            has("somaria"),
            has("hookshot"),
        )
    ) 
end)

tr_big_key_door_room:connect_one_way(tr_crystalroller_room, function() retrun has("tr_bigkey") end)
tr_crystalroller_room:connect_one_way(tr_big_key_door_room, function(keys) retrun has("tr_smallkeys", keys + 1, 4, keys + 1, 6) end)

tr_crystalroller_room:connect_one_way(tr_travel_maze, function(keys) return has("tr_smallkeys", keys + 1, 3, keys + 1, 5) end)
tr_travel_maze:connect_one_way(tr_crystalroller_room, function(keys) return has("tr_smallkeys", keys, 3, keys, 5) end)
tr_crystalroller_room:connect_one_way("TR - Crystalroller Chest")

tr_travel_maze:connect_two_ways(tr_eye_hallway)

tr_eye_hallway:connect_two_ways(tr_eye_bridge_entrance)
tr_eye_hallway:connect_two_ways(tr_switch_puzzle, function(keys) return has("tr_smallkeys", keys + 1, 3, keys + 1, 5))

tr_eye_bridge_entrance:connect_one_way("TR - Eyebridge Top Right")
tr_eye_bridge_entrance:connect_one_way("TR - Eyebridge Top Left")
tr_eye_bridge_entrance:connect_one_way("TR - Eyebridge Bottom Right")
tr_eye_bridge_entrance:connect_one_way("TR - Eyebridge Bottom Left")

tr_switch_puzzle:connect_two_ways(tr_boss_room, function() return has("somaria") end)

tr_boss_room:connect_one_way("TR - Boss", function() return getBossRef("tr_boss") end)