-- SW_gibdo_entrance = alttp_location.new("", nil, nil, "SW", true)
-- SW_big_chest_entrance = alttp_location.new("", nil, nil, "SW", true)
-- SW_pot_circle_drop = alttp_location.new("", nil, nil, "SW", true)
-- SW_bottom_left_drop = alttp_location.new("", nil, nil, "SW", true)
-- SW_pinball_drop = alttp_location.new("", nil, nil, "SW", true)
-- SW_north_drop = alttp_location.new("", nil, nil, "SW", true)
-- SW_west_lobby_entrance = alttp_location.new("", nil, nil, "SW", true)
-- SW_back_entrance = alttp_location.new("", nil, nil, "SW", true)

local SW_compass_room = alttp_location.new("SW_compass_room", "SW Compass Room", nil, "SW", true)
local SW_pot_prison = alttp_location.new("SW_pot_prison", "SW Pot Prison", nil, "SW", true)
local SW_pinball_room = alttp_location.new("SW_pinball_room", "SW Pinball Room", nil, "SW", true)
local SW_bottom_left_room = alttp_location.new("SW_bottom_left_room", "SW Bottom Left Drop", nil, "SW", true)
local SW_map_room = alttp_location.new("SW_map_room", "SW Map Room", nil, "SW", true)
local SW_pot_circle = alttp_location.new("SW_pot_circle", "SW Pot Circle", nil, "SW", true)
local SW_big_key_room = alttp_location.new("SW_big_key_room", "SW Big Key Room", nil, "SW", true)
local SW_lonely_pot_room = alttp_location.new("SW_lonely_pot_room", "SW Lonely Pot Room", nil, "SW", true)
local SW_back_bridge = alttp_location.new("SW_back_bridge", "SW Back Bridge", nil, "SW", true)
local SW_back_bottom_hallway = alttp_location.new("SW_back_bottom_hallway", "SW Back Below Bridge", nil, "SW", true)
local SW_back_troch_puzzle = alttp_location.new("SW_back_troch_puzzle", "SW Back Torches", nil, "SW", true)
local SW_back_spike_corner_room = alttp_location.new("SW_back_spike_corner_room", "SW Back Spike", nil, "SW", true)
local SW_back_pre_boss_drop = alttp_location.new("SW_back_pre_boss_drop", "SW Back Pre Boss Drop", nil, "SW", true)
local SW_back_boss_room = alttp_location.new("SW_back_boss_room", "SW Back Boss", nil, "SW", true)

local SW_gibdo_west_lobby_connector = alttp_location.new("SW_gibdo_west_lobby_connector", "SW Gibdo West Lobby connector")
local SW_star_switch_holes = alttp_location.new("SW_star_switch_holes", "SW Star Switch Holes")
local SW_vines_room = alttp_location.new("SW_vines_room", "SW Vines room")
local SW_big_chest_entrance_lobby = alttp_location.new("SW_big_chest_entrance_lobby", "SW Big Chest Entrance Lobby")
local SW_gibdo_entrance_lobby =  alttp_location.new("SW_gibdo_entrance_lobby", "SW Gibdo Entrance Lobby")
local SW_west_lobby =  alttp_location.new("SW_west_lobby", "SW West Lobby")
local SW_x_room =  alttp_location.new("SW_x_room", "SW X Room")
local SW_back_entrance_lobby =  alttp_location.new("SW_back_entrance_lobby", "SW Back Entrance Lobby")
local SW_big_chest_section = alttp_location.new("SW_big_chest_section", "SW Big Chest Section")
local SW_gibdo_west_lobby_connector_north = alttp_location.new("SW_gibdo_west_lobby_connector_north", "SW Gibdo West Lobby Connector North")

