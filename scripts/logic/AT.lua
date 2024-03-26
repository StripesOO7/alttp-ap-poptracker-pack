-- at_entrance = alttp_location.new("")
local at_golden_guards = alttp_location.new("at_golden_guards")
local at_first_chest = alttp_location.new("at_first_chest")
local at_dark_maze = alttp_location.new("at_dark_maze")
local at_dark_archer_key_drop = alttp_location.new("at_dark_archer_key_drop")
local at_circle_of_pots = alttp_location.new("at_circle_of_pots")
local at_aga1 = alttp_location.new("at_aga1")

at_entrance:connect_one_way(at_golden_guards)

at_golden_guards:connect_one_way(at_entrance, function() return dealDamage() end)
at_golden_guards:connect_two_ways(at_first_chest)

at_first_chest:connect_one_way("AT - First Chest", function() return dealDamage() end)
at_first_chest:connect_two_ways(at_dark_maze, function(keys) 
    return has("at_smallkey", keys + 1, 1, keys + 1, 1), KDSreturn(keys + 1, keys + 1)
end)
at_dark_maze:connect_two_ways(at_dark_archer_key_drop, function(keys) 
    return all(
        darkRooms(),
        has("at_smallkey", keys + 1, 2, keys + 1, 2)
    ), KDSreturn(keys + 1, keys + 1)
end)
at_dark_maze:connect_one_way("AT - Maze Chest", function() 
    return darkRooms()
end)

at_dark_archer_key_drop:connect_two_ways(at_circle_of_pots, function(keys) 
    return has("at_smallkey", keys, 2, keys + 1, 3), KDSreturn(keys, keys + 1)
end)
at_dark_archer_key_drop:connect_one_way("AT - Dark Archer Key Drop", function() return dealDamage() end)

at_circle_of_pots:connect_two_ways(at_aga1, function(keys) 
    return all(
        has("at_smallkey", keys, 2, keys + 1, 4),
        canRemoveCurtains()
    ), KDSreturn(keys, keys + 1)
end)
at_circle_of_pots:connect_one_way("AT - Circle of Pots Key Drop")

at_aga1:connect_one_way("AT - Aga1", function() 
    return any(
        has("sword"),
        has("hammer"),
        has("bug_net")
    ) 
end)