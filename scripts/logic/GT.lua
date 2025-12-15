-- gt_entrance = alttp_location.new("", nil, nil, true)
local gt_bottom_bobs_torch = alttp_location.new("gt_bottom_bobs_torch", "GT Torch", nil, true)
local gt_bottom_hope_room = alttp_location.new("gt_bottom_hope_room", "GT Hope", nil, true)
local gt_bottom_big_chest_room = alttp_location.new("gt_bottom_big_chest_room", "GT Big Chest", nil, true)
local gt_bottom_above_ice_fight = alttp_location.new("gt_bottom_above_ice_fight", "GT Above Ice", nil, true)
local gt_bottom_big_key_room = alttp_location.new("gt_bottom_big_key_room", "GT Big Key", nil, true)
local gt_bottom_conveyor_cross_room = alttp_location.new("gt_bottom_conveyor_cross_room", "GT Conveyor Cross", nil, true)
local gt_bottom_bonk_pit_room = alttp_location.new("gt_bottom_bonk_pit_room", "GT Bonk Pit Room", nil, true)
local gt_bottom_bonk_pit_room_bottom = alttp_location.new("gt_bottom_bonk_pit_room_bottom", "GT Bonk Pit Bottom", nil, true)
local gt_bottom_dm_room = alttp_location.new("gt_bottom_dm_room", "GT DM Room", nil, true)
local gt_bottom_map_room = alttp_location.new("gt_bottom_map_room", "GT Map Room", nil, true)
local gt_bottom_double_switch_room = alttp_location.new("gt_bottom_double_switch_room", "GT Double Switch", nil, true)
local gt_bottom_firesnake_room = alttp_location.new("gt_bottom_firesnake_room", "GT Firesneak", nil, true)
local gt_bottom_randomizer_room = alttp_location.new("gt_bottom_randomizer_room", "GT Randomizer Room", nil, true)
local gt_bottom_teleporter_puzzle_room = alttp_location.new("gt_bottom_teleporter_puzzle_room", "GT Teleporter Puzzle", nil, true)
local gt_bottom_invisibile_bonk_room = alttp_location.new("gt_bottom_invisibile_bonk_room", "GT Invis. Path", nil, true)
local gt_bottom_tile_room = alttp_location.new("gt_bottom_tile_room", "GT Tile Room", nil, true)
local gt_bottom_torch_puzzle = alttp_location.new("gt_bottom_torch_puzzle", "GT Torches", nil, true)
local gt_bottom_compass_room = alttp_location.new("gt_bottom_compass_room", "GT Compass", nil, true)
local gt_bottom_conveyor_star_room = alttp_location.new("gt_bottom_conveyor_star_room", "GT Conveyor Star", nil, true)
local gt_bottom_ice_fight = alttp_location.new("gt_bottom_ice_fight", "GT Ice Refight", nil, true)
local gt_bottom_main_room = alttp_location.new("gt_bottom_main_room", "GT Main Lobby", nil, true)

local gt_top_entrance = alttp_location.new("gt_top_entrance", "GT-Top Entrance", nil, true)
local gt_top_mini_helmasaur_room = alttp_location.new("gt_top_mini_helmasaur_room", "GT-Top Mini Hemlas", nil, true)
local gt_top_gauntlet = alttp_location.new("gt_top_gauntlet", "GT-Top Gauntlet", nil, true)
local gt_top_pre_moldorm_room = alttp_location.new("gt_top_pre_moldorm_room", "GT-Top Pre-Moldorm", nil, true)
local gt_top_torch_puzzle = alttp_location.new("gt_top_torch_puzzle", "GT-Top Torch Puzzle", nil, true)
local gt_top_top_refight = alttp_location.new("gt_top_top_refight", "GT-Top Moldorm Refight", nil, true)
local gt_top_desert_refight = alttp_location.new("gt_top_desert_refight", "GT-Top Lanmo Refight", nil, true)
local gt_top_validation = alttp_location.new("gt_top_validation", "GT-Top Validation", nil, true)
local gt_top_aga2 = alttp_location.new("gt_top_aga2", "GT-Top Aga2 Arena", nil, true)

gt_entrance_inside:connect_two_ways(gt_bottom_main_room, function() 
    return ALL(
        CanInteract(gt_entrance_inside), 
        OpenOrStandard
    )
end)
gt_entrance_inside:connect_two_ways(gt_bottom_main_room, function() 
    return ALL(
        CanInteract(gt_entrance_inside), 
        Inverted
    )
end)
gt_bottom_main_room:connect_two_ways(gt_bottom_bobs_torch)
gt_bottom_main_room:connect_two_ways(gt_bottom_hope_room)
gt_bottom_main_room:connect_two_ways(gt_top_entrance)

gt_bottom_bobs_torch:connect_two_ways(gt_bottom_conveyor_cross_room)
-- gt_bottom_bobs_torch:connect_two_ways(gt_bottom_hope_room)--, function(keys) return Has("gt_smallkey", keys + 1, 4, keys + 1, 6), KDSreturn(keys+1, keys+1) end)
gt_bottom_bobs_torch:connect_two_ways(gt_bottom_hope_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7), keys + 1 end)
gt_bottom_bobs_torch:connect_one_way("GT - Bob's Torch", function()
    return ANY(
        ALL(
            "boots",
            CanInteract(gt_bottom_bobs_torch)
        ),
        ACCESS_INSPECT
    )
end)

gt_bottom_conveyor_cross_room:connect_two_ways(gt_bottom_bonk_pit_room, function() return Has("hammer") end)
gt_bottom_conveyor_cross_room:connect_one_way("GT - Conveyor Cross Key Drop")

gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_dm_room, function() return Has("hookshot") end)

