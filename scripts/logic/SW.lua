sw_gibdo_entrance
sw_big_chest_entrance
sw_pot_circle_drop
sw_bottom_left_drop
sw_pinball_drop
sw_north_drop
sw_west_lobby_entrance
sw_back_entracne

local sw_compass_room
local sw_pot_prison
local sw_pinball_room
local sw_bottom_left_room
local sw_map_room
local sw_pot_circle
local sw_big_key_room
local sw_back_bridge
local sw_back_bottom_hallway
local sw_back_troch_puzzle
local sw_back_spike_corner_room
local sw_back_boss_room


sw_bottom_left_drop:connect_one_way(sw_bottom_left_room)
sw_bottom_left_room:connect_two_ways(sw_compass_room)

sw_compass_room:connect_two_ways(sw_pot_prison)
sw_compass_room:connect_one_way(sw_pinball_room)
sw_compass_room:connect_one_way("SW - compass Chest")

sw_pot_prison:connect_two_ways(sw_big_chest_entrance)
sw_pot_prison:connect_one_way("SW - Pot Prison")

sw_pinball_drop:connect_one_way(sw_pinball_room)

sw_pinball_room:connect_two_ways(sw_map_room)
sw_pinball_room:connect_one_way("SW - Pinball Chest")

sw_pot_circle_drop:connect_one_way(sw_pot_circle)
sw_pot_circle:connect_one_way(sw_map_room)
sw_pot_circle:connect_two_ways(sw_big_chest_entrance)

sw_map_room:connect_two_ways(sw_big_chest_entrance)
sw_map_room:connect_one_way("SW - Map Chest")

sw_big_chest_entrance:connect_one_way("SW - Big Chest")

sw_gibdo_entrance:connect_two_ways(sw_big_key_room)
sw_gibdo_entrance:connect_two_ways(sw_west_lobby_entrance)

sw_big_key_room:connect_one_way("SW - Big Key Chest")

sw_north_drop:connect_one_way(sw_gibdo_entrance)

sw_west_lobby_entrance:connect_one_way("SW - West L:obby Key Drop")

sw_back_entracne:connect_two_ways(sw_back_bridge)
sw_back_entracne:connect_two_ways(sw_back_bottom_hallway)

sw_back_bottom_hallway:connect_one_way("SW - Bridge Chest")

sw_back_bridge:connect_two_ways(sw_back_troch_puzzle)

sw_back_troch_puzzle:connect_one_way(sw_back_spike_corner_room)

sw_back_spike_corner_room:connect_two_ways(sw_back_boss_room)
sw_back_spike_corner_room:connect_one_way("SW - Spike Corner Key Drop")

sw_back_boss_room:connnconnect_one_way("SW - Boss")