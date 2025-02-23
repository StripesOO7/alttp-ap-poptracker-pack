-- dp_main_entrance = alttp_location.new("")
-- dp_left_entrance = alttp_location.new("")
-- dp_right_entrance = alttp_location.new("")
local dp_big_chest_room = alttp_location.new("dp_big_chest_room")
local dp_main_room = alttp_location.new("dp_main_room")
local dp_torch_room = alttp_location.new("dp_torch_room")
local dp_map_chest_room = alttp_location.new("dp_map_chest_room")
local dp_compass_room = alttp_location.new("dp_compass_room")
local dp_big_key_chest_room = alttp_location.new("dp_big_key_chest_room")
-- dp_back_entrance = alttp_location.new("")
local dp_back_tile1_room = alttp_location.new("dp_back_tile1_room")
local dp_back_beamos_hallway = alttp_location.new("dp_back_beamos_hallway")
local dp_back_tiles2_room = alttp_location.new("dp_back_tiles2_room")
local dp_back_torch_room = alttp_location.new("dp_back_torch_room")
local dp_back_boss_room = alttp_location.new("dp_back_boss_room")



dp_main_entrance:connect_two_ways(dp_main_room, function() return can_interact("light", 1) end)
dp_main_room:connect_two_ways(dp_big_chest_room)
dp_big_chest_room:connect_one_way("DP - Big Chest", function() return has("dp_bigkey") end)

dp_main_room:connect_two_ways(dp_torch_room)
dp_torch_room:connect_one_way("DP - Torch", function() return any(has("boots"), AccessibilityLevel.Inspect) end)

dp_main_room:connect_two_ways(dp_map_chest_room)
dp_map_chest_room:connect_one_way("DP - Map Chest")

dp_main_room:connect_one_way(dp_compass_room, function(keys) 
    if Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return has("dp_smallkey", keys + 1, 1, keys + 1, 4), KDSreturn(keys + 1, keys + 1)
    else
        return all(
            has("dp_smallkey", keys + 1, 1, keys + 1, 4),
            has("boots")
        ), KDSreturn(keys + 1, keys + 1)
    end
end)
dp_compass_room:connect_one_way("DP - Compass Chest")

dp_compass_room:connect_one_way(dp_big_key_chest_room)
dp_big_key_chest_room:connect_one_way("DP - Big Key Chest", function() return dealDamage() end)
dp_main_room:connect_two_ways(dp_right_entrance, function() return can_interact("light", 1) end)
dp_main_room:connect_two_ways(dp_left_entrance, function() return can_interact("light", 1) end)
dp_back_entrance:connect_two_ways(dp_back_tile1_room, function() return can_interact("light", 1) end)

dp_back_tile1_room:connect_one_way(dp_back_beamos_hallway, function(keys) 
    return has("dp_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1)
end)
dp_back_tile1_room:connect_one_way("DP - Tile 1 Key Drop")

dp_back_beamos_hallway:connect_one_way(dp_back_tiles2_room, function(keys) 
    return has("dp_smallkey", keys, 1, keys + 1, 3), KDSreturn(keys, keys + 1)
end)
dp_back_beamos_hallway:connect_one_way("DP - Beamos Hallway Key Drop")

dp_back_tiles2_room:connect_one_way(dp_back_torch_room, function(keys) 
    return has("dp_smallkey", keys, 1, keys + 1, 4), KDSreturn(keys, keys + 1)
end)
dp_back_tiles2_room:connect_one_way("DP - Tile 2 Key Drop")


dp_back_torch_room:connect_one_way(dp_back_boss_room, function(keys) 
    if Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return all(
            has("firesource"),
            has("dp_bigkey"),
            has("dp_smallkey", keys, 1, keys, 4)
        ),KDSreturn(keys, keys)
    else
        return all(
            has("firesource"),
            has("dp_bigkey"),
            has("boots"),
            has("dp_smallkey", keys, 1, keys, 4)
        ),KDSreturn(keys, keys)
    end
end)

dp_back_boss_room:connect_one_way("DP - Boss", function() return getBossRef("dp_boss") end)