gt_bottom_bonk_pit_room:connect_two_ways(gt_bottom_bonk_pit_room_bottom, function()
    return ANY(
        "hookshot",
        "boots"
    )
end)

gt_bottom_bonk_pit_room_bottom:connect_two_ways(gt_bottom_double_switch_room, function() return DealDamage() end)
gt_bottom_bonk_pit_room_bottom:connect_two_ways(gt_bottom_map_room, function(keys)
    return ALL(
        Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8)
    ), KDSreturn(keys, keys + 1)
end)

gt_bottom_dm_room:connect_one_way("GT - DM Room Top Left")
gt_bottom_dm_room:connect_one_way("GT - DM Room Top Right")
gt_bottom_dm_room:connect_one_way("GT - DM Room Bottom Left")
gt_bottom_dm_room:connect_one_way("GT - DM Room Bottom Right")

gt_bottom_map_room:connect_one_way("GT - Map Chest")

gt_bottom_double_switch_room:connect_two_ways(gt_bottom_firesnake_room, function(keys)
    return ALL(
        ANY(
            "bombs",
            "somaria",
            ALL(
                "boomerangs",
                ANY(
                    "boots",
                    "hookshot"
                )
            )
        ),
        Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 3, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 5)
    ), KDSreturn(keys, keys + 1) end)
gt_bottom_double_switch_room:connect_one_way("GT - Double Switch Pot Key")--, function() ret
--     return ANY(
--         "boots",
--         "hookshot"
--     )
-- end)

gt_bottom_firesnake_room:connect_two_ways(gt_bottom_teleporter_puzzle_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8), keys + 1 end)
gt_bottom_firesnake_room:connect_one_way("GT - Firesnake Room")

gt_bottom_teleporter_puzzle_room:connect_two_ways(gt_bottom_randomizer_room, function() return ALL("bombs", CanInteract(gt_bottom_teleporter_puzzle_room)) end)
gt_bottom_teleporter_puzzle_room:connect_one_way(gt_bottom_invisibile_bonk_room)

gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Left")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Right")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Left")
gt_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Right")

gt_bottom_hope_room:connect_two_ways(gt_bottom_tile_room, function() return ALL("somaria",CanInteract(gt_bottom_hope_room)) end)
gt_bottom_hope_room:connect_one_way("GT - Hope Room Left", function() return CanInteract(gt_bottom_hope_room) end)
gt_bottom_hope_room:connect_one_way("GT - Hope Room Right", function() return CanInteract(gt_bottom_hope_room) end)

gt_bottom_tile_room:connect_two_ways(gt_bottom_torch_puzzle, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 3, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7), keys + 1 end)
gt_bottom_tile_room:connect_one_way("GT - Tile Room Chest")

gt_bottom_torch_puzzle:connect_one_way(gt_bottom_compass_room, function()
    return ALL(
        "firerod",
        ANY(
            "bombs",
            "somaria"
        )
    )
end)

gt_bottom_compass_room:connect_one_way(gt_bottom_conveyor_star_room)
gt_bottom_compass_room:connect_one_way("GT - Compass Room Top Left")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Top Right")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Left")
gt_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Right")

gt_bottom_conveyor_star_room:connect_one_way(gt_bottom_invisibile_bonk_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8), KDSreturn(keys, keys + 1) end)
gt_bottom_conveyor_star_room:connect_one_way("GT - Conveyor Star Key Drop")

gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_big_chest_room)
gt_bottom_invisibile_bonk_room:connect_two_ways(gt_bottom_above_ice_fight)

gt_bottom_big_chest_room:connect_one_way("GT - Big Chest", function() return Has("gt_bigkey") end)

gt_bottom_above_ice_fight:connect_one_way(gt_bottom_ice_fight, function() return Has("bombs") end)
gt_bottom_above_ice_fight:connect_one_way("GT - Bob's Chest")

gt_bottom_ice_fight:connect_two_ways(gt_bottom_big_key_room, function() return GetBossRef("gt_ice") end)
gt_bottom_ice_fight:connect_one_way(gt_bottom_big_chest_room, function() return GetBossRef("gt_ice") end)

gt_bottom_big_key_room:connect_one_way("GT - Big Key Chest")
gt_bottom_big_key_room:connect_one_way("GT - Big Key Room Left")
gt_bottom_big_key_room:connect_one_way("GT - Big Key Room Right")

gt_top_entrance:connect_two_ways(gt_top_gauntlet, function()
    return ALL(
        "gt_bigkey",
        EnemizerCheck("bow"),
        CanInteract(gt_top_entrance)
    )
end)
gt_top_gauntlet:connect_two_ways(gt_top_desert_refight, function() return GetBossRef("gt_lanmo") end)
gt_top_desert_refight:connect_two_ways(gt_top_torch_puzzle)
gt_top_torch_puzzle:connect_one_way(gt_top_mini_helmasaur_room, function() return Has("firesource") end)

gt_top_mini_helmasaur_room:connect_two_ways(gt_top_pre_moldorm_room, function(keys)
    return ALL(
        Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 3, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7),
        "bombs"
    ), KDSreturn(keys + 0 , keys + 1 )
end)
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Left")
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Right")
gt_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Key Drop")

gt_top_pre_moldorm_room:connect_one_way(gt_top_top_refight, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key"), 8), keys + 1 end)
gt_top_pre_moldorm_room:connect_one_way("GT - Pre Moldorm Chest")

gt_top_top_refight:connect_one_way(gt_top_validation, function() return ALL(
        GetBossRef("gt_boss"),
        "hookshot"
    )
end)
gt_top_validation:connect_one_way("GT - Validation Chest")
gt_top_validation:connect_one_way(gt_top_aga2)
gt_top_aga2:connect_one_way("GT - Aga2", function()
    return ANY(
        "sword",
        "hammer",
        "bug_net"
    )
end)