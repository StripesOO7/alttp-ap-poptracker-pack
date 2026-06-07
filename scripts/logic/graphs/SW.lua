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
local SW_back_bridge = alttp_location.new("SW_back_bridge", "SW Back Bridge", nil, "SW", true)
local SW_back_bottom_hallway = alttp_location.new("SW_back_bottom_hallway", "SW Back Below Bridge", nil, "SW", true)
local SW_back_troch_puzzle = alttp_location.new("SW_back_troch_puzzle", "SW Back Torches", nil, "SW", true)
local SW_back_spike_corner_room = alttp_location.new("SW_back_spike_corner_room", "SW Back Spike", nil, "SW", true)
local SW_back_boss_room = alttp_location.new("SW_back_boss_room", "SW Back Boss", nil, "SW", true)


SW_bottom_left_drop_inside:connect_one_way(SW_bottom_left_room)
SW_bottom_left_room:connect_two_ways(SW_compass_room)

SW_compass_room:connect_two_ways(SW_pot_prison)
SW_compass_room:connect_one_way(SW_pinball_room)
SW_compass_room:connect_one_way("SW - Compass Chest")

SW_pot_prison:connect_two_ways(SW_big_chest_entrance_inside, function(keys) return Has("sw_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SW_pot_prison:connect_one_way("SW - Pot Prison")

SW_pinball_drop_inside:connect_one_way(SW_pinball_room)

SW_pinball_room:connect_two_ways(SW_map_room, function(keys) return Has("sw_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
SW_pinball_room:connect_one_way("SW - Pinball Chest")

SW_pot_circle_drop_inside:connect_one_way(SW_pot_circle)
SW_pot_circle:connect_one_way(SW_map_room, function() return CanInteract(SW_pot_circle) end)
SW_pot_circle:connect_two_ways(SW_big_chest_entrance_inside)

SW_map_room:connect_two_ways(SW_big_chest_entrance_inside)
SW_map_room:connect_one_way("SW - Map Chest")

SW_big_chest_entrance_inside:connect_one_way("SW - Big Chest", function()
    return ALL(
        "sw_bigkey",
        "bombs",
        CanInteract(SW_big_chest_entrance_inside)
    )
end)

SW_gibdo_entrance_inside:connect_two_ways(SW_big_key_room)
SW_gibdo_entrance_inside:connect_two_ways(SW_west_lobby_entrance_inside)

SW_big_key_room:connect_one_way("SW - Big Key Chest")

SW_north_drop_inside:connect_one_way(SW_gibdo_entrance_inside)

SW_west_lobby_entrance_inside:connect_one_way("SW - West Lobby Key Drop")

SW_back_entrance_inside:connect_two_ways(SW_back_bridge)
SW_back_entrance_inside:connect_two_ways(SW_back_bottom_hallway)

SW_back_bottom_hallway:connect_one_way("SW - Bridge Chest")

SW_back_bridge:connect_two_ways(SW_back_troch_puzzle, function(keys) return Has("sw_smallkey", keys + 1, 3, keys + 1, 3), keys + 1 end)

SW_back_troch_puzzle:connect_one_way(SW_back_spike_corner_room, function()
    return ALL(
        "firerod",
        CanRemoveCurtains
    )
end)

SW_back_spike_corner_room:connect_two_ways(SW_back_boss_room, function(keys) return Has("sw_smallkey", keys, 3, keys + 1, 4), KDSreturn(keys, keys + 1) end)
SW_back_spike_corner_room:connect_one_way("SW - Spike Corner Key Drop")

SW_back_boss_room:connect_one_way("SW - Boss")