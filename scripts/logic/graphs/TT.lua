-- tt_entrance = alttp_location.new("", nil, nil, "TR", true)
local TT_front_bottom_left = alttp_location.new("TT_front_bottom_left", "TT Front Bottom Left", nil, "TR", true)
local TT_front_top_left = alttp_location.new("TT_front_top_left", "TT Front Top Left", nil, "TR", true)
local TT_front_top_right = alttp_location.new("TT_front_top_right", "TT Front Top Right", nil, "TR", true)
local TT_front_bottom_right = alttp_location.new("TT_front_bottom_right", "TT Front Bottom Right", nil, "TR", true)
local TT_back_hallway = alttp_location.new("TT_back_hallway", "TT Back Hallway", nil, "TR", true)
local TT_crystal_switch_room = alttp_location.new("TT_crystal_switch_room", "TT Crystal Switch", nil, "TR", true)
local TT_attic = alttp_location.new("TT_attic", "TT Attic", nil, "TR", true)
local TT_basement = alttp_location.new("TT_basement", "TT Basement", nil, "TR", true)
local TT_big_chest_room = alttp_location.new("TT_big_chest_room", "TT Big Chest", nil, "TR", true)
local TT_basement_cell = alttp_location.new("TT_basement_cell", "TT Basement Cell", nil, "TR", true)
local TT_back_room = alttp_location.new("TT_back_room", "TT Back Room", nil, "TR", true)
local TT_boss_room = alttp_location.new("TT_boss_room", "TT Boss Room", nil, "TR", true)


TT_entrance_inside:connect_two_ways(TT_front_bottom_left)
TT_front_bottom_left:connect_two_ways(TT_front_top_left)
TT_front_bottom_left:connect_one_way("TT - Map Chest", function() return CanInteract(TT_front_bottom_left) end)

TT_front_top_left:connect_two_ways(TT_front_top_right)
TT_front_top_left:connect_one_way("TT - Ambush Chest", function() return CanInteract(TT_front_top_left) end)

TT_front_top_right:connect_two_ways(TT_front_bottom_right)
TT_front_top_right:connect_two_ways(TT_back_hallway, function() return ALL("tt_bigkey", CanInteract(TT_front_top_right)) end)

TT_front_bottom_right:connect_one_way(TT_front_bottom_left)
TT_front_bottom_right:connect_one_way("TT - Compass Chest", function() return CanInteract(TT_front_bottom_right) end)
TT_front_bottom_right:connect_one_way("TT - Big Key Chest", function() return CanInteract(TT_front_bottom_right) end)



TT_back_hallway:connect_two_ways(TT_crystal_switch_room, function(keys)
    return Has("tt_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1)
end)
TT_back_hallway:connect_one_way("TT - Hallway Pot Key")

TT_crystal_switch_room:connect_two_ways(TT_basement)
TT_crystal_switch_room:connect_two_ways(TT_attic, function(keys)
    return Has("tt_smallkey", keys + CountDoneDeadends(0, "@Thieves Town Back/Big Chest/Big Chest"), 0, keys + CountDoneDeadends(1, "@Thieves Town Back/Big Chest/Big Chest"), 3), KDSreturn(keys, keys + 1)
end)
TT_crystal_switch_room:connect_one_way("TT - Spike Switch Pot Key")

TT_attic:connect_one_way("TT - Attic")

TT_basement:connect_two_ways(TT_big_chest_room, function(keys)
    return Has("tt_smallkey", keys + CountDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 1, keys + CountDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 3), keys + 1
end)
TT_basement:connect_two_ways(TT_basement_cell)

TT_basement_cell:connect_one_way("TT - Blind's Cell")
TT_big_chest_room:connect_one_way("TT - Big Chest", function()
    return ALL(
        "hammer",
        "tt_bigkey"
    )
end)
TT_back_hallway:connect_two_ways(TT_boss_room)
TT_boss_room:connect_one_way("TT - Boss", function()
    return ALL(
        GetBossRef("tt_boss"),
        TT_boss_check
    )
end)