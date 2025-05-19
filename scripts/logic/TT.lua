-- tt_entrance = alttp_location.new("")
local tt_front_bottom_left = alttp_location.new("tt_front_bottom_left")
local tt_front_top_left = alttp_location.new("tt_front_top_left")
local tt_front_top_right = alttp_location.new("tt_front_top_right")
local tt_front_bottom_right = alttp_location.new("tt_front_bottom_right")
local tt_back_hallway = alttp_location.new("tt_back_hallway")
local tt_crystal_switch_room = alttp_location.new("tt_crystal_switch_room")
local tt_attic = alttp_location.new("tt_attic")
local tt_basement = alttp_location.new("tt_basement")
local tt_big_chest_room = alttp_location.new("tt_big_chest_room")
local tt_basement_cell = alttp_location.new("tt_basement_cell")
local tt_back_room = alttp_location.new("tt_back_room")
local tt_boss_room = alttp_location.new("tt_boss_room")


tt_entrance_inside:connect_two_ways(tt_front_bottom_left)
tt_front_bottom_left:connect_two_ways(tt_front_top_left)
tt_front_bottom_left:connect_one_way("TT - Map Chest", function() return can_interact("dark", 1) end)

tt_front_top_left:connect_two_ways(tt_front_top_right)
tt_front_top_left:connect_one_way("TT - Ambush Chest", function() return can_interact("dark", 1) end)

tt_front_top_right:connect_two_ways(tt_front_bottom_right)
tt_front_top_right:connect_two_ways(tt_back_hallway, function() return all(has("tt_bigkey"), can_interact("dark", 1)) end)

tt_front_bottom_right:connect_one_way(tt_front_bottom_left)
tt_front_bottom_right:connect_one_way("TT - Compass Chest", function() return can_interact("dark", 1) end)
tt_front_bottom_right:connect_one_way("TT - Big Key Chest", function() return can_interact("dark", 1) end)



tt_back_hallway:connect_two_ways(tt_crystal_switch_room, function(keys) 
    return has("tt_smallkey", keys, 0, keys + 1, 1), KDSreturn(keys, keys + 1)
end)
tt_back_hallway:connect_one_way("TT - Hallway Pot Key")

tt_crystal_switch_room:connect_two_ways(tt_basement)
tt_crystal_switch_room:connect_two_ways(tt_attic, function(keys) 
    return has("tt_smallkey", keys + countDoneDeadends(0, "@Thieves Town Back/Big Chest/Big Chest"), 0, keys + countDoneDeadends(1, "@Thieves Town Back/Big Chest/Big Chest"), 3), KDSreturn(keys, keys + 1)
end)
tt_crystal_switch_room:connect_one_way("TT - Spike Switch Pot Key")

tt_attic:connect_one_way("TT - Attic")

tt_basement:connect_two_ways(tt_big_chest_room, function(keys) 
    return has("tt_smallkey", keys + countDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 1, keys + countDoneDeadends(1, "@Thieves Town Back/Attic/Attic"), 3), KDSreturn(keys + 1, keys + 1)
end)
tt_basement:connect_two_ways(tt_basement_cell)

tt_basement_cell:connect_one_way("TT - Blind's Cell")
tt_big_chest_room:connect_one_way("TT - Big Chest", function() 
    return all(
        has("hammer"),
        has("tt_bigkey")
    ) 
end)
tt_back_hallway:connect_two_ways(tt_boss_room)
tt_boss_room:connect_one_way("TT - Boss", function() 
    return all(
        getBossRef("tt_boss"),
        tt_boss_check()
    )
end)