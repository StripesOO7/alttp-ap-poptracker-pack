-- gt_entrance = alttp_location.new("")
local gt_bottom_bobs_torch = alttp_location.new("gt_bottom_bobs_torch")
local gt_bottom_hope_room = alttp_location.new("gt_bottom_hope_room")
local gt_bottom_big_chest_room = alttp_location.new("gt_bottom_big_chest_room")
local gt_bottom_above_ice_fight = alttp_location.new("gt_bottom_above_ice_fight")
local gt_bottom_big_key_room = alttp_location.new("gt_bottom_big_key_room")
local gt_bottom_conveyor_cross_room = alttp_location.new("gt_bottom_conveyor_cross_room")
local gt_bottom_bonk_pit_room = alttp_location.new("gt_bottom_bonk_pit_room")
local gt_bottom_dm_room = alttp_location.new("gt_bottom_dm_room")
local gt_bottom_map_room = alttp_location.new("gt_bottom_map_room")
local gt_bottom_double_switch_room = alttp_location.new("gt_bottom_double_switch_room")
local gt_bottom_firesnake_room = alttp_location.new("gt_bottom_firesnake_room")
local gt_bottom_randomizer_room = alttp_location.new("gt_bottom_randomizer_room")
local gt_bottom_teleporter_puzzle_room = alttp_location.new("gt_bottom_teleporter_puzzle_room")
local gt_bottom_invisibile_bonk_room = alttp_location.new("gt_bottom_invisibile_bonk_room")
local gt_bottom_tile_room = alttp_location.new("gt_bottom_tile_room")
local gt_bottom_torch_puzzle = alttp_location.new("gt_bottom_torch_puzzle")
local gt_bottom_compass_room = alttp_location.new("gt_bottom_compass_room")
local gt_bottom_conveyor_star_room = alttp_location.new("gt_bottom_conveyor_star_room")
local gt_bottom_ice_fight = alttp_location.new("gt_bottom_ice_fight")
local gt_bottom_main_room = alttp_location.new("gt_bottom_main_room")

local gt_top_entrance = alttp_location.new("gt_top_entrance")
local gt_top_mini_helmasaur_room = alttp_location.new("gt_top_mini_helmasaur_room")
local gt_top_gauntlet = alttp_location.new("gt_top_gauntlet")
local gt_top_pre_moldorm_room = alttp_location.new("gt_top_pre_moldorm_room")
local gt_top_torch_puzzle = alttp_location.new("gt_top_torch_puzzle")
local gt_top_top_refight = alttp_location.new("gt_top_top_refight")
local gt_top_desert_refight = alttp_location.new("gt_top_desert_refight")
local gt_top_validation = alttp_location.new("gt_top_validation")
local gt_top_aga2 = alttp_location.new("gt_top_aga2")

gt_entrance:connect_two_ways(gt_bottom_main_room, function() return all(can_interact("dark", 1), openOrStandard()) end)
gt_entrance:connect_two_ways(gt_bottom_main_room, function() return all(can_interact("light", 1), inverted()) end)
gt_bottom_main_room:connect_two_ways(gt_bottom_bobs_torch)
gt_bottom_main_room:connect_two_ways(gt_bottom_hope_room, function(keys) return has("gt_smallkey", keys + 1, 4, keys + 1, 6), KDSreturn(keys + 1, keys + 1) end)
gt_bottom_main_room:connect_two_ways(gt_top_entrance)

gt_bottom_bobs_torch:connect_two_ways(gt_bottom_conveyor_cross_room)
gt_bottom_bobs_torch:connect_two_ways(gt_bottom_hope_room)
gt_bottom_bobs_torch:connect_one_way("GT - Bob's Torch", function() 
    return any(
        has("boots"),
        AccessibilityLevel.Inspect
    ) 
end)

gt_bottom_conveyor_cross_room:connect_two_ways(gt_bottom_bonk_pit_room, function() return has("hammer") end)
gt_bottom_conveyor_cross_room:connect_one_way("GT - Conveyor Cross Key Drop")

gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_dm_room, function() return has("hookshot") end)
gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_map_room, function(keys) 
    return all(
        has("hookshot"),
        has("gt_smallkey", keys, 3, keys + 1, 5)
    ), KDSreturn(keys, keys + 1) 
end)
gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_double_switch_room, function() return has("hookshot") end)

gt_bottom_dm_room:connect_one_way("GT - DM Room Top Left")
gt_bottom_dm_room:connect_one_way("GT - DM Room Top Right")
gt_bottom_dm_room:connect_one_way("GT - DM Room Bottom Left")
gt_bottom_dm_room:connect_one_way("GT - DM Room Bottom Right")

gt_bottom_map_room:connect_one_way("GT - Map Chest")

