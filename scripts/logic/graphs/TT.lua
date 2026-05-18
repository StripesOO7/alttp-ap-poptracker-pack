-- tt_entrance = alttp_location.new("", nil, nil, true)
local tt_front_bottom_left = alttp_location.new("tt_front_bottom_left", "TT Front Bottom Left", nil, true)
local tt_front_top_left = alttp_location.new("tt_front_top_left", "TT Front Top Left", nil, true)
local tt_front_top_right = alttp_location.new("tt_front_top_right", "TT Front Top Right", nil, true)
local tt_front_bottom_right = alttp_location.new("tt_front_bottom_right", "TT Front Bottom Right", nil, true)
local tt_back_hallway = alttp_location.new("tt_back_hallway", "TT Back Hallway", nil, true)
local tt_crystal_switch_room = alttp_location.new("tt_crystal_switch_room", "TT Crystal Switch", nil, true)
local tt_attic = alttp_location.new("tt_attic", "TT Attic", nil, true)
local tt_basement = alttp_location.new("tt_basement", "TT Basement", nil, true)
local tt_big_chest_room = alttp_location.new("tt_big_chest_room", "TT Big Chest", nil, true)
local tt_basement_cell = alttp_location.new("tt_basement_cell", "TT Basement Cell", nil, true)
local tt_back_room = alttp_location.new("tt_back_room", "TT Back Room", nil, true)
local tt_boss_room = alttp_location.new("tt_boss_room", "TT Boss Room", nil, true)


tt_entrance_inside:connect_two_ways(tt_front_bottom_left)
tt_front_bottom_left:connect_two_ways(tt_front_top_left)
tt_front_bottom_left:connect_one_way("TT - Map Chest", function() return CanInteract(tt_front_bottom_left) end)

tt_front_top_left:connect_two_ways(tt_front_top_right)
tt_front_top_left:connect_one_way("TT - Ambush Chest", function() return CanInteract(tt_front_top_left) end)

tt_front_top_right:connect_two_ways(tt_front_bottom_right)
tt_front_top_right:connect_two_ways(tt_back_hallway, function() return ALL("tt_bigkey", CanInteract(tt_front_top_right)) end)

tt_front_bottom_right:connect_one_way(tt_front_bottom_left)
tt_front_bottom_right:connect_one_way("TT - Compass Chest", function() return CanInteract(tt_front_bottom_right) end)
tt_front_bottom_right:connect_one_way("TT - Big Key Chest", function() return CanInteract(tt_front_bottom_right) end)



tt_back_hallway:connect_two_ways(tt_crystal_switch_room, function(keys)
    return Has("tt_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1)
end)
tt_back_hallway:connect_one_way("TT - Hallway Pot Key")

tt_crystal_switch_room:connect_two_ways(tt_basement)
tt_crystal_switch_room:connect_two_ways(tt_attic, function(keys)
    return Has("tt_smallkey", keys + CountDoneDeadends(0, "@Thieves Town Back/Big Chest/Big Chest"), 0, keys + CountDoneDeadends(1, "@Thieves Town Back/Big Chest/Big Chest"), 3), KDSreturn(keys, keys + 1)
end)
tt_crystal_switch_room:connect_one_way("TT - Spike Switch Pot Key")

tt_attic:connect_one_way("TT - Attic")

tt_basement:connect_two_ways(tt_big_chest_room, function(keys)
    return Has("tt_smallkey", keys + CountDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 1, keys + CountDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 3), keys + 1
end)
tt_basement:connect_two_ways(tt_basement_cell)

tt_basement_cell:connect_one_way("TT - Blind's Cell")
tt_big_chest_room:connect_one_way("TT - Big Chest", function()
    return ALL(
        "hammer",
        "tt_bigkey"
    )
end)
tt_back_hallway:connect_two_ways(tt_boss_room)
tt_boss_room:connect_one_way("TT - Boss", function()
    return ALL(
        GetBossRef("tt_boss"),
        TT_boss_check
    )
end)