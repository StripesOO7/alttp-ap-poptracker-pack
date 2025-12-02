-- dp_main_entrance = alttp_location.new("", nil, nil, true)
-- dp_left_entrance = alttp_location.new("", nil, nil, true)
-- dp_right_entrance = alttp_location.new("", nil, nil, true)
local dp_big_chest_room = alttp_location.new("dp_big_chest_room", nil, nil, true)
local dp_main_room = alttp_location.new("dp_main_room", nil, nil, true)
local dp_torch_room = alttp_location.new("dp_torch_room", nil, nil, true)
local dp_map_chest_room = alttp_location.new("dp_map_chest_room", nil, nil, true)
local dp_compass_room = alttp_location.new("dp_compass_room", nil, nil, true)
local dp_big_key_chest_room = alttp_location.new("dp_big_key_chest_room", nil, nil, true)
-- dp_back_entrance = alttp_location.new("", nil, nil, true)
local dp_back_tile1_room = alttp_location.new("dp_back_tile1_room", nil, nil, true)
local dp_back_beamos_hallway = alttp_location.new("dp_back_beamos_hallway", nil, nil, true)
local dp_back_tiles2_room = alttp_location.new("dp_back_tiles2_room", nil, nil, true)
local dp_back_torch_room = alttp_location.new("dp_back_torch_room", nil, nil, true)
local dp_back_boss_room = alttp_location.new("dp_back_boss_room", nil, nil, true)


dp_left_entrance_inside:connect_two_ways(dp_right_entrance_inside)
dp_main_entrance_inside:connect_two_ways(dp_main_room, function() return CanInteract(dp_main_entrance_inside, 0) end)
dp_left_entrance_inside:connect_two_ways(dp_big_chest_room)
dp_big_chest_room:connect_one_way("DP - Big Chest", function() return ALL("dp_bigkey", CanInteract(dp_big_chest_room, 0)) end)

dp_left_entrance_inside:connect_two_ways(dp_torch_room)
dp_torch_room:connect_one_way("DP - Torch", function()
    return ANY(
        ALL(
        "boots",
        CanInteract(dp_torch_room, 0)
    ),
    ACCESS_INSPECT)
end)

dp_left_entrance_inside:connect_two_ways(dp_map_chest_room)
dp_map_chest_room:connect_one_way("DP - Map Chest", function() return CanInteract(dp_map_chest_room,1 ) end)

dp_main_room:connect_one_way(dp_compass_room, function(keys)
    if not Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return ALL(
            Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace Back/Boss/Boss Item"), 1, keys + CountDoneDeadends(1, "@Desert Palace Back/Boss/Boss Item", "@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key", "@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"), 4),
            "boots",
            CanInteract(dp_main_room, 0)
        ), keys + 1
    else
        return ALL(
            Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace Back/Boss/Boss Item"), 1, keys + CountDoneDeadends(1, "@Desert Palace Back/Boss/Boss Item", "@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key", "@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"), 4),
            CanInteract(dp_main_room, 0)
        ), keys + 1
    end
end)
dp_compass_room:connect_one_way("DP - Compass Chest", function() return CanInteract(dp_compass_room,0 ) end)

dp_compass_room:connect_one_way(dp_big_key_chest_room, function() return CanInteract(dp_compass_room,0 ) end)
dp_big_key_chest_room:connect_one_way("DP - Big Key Chest", function() return DealDamage() end)
dp_main_room:connect_two_ways(dp_right_entrance_inside, function() return CanInteract(dp_main_room, 0) end)
dp_main_room:connect_two_ways(dp_left_entrance_inside, function() return CanInteract(dp_main_room, 0) end)
dp_back_entrance_inside:connect_two_ways(dp_back_tile1_room, function() return CanInteract(dp_back_entrance_inside, 0) end)

dp_back_tile1_room:connect_one_way(dp_back_beamos_hallway, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 2), KDSreturn(keys, keys + 1)
end)
dp_back_tile1_room:connect_one_way("DP - Tile 1 Key Drop")

dp_back_beamos_hallway:connect_one_way(dp_back_tiles2_room, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 3), KDSreturn(keys, keys + 1)
end)
dp_back_beamos_hallway:connect_one_way("DP - Beamos Hallway Key Drop")

dp_back_tiles2_room:connect_one_way(dp_back_torch_room, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 4), KDSreturn(keys, keys + 1)
end)
dp_back_tiles2_room:connect_one_way("DP - Tile 2 Key Drop")


dp_back_torch_room:connect_one_way(dp_back_boss_room, function(keys)
    if Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return ALL(
            "firesource",
            "dp_bigkey"
        ),keys
    else
        return ALL(
            "firesource",
            "dp_bigkey",
            "boots"
        ),keys
    end
end)

dp_back_boss_room:connect_one_way("DP - Boss", function() return GetBossRef("dp_boss") end)