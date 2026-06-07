-- AT_entrance = alttp_location.new("", nil, nil, "AT", true)
local AT_golden_guards = alttp_location.new("AT_golden_guards", "AT Golden Guards", nil, "AT", true)
local AT_first_chest = alttp_location.new("AT_first_chest", "AT First Chest", nil, "AT", true)
local AT_dark_maze = alttp_location.new("AT_dark_maze", "AT Dark Maze", nil, "AT", true)
local AT_dark_archer_key_drop = alttp_location.new("AT_dark_archer_key_drop", "AT Dark Archer", nil, "AT", true)
local AT_circle_of_pots = alttp_location.new("AT_circle_of_pots", "AT Circle of Pots", nil, "AT", true)
local AT_aga1 = alttp_location.new("AT_aga1", "AT Aga1 Arena", nil, "AT", true)
local AT_pre_curtain = alttp_location.new("AT_pre_curtain", "AT Cutscene Room", nil, "AT", true)

AT_entrance_inside:connect_one_way(AT_golden_guards, function() 
    return ANY(
        ALL(
            CanInteract(AT_entrance_inside),
            OpenOrStandard
        ),
        CanInteract(AT_entrance_inside)
    )
end)


AT_golden_guards:connect_one_way(AT_entrance_inside)
AT_golden_guards:connect_two_ways(AT_first_chest, function() return DealDamage() end)

AT_first_chest:connect_one_way("AT - First Chest", function() return DealDamage() end)
AT_first_chest:connect_two_ways(AT_dark_maze, function(keys)
    return Has("at_smallkey", keys + 1, 1, keys + 1, 1), keys + 1
end)
AT_dark_maze:connect_two_ways(AT_dark_archer_key_drop, function(keys)
    return ALL(
        DarkRooms(true),
        Has("at_smallkey", keys + 1, 2, keys + 1, 2)
    ), keys + 1
end)
AT_dark_maze:connect_one_way("AT - Maze Chest", function()
    return DarkRooms(true)
end)

AT_dark_archer_key_drop:connect_two_ways(AT_circle_of_pots, function(keys)
    return Has("at_smallkey", keys, 2, keys + 1, 3), KDSreturn( keys, keys + 1)
end)
AT_dark_archer_key_drop:connect_one_way("AT - Dark Archer Key Drop", function() return DealDamage() end)

AT_circle_of_pots:connect_two_ways(AT_pre_curtain, function(keys)
    return ALL(
        Has("at_smallkey", keys, 2, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
AT_circle_of_pots:connect_one_way("AT - Circle of Pots Key Drop") --functoin() return CanInteract("", end)
AT_pre_curtain:connect_one_way(AT_aga1, function() return CanRemoveCurtains() end)
AT_aga1:connect_one_way("AT - Aga1", function()
    return ANY(
        "sword",
        "hammer",
        "bug_net"
    )
end)

AT_aga1:connect_one_way(Pyramid_area, function() return ALL(OpenOrStandard, "aga1") end)
AT_aga1:connect_one_way(Hyrule_castle_area, function() return ALL(Inverted, "aga1") end)