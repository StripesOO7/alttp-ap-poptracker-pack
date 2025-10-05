-- ip_entrance = alttp_location.new("")
local ip_freezor_entrance = alttp_location.new("ip_freezor_entrance")
local ip_jelly_room = alttp_location.new("ip_jelly_room")
local ip_push_cross = alttp_location.new("ip_push_cross")
local ip_bomb_dropdown = alttp_location.new("ip_bomb_dropdown")
local ip_sliding_switch_room = alttp_location.new("ip_sliding_switch_room")
local ip_compass_room = alttp_location.new("ip_compass_room")
local ip_conveyor_room = alttp_location.new("ip_conveyor_room")
local ip_map_room = alttp_location.new("ip_map_room")
local ip_sliding_penguins = alttp_location.new("ip_sliding_penguins")
local ip_cross = alttp_location.new("ip_cross")
local ip_falling_floor = alttp_location.new("ip_falling_floor")
local ip_sliding_firebar = alttp_location.new("ip_sliding_firebar")
local ip_ice_hallway = alttp_location.new("ip_ice_hallway")
local ip_hookshot_pit = alttp_location.new("ip_hookshot_pit")
local ip_big_spikeballs = alttp_location.new("ip_big_spikeballs")
local ip_spike_room = alttp_location.new("ip_spike_room")
local ip_big_key_room = alttp_location.new("ip_big_key_room")
local ip_freezor_room = alttp_location.new("ip_freezor_room")
local ip_big_chest_room = alttp_location.new("ip_big_chest_room")
local ip_many_pots_room = alttp_location.new("ip_many_pots_room")
local ip_iced_t_room = alttp_location.new("ip_iced_t_room")
local ip_above_boss_dropdown = alttp_location.new("ip_above_boss_dropdown")
local ip_boss_dropdown = alttp_location.new("ip_boss_dropdown")
local ip_boss_room = alttp_location.new("ip_boss_room")

ip_entrance_inside:connect_two_ways(ip_freezor_entrance, function() return Can_interact(ip_entrance_inside.worldstate, 1) end)
ip_freezor_entrance:connect_two_ways(ip_jelly_room, function()
    return ANY(
        "firerod",
        ALL(
            "bombos",
            CanUseMedallions
        )
    )
end)
ip_jelly_room:connect_two_ways(ip_push_cross, function(keys) return Has("ip_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1) end)
ip_jelly_room:connect_one_way("IP - Jelly Key Drop", DealDamage)
ip_push_cross:connect_two_ways(ip_bomb_dropdown)
ip_push_cross:connect_two_ways(ip_sliding_switch_room)
ip_push_cross:connect_two_ways(ip_compass_room)
ip_compass_room:connect_one_way("IP - Compass Chest", DealDamage)
ip_bomb_dropdown:connect_one_way(ip_conveyor_room, function() return Has("bombs") end)

ip_conveyor_room:connect_two_ways(ip_sliding_penguins, function(keys) return Has("ip_smallkey", keys, 0, keys + 1, 2), KDSreturn(keys, keys + 1) end)
ip_conveyor_room:connect_one_way("IP - Conveyor Key Drop", DealDamage)
ip_sliding_penguins:connect_two_ways(ip_cross, DealDamage)
ip_cross:connect_two_ways(ip_falling_floor)
ip_cross:connect_two_ways(ip_spike_room, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 4), KDSreturn(keys + 1, keys + 1)
    else
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 6), KDSreturn(keys + 1, keys + 1)
    end
end)
ip_cross:connect_two_ways(ip_sliding_firebar)

ip_sliding_firebar:connect_two_ways(ip_freezor_room)
ip_falling_floor:connect_one_way(ip_ice_hallway)

ip_freezor_room:connect_one_way(ip_big_chest_room)
ip_freezor_room:connect_one_way("IP - Freezor Chest", function()
    return ANY(
        "firerod",
        ALL(
            "bombos",
            CanUseMedallions
        )
    )
end)
ip_big_chest_room:connect_two_ways(ip_above_boss_dropdown)
ip_big_chest_room:connect_one_way("IP - Big Chest", function()
    return ALL(
        "ip_bigkey",
        ANY(
            "bombs",
            "hookshot"
        )
    )
end)
ip_above_boss_dropdown:connect_one_way(ip_boss_dropdown, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return ALL(
            Has("ip_smallkey", keys + 1, 2, keys + 1, 5),
            "ip_bigkey"
        ), KDSreturn(keys + 1, keys + 1)
    else
        return ALL(
            Has("ip_smallkey", keys + 1, 2, keys + 1, 6),
            "ip_bigkey"
        ), KDSreturn(keys + 1, keys + 1)
    end
end)
ip_above_boss_dropdown:connect_two_ways(ip_many_pots_room)

ip_many_pots_room:connect_two_ways(ip_iced_t_room)
ip_many_pots_room:connect_one_way("IP - Many Pots Key Drop")
ip_iced_t_room:connect_two_ways(ip_ice_hallway, function(keys)
    if Tracker:FindObjectForCode("hookshot").Active then
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 4), KDSreturn(keys + 1, keys + 1)
    else
        return Has("ip_smallkey", keys + 1, 2, keys + 1, 6), KDSreturn(keys + 1, keys + 1)
    end
end)
ip_iced_t_room:connect_one_way("IP - Iced T Chest")
-- ip_ice_hallway:connect_one_way(ip_freezor_room)
ip_ice_hallway:connect_one_way(ip_big_chest_room)
ip_ice_hallway:connect_two_ways(ip_hookshot_pit)
ip_hookshot_pit:connect_one_way(ip_big_spikeballs, function() return Has("hookshot") end)
ip_big_spikeballs:connect_two_ways(ip_spike_room)

ip_spike_room:connect_two_ways(ip_map_room)
ip_spike_room:connect_one_way("IP - Spike Chest")
ip_map_room:connect_two_ways(ip_big_key_room, function()
    return ALL(
        "hammer",
        "glove"
    )
end)
ip_map_room:connect_one_way("IP - Map Chest", function()
    return ALL(
        "hammer",
        "glove"
    )
end)
ip_map_room:connect_one_way("IP - Hammer Block Key Drop", function()
    return ALL(
        "hammer",
        "glove"
    )
end)

ip_sliding_switch_room:connect_two_ways(ip_big_key_room, function()
    return ALL(
        "somaria",
        CheckGlitches(2)
    )
end)
-- ip_big_key_room:connect_one_way(ip_big_key_room)
ip_big_key_room:connect_one_way(ip_sliding_switch_room)
ip_big_key_room:connect_one_way("IP - Big Key Chest")
-- ip_sliding_switch_room:connect_two_ways(ip_big_key_room) --icebreaker
ip_boss_dropdown:connect_one_way(ip_boss_room, function(keys)
    if Tracker:FindObjectForCode("somaria").Active then
        return ALL(
            "hammer",
            "glove",
            Has("ip_smallkey", keys + 1, 2, keys + 1, 5)
        ), KDSreturn(keys + 1, keys + 1)
    else
        return ALL(
            "hammer",
            "glove",
            Has("ip_smallkey", keys + 1, 2, keys + 1, 6)
        ), KDSreturn(keys + 1, keys + 1)
    end
end)
ip_boss_dropdown:connect_one_way(ip_above_boss_dropdown)
ip_boss_room:connect_one_way("IP - Boss", function() return GetBossRef("ip_boss") end)
