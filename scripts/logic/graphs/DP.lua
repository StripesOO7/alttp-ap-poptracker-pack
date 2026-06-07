-- DP_main_entrance = alttp_location.new("", nil, nil, "DP", true)
-- DP_left_entrance = alttp_location.new("", nil, nil, "DP", true)
-- DP_right_entrance = alttp_location.new("", nil, nil, "DP", true)
local DP_big_chest_room = alttp_location.new("DP_big_chest_room", "DP Big Chest", nil, "DP", true)
local DP_main_room = alttp_location.new("DP_main_room", "DP Main", nil, "DP", true)
local DP_torch_room = alttp_location.new("DP_torch_room", "DP Torch", nil, "DP", true)
local DP_map_chest_room = alttp_location.new("DP_map_chest_room", "DP Map Chest", nil, "DP", true)
local DP_compass_room = alttp_location.new("DP_compass_room", "DP Compass Chest", nil, "DP", true)
local DP_big_key_chest_room = alttp_location.new("DP_big_key_chest_room", "DP Big Key", nil, "DP", true)
-- DP_back_entrance = alttp_location.new("", nil, nil, "DP", true)
local DP_back_tile1_room = alttp_location.new("DP_back_tile1_room", "DP Back Tiles 1", nil, "DP", true)
local DP_back_beamos_hallway = alttp_location.new("DP_back_beamos_hallway", "DP Back Beamos ", nil, "DP", true)
local DP_back_tiles2_room = alttp_location.new("DP_back_tiles2_room", "DP Back Tiles 2", nil, "DP", true)
local DP_back_torch_room = alttp_location.new("DP_back_torch_room", "DP Back Torches", nil, "DP", true)
local DP_back_boss_room = alttp_location.new("DP_back_boss_room", "DP Boss Room", nil, "DP", true)


DP_left_entrance_inside:connect_two_ways(DP_right_entrance_inside)
DP_main_entrance_inside:connect_two_ways(DP_main_room, function() return CanInteract(DP_main_entrance_inside) end)
DP_left_entrance_inside:connect_two_ways(DP_big_chest_room)
DP_big_chest_room:connect_one_way("DP - Big Chest", function() return ALL("dp_bigkey", CanInteract(DP_big_chest_room)) end)

DP_left_entrance_inside:connect_two_ways(DP_torch_room)
DP_torch_room:connect_one_way("DP - Torch", function()
    return ANY(
        ALL(
        "boots",
        CanInteract(DP_torch_room)
    ),
    ACCESS_INSPECT)
end)

DP_left_entrance_inside:connect_two_ways(DP_map_chest_room)
DP_map_chest_room:connect_one_way("DP - Map Chest", function() return CanInteract(DP_map_chest_room) end)

DP_main_room:connect_one_way(DP_compass_room, function(keys)
    if not Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return ALL(
            Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace Back/Boss/Boss Item"), 1, keys + CountDoneDeadends(1, "@Desert Palace Back/Boss/Boss Item", "@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key", "@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"), 4),
            "boots",
            CanInteract(DP_main_room)
        ), keys + 1
    else
        return ALL(
            Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace Back/Boss/Boss Item"), 1, keys + CountDoneDeadends(1, "@Desert Palace Back/Boss/Boss Item", "@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key", "@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"), 4),
            CanInteract(DP_main_room)
        ), keys + 1
    end
end)
DP_compass_room:connect_one_way("DP - Compass Chest", function() return CanInteract(DP_compass_room) end)

DP_compass_room:connect_one_way(DP_big_key_chest_room, function() return CanInteract(DP_compass_room) end)
DP_big_key_chest_room:connect_one_way("DP - Big Key Chest", function() return DealDamage() end)
DP_main_room:connect_two_ways(DP_right_entrance_inside, function() return CanInteract(DP_main_room) end)
DP_main_room:connect_two_ways(DP_left_entrance_inside, function() return CanInteract(DP_main_room) end)
DP_back_entrance_inside:connect_two_ways(DP_back_tile1_room, function() return CanInteract(DP_back_entrance_inside) end)

DP_back_tile1_room:connect_one_way(DP_back_beamos_hallway, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 2), KDSreturn(keys, keys + 1)
end)
DP_back_tile1_room:connect_one_way("DP - Tile 1 Key Drop")

DP_back_beamos_hallway:connect_one_way(DP_back_tiles2_room, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 3), KDSreturn(keys, keys + 1)
end)
DP_back_beamos_hallway:connect_one_way("DP - Beamos Hallway Key Drop")

DP_back_tiles2_room:connect_one_way(DP_back_torch_room, function(keys)
    return Has("dp_smallkey", keys + CountDoneDeadends(0, "@Desert Palace/Compass Chest/Compass Chest"), 1, keys + CountDoneDeadends(1, "@Desert Palace/Compass Chest/Compass Chest"), 4), KDSreturn(keys, keys + 1)
end)
DP_back_tiles2_room:connect_one_way("DP - Tile 2 Key Drop")


DP_back_torch_room:connect_one_way(DP_back_boss_room, function(keys)
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

DP_back_boss_room:connect_one_way("DP - Boss", function() return GetBossRef("dp_boss") end)