SW_compass_room_2N_door = alttp_location.new("SW_compass_room_2N_door", "SW Compass Room 2N Door", nil, "", true, 103, 3960, 3960, 3100, 3170, {"Skull Woods Front Doors", "SW Compass Room 2N Door", "SW Compass Room 2N Door"})
SW_compass_room_4E_door = alttp_location.new("SW_compass_room_4E_door", "SW Compass Room 4E Door", nil, "", true, 103, 4050, 4110, 3448, 3448, {"Skull Woods Front Doors", "SW Compass Room 4E Door", "SW Compass Room 4E Door"})
SW_pot_prison_4E_door = alttp_location.new("SW_pot_prison_4E_door", "SW Pot Prison 4E Door", nil, "", true, 87, 4050, 4100, 2936, 2936, {"Skull Woods Front Doors", "SW Pot Prison 4E Door", "SW Pot Prison 4E Door"})
SW_pot_prison_4S_door = alttp_location.new("SW_pot_prison_4S_door", "SW Pot Prison 4S Door", nil, "", true, 87, 3960, 3960, 3030, 3090, {"Skull Woods Front Doors", "SW Pot Prison 4S Door", "SW Pot Prison 4S Door"})
SW_pinball_room_3W_door = alttp_location.new("SW_pinball_room_3W_door", "SW Pinball Room 3W Door", nil, "", true, 104, 4070, 4120, 3448, 3448, {"Skull Woods Front Doors", "SW Pinball Room 3W Door", "SW Pinball Room 3W Door"})
SW_pinball_room_2N_door = alttp_location.new("SW_pinball_room_2N_door", "SW Pinball Room 2N Door", nil, "", true, 104, 4472, 4472, 3050, 3110, {"Skull Woods Front Doors", "SW Pinball Room 2N Door", "SW Pinball Room 2N Door"})
SW_map_room_4S_door = alttp_location.new("SW_map_room_4S_door", "SW Map Room 4S Door", nil, "", true, 88, 4472, 4472, 3030, 3090, {"Skull Woods Front Doors", "SW Map Room 4S Door", "SW Map Room 4S Door"})
SW_big_chest_entrance_3W_door = alttp_location.new("SW_big_chest_entrance_3W_door", "SW Big Chest Entrance 3W Door", nil, "", true, 88, 4070, 4120, 2936, 2936, {"Skull Woods Front Doors", "SW Big Chest Entrance 3W Door", "SW Big Chest Entrance 3W Door"})
SW_gibdo_entrance_3W_door = alttp_location.new("SW_gibdo_entrance_3W_door", "SW Gibdo Entrance 3W Door", nil, "", true, 87, 3560, 3620, 2936, 2936, {"Skull Woods Front Doors", "SW Gibdo Entrance 3W Door", "SW Gibdo Entrance 3W Door"})
SW_gibdo_west_lobby_connector_4E_door = alttp_location.new("SW_gibdo_west_lobby_connector_4E_door", "SW Gibdo West Lobby Connector 4E Door", nil, "", true, 86, 3550, 3600, 2936, 2936, {"Skull Woods Front Doors", "SW Gibdo West Lobby Connector 4E Door", "SW Gibdo West Lobby Connector 4E Door"})
SW_back_bridge_1N_door = alttp_location.new("SW_back_bridge_1N_door", "SW Back Bridge 1N Door", nil, "", true, 89, 4728, 4728, 2540, 2590, {"Skull Woods Back Doors", "SW Back Bridge 1N Door", "SW Back Bridge 1N Door"})
SW_star_switch_holes_3S_door = alttp_location.new("SW_star_switch_holes_3S_door", "SW Star Switch Holes 3S Door", nil, "", true, 73, 4728, 4728, 2510, 2580, {"Skull Woods Back Doors", "SW Star Switch Holes 3S Door", "SW Star Switch Holes 3S Door"})
SW_vines_room_1N_door = alttp_location.new("SW_vines_room_1N_door", "SW Vines Room 1N Door", nil, "", true, 73, 4728, 4728, 2070, 2120, {"Skull Woods Back Doors", "SW Vines Room 1N Door", "SW Vines Room 1N Door"})
SW_back_spike_corner_room_3S_door = alttp_location.new("SW_back_spike_corner_room_3S_door", "SW Back Spike Corner Room 3S Door", nil, "", true, 57, 4728, 4728, 2050, 2100, {"Skull Woods Back Doors", "SW Back Spike Corner Room 3S Door", "SW Back Spike Corner Room 3S Door"})


SW_bottom_left_drop_inside:connect_one_way(SW_bottom_left_room)

SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #1")
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #2")
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #3")
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #4")
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #5")
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Pot #6")
SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #1", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #2", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #3", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #4", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #6", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #7", function() return DealDamage end)
-- SW_bottom_left_room:connect_one_way("SW - Left Drop Enemy #9", function() return DealDamage end)

