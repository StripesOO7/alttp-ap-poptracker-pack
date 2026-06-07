-- GT_entrance = alttp_location.new("", nil, nil, "GT", true)
local GT_bottom_bobs_torch = alttp_location.new("GT_bottom_bobs_torch", "GT Torch", nil, "GT", true)
local GT_bottom_hope_room = alttp_location.new("GT_bottom_hope_room", "GT Hope", nil, "GT", true)
local GT_bottom_big_chest_room = alttp_location.new("GT_bottom_big_chest_room", "GT Big Chest", nil, "GT", true)
local GT_bottom_above_ice_fight = alttp_location.new("GT_bottom_above_ice_fight", "GT Above Ice", nil, "GT", true)
local GT_bottom_big_key_room = alttp_location.new("GT_bottom_big_key_room", "GT Big Key", nil, "GT", true)
local GT_bottom_conveyor_cross_room = alttp_location.new("GT_bottom_conveyor_cross_room", "GT Conveyor Cross", nil, "GT", true)
local GT_bottom_bonk_pit_room = alttp_location.new("GT_bottom_bonk_pit_room", "GT Bonk Pit Room", nil, "GT", true)
local GT_bottom_bonk_pit_room_bottom = alttp_location.new("GT_bottom_bonk_pit_room_bottom", "GT Bonk Pit Bottom", nil, "GT", true)
local GT_bottom_dm_room = alttp_location.new("GT_bottom_dm_room", "GT DM Room", nil, "GT", true)
local GT_bottom_map_room = alttp_location.new("GT_bottom_map_room", "GT Map Room", nil, "GT", true)
local GT_bottom_double_switch_room = alttp_location.new("GT_bottom_double_switch_room", "GT Double Switch", nil, "GT", true)
local GT_bottom_firesnake_room_before_pit = alttp_location.new("GT_bottom_firesnake_room_before_pit", "GT Firesneak Pre(d)-Pit", nil, "GT", true)
local GT_bottom_firesnake_room_after_pit = alttp_location.new("GT_bottom_firesnake_room_after_pit", "GT Firesneak Post-Pit", nil, "GT", true)
local GT_bottom_randomizer_room = alttp_location.new("GT_bottom_randomizer_room", "GT Randomizer Room", nil, "GT", true)
local GT_bottom_teleporter_puzzle_room = alttp_location.new("GT_bottom_teleporter_puzzle_room", "GT Teleporter Puzzle", nil, "GT", true)
local GT_bottom_invisibile_bonk_room = alttp_location.new("GT_bottom_invisibile_bonk_room", "GT Invis. Path", nil, "GT", true)
local GT_bottom_tile_room = alttp_location.new("GT_bottom_tile_room", "GT Tile Room", nil, "GT", true)
local GT_bottom_torch_puzzle = alttp_location.new("GT_bottom_torch_puzzle", "GT Torches", nil, "GT", true)
local GT_bottom_compass_room = alttp_location.new("GT_bottom_compass_room", "GT Compass", nil, "GT", true)
local GT_bottom_conveyor_star_room = alttp_location.new("GT_bottom_conveyor_star_room", "GT Conveyor Star", nil, "GT", true)
local GT_bottom_ice_fight = alttp_location.new("GT_bottom_ice_fight", "GT Ice Refight", nil, "GT", true)
local GT_bottom_main_room = alttp_location.new("GT_bottom_main_room", "GT Main Lobby", nil, "GT", true)

local GT_top_entrance = alttp_location.new("GT_top_entrance", "GT-Top Entrance", nil, "GT", true)
local GT_top_mini_helmasaur_room = alttp_location.new("GT_top_mini_helmasaur_room", "GT-Top Mini Hemlas", nil, "GT", true)
local GT_top_gauntlet = alttp_location.new("GT_top_gauntlet", "GT-Top Gauntlet", nil, "GT", true)
local GT_top_pre_moldorm_room = alttp_location.new("GT_top_pre_moldorm_room", "GT-Top Pre-Moldorm", nil, "GT", true)
local GT_top_torch_puzzle = alttp_location.new("GT_top_torch_puzzle", "GT-Top Torch Puzzle", nil, "GT", true)
local GT_top_top_refight = alttp_location.new("GT_top_top_refight", "GT-Top Moldorm Refight", nil, "GT", true)
local GT_top_Desert_refight = alttp_location.new("GT_top_Desert_refight", "GT-Top Lanmo Refight", nil, "GT", true)
local GT_top_validation = alttp_location.new("GT_top_validation", "GT-Top Validation", nil, "GT", true)
local GT_top_aga2 = alttp_location.new("GT_top_aga2", "GT-Top Aga2 Arena", nil, "GT", true)

