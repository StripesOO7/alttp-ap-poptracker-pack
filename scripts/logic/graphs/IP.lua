-- IP_entrance = alttp_location.new("", nil, nil, "IP", true)
local IP_freezor_entrance = alttp_location.new("IP_freezor_entrance", "IP Freezor Entrance", nil, "IP", true)
local IP_jelly_room = alttp_location.new("IP_jelly_room", "IP Jelly Room", nil, "IP", true)
local IP_push_cross = alttp_location.new("IP_push_cross", "IP Push Cross", nil, "IP", true)
local IP_bomb_dropdown = alttp_location.new("IP_bomb_dropdown", "IP Bomb Dropdown", nil, "IP", true)
local IP_sliding_switch_room = alttp_location.new("IP_sliding_switch_room", "IP Sliding Switch", nil, "IP", true)
local IP_compass_room = alttp_location.new("IP_compass_room", "IP Comppass", nil, "IP", true)
local IP_conveyor_room = alttp_location.new("IP_conveyor_room", "IP Conveyor Room", nil, "IP", true)
local IP_map_room = alttp_location.new("IP_map_room", "IP Map Room", nil, "IP", true)
local IP_sliding_penguins = alttp_location.new("IP_sliding_penguins", "IP ", nil, "IP", true)
local IP_cross = alttp_location.new("IP_cross", "IP Spikeball Cross", nil, "IP", true)
local IP_falling_floor = alttp_location.new("IP_falling_floor", "IP Falling Floor", nil, "IP", true)
local IP_sliding_firebar = alttp_location.new("IP_sliding_firebar", "IP Slideing Firesneak", nil, "IP", true)
local IP_ice_hallway = alttp_location.new("IP_ice_hallway", "IP Icey Hallway", nil, "IP", true)
local IP_hookshot_pit = alttp_location.new("IP_hookshot_pit", "IP Hookshot Pit", nil, "IP", true)
local IP_big_spikeballs = alttp_location.new("IP_big_spikeballs", "IP Big Spikeballs", nil, "IP", true)
local IP_spike_room = alttp_location.new("IP_spike_room", "IP Spike Room", nil, "IP", true)
local IP_big_key_room = alttp_location.new("IP_big_key_room", "IP Big Key", nil, "IP", true)
local IP_freezor_room = alttp_location.new("IP_freezor_room", "IP 2 Freezors", nil, "IP", true)
local IP_big_chest_room = alttp_location.new("IP_big_chest_room", "IP Big Chest", nil, "IP", true)
local IP_many_pots_room = alttp_location.new("IP_many_pots_room", "IP Many Pots", nil, "IP", true)
local IP_iced_t_room = alttp_location.new("IP_iced_t_room", "IP Ice-T Room", nil, "IP", true)
local IP_above_boss_dropdown = alttp_location.new("IP_above_boss_dropdown", "IP Above Boss", nil, "IP", true)
local IP_boss_dropdown = alttp_location.new("IP_boss_dropdown", "IP Boss Dropdown", nil, "IP", true)
local IP_boss_room = alttp_location.new("IP_boss_room", "IP Boss Room", nil, "IP", true)

IP_entrance_inside:connect_two_ways(IP_freezor_entrance, function() return CanInteract(IP_entrance_inside) end)
IP_freezor_entrance:connect_two_ways(IP_jelly_room, function()
    return ANY(
        "firerod",
        ALL(
            "bombos",
            CanUseMedallions
        )
    )
end)

-- UWG
IP_freezor_entrance:connect_one_way(IP_bomb_dropdown, function()
    return ALL(
        CheckGlitches(3),
        CanBombClip(IP_freezor_entrance)
    )
end) -- Ice Palace Entrance Clip
-- UWG end