SW_bottom_left_room:connect_two_ways(SW_compass_room)
SW_compass_room:connect_two_ways(SW_pot_prison)

SW_compass_room:connect_one_way("SW - Compass Chest")
SW_compass_room:connect_one_way("SW - Compass Room Pot #7")
-- SW_compass_room:connect_one_way("SW - Compass Room Pot #8")
-- SW_compass_room:connect_one_way("SW - Compass Room Pot #9")
-- SW_compass_room:connect_one_way("SW - Compass Room Pot #10")
-- SW_compass_room:connect_one_way("SW - Compass Room Pot #11")
SW_compass_room:connect_one_way("SW - Compass Room Enemy #5", function() return DealDamage end)
-- SW_compass_room:connect_one_way("SW - Compass Room Enemy #8", function() return DealDamage end)
-- SW_compass_room:connect_one_way("SW - Compass Room Enemy #10", function() return DealDamage end)

SW_compass_room:connect_two_ways(SW_compass_room_2N_door)
SW_compass_room_2N_door:connect_two_ways_entrance("", SW_pot_prison_4S_door)
SW_pot_prison_4S_door:connect_two_ways(SW_pot_prison)

SW_pot_prison:connect_one_way("SW - Pot Prison")
SW_pot_prison:connect_one_way("SW - Pot Prison Pot #3")
-- SW_pot_prison:connect_one_way("SW - Pot Prison Pot #4")
-- SW_pot_prison:connect_one_way("SW - Pot Prison Pot #5")
-- SW_pot_prison:connect_one_way("SW - Pot Prison Pot #6")
SW_pot_prison:connect_one_way("SW - Pot Prison Enemy #10", function() return DealDamage end)
-- SW_pot_prison:connect_one_way("SW - Pot Prison Enemy #11", function() return DealDamage end)
-- SW_pot_prison:connect_one_way("SW - Pot Prison Enemy #12", function() return DealDamage end)
-- SW_pot_prison:connect_one_way("SW - Pot Prison Enemy #13", function() return DealDamage end)