GT_entrance_inside:connect_two_ways(GT_bottom_main_room, function() 
    return ALL(
        CanInteract(GT_entrance_inside), 
        OpenOrStandard
    )
end)
GT_entrance_inside:connect_two_ways(GT_bottom_main_room, function() 
    return ALL(
        CanInteract(GT_entrance_inside), 
        Inverted
    )
end)
GT_bottom_main_room:connect_two_ways(GT_bottom_bobs_torch)
GT_bottom_main_room:connect_two_ways(GT_bottom_hope_room)
GT_bottom_main_room:connect_two_ways(GT_top_entrance)

GT_bottom_bobs_torch:connect_two_ways(GT_bottom_conveyor_cross_room)
-- GT_bottom_bobs_torch:connect_two_ways(GT_bottom_hope_room)--, function(keys) return Has("gt_smallkey", keys + 1, 4, keys + 1, 6), KDSreturn(keys+1, keys+1) end)
GT_bottom_bobs_torch:connect_two_ways(GT_bottom_hope_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7), keys + 1 end)
GT_bottom_bobs_torch:connect_one_way("GT - Bob's Torch", function()
    return ANY(
        ALL(
            "boots",
            CanInteract(GT_bottom_bobs_torch)
        ),
        ACCESS_INSPECT
    )
end)

GT_bottom_conveyor_cross_room:connect_two_ways(GT_bottom_bonk_pit_room, function() return Has("hammer") end)
GT_bottom_conveyor_cross_room:connect_one_way("GT - Conveyor Cross Key Drop")

GT_bottom_bonk_pit_room:connect_two_ways(GT_bottom_dm_room, function() return Has("hookshot") end)

GT_bottom_bonk_pit_room:connect_two_ways(GT_bottom_bonk_pit_room_bottom, function()
    return ANY(
        "hookshot",
        "boots"
    )
end)

GT_bottom_bonk_pit_room_bottom:connect_two_ways(GT_bottom_double_switch_room, function() return DealDamage() end)
GT_bottom_bonk_pit_room_bottom:connect_two_ways(GT_bottom_map_room, function(keys)
    return ALL(
        Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8)
    ), KDSreturn(keys, keys + 1)
end)

GT_bottom_dm_room:connect_one_way("GT - DM Room Top Left")
GT_bottom_dm_room:connect_one_way("GT - DM Room Top Right")
GT_bottom_dm_room:connect_one_way("GT - DM Room Bottom Left")
GT_bottom_dm_room:connect_one_way("GT - DM Room Bottom Right")

GT_bottom_map_room:connect_one_way("GT - Map Chest")

GT_bottom_double_switch_room:connect_two_ways(GT_bottom_firesnake_room_before_pit, function(keys)
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
GT_bottom_double_switch_room:connect_one_way("GT - Double Switch Pot Key")--, function() ret
--     return ANY(
--         "boots",
--         "hookshot"
--     )
-- end)

GT_bottom_firesnake_room_before_pit:connect_two_ways(GT_bottom_firesnake_room_after_pit, function() return Has("hookshot") end)

GT_bottom_firesnake_room_after_pit:connect_two_ways(GT_bottom_teleporter_puzzle_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8), keys + 1 end)
GT_bottom_firesnake_room_after_pit:connect_one_way("GT - Firesnake Room")

GT_bottom_teleporter_puzzle_room:connect_two_ways(GT_bottom_randomizer_room, function() return ALL("bombs", CanInteract(GT_bottom_teleporter_puzzle_room)) end)
GT_bottom_teleporter_puzzle_room:connect_one_way(GT_bottom_invisibile_bonk_room)

GT_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Left")
GT_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Top Right")
GT_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Left")
GT_bottom_randomizer_room:connect_one_way("GT - Randomizer Room Bottom Right")

