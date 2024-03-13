hc_main_entrance
hc_left_entrance
hc_right_entrance
local hc_back_hall
local hc_map_chest_room
local hc_boomerang_chest_room
local hc_ball_guard_room
local hc_zeldas_cell
ce_entrance
ce_dropdown_entrance
local ce_dark_cross
local ce_rat_key_room
local ce_secret_room

hc_main_entrance:connect_two_ways(hc_left_entrance)
hc_main_entrance:connect_two_ways(hc_right_entrance)
hc_main_entrance:connect_one_way(ce_entrance)

hc_left_entrance:connect_two_ways(hc_back_hall)
hc_right_entrance:connect_two_ways(hc_back_hall)

hc_back_hall:connect_two_ways(hc_map_chest_room)
hc_map_chest_room:connect_one_way("HC - Map Chest")
hc_map_chest_room:connect_one_way("HC - Map Guard Key Drop")

hc_map_chest_room:connect_two_ways(hc_boomerang_chest_room)
hc_boomerang_chest_room:connect_one_way("HC - Boomerang Chest")
hc_boomerang_chest_room:connect_one_way("HC - Booomerang Guard Key Drop")

dp_map_chest_room:connect_two_ways(hc_ball_guard_room)
hc_ball_guard_room:connect_one_way("HC - Big Key")

hc_ball_guard_room:connect_two_ways(hc_zeldas_cell)
hc_zeldas_cell:connect_one_way("HC - Zelda's Chest")

ce_entrance:connect_two_ways(ce_dark_cross)

ce_dark_cross:connect_two_ways(ce_rat_key_room)
ce_dark_cross:connect_one_way("CE - Dark sross")

ce_rat_key_room:connect_two_ways(ce_dropdown_entrance)
ce_rat_key_room:connect_one_way("CE - Rat Key Drop")

ce_dropdown_entrance:connect_two_ways(ce_secret_room)
ce_secret_room:connect_one_way("CE - Secret Room Left")
ce_secret_room:connect_one_way("CE - Secret Room Center")
ce_secret_room:connect_one_way("CE - Secret Room Right")

ce_dropdown_entrance:connect_one_way(sanctuary)