-- SP_entrance = alttp_location.new("", nil, nil, "SP", true)
SP_first_room = alttp_location.new("SP_first_room", "SP First Room", nil, "SP", true)
local SP_hallway_before_first_trench = alttp_location.new("SP_hallway_before_first_trench", "SP ", nil, "SP", true)
local SP_first_trench = alttp_location.new("SP_first_trench", "SP 1st Trench", nil, "SP", true)
SP_main_room = alttp_location.new("SP_main_room", "SP Center Room", nil, "SP", true)
local SP_roundabout = alttp_location.new("SP_roundabout", "SP Roundabout", nil, "SP", true)
local SP_second_trench = alttp_location.new("SP_second_trench", "SP 2nd Trench", nil, "SP", true)
local SP_hallway_after_second_trench = alttp_location.new("SP_hallway_after_second_trench", "SP Hallway After 2nd Tranch", nil, "SP", true)
local SP_flooded_room = alttp_location.new("SP_flooded_room", "SP Flooded Room", nil, "SP", true)
local SP_waterfall_room = alttp_location.new("SP_waterfall_room", "SP Waterfall", nil, "SP", true)
local SP_after_waterfall_room = alttp_location.new("SP_after_waterfall_room", "SP Beyond Waterfall", nil, "SP", true)
local SP_boss_room = alttp_location.new("SP_boss_room", "SP Boss Room", nil, "SP", true)

SP_entrance_inside:connect_two_ways(SP_first_room, function()
    return ALL(
        CanInteract(SP_entrance_inside),
        "flippers",
        CanReach("Dam_inside"),
        CanInteract(Dam_inside),
        ANY(
            CanChangeWorldWithMirror,
            Tracker:FindObjectForCode("er_tracking").CurrentStage > 0
        )
    )
end)

SP_first_room:connect_two_ways(SP_hallway_before_first_trench, function(keys) return Has("sp_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SP_first_room:connect_one_way("SP - Entrance Chest", function() return ALL(DealDamage, CanInteract(SP_first_room)) end)

SP_hallway_before_first_trench:connect_two_ways(SP_first_trench, function(keys) return Has("sp_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)
SP_hallway_before_first_trench:connect_one_way("SP - Pot Row Key")
SP_hallway_before_first_trench:connect_one_way("SP - Map chest", function() return Has("bombs") end)

SP_first_trench:connect_two_ways(SP_main_room, function(keys)
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
SP_first_trench:connect_one_way("SP - Tench 1 Pot Key")

SP_main_room:connect_two_ways(SP_roundabout)
SP_main_room:connect_two_ways(SP_second_trench)
SP_main_room:connect_two_ways(SP_flooded_room, function(keys)
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
SP_main_room:connect_one_way("SP - Hookshot Pot Key", function() return Has("hookshot") end)
SP_main_room:connect_one_way("SP - Big Chest", function() return Has("sp_bigkey") end)

SP_second_trench:connect_two_ways(SP_hallway_after_second_trench, function(keys)
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
SP_second_trench:connect_one_way("SP - Trench 2 Pot Key")

SP_hallway_after_second_trench:connect_one_way("SP - West Chest")
SP_hallway_after_second_trench:connect_one_way("SP - Big Key Chest")

SP_roundabout:connect_one_way("SP - Compass Chest")

SP_flooded_room:connect_two_ways(SP_waterfall_room)
SP_flooded_room:connect_one_way("SP - Flooded Room Left")
SP_flooded_room:connect_one_way("SP - Flooded Room Right")

SP_waterfall_room:connect_two_ways(SP_after_waterfall_room)
SP_waterfall_room:connect_one_way("SP - Waterfall Room")

SP_after_waterfall_room:connect_two_ways(SP_boss_room, function(keys)
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
SP_after_waterfall_room:connect_one_way("SP - Waterway Pot Key")

SP_boss_room:connect_one_way("SP - Boss", function() return GetBossRef("sp_boss") end)