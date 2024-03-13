at_entrance = alttp_location.new()
local at_golden_guards = alttp_location.new()
local at_first_chest = alttp_location.new()
local at_dark_maze = alttp_location.new()
local at_dark_archer_key_drop = alttp_location.new()
local at_circle_of_pots = alttp_location.new()
local at_aga1 = alttp_location.new()

at_entrance:connect_one_way(at_golden_guards)

at_golden_guards:connect_one_way(at_entrance, function() return weapon() end)
at_golden_guards:connect_two_ways(at_first_chest)

at_first_chest:connect_one_way("AT - First Chest", function() return weapon() end)
at_first_chest:connect_two_ways(at_dark_maze, function() 
    return any(
        darkRooms()
    ) 
end)
at_dark_maze:connect_two_ways(at_dark_archer_key_drop)
at_dark_maze:connect_one_way("AT - Maze Chest", function() 
    return any(
        darkRooms()
    ) 
end)

at_dark_archer_key_drop:connect_two_ways(at_circle_of_pots)
at_dark_archer_key_drop:connect_one_way("AT - Dark Archer Key Drop")

at_circle_of_pots:connect_two_ways(at_aga1)
at_circle_of_pots:connect_one_way("AT - Circle of Pots Key Drop")

at_aga1:connect_one_way("AT - Aga1")