gt_bottom_double_switch_room:connect_two_ways(gt_bottom_firesnake_room, function(keys) return has("gt_smallkey", keys, 3, keys + 1, 5), KDSreturn(keys, keys + 1) end)
gt_bottom_double_switch_room:connect_one_way("GT - Double Switch Pot Key")--, function() ret
--     return any(
--         has("boots"), 
--         has("hookshot")
--     )
-- end)

gt_bottom_firesnake_room:connect_two_ways(gt_bottom_teleporter_puzzle_room, function(keys) return has("gt_smallkey", keys + 1, 3, keys + 1, 5), KDSreturn(keys + 1, keys + 1) end)
gt_bottom_firesnake_room:connect_one_way("GT - Firesnake Room")

gt_bottom_teleporter_puzzle_room:connect_two_ways(gt_bottom_randomizer_room, function() return has("bombs") end)
gt_bottom_teleporter_puzzle_room:connect_one_way(gt_bottom_invisibile_bonk_room)

gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Left")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Right")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Left")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Right")

gt_bottom_hope_room:connect_two_ways(gt_bottom_tile_room, function() return has("somaria") end)
gt_bottom_hope_room:connect_one_way("GT - Hope Room Left")
gt_bottom_hope_room:connect_one_way("GT - Hope Room Right")

gt_bottom_tile_room:connect_two_ways(gt_bottom_torch_puzzle, function(keys) return has("gt_smallkey", keys + 1, 2, keys + 1, 4), KDSreturn(keys + 1, keys + 1) end)
gt_bottom_tile_room:connect_one_way("GT - Tile Room Chest")

gt_bottom_torch_puzzle:connect_one_way(gt_bottom_compass_room, function() 
    return all(
        has("firerod"),
        any(
            has("bombs"),
            has("somaria")
        )
    ) 
end)

gt_bottom_compass_room:connect_one_way(gt_bottom_conveyor_star_room)
gt_bottom_compass_room:connect_one_way("GT - Compass Room Top Left")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Top Right")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Left")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Right")

gt_bottom_conveyor_star_room:connect_one_way(gt_bottom_invisibile_bonk_room, function(keys) return has("gt_smallkey", keys + 1, 2, keys + 1, 5), KDSreturn(keys + 1, keys + 1) end)
gt_bottom_conveyor_star_room:connect_one_way("GT - Conveyor Star Key Drop")

gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_big_chest_room)
gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_above_ice_fight)

gt_bottom_big_chest_room:connect_one_way("GT - Big Chest", function() return has("gt_bigkey") end)

gt_bottom_above_ice_fight:connect_one_way(gt_bottom_ice_fight, function() return has("bombs") end)
gt_bottom_above_ice_fight:connect_one_way("GT - Bob's Chest")

gt_bottom_ice_fight:connect_two_ways(gt_bottom_big_key_room, function() return getBossRef("gt_ice") end)
gt_bottom_ice_fight:connect_one_way(gt_bottom_big_chest_room, function() return getBossRef("gt_ice") end)

gt_bottom_big_key_room:connect_one_way("GT - Big Key Chest")
gt_bottom_big_key_room:connect_one_way("GT - Big Key Room Left")
gt_bottom_big_key_room:connect_one_way("GT - Big Key Room Right")

gt_top_entrance:connect_two_ways(gt_top_gauntlet, function() 
    return all(
        has("gt_bigkey"), 
        enemizerCheck("bow")
    ) 
end)
gt_top_gauntlet:connect_two_ways(gt_top_desert_refight, function() return getBossRef("gt_lanmo") end)
gt_top_desert_refight:connect_two_ways(gt_top_torch_puzzle)
gt_top_torch_puzzle:connect_one_way(gt_top_mini_helmasaur_room, function() return has("firesource") end)

gt_top_mini_helmasaur_room:connect_two_ways(gt_top_pre_moldorm_room, function(keys) 
    return all(
        has("gt_smallkey", keys, 3, keys + 1, 6),
        has("bombs")
    ), KDSreturn(keys, keys + 1)
end)
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Left")
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Right")
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Key Drop")

gt_top_pre_moldorm_room:connect_one_way(gt_top_top_refight, function(keys) return has("gt_smallkey", keys + 1, 4, keys + 1, 7), KDSreturn(keys + 1, keys + 1) end)
gt_top_pre_moldorm_room:connect_one_way("GT - Pre Moldorm Chest")

gt_top_top_refight:connect_one_way(gt_top_validation, function() return all(
        getBossRef("gt_boss"), 
        has("hookshot")
    )
end)
gt_top_validation:connect_one_way("GT - Validation Chest")
gt_top_validation:connect_one_way(gt_top_aga2)
gt_top_aga2:connect_one_way("GT - Aga2", function() 
    return any(
        has("sword"),
        has("hammer"),
        has("bug_net")
    ) 
end)
