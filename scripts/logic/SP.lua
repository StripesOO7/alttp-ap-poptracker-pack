-- sp_entrance = alttp_location.new("")
local sp_first_room = alttp_location.new("sp_first_room")
local sp_hallway_before_first_trench = alttp_location.new("sp_hallway_before_first_trench")
local sp_first_trench = alttp_location.new("sp_first_trench")
local sp_main_room = alttp_location.new("sp_main_room")
local sp_roundabout = alttp_location.new("sp_roundabout")
local sp_second_trench = alttp_location.new("sp_second_trench")
local sp_hallway_after_second_trench = alttp_location.new("sp_hallway_after_second_trench")
local sp_flooded_room = alttp_location.new("sp_flooded_room")
local sp_waterfall_room = alttp_location.new("sp_waterfall_room")
local sp_after_waterfall_room = alttp_location.new("sp_after_waterfall_room")
local sp_boss_room = alttp_location.new("sp_boss_room")

sp_entrance:connect_two_ways(sp_first_room)

sp_first_room:connect_two_ways(sp_hallway_before_first_trench, function(keys) return has("sp_smallkey_smallkey", keys + 1, 1, keys + 1, 1), KDSreturn(keys + 1, keys + 1) end)
sp_first_room:connect_one_way("SP - Entrance Chest", function() 
    return all(
        can_reach(dam_inside),
        has("flippers"),
        dealDamage()
    )
end)

sp_hallway_before_first_trench:connect_two_ways(sp_first_trench, function(keys) return has("sp_smallkey", keys, 1, keys + 1, 2), KDSreturn(keys, keys + 1) end)
sp_hallway_before_first_trench:connect_one_way("SP - Pot Row Key")
sp_hallway_before_first_trench:connect_one_way("SP - Map chest", function() return has("bombs") end)

sp_first_trench:connect_two_ways(sp_main_room, function(keys) 
    return any(
        all(
            has("sp_smallkey", keys, 1, keys, 2),
            checkGlitches(1),
            has("bombs"),
            has("hookshot")
        ),
        all(
            has("hammer"),
            has("sp_smallkey", keys, 1, keys + 1, 3)
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_first_trench:connect_one_way("SP - Tench 1 Pot Key")

sp_main_room:connect_two_ways(sp_roundabout)
sp_main_room:connect_two_ways(sp_second_trench)
sp_main_room:connect_two_ways(sp_flooded_room, function(keys) 
    return any(
        all(
            has("sp_smallkey", keys, 1, keys + 1, 4),
            checkGlitches(1),
            has("hookshot")
        ),
        all(
            has("sp_smallkey", keys, 1, keys + 1, 5),
            has("hookshot")
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_main_room:connect_one_way("SP - Hookshot Pot Key", function() return has("hookshot") end)
sp_main_room:connect_one_way("SP - Big Chest", function() return has("sp_bigkey") end)

sp_second_trench:connect_two_ways(sp_hallway_after_second_trench, function(keys) 
    return any(
        all(
            has("sp_smallkey", keys, 1, keys + 1, 3),
            checkGlitches(1)
        ),
        all(
            has("sp_smallkey", keys, 1, keys + 1, 4)
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
    return any(
        all(
            has("sp_smallkey", keys, 1, keys + 1, 5),
            checkGlitches(1)
        ),
        all(
            has("sp_smallkey", keys, 1, keys + 1, 6)
        )
    ), KDSreturn(keys, keys + 1)
end)
sp_after_waterfall_room:connect_one_way("SP - Waterway Pot Key")

sp_boss_room:connect_one_way("SP - Boss", function() return getBossRef("sp_boss") end)