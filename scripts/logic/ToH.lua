toh_entrance
local toh_basement_cage
local toh_big_key_chest
local toh_big_chest_room
local toh_boss_room
local toh_above_big_chest


toh_entrance:connect_two_ways(toh_basement_cage)
toh_entrance:connect_two_ways(toh_big_key_chest)
toh_entrance:connect_two_ways(toh_big_chest_room)
toh_entrance:connect_one_way("ToH - Map Chest")

toh_basement_cage:connect_one_way("ToH - Basement Cage")
toh_big_key_chest:connect_one_way("ToH - Big Key Chest")

toh_big_chest_room:connect_two_ways(toh_above_big_chest)
toh_big_chest_room:connect_one_way("ToH - Compass Chest")

toh_above_big_chest:connect_two_ways(toh_boss_room)
toh_above_big_chest:connect_one_way("ToH - Big Chest")

toh_boss_room:connect_one_way("ToH - Boss")