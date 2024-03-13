gt_entrance = alttp_location.new()
local gt_bottom_bobs_torch = alttp_location.new()
local gt_bottom_hope_room = alttp_location.new()
local gt_bottom_big_chest_room = alttp_location.new()
local gt_bottom_above_ice_fight = alttp_location.new()
local gt_bottom_big_key_room = alttp_location.new()
local gt_bottom_conveyor_cross_room = alttp_location.new()
local gt_bottom_bonk_pit_room = alttp_location.new()
local gt_bottom_dm_room = alttp_location.new()
local gt_bottom_map_room = alttp_location.new()
local gt_bottom_double_switch_room = alttp_location.new()
local gt_bottom_firesneak_room = alttp_location.new()
local gt_bottom_randomizer_room = alttp_location.new()
local gt_bottom_teleporter_puzzle_room = alttp_location.new()
local gt_bottom_invisibile_bonk_room = alttp_location.new()
local gt_bottom_tile_room = alttp_location.new()
local gt_bottom_torch_puzzle = alttp_location.new()
local gt_bottom_compass_room = alttp_location.new()
local gt_bottom_conveyor_star_room = alttp_location.new()
local gt_bottom_ice_fight = alttp_location.new()
local gt_bottom_main_room = alttp_location.new()

local gt_top_entrance = alttp_location.new()
local gt_top_mini_helmasaur_room = alttp_location.new()
local gt_top_gauntlet = alttp_location.new()
local gt_top_pre_moldorm_room = alttp_location.new()
local gt_top_torch_puzzle = alttp_location.new()
local gt_top_top_refight = alttp_location.new()
local gt_top_desert_refight = alttp_location.new()
local gt_top_validation = alttp_location.new()
local gt_top_aga2 = alttp_location.new()

gt_access:connect_two_ways(gt_bottom_main_room)
gt_bottom_main_room:connect_two_ways(gt_bottom_bobs_torch)
gt_bottom_main_room:connect_two_ways(gt_bottom_hope_room)
gt_bottom_main_room:connect_two_ways(gt_top_entrance)

gt_bottom_bobs_torch:connect_two_ways(gt_bottom_conveyor_cross_room)
gt_bottom_bobs_torch:connect_two_ways(gt_bottom_hope_room)
gt_bottom_bobs_torch:connect_one_way("GT - ")

gt_bottom_conveyor_cross_room:connect_two_ways(gt_bottom_bonk_pit_room)
gt_bottom_conveyor_cross_room:connect_one_way("GT - ")

gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_dm_room)
gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_map_room)
gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_double_switch_room)

gt_bottom_dm_room:connect_one_way("GT - ")
gt_bottom_dm_room:connect_one_way("GT - ")
gt_bottom_dm_room:connect_one_way("GT - ")
gt_bottom_dm_room:connect_one_way("GT - ")

gt_bottom_map_room:connect_one_way("GT - ")

gt_bottom_double_switch_room:connect_two_ways(gt_bottom_firesneak_room)
gt_bottom_double_switch_room:connect_one_way("GT - ")

gt_bottom_firesneak_room:connect_two_ways(gt_bottom_teleporter_puzzle_room)
gt_bottom_firesneak_room:connect_one_way("GT - ")

gt_bottom_teleporter_puzzle_room:connect_two_ways(gt_bottom_randomizer_room)
gt_bottom_teleporter_puzzle_room:connect_two_ways(gt_bottom_invisibile_bonk_room)

gt_bottom_randomizer_room:connect_one_way("GT - ")
gt_bottom_randomizer_room:connect_one_way("GT - ")
gt_bottom_randomizer_room:connect_one_way("GT - ")
gt_bottom_randomizer_room:connect_one_way("GT - ")

gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_big_chest_room)
gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_above_ice_fight)

gt_bottom_big_chest_room:connect_one_way("GT - ")

gt_bottom_above_ice_fight:connect_one_way(gt_bottom_ice_fight)
gt_bottom_above_ice_fight:connect_one_way("GT - ")

gt_bottom_ice_fight:connect_two_ways(gt_bottom_big_key_room)
gt_bottom_ice_fight:connect_one_way(gt_bottom_big_chest_room)

gt_bottom_big_key_room:connect_one_way("GT - ")
gt_bottom_big_key_room:connect_one_way("GT - ")
gt_bottom_big_key_room:connect_one_way("GT - ")

gt_bottom_hope_room:connect_two_ways(gt_bottom_tile_room)
gt_bottom_hope_room:connect_one_way("GT - ")
gt_bottom_hope_room:connect_one_way("GT - ")

gt_bottom_tile_room:connect_two_ways(gt_bottom_torch_puzzle)
gt_bottom_tile_room:connect_one_way("GT - ")

gt_bottom_torch_puzzle:connect_one_way(gt_bottom_compass_room)

gt_bottom_compass_room:connect_one_way(gt_bottom_conveyor_star_room)
gt_bottom_compass_room:connect_one_way("GT - ")
gt_bottom_compass_room:connect_one_way("GT - ")
gt_bottom_compass_room:connect_one_way("GT - ")
gt_bottom_compass_room:connect_one_way("GT - ")

gt_bottom_conveyor_star_room:connect_one_way(gt_bottom_invisibile_bonk_room)
gt_bottom_conveyor_star_room:connect_one_way("GT - ")

gt_top_entrance:connect_two_ways(gt_top_gauntlet)
gt_top_gauntlet:connect_two_ways(gt_top_desert_refight)
gt_top_desert_refight:connect_two_ways(gt_top_torch_puzzle)
gt_top_torch_puzzle:connect_one_way(gt_top_mini_helmasaur_room)

gt_top_mini_helmasaur_room:connect_two_ways(gt_top_pre_moldorm_room)
gt_top_mini_helmasaur_room:connect_one_way("GT - ")
gt_top_mini_helmasaur_room:connect_one_way("GT - ")
gt_top_mini_helmasaur_room:connect_one_way("GT - ")

gt_top_pre_moldorm_room:connect_one_way(gt_top_top_refight)
gt_top_pre_moldorm_room:connect_one_way("GT - ")

gt_top_top_refight:connect_one_way(gt_top_validation)
gt_top_top_refight:connect_one_way("GT - ")
gt_top_validation:connect_one_way(gt_top_aga2)
