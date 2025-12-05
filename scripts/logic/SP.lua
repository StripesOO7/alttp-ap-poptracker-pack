-- sp_entrance = alttp_location.new("", nil, nil, true)
local sp_first_room = alttp_location.new("sp_first_room", nil, nil, true)
local sp_hallway_before_first_trench = alttp_location.new("sp_hallway_before_first_trench", nil, nil, true)
local sp_first_trench = alttp_location.new("sp_first_trench", nil, nil, true)
local sp_main_room = alttp_location.new("sp_main_room", nil, nil, true)
local sp_roundabout = alttp_location.new("sp_roundabout", nil, nil, true)
local sp_second_trench = alttp_location.new("sp_second_trench", nil, nil, true)
local sp_hallway_after_second_trench = alttp_location.new("sp_hallway_after_second_trench", nil, nil, true)
local sp_flooded_room = alttp_location.new("sp_flooded_room", nil, nil, true)
local sp_waterfall_room = alttp_location.new("sp_waterfall_room", nil, nil, true)
local sp_after_waterfall_room = alttp_location.new("sp_after_waterfall_room", nil, nil, true)
local sp_boss_room = alttp_location.new("sp_boss_room", nil, nil, true)

sp_entrance_inside:connect_two_ways(sp_first_room, function()
    return ALL(
        CanInteract(sp_entrance_inside),
        "flippers",
        CanReach("dam_inside"),
        CanInteract(dam_inside),
        ANY(
            CanChangeWorldWithMirror,
            Tracker:FindObjectForCode("er_tracking").CurrentStage > 0
        )
    )
end)

sp_first_room:connect_two_ways(sp_hallway_before_first_trench, function(keys) return Has("sp_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
sp_first_room:connect_one_way("SP - Entrance Chest", function() return ALL(DealDamage, CanInteract(sp_first_room)) end)

sp_hallway_before_first_trench:connect_two_ways(sp_first_trench, function(keys) return Has("sp_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)
sp_hallway_before_first_trench:connect_one_way("SP - Pot Row Key")
sp_hallway_before_first_trench:connect_one_way("SP - Map chest", function() return Has("bombs") end)

sp_first_trench:connect_two_ways(sp_main_room, function(keys)
    return ANY(
        ALL(
            Has("sp_smallkey", keys, 1, keys, 2),
            CheckGlitches(1),
            "bombs",
            "hookshot"
        ),
        ALL(
            "hammer",
            Has("sp_smallkey", keys, 1, keys + 1, 3)
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_first_trench:connect_one_way("SP - Tench 1 Pot Key")

sp_main_room:connect_two_ways(sp_roundabout)
sp_main_room:connect_two_ways(sp_second_trench)
sp_main_room:connect_two_ways(sp_flooded_room, function(keys)
    return ANY(
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 4),
            CheckGlitches(1),
            "hookshot"
        ),
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
            "hookshot"
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_main_room:connect_one_way("SP - Hookshot Pot Key", function() return Has("hookshot") end)
sp_main_room:connect_one_way("SP - Big Chest", function() return Has("sp_bigkey") end)

sp_second_trench:connect_two_ways(sp_hallway_after_second_trench, function(keys)
    return ANY(
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 5),
            CheckGlitches(1)
        ),
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Boss/Boss Item", "@Swamp Palace/Waterfall Room/Waterfall Room"), 6)
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_second_trench:connect_one_way("SP - Trench 2 Pot Key")

sp_hallway_after_second_trench:connect_one_way("SP - West Chest")
sp_hallway_after_second_trench:connect_one_way("SP - Big Key Chest")

sp_roundabout:connect_one_way("SP - Compass Chest")

sp_flooded_room:connect_two_ways(sp_waterfall_room)
sp_flooded_room:connect_one_way("SP - Flooded Room Left")
sp_flooded_room:connect_one_way("SP - Flooded Room Right")

sp_waterfall_room:connect_two_ways(sp_after_waterfall_room)
sp_waterfall_room:connect_one_way("SP - Waterfall Room")

sp_after_waterfall_room:connect_two_ways(sp_boss_room, function(keys)
    return ANY(
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 5),
            CheckGlitches(1)
        ),
        ALL(
            Has("sp_smallkey", keys, 1, keys + CountDoneDeadends(1, "@Swamp Palace/Big Key Chest/Big Key Chest"), 6)
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_after_waterfall_room:connect_one_way("SP - Waterway Pot Key")

sp_boss_room:connect_one_way("SP - Boss", function() return GetBossRef("sp_boss") end)