SW_pot_prison:connect_one_way(SW_pot_prison_4E_door)
SW_pot_prison_4E_door:connect_two_ways_entrance("", SW_big_chest_entrance_3W_door, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SW_big_chest_entrance_3W_door:connect_two_ways(SW_big_chest_entrance_lobby)



SW_compass_room:connect_two_ways(SW_compass_room_4E_door)
SW_compass_room_4E_door:connect_two_ways_entrance_door_stuck("", SW_pinball_room_3W_door, nil, function() return false end)
SW_pinball_room_3W_door:connect_two_ways(SW_pinball_room)
SW_compass_room:connect_one_way(SW_pinball_room)

SW_pinball_room:connect_one_way("SW - Pinball Chest")
SW_pinball_room:connect_one_way("SW - Pinball Pot #1")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #2")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #3")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #4")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #5")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #6")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #7")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #8")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #9")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #10")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #11")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #12")
-- SW_pinball_room:connect_one_way("SW - Pinball Pot #13")
SW_pinball_room:connect_one_way("SW - Pinball Enemy #1", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #2", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #3", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #4", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #5", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #7", function() return DealDamage end)
-- SW_pinball_room:connect_one_way("SW - Pinball Enemy #8", function() return DealDamage end)

SW_pinball_room:connect_two_ways(SW_pinball_room_2N_door)
SW_pinball_room_2N_door:connect_two_ways_entrance("", SW_map_room_4S_door, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SW_map_room_4S_door:connect_two_ways(SW_map_room)

SW_map_room:connect_one_way("SW - Map Chest")
SW_map_room:connect_one_way("SW - Map Room Enemy #3", function() return DealDamage end)
-- SW_map_room:connect_one_way("SW - Map Room Enemy #8", function() return DealDamage end)

SW_map_room:connect_two_ways(SW_big_chest_entrance_lobby)


SW_pot_circle_drop_inside:connect_one_way(SW_pot_circle)

SW_pot_circle:connect_one_way("SW - Pot Circle Pot #5")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #6")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #7")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #8")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #9")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #10")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #11")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #12")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #13")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #14")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #15")
-- SW_pot_circle:connect_one_way("SW - Pot Circle Pot #16")
SW_pot_circle:connect_one_way("SW - Pot Circle Enemy #4", function() return DealDamage end)
-- SW_pot_circle:connect_one_way("SW - Pot Circle Enemy #5", function() return DealDamage end)
-- SW_pot_circle:connect_one_way("SW - Pot Circle Enemy #7", function() return DealDamage end)

SW_pot_circle:connect_two_ways_stuck(SW_map_room, function() return CanInteract(SW_pot_circle) end, function() return Has("hookshot") end)
SW_pot_circle:connect_two_ways(SW_big_chest_section, function() return Has("bombs") end)

SW_big_chest_section:connect_one_way("SW - Pull Switch Pot #1")
-- SW_big_chest_section:connect_one_way("SW - Pull Switch Pot #2")
-- SW_big_chest_section:connect_one_way("SW - Pull Switch Pot #3")
-- SW_big_chest_section:connect_one_way("SW - Pull Switch Pot #4")
SW_big_chest_section:connect_one_way("SW - ", function() return DealDamage end)

SW_big_chest_section:connect_one_way("SW - Big Chest", function() return Has("bigkey") end)
SW_big_chest_section:connect_one_way("SW - Big Chest Enemy #1", function() return DealDamage end)
-- SW_big_chest_section:connect_one_way("SW - Big Chest Enemy #2", function() return DealDamage end)
-- SW_big_chest_section:connect_two_ways()
-- SW_big_chest_section --get over the pit without pot circle access

SW_big_chest_entrance_inside:connect_two_ways(SW_big_chest_entrance_lobby)

SW_big_chest_entrance_lobby:connect_one_way("SW - 1 Lobby Enemy #9", function() return DealDamage end)
---

SW_gibdo_entrance_inside:connect_two_ways(SW_gibdo_entrance_lobby)

SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Pot #7")
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Pot #8")
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Pot #9")
SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Enemy #8", function() return DealDamage end)
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Enemy #9", function() return DealDamage end)
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Enemy #14", function() return DealDamage end)
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Enemy #15", function() return DealDamage end)
-- SW_gibdo_entrance_lobby:connect_one_way("SW - 2 East Lobby Enemy #16", function() return DealDamage end)

SW_gibdo_entrance_lobby:connect_two_ways(SW_big_key_room)

SW_big_key_room:connect_one_way("SW - Big Key Chest")
SW_big_key_room:connect_one_way("SW - Big Key Pot #2")
SW_big_key_room:connect_one_way("SW - Big Key Enemy #1", function() return DealDamage end)
-- SW_big_key_room:connect_one_way("SW - Big Key Enemy #2", function() return DealDamage end)
-- SW_big_key_room:connect_one_way("SW - Big Key Enemy #3", function() return DealDamage end)
-- SW_big_key_room:connect_one_way("SW - Big Key Enemy #4", function() return DealDamage end)
-- SW_big_key_room:connect_one_way("SW - Big Key Enemy #5", function() return DealDamage end)
-- SW_big_key_room:connect_one_way("SW - Big Key Enemy #6", function() return DealDamage end)

SW_big_key_room:connect_two_ways(SW_lonely_pot_room)
SW_lonely_pot_room:connect_one_way("SW - Lone Pot Pot #1")

SW_gibdo_entrance_lobby:connect_two_ways(SW_gibdo_entrance_3W_door)
SW_gibdo_entrance_3W_door:connect_two_ways_entrance("", SW_gibdo_west_lobby_connector_4E_door)
SW_gibdo_west_lobby_connector_4E_door:connect_two_ways(SW_gibdo_west_lobby_connector)

SW_gibdo_west_lobby_connector:connect_one_way("SW - Small Hall Enemy #3", function() return DealDamage end)
-- SW_gibdo_west_lobby_connector:connect_one_way("SW - Small Hall Enemy #12", function() return DealDamage end)
-- SW_gibdo_west_lobby_connector:connect_one_way("SW - Small Hall Enemy #13", function() return DealDamage end)

SW_gibdo_west_lobby_connector:connect_two_ways(SW_west_lobby)

SW_north_drop_inside:connect_one_way(SW_gibdo_west_lobby_connector_north)

SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Pot #1")
-- SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Pot #2")
-- SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Pot #3")
SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Enemy #5", function() return DealDamage end)
-- SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Enemy #9", function() return DealDamage end)
-- SW_gibdo_west_lobby_connector_north:connect_one_way("SW - Back Drop Enemy #10", function() return DealDamage end)

SW_gibdo_west_lobby_connector_north:connect_one_way(SW_gibdo_west_lobby_connector)

SW_west_lobby:connect_one_way("SW - West Lobby Key Drop")
SW_west_lobby:connect_one_way("SW - 2 West Lobby Pot #15")
SW_west_lobby:connect_one_way("SW - 2 West Lobby Enemy #2", function() return DealDamage end)
-- SW_west_lobby:connect_one_way("SW - 2 West Lobby Enemy #11", function() return DealDamage end)

SW_west_lobby:connect_two_ways(SW_x_room)

SW_x_room:connect_one_way("SW - X Room Pot #4")
-- SW_x_room:connect_one_way("SW - X Room Pot #5")
-- SW_x_room:connect_one_way("SW - X Room Pot #6")
-- SW_x_room:connect_one_way("SW - X Room Pot #7")
-- SW_x_room:connect_one_way("SW - X Room Pot #8")
-- SW_x_room:connect_one_way("SW - X Room Pot #9")
-- SW_x_room:connect_one_way("SW - X Room Pot #10")
-- SW_x_room:connect_one_way("SW - X Room Pot #11")
-- SW_x_room:connect_one_way("SW - X Room Pot #12")
-- SW_x_room:connect_one_way("SW - X Room Pot #13")
SW_x_room:connect_one_way("SW - X Room Enemy #4", function() return DealDamage end)
-- SW_x_room:connect_one_way("SW - X Room Enemy #6", function() return DealDamage end)
-- SW_x_room:connect_one_way("SW - X Room Enemy #7", function() return DealDamage end)

SW_west_lobby_entrance_inside:connect_two_ways(SW_west_lobby)

---

SW_back_entrance_inside:connect_two_ways(SW_back_bottom_hallway)
SW_back_bottom_hallway:connect_one_way("SW - Bridge Chest")
SW_back_bottom_hallway:connect_one_way("SW - 3 Lobby Pot #1")
-- SW_back_bottom_hallway:connect_one_way("SW - 3 Lobby Pot #2")
SW_back_bottom_hallway:connect_one_way("SW - East Bridge Pot #3")
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Pot #4")
SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #3", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #4", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #5", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #7", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #9", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #10", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #11", function() return DealDamage end)
-- SW_back_bottom_hallway:connect_one_way("SW - East Bridge Enemy #12", function() return DealDamage end)

SW_back_entrance_inside:connect_two_ways(SW_back_bridge)

SW_back_bridge:connect_one_way("SW - 3 Lobby Enemy #1", function() return DealDamage end)
-- SW_back_bridge:connect_one_way("SW - 3 Lobby Enemy #2", function() return DealDamage end)
-- SW_back_bridge:connect_one_way("SW - 3 Lobby Enemy #6", function() return DealDamage end)
-- SW_back_bridge:connect_one_way("SW - 3 Lobby Enemy #8", function() return DealDamage end)

SW_back_bridge:connect_two_ways(SW_back_bridge_1N_door)
SW_back_bridge_1N_door:connect_two_ways_entrance("", SW_star_switch_holes_3S_door, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 3, keys + 1, 3), keys + 1 end)
SW_star_switch_holes_3S_door:connect_two_ways(SW_star_switch_holes)

SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #3")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #4")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #5")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #6")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #7")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #8")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #9")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #10")
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Pot #11")
SW_star_switch_holes:connect_one_way("SW - Star Pits Enemy #11", function() return DealDamage end)
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Enemy #12", function() return DealDamage end)
-- SW_star_switch_holes:connect_one_way("SW - Star Pits Enemy #13", function() return DealDamage end)

SW_star_switch_holes:connect_two_ways(SW_back_troch_puzzle)

SW_back_troch_puzzle:connect_one_way("SW - Torch Room Pot #1")
-- SW_back_troch_puzzle:connect_one_way("SW - Torch Room Pot #2")
SW_back_troch_puzzle:connect_one_way("SW - Torch Room Enemy #6", function() return DealDamage end)
-- SW_back_troch_puzzle:connect_one_way("SW - Torch Room Enemy #8", function() return DealDamage end)
-- SW_back_troch_puzzle:connect_one_way("SW - Torch Room Enemy #9", function() return DealDamage end)
-- SW_back_troch_puzzle:connect_one_way("SW - Torch Room Enemy #10", function() return DealDamage end)

SW_back_troch_puzzle:connect_one_way(SW_vines_room, function() return Has("firerod") end)

SW_vines_room:connect_one_way("SW - Vines Enemy #1", function() return DealDamage end)
-- SW_vines_room:connect_one_way("SW - Vines Enemy #2", function() return DealDamage end)
-- SW_vines_room:connect_one_way("SW - Vines Enemy #3", function() return DealDamage end)
-- SW_vines_room:connect_one_way("SW - Vines Enemy #4", function() return DealDamage end)
-- SW_vines_room:connect_one_way("SW - Vines Enemy #5", function() return DealDamage end)

SW_vines_room:connect_two_ways(SW_vines_room_1N_door)
SW_vines_room_1N_door:connect_two_ways_entrance("", SW_back_spike_corner_room_3S_door)
SW_back_spike_corner_room_3S_door:connect_one_way(SW_back_spike_corner_room)

SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Key Drop")
SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Pot #1")
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Pot #2")
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Pot #3")
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Pot #4")
SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Enemy #1", function() return DealDamage end)
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Enemy #4", function() return DealDamage end)
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Enemy #6", function() return DealDamage end)

SW_back_spike_corner_room:connect_two_ways(SW_back_pre_boss_drop, function(keys, Current_Dungeon) return Has("smallkey", keys, 3, keys + 1, 4), KDSreturn(keys, keys + 1) end)

SW_back_pre_boss_drop:connect_one_way("SW - Final Drop Pot #3")
-- SW_back_pre_boss_drop:connect_one_way("SW - Final Drop Pot #4")
SW_back_pre_boss_drop:connect_one_way("SW - Final Drop Enemy #5", function() return DealDamage end)
-- SW_back_pre_boss_drop:connect_one_way("SW - Final Drop Enemy #7", function() return DealDamage end)

SW_back_pre_boss_drop:connect_one_way(SW_back_boss_room)
SW_back_boss_room:connect_one_way("SW - Boss")


---

-- SW_bottom_left_drop_inside:connect_one_way(SW_bottom_left_room)
-- SW_bottom_left_room:connect_two_ways(SW_compass_room)



-- SW_pot_prison:connect_two_ways(SW_big_chest_entrance_inside, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)


-- SW_pinball_drop_inside:connect_one_way(SW_pinball_room)

-- SW_pinball_room:connect_two_ways(SW_map_room, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)


-- SW_big_chest_entrance_inside:connect_one_way("SW - Big Chest", function()
--     return ALL(
--         "bigkey",
--         "bombs",
--         CanInteract(SW_big_chest_entrance_inside)
--     )
-- end)

-- SW_gibdo_entrance_inside:connect_two_ways(SW_big_key_room)
-- SW_gibdo_entrance_inside:connect_two_ways(SW_west_lobby_entrance_inside)

-- SW_big_key_room:connect_one_way("SW - Big Key Chest")

-- SW_north_drop_inside:connect_one_way(SW_gibdo_entrance_inside)

-- SW_west_lobby_entrance_inside:connect_one_way("SW - West Lobby Key Drop")

-- SW_back_entrance_inside:connect_two_ways(SW_back_bridge)
-- SW_back_entrance_inside:connect_two_ways(SW_back_bottom_hallway)

-- SW_back_bottom_hallway:connect_one_way("SW - Bridge Chest")

-- SW_back_bridge:connect_two_ways(SW_back_troch_puzzle, function(keys, Current_Dungeon) return Has("smallkey", keys + 1, 3, keys + 1, 3), keys + 1 end)

-- SW_back_troch_puzzle:connect_one_way(SW_back_spike_corner_room, function()
--     return ALL(
--         "firerod",
--         CanRemoveCurtains
--     )
-- end)

-- SW_back_spike_corner_room:connect_two_ways(SW_back_boss_room, function(keys, Current_Dungeon) return Has("smallkey", keys, 3, keys + 1, 4), KDSreturn(keys, keys + 1) end)
-- SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Key Drop")

-- SW_back_boss_room:connect_one_way("SW - Boss")