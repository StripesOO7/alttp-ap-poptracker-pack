-- at_entrance = alttp_location.new("")
local at_golden_guards = alttp_location.new("at_golden_guards")
local at_first_chest = alttp_location.new("at_first_chest")
local at_dark_maze = alttp_location.new("at_dark_maze")
local at_dark_archer_key_drop = alttp_location.new("at_dark_archer_key_drop")
local at_circle_of_pots = alttp_location.new("at_circle_of_pots")
local at_aga1 = alttp_location.new("at_aga1")
local at_pre_curtain = alttp_location.new("at_pre_curtain")

at_entrance_inside:connect_one_way(at_golden_guards, function() return ALL(Can_interact(at_entrance_inside.worldstate, 1), OpenOrStandard) end)
at_entrance_inside:connect_one_way(at_golden_guards, function() return ALL(Can_interact(at_entrance_inside.worldstate, 1), Inverted) end)

at_golden_guards:connect_one_way(at_entrance_inside)
at_golden_guards:connect_two_ways(at_first_chest, DealDamage)

at_first_chest:connect_one_way("AT - First Chest", DealDamage)
at_first_chest:connect_two_ways(at_dark_maze, function(keys)
    return Has("at_smallkey", keys + 1, 1, keys + 1, 1), keys + 1
end)
at_dark_maze:connect_two_ways(at_dark_archer_key_drop, function(keys)
    return ALL(
        DarkRooms(true),
        Has("at_smallkey", keys + 1, 2, keys + 1, 2)
    ), keys + 1
end)
at_dark_maze:connect_one_way("AT - Maze Chest", function()
    return DarkRooms(true)
end)

at_dark_archer_key_drop:connect_two_ways(at_circle_of_pots, function(keys)
    return Has("at_smallkey", keys, 2, keys + 1, 3), KDSreturn( keys, keys + 1)
end)
at_dark_archer_key_drop:connect_one_way("AT - Dark Archer Key Drop", DealDamage)

at_circle_of_pots:connect_two_ways(at_pre_curtain, function(keys)
    return ALL(
        Has("at_smallkey", keys, 2, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
at_circle_of_pots:connect_one_way("AT - Circle of Pots Key Drop") --functoin() return Can_interact(" light",1) end)
at_pre_curtain:connect_one_way(at_aga1, CanRemoveCurtains)
at_aga1:connect_one_way("AT - Aga1", function()
    return ANY(
        "sword",
        "hammer",
        "bug_net"
    )
end)

at_aga1:connect_one_way(pyramid, function() return ALL(OpenOrStandard, "aga1") end)
at_aga1:connect_one_way(hyrule_castle_area, function() return ALL(Inverted, "aga1") end)
-- at_aga1:connect_one_way("Kakariko Well - Left", function() return Inverted end)
-- at_aga1:connect_one_way("Kakariko Well - Middle", function() return Inverted end)
-- at_aga1:connect_one_way("Kakariko Well - Right", function() return Inverted end)
-- at_aga1:connect_one_way("Kakariko Well - Bottom", function() return Inverted end)
-- at_aga1:connect_one_way("Rescue Dwarf", function() return Inverted end)
-- at_aga1:connect_one_way("Bottle Merchant", function() return Inverted end)
-- at_aga1:connect_one_way("Purple Chest Return", function() return Inverted end)