-- sw_gibdo_entrance = alttp_location.new("", nil, nil, true)
-- sw_big_chest_entrance = alttp_location.new("", nil, nil, true)
-- sw_pot_circle_drop = alttp_location.new("", nil, nil, true)
-- sw_bottom_left_drop = alttp_location.new("", nil, nil, true)
-- sw_pinball_drop = alttp_location.new("", nil, nil, true)
-- sw_north_drop = alttp_location.new("", nil, nil, true)
-- sw_west_lobby_entrance = alttp_location.new("", nil, nil, true)
-- sw_back_entrance = alttp_location.new("", nil, nil, true)

local sw_compass_room = alttp_location.new("sw_compass_room", "SW Compass Room", nil, true)
local sw_pot_prison = alttp_location.new("sw_pot_prison", "SW Pot Prison", nil, true)
local sw_pinball_room = alttp_location.new("sw_pinball_room", "SW Pinball Room", nil, true)
local sw_bottom_left_room = alttp_location.new("sw_bottom_left_room", "SW Bottom Left Drop", nil, true)
local sw_map_room = alttp_location.new("sw_map_room", "SW Map Room", nil, true)
local sw_pot_circle = alttp_location.new("sw_pot_circle", "SW Pot Circle", nil, true)
local sw_big_key_room = alttp_location.new("sw_big_key_room", "SW Big Key Room", nil, true)
local sw_back_bridge = alttp_location.new("sw_back_bridge", "SW Back Bridge", nil, true)
local sw_back_bottom_hallway = alttp_location.new("sw_back_bottom_hallway", "SW Back Below Bridge", nil, true)
local sw_back_troch_puzzle = alttp_location.new("sw_back_troch_puzzle", "SW Back Torches", nil, true)
local sw_back_spike_corner_room = alttp_location.new("sw_back_spike_corner_room", "SW Back Spike", nil, true)
local sw_back_boss_room = alttp_location.new("sw_back_boss_room", "SW Back Boss", nil, true)


sw_bottom_left_drop_inside:connect_one_way(sw_bottom_left_room)
sw_bottom_left_room:connect_two_ways(sw_compass_room)

sw_compass_room:connect_two_ways(sw_pot_prison)
sw_compass_room:connect_one_way(sw_pinball_room)
sw_compass_room:connect_one_way("SW - Compass Chest")

sw_pot_prison:connect_two_ways(sw_big_chest_entrance_inside, function(keys) return Has("sw_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
sw_pot_prison:connect_one_way("SW - Pot Prison")

sw_pinball_drop_inside:connect_one_way(sw_pinball_room)

sw_pinball_room:connect_two_ways(sw_map_room, function(keys) return Has("sw_smallkey", keys + 1, 1, keys + 1, 1), keys + 1 end)
sw_pinball_room:connect_one_way("SW - Pinball Chest")

sw_pot_circle_drop_inside:connect_one_way(sw_pot_circle)
sw_pot_circle:connect_one_way(sw_map_room, function() return CanInteract(sw_pot_circle) end)
sw_pot_circle:connect_two_ways(sw_big_chest_entrance_inside)

sw_map_room:connect_two_ways(sw_big_chest_entrance_inside)
sw_map_room:connect_one_way("SW - Map Chest")

sw_big_chest_entrance_inside:connect_one_way("SW - Big Chest", function()
    return ALL(
        "sw_bigkey",
        "bombs",
        CanInteract(sw_big_chest_entrance_inside)
    )
end)

sw_gibdo_entrance_inside:connect_two_ways(sw_big_key_room)
sw_gibdo_entrance_inside:connect_two_ways(sw_west_lobby_entrance_inside)

sw_big_key_room:connect_one_way("SW - Big Key Chest")

sw_north_drop_inside:connect_one_way(sw_gibdo_entrance_inside)

sw_west_lobby_entrance_inside:connect_one_way("SW - West Lobby Key Drop")

sw_back_entrance_inside:connect_two_ways(sw_back_bridge)
sw_back_entrance_inside:connect_two_ways(sw_back_bottom_hallway)

sw_back_bottom_hallway:connect_one_way("SW - Bridge Chest")

sw_back_bridge:connect_two_ways(sw_back_troch_puzzle, function(keys) return Has("sw_smallkey", keys + 1, 3, keys + 1, 3), keys + 1 end)

sw_back_troch_puzzle:connect_one_way(sw_back_spike_corner_room, function()
    return ALL(
        "firerod",
        CanRemoveCurtains
    )
end)

sw_back_spike_corner_room:connect_two_ways(sw_back_boss_room, function(keys) return Has("sw_smallkey", keys, 3, keys + 1, 4), KDSreturn(keys, keys + 1) end)
sw_back_spike_corner_room:connect_one_way("SW - Spike Corner Key Drop")

sw_back_boss_room:connect_one_way("SW - Boss")