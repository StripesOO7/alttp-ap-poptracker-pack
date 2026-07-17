-- AT_entrance = alttp_location.new("", nil, nil, "AT", true)
local AT_lobby = alttp_location.new("AT_lobby", "AT Lobby", nil, "AT", true)
local AT_golden_guards = alttp_location.new("AT_golden_guards", "AT Golden Guards", nil, "AT", true)
local AT_first_chest = alttp_location.new("AT_first_chest", "AT Room 03", nil, "AT", true)
local AT_dark_maze = alttp_location.new("AT_dark_maze", "AT Dark Maze", nil, "AT", true)
local AT_dark_archers = alttp_location.new("AT_dark_archers", "AT Dark Archers", nil, "AT", true)
local AT_circle_of_pots = alttp_location.new("AT_circle_of_pots", "AT Circle of Pots", nil, "AT", true)
local AT_aga1 = alttp_location.new("AT_aga1", "AT Aga1 Arena", nil, "AT", true)
local AT_pre_curtain = alttp_location.new("AT_pre_curtain", "AT Cutscene Room", nil, "AT", true)

local AT_dark_chargers = alttp_location.new("AT_dark_chargers", "AT Dark Chargers")
local AT_dual_statues = alttp_location.new("AT_dual_statues", "AT Dual Statues")
local AT_dark_pits = alttp_location.new("AT_dark_pits", "AT Dark Pits")
local AT_red_spears = alttp_location.new("AT_red_spears", "AT Red Spears")
local AT_red_guards = alttp_location.new("AT_red_guards", "AT Red Guards")
local AT_pacifist_run = alttp_location.new("AT_pacifist_run", "AT Pacifist run")
local AT_push_statue_down = alttp_location.new("AT_push_statue_down", "AT Push Statue Down")
local AT_catwalk = alttp_location.new("AT_catwalk", "AT Catwalk")
local AT_antechamber = alttp_location.new("AT_antechamber", "AT Antechamber")

-- local AT_Lobby_north_door = alttp_location.new("AT_", "AT Lobby North Door")
AT_first_chest_2N_door = alttp_location.new("AT_first_chest_2N_door", "AT First Chest 2N Door")
AT_dark_maze_2N_door = alttp_location.new("AT_dark_maze_2N_door", "AT Dark Maze 2N Door")
AT_dark_chargers_4N_door = alttp_location.new("AT_dark_chargers_4N_door", "AT dark chargers 4N Door")
AT_dual_statues_4N_door = alttp_location.new("AT_dual_statues_4N_door", "AT Dual Statues 4N Door")
AT_dark_archers_2N_door = alttp_location.new("AT_dark_archers_2N_door", "AT Dark Archers 2N Door")
AT_red_spears_2N_door = alttp_location.new("AT_red_spears_2N_door", "AT Red Spears 2N door")
AT_pacifist_run_4N_door = alttp_location.new("AT_pacifist_run_4N_door", "AT Pacifist run 4N door")
AT_push_statue_down_4N_door = alttp_location.new("AT_push_statue_down_4N_door", "AT Push Statue Down 4N door")
AT_catwalk_1N_door = alttp_location.new("AT_catwalk_1N_door", "AT Catwalk 1N Door")
AT_antechamber_2S_door = alttp_location.new("AT_antechamber_2S_door", "AT Antechamber 2S Door")
AT_pre_curtain_1N_door = alttp_location.new("AT_pre_curtain_1N_door", "AT Pre Crtain 1N Door")
AT_aga_arena_1S_door = alttp_location.new("AT_aga_arena_1S_door", "AT Aga Arena 1S Door")



AT_entrance_inside:connect_two_ways(AT_lobby)
AT_lobby:connect_one_way(AT_golden_guards)
AT_golden_guards:connect_one_way(AT_lobby, function() return DealDamage end)

AT_golden_guards:connect_two_ways(AT_first_chest, function() return DealDamage end)

AT_first_chest:connect_one_way("AT - First Chest", function() return DealDamage end)
AT_first_chest:connect_two_ways(AT_first_chest_2N_door)

AT_first_chest_2N_door:connect_two_ways_entrance("", AT_dark_maze_2N_door, function(keys)
    return Has("at_smallkey", keys + 1, 1, keys + 1, 1), keys + 1
end)

AT_dark_maze_2N_door:connect_two_ways(AT_dark_maze)
AT_dark_maze:connect_one_way("AT - Maze Chest", function()
    return DarkRooms(true)
end)
AT_dark_maze:connect_two_ways(AT_dark_chargers, function(keys)
    return ALL(
        DarkRooms(true),
        Has("at_smallkey", keys + 1, 2, keys + 1, 2)
    ), keys + 1
end)

AT_dark_chargers:connect_two_ways(AT_dark_chargers_4N_door)
AT_dark_chargers_4N_door:connect_two_ways_entrance("", AT_dual_statues_4N_door)

AT_dual_statues_4N_door:connect_two_ways(AT_dual_statues)
AT_dual_statues:connect_two_ways_stuck(AT_dark_pits, function() return true end , function() return CanInteract(AT_dark_pits) end)
AT_dark_pits:connect_two_ways(AT_dark_archers, function() return DarkRooms(true) end)

AT_dark_archers:connect_one_way("AT - Dark Archer Key Drop", function() return DealDamage end)
AT_dark_archers:connect_two_ways(AT_dark_archers_2N_door)
AT_dark_archers_2N_door:connect_two_ways_entrance("", AT_red_spears_2N_door, function(keys)
    return Has("at_smallkey", keys, 2, keys + 1, 3), KDSreturn( keys, keys + 1)
end)
AT_red_spears_2N_door:connect_two_ways(AT_red_spears)
AT_red_spears:connect_two_ways(AT_red_guards)
AT_red_guards:connect_two_ways(AT_circle_of_pots)

AT_circle_of_pots:connect_one_way("AT - Circle of Pots Key Drop") --functoin() return CanInteract("", end)
AT_circle_of_pots:connect_two_ways(AT_pacifist_run)

AT_pacifist_run:connect_two_ways(AT_pacifist_run_4N_door)
AT_pacifist_run_4N_door:connect_two_ways_entrance("", AT_push_statue_down_4N_door, function(keys)
    return ALL(
        Has("at_smallkey", keys, 2, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
AT_push_statue_down_4N_door:connect_two_ways(AT_push_statue_down)

AT_push_statue_down:connect_two_ways(AT_catwalk)

AT_catwalk:connect_two_ways(AT_catwalk_1N_door)
AT_catwalk_1N_door:connect_two_ways_entrance("", AT_antechamber_2S_door)
AT_antechamber_2S_door:connect_two_ways(AT_antechamber)

AT_antechamber:connect_two_ways(AT_pre_curtain)

AT_pre_curtain:connect_two_ways(AT_pre_curtain_1N_door)
AT_pre_curtain_1N_door:connect_two_ways_entrance("", AT_aga_arena_1S_door, function() return CanRemoveCurtains end)
AT_aga_arena_1S_door:connect_two_ways(AT_aga1)


AT_aga1:connect_one_way("AT - Aga1", function()
    return ANY(
        "sword",
        "hammer",
        "bug_net"
    )
end)

AT_aga1:connect_one_way(Pyramid_area, function() return ALL(OpenOrStandard, "aga1") end)
AT_aga1:connect_one_way(Hyrule_castle_area, function() return ALL(Inverted, "aga1") end)