GT_bottom_hope_room:connect_two_ways(GT_bottom_tile_room, function() return ALL("somaria",CanInteract(GT_bottom_hope_room)) end)
GT_bottom_hope_room:connect_one_way("GT - Hope Room Left", function() return CanInteract(GT_bottom_hope_room) end)
GT_bottom_hope_room:connect_one_way("GT - Hope Room Right", function() return CanInteract(GT_bottom_hope_room) end)

GT_bottom_tile_room:connect_two_ways(GT_bottom_torch_puzzle, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 3, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7), keys + 1 end)
GT_bottom_tile_room:connect_one_way("GT - Tile Room Chest")

GT_bottom_torch_puzzle:connect_one_way(GT_bottom_compass_room, function()
    return ALL(
        "firerod",
        ANY(
            "bombs",
            "somaria"
        )
    )
end)

GT_bottom_compass_room:connect_one_way(GT_bottom_conveyor_star_room)
GT_bottom_compass_room:connect_one_way("GT - Compass Room Top Left")
GT_bottom_compass_room:connect_one_way("GT - Compass Room Top Right")
GT_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Left")
GT_bottom_compass_room:connect_one_way("GT - Compass Room Bottom Right")

GT_bottom_conveyor_star_room:connect_one_way(GT_bottom_invisibile_bonk_room, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 8), KDSreturn(keys, keys + 1) end)
GT_bottom_conveyor_star_room:connect_one_way("GT - Conveyor Star Key Drop")

GT_bottom_invisibile_bonk_room:connect_two_ways(GT_bottom_big_chest_room)
GT_bottom_invisibile_bonk_room:connect_two_ways(GT_bottom_above_ice_fight)

GT_bottom_big_chest_room:connect_one_way("GT - Big Chest", function() return Has("gt_bigkey") end)

GT_bottom_above_ice_fight:connect_one_way(GT_bottom_ice_fight, function() return Has("bombs") end)
GT_bottom_above_ice_fight:connect_one_way("GT - Bob's Chest")

GT_bottom_ice_fight:connect_two_ways(GT_bottom_big_key_room, function() return GetBossRef("gt_ice") end)
GT_bottom_ice_fight:connect_one_way(GT_bottom_big_chest_room, function() return GetBossRef("gt_ice") end)

GT_bottom_big_key_room:connect_one_way("GT - Big Key Chest")
GT_bottom_big_key_room:connect_one_way("GT - Big Key Room Left")
GT_bottom_big_key_room:connect_one_way("GT - Big Key Room Right")

GT_top_entrance:connect_two_ways(GT_top_gauntlet, function()
    return ALL(
        "gt_bigkey",
        EnemizerCheck("bow"),
        CanInteract(GT_top_entrance)
    )
end)
GT_top_gauntlet:connect_two_ways(GT_top_Desert_refight, function() return GetBossRef("gt_lanmo") end)
GT_top_Desert_refight:connect_two_ways(GT_top_torch_puzzle)
GT_top_torch_puzzle:connect_one_way(GT_top_mini_helmasaur_room, function() return Has("firesource") end)

GT_top_mini_helmasaur_room:connect_two_ways(GT_top_pre_moldorm_room, function(keys)
    return ALL(
        Has("gt_smallkey", keys + CountDoneDeadends(0, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 3, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key", "@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@Ganon's Tower Top/Validation Chest/Validation Chest"), 7),
        "bombs"
    ), KDSreturn(keys + 0 , keys + 1 )
end)
GT_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Left")
GT_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Right")
GT_top_mini_helmasaur_room:connect_one_way("GT - Mini Helmasaur Key Drop")

GT_top_pre_moldorm_room:connect_one_way(GT_top_top_refight, function(keys) return Has("gt_smallkey", keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest"), 4, keys + CountDoneDeadends(1, "@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key"), 8), keys + 1 end)
GT_top_pre_moldorm_room:connect_one_way("GT - Pre Moldorm Chest")

GT_top_top_refight:connect_one_way(GT_top_validation, function() return ALL(
        GetBossRef("gt_boss"),
        "hookshot"
    )
end)
GT_top_validation:connect_one_way("GT - Validation Chest")
GT_top_validation:connect_one_way(GT_top_aga2)
GT_top_aga2:connect_one_way("GT - Aga2", function()
    return ANY(
        "sword",
        "hammer",
        "bug_net"
    )
end)