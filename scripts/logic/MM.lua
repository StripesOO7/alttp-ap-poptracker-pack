mm_entrance
local mm_main_room
local mm_big_chest_room
local mm_map_room_top
local mm_map_room_bottom
local mm_conveyor_crystal_room
local mm_compass_room
local mm_block_push
local mm_cutscene_room
local mm_big_key_chest
local mm_spike_room
local mm_fishbone_room
local mm_bridge_right
local mm_bridge_middle
local mm_big_key_door
local mm_hourlgas_room
local mm_teleporter_room
local mm_boss_room

mm_entrance:connect_two_ways(mm_main_room)
mm_main_room:connect_two_ways(mm_map_room_bottom)
mm_main_room:connect_two_ways(mm_conveyor_crystal_room)
mm_main_room:connect_two_ways(mm_block_push)
mm_main_room:connect_one_way("MM - Main Lobby Chest")

mm_map_room_bottom:connect_two_ways(mm_big_chest_room)

mm_big_chest_room:connect_one_way(mm_map_room_top)
mm_big_chest_room:connect_one_way("MM - Big Chest")

mm_map_room_top:connect_one_way(mm_map_room_bottom)
mm_map_room_top:connect_two_ways(mm_spike_room)
mm_map_room_top:connect_one_way("MM - Map Chest")

mm_block_push:connect_two_ways(mm_bridge_right)
mm_block_push:connect_two_ways(mm_spike_room)

mm_bridge_right:connect_one_way("MM - Bridge Chest")

mm_spike_room:connect_two_ways(mm_big_key_door)
mm_spike_room:connect_two_ways(mm_fishbone_room)
mm_spike_room:connect_one_way("MM - Spike Chest")
mm_spike_room:connect_one_way("MM - Spike Key Drop")

mm_fishbone_room:connect_one_way(mm_hourlgas_room)
mm_fishbone_room:connect_one_way("MM - Fishbone Key Drop")

mm_hourlgas_room:connect_two_ways(mm_main_room)
mm_hourlgas_room:connect_two_ways(mm_teleporter_room)

mm_conveyor_crystal_room:connect_two_ways(mm_compass_room)
mm_conveyor_crystal_room:connect_two_ways(mm_cutscene_room)
mm_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Key Drop")

mm_compass_room:connect_two_ways(mm_main_room)
mm_compass_room:connect_one_way("MM - Comapss Chest")

mm_cutscene_room:connect_one_way(mm_big_key_chest)

mm_big_key_chest:connect_one_way(mm_hourlgas_room)
mm_big_key_chest:connect_one_way("MM - Big Key Chest")

mm_teleporter_room:connect_one_way(mm_big_key_door)

mm_big_key_door:connect_two_ways(mm_bridge_middle) 
mm_bridge_middle:connect_two_ways(mm_boss_room) 

mm_boss_room:connect_one_way("MM - Boss")