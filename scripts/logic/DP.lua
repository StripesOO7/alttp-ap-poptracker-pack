dp_main_entrance = alttp_location.new()
dp_left_entracne = alttp_location.new()
dp_right_entrance = alttp_location.new()
local dp_big_chest_room = alttp_location.new()
local dp_torch_room = alttp_location.new()
local dp_map_chest_room = alttp_location.new()
local dp_compass_room = alttp_location.new()
local dp_big_key_chest_room = alttp_location.new()
dp_back_entrance = alttp_location.new()
local dp_back_tile1_room = alttp_location.new()
local dp_back_beamos_hallway = alttp_location.new()
local dp_back_tiles2_room = alttp_location.new()
local dp_back_torch_room = alttp_location.new()
local dp_back_boss_room = alttp_location.new()



dp_left_entracne:connect_two_ways(dp_main_entrance)
dp_right_entrance:connect_two_ways(dp_main_entrance)

dp_main_entrance:connect_two_ways(dp_big_chest_room)
dp_big_chest_room:connect_one_way("DP - Big Chest", function() return has("dp_bigkey") end)

dp_main_entrance:connect_two_ways(dp_torch_room)
dp_torch_room:connect_one_way("DP - Torch", function() return any(has("boots"), AccessibilityLevel.Inspect) end)

dp_main_entrance:connect_two_ways(dp_map_chest_room)
dp_map_chest_room:connect_one_way("DP - Map Chest")

dp_main_entrance:connect_two_ways(dp_compass_room)
dp_compass_room:connect_one_way("DP - Compass Chest", function(keys) 
    return any(
        all(
            has("dp_smallkey", keys + 1, 1, keys + 1, 4),
            can_reach(dp_boss)
        )
        all(
            has("dp_smallkey", keys + 1, 1, keys + 1, 2),
            can_reach(dp_back_tile1_room)
        ),
        all(
            has("dp_smallkey", keys + 1, 1, keys + 1, 1),
            can_reach(dp_main_entrance)
        )
    ) 
end)

dp_compass_room:connect_two_ways(dp_big_key_chest_room)
dp_big_key_chest_room:connect_one_way("DP - Big Key Chest", function() return can_reach(dp_compass_room) end)

dp_back_entrance:connect_two_ways(dp_back_tile1_room)

dp_back_tile1_room:connect_two_ways(dp_back_beamos_hallway, function(keys) 
    return any(
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 1),
            can_reach(dp_back_tile1_room)
        ),
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 2),
            can_reach(dp_main_entrance)
        )
    )
end)
dp_back_tile1_room:connect_one_way("DP - Tile 1 Key Drop")

dp_back_beamos_hallway:connect_two_ways(dp_back_tiles2_room, function(keys) 
    return any(
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 2, 2),
            can_reach(dp_back_tile1_room)
        ),
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 2, 3),
            can_reach(dp_main_entrance)
        )
    )
en)
dp_back_beamos_hallway:connect_one_way("DP - Beamos Hallway Key Drop")

dp_back_tiles2_room:connect_two_ways(dp_back_torch_room, function(keys) 
    return any(
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 3),
            can_reach(dp_back_tile1_room)
        ),
        all(
            has("dp_smallkey", keys + 0, 0, keys + 1, 4),
            can_reach(dp_main_entrance)
        )
    )
en)
dp_back_tiles2_room:connect_one_way("DP - Tile 2 Key Drop")


dp_torch_room:connect_two_ways(dp_back_boss_room, function() 
    return all(
        has("firesource"), 
        has("dp_bigkey")
    ) 
end)

dp_back_boss_room:connect_one_way("DP - Boss", function() return getBossRef("pd_boss") end)