IP_jelly_room:connect_two_ways(IP_push_cross, function(keys) return Has("ip_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1) end)
IP_jelly_room:connect_one_way("IP - Jelly Key Drop", function() return DealDamage() end)
IP_push_cross:connect_two_ways(IP_bomb_dropdown)
IP_push_cross:connect_two_ways(IP_sliding_switch_room)
IP_push_cross:connect_two_ways(IP_compass_room)
IP_compass_room:connect_one_way("IP - Compass Chest", function() return DealDamage() end)
IP_bomb_dropdown:connect_one_way(IP_conveyor_room, function() return Has("bombs") end)

IP_conveyor_room:connect_two_ways(IP_sliding_penguins, function(keys) return Has("ip_smallkey", keys, 0, keys + 1, 2), KDSreturn(keys, keys + 1) end)
IP_conveyor_room:connect_one_way("IP - Conveyor Key Drop", function() return DealDamage() end)
IP_sliding_penguins:connect_two_ways(IP_cross, function() return DealDamage() end)
IP_cross:connect_two_ways(IP_falling_floor)
IP_cross:connect_two_ways(IP_spike_room, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 4), keys + 1
    else
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 6), keys + 1
    end
end)
IP_cross:connect_two_ways(IP_sliding_firebar)

IP_sliding_firebar:connect_two_ways(IP_freezor_room)
IP_falling_floor:connect_one_way(IP_ice_hallway)

IP_freezor_room:connect_one_way(IP_big_chest_room)
IP_freezor_room:connect_one_way("IP - Freezor Chest", function()
    return ANY(
        "firerod",
        ALL(
            "bombos",
            CanUseMedallions
        )
    )
end)
IP_big_chest_room:connect_two_ways(IP_above_boss_dropdown)
IP_big_chest_room:connect_one_way("IP - Big Chest", function()
    return ALL(
        "ip_bigkey",
        ANY(
            "bombs",
            "hookshot"
        )
    )
end)
IP_above_boss_dropdown:connect_one_way(IP_boss_dropdown, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return ALL(
            Has("ip_smallkey", keys + 1, 2, keys + 1, 5),
            "ip_bigkey"
        ), keys + 1
    else
        return ALL(
            Has("ip_smallkey", keys + 1, 2, keys + 1, 6),
            "ip_bigkey"
        ), keys + 1
    end
end)
IP_above_boss_dropdown:connect_two_ways(IP_many_pots_room)

IP_many_pots_room:connect_two_ways(IP_iced_t_room)
IP_many_pots_room:connect_one_way("IP - Many Pots Key Drop")
IP_iced_t_room:connect_two_ways(IP_ice_hallway, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 4), keys + 1
    else
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 6), keys + 1
    end
end)
IP_iced_t_room:connect_one_way("IP - Iced T Chest")
-- IP_ice_hallway:connect_one_way(IP_freezor_room)
IP_ice_hallway:connect_one_way(IP_big_chest_room)
IP_ice_hallway:connect_two_ways(IP_hookshot_pit)
IP_hookshot_pit:connect_one_way(IP_big_spikeballs, function() return Has("hookshot") end)
IP_big_spikeballs:connect_two_ways(IP_spike_room)

IP_spike_room:connect_two_ways(IP_map_room)
IP_spike_room:connect_one_way("IP - Spike Chest")
IP_map_room:connect_two_ways(IP_big_key_room, function()
    return ALL(
        "hammer",
        "glove"
    )
end)
IP_map_room:connect_one_way("IP - Map Chest", function()
    return ALL(
        "hammer",
        "glove"
    )
end)
IP_map_room:connect_one_way("IP - Hammer Block Key Drop", function()
    return ALL(
        "hammer",
        "glove"
    )
end)

IP_sliding_switch_room:connect_two_ways(IP_big_key_room, function()
    return ALL(
        "somaria",
        CheckGlitches(2)
    )
end)
-- IP_big_key_room:connect_one_way(IP_big_key_room)
IP_big_key_room:connect_one_way(IP_sliding_switch_room)
IP_big_key_room:connect_one_way("IP - Big Key Chest")
-- IP_sliding_switch_room:connect_two_ways(IP_big_key_room) --icebreaker
IP_boss_dropdown:connect_one_way(IP_boss_room, function(keys)
    if Tracker:FindObjectForCode("somaria").Active then
        return ALL(
            "hammer",
            "glove",
            Has("ip_smallkey", keys + 1, 2, keys + 1, 5)
        ), keys + 1
    else
        return ALL(
            "hammer",
            "glove",
            Has("ip_smallkey", keys + 1, 2, keys + 1, 6)
        ), keys + 1
    end
end)
IP_boss_dropdown:connect_one_way(IP_above_boss_dropdown)
IP_boss_room:connect_one_way("IP - Boss", function() return GetBossRef("ip_boss") end)
