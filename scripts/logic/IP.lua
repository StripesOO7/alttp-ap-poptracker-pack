ip_entrance
local ip_freezor_entrance
local ip_jelly_room
local ip_push_cross
local ip_bomb_dropdown
local ip_sliding_switch_room
local ip_compass_room
local ip_conveyor_room
local ip_map_room
local ip_spliding_penguins
local ip_cross
local ip_falling_floor
local ip_sliding_firebar
local ip_ice_hallway
local ip_hookshot_pit
local ip_big_spikeballs
local ip_spike_room
local ip_big_key_room
local ip_freezor_room
local ip_big_chest_room
local ip_many_pots_room
local ip_iced_t_room
local ip_above_boss_dropdown
local ip_boss_dropdown
local ip_boss_room

ip_entrance:connect_two_ways(ip_freezor_entrance)
ip_freezor_entrance:connect_two_ways(ip_jelly_room, function() 
    return any(
        has("fireros"), 
        has("bombos")
    ) 
end)
ip_jelly_room:connect_two_ways(ip_push_cross, function(keys) return has("ip_smallkey", keys + 1, 0, 0, keys + 1, 1, 1) end)
ip_jelly_room:connect_one_way("IP - Jelly Key Drop")
ip_push_cross:connect_two_ways(ip_bomb_dropdown)
ip_push_cross:connect_two_ways(ip_sliding_switch_room)
ip_push_cross:connect_two_ways(ip_compass_room)
ip_compass_room:connect_one_way("IP - Compass Chest")
ip_bomb_dropdown:connect_one_way(ip_conveyor_room, function() return has("bombs") end)

ip_conveyor_room:connect_two_ways(ip_spliding_penguins, function(keys) return has("ip_smallkey", keys + 1, 0, 0, keys + 1, 2, 2) end)
ip_conveyor_room::connect_one_way("IP - Conveyor Key Drop")
ip_spliding_penguins:connect_two_ways(ip_cross)
ip_cross:connect_two_ways(ip_falling_floor)
ip_cross:connect_two_ways(ip_spike_room)
ip_cross:connect_two_ways(ip_sliding_firebar)

ip_sliding_firebar:connect_two_ways(ip_freezor_room)
ip_falling_floor:connect_one_way(ip_boss_dropdown)

ip_freezor_room:connect_one_way(ip_big_chest_room)
ip_freezor_room:connect_one_way("IP - Freezor Chest")
ip_big_chest_room:connect_two_ways(ip_above_boss_dropdown)
ip_big_chest_room:connect_one_way("IP - Big Chest")
ip_above_boss_dropdown:connect_one_way(ip_boss_dropdown)
ip_above_boss_dropdown:connect_two_ways(ip_many_pots_room)

ip_many_pots_room:connect_two_ways(ip_iced_t_room)
ip_many_pots_room:connect_one_way("IP - Many Pots Key Drop")
ip_iced_t_room:connect_two_ways(ip_ice_hallway)
ip_iced_t_room:connect_one_way("IP - Iced T Chest")
-- ip_ice_hallway:connect_one_way(ip_freezor_room)
ip_ice_hallway:connect_one_way(ip_big_chest_room)
ip_ice_hallway:connect_two_ways(ip_hookshot_pit)
ip_hookshot_pit:connect_one_way(ip_big_spikeballs)
ip_big_spikeballs:connect_two_ways(ip_spike_room)

ip_spike_room:connect_two_ways(ip_map_room)
ip_spike_room:connect_one_way("IP - Spike Chest")
ip_map_room:connect_two_ways(ip_big_key_room)
ip_map_room:connect_one_way("IP - Map Chest")
ip_map_room:connect_one_way("IP - Hammer Block Key Drop")

ip_sliding_switch_room:connect_two_ways(ip_big_key_room, function() 
    return all(
        has("somaria"),
        checkGlitches(2)
    ) 
end)
ip_big_key_room:connect_one_way(ip_sliding_switch_room)
ip_big_key_room:connect_one_way("IP - Big Key Chest")
-- ip_sliding_switch_room:connect_two_ways(ip_big_key_room) --icebreaker
ip_boss_dropdown:connect_one_way(ip_boss_room)
ip_boss_room:connect_one_way("IP - Boss")
