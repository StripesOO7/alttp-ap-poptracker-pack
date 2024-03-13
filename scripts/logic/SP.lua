sp_entrance = alttp_location.new()
local sp_first_room = alttp_location.new()
local sp_hallway_before_first_trench = alttp_location.new()
local sp_first_trench = alttp_location.new()
local sp_main_room = alttp_location.new()
local sp_roundabout = alttp_location.new()
local sp_second_trench = alttp_location.new()
local sp_hallway_after_second_trench = alttp_location.new()
local sp_flooded_room = alttp_location.new()
local sp_waterfall_room = alttp_location.new()
local sp_after_waterfall_room = alttp_location.new()
local sp_boss_room = alttp_location.new()

sp_entrance:connect_two_ways(sp_first_room)

sp_first_room:connect_two_ways(sp_hallway_before_first_trench)
sp_first_room:connect_one_way("SP - Entrance Chest")

sp_hallway_before_first_trench:connect_two_ways(sp_first_trench)
sp_hallway_before_first_trench:connect_one_way("SP - Pot Row Key")
sp_hallway_before_first_trench:connect_one_way("SP - Map chest")

sp_first_trench:connect_two_ways(sp_main_room)
sp_first_room:connect_one_way("SP - Tench 1 Pot Key")

sp_main_room:connect_two_ways(sp_roundabout)
sp_main_room:connect_two_ways(sp_second_trench)
sp_main_room:connect_two_ways(sp_flooded_room)
sp_main_room:connect_one_way("SP - Hookshot Pot Key")
sp_main_room:connect_one_way("SP - Big Chest")

sp_second_trench:connect_two_ways(sp_hallway_after_second_trench)
sp_second_trench:connect_one_way("SP - Trench 2 Pot Key")

sp_hallway_after_second_trench:connect_one_way("SP - West Chest")
sp_hallway_after_second_trench:connect_one_way("SP - Big Key Chest")

sp_roundabout:connect_one_way("SP - Compass Chest")

sp_flooded_room:connect_two_ways(sp_waterfall_room)
sp_flooded_room:connect_one_way("SP - Flooded Room Left")
sp_flooded_room:connect_one_way("SP - Flooded Room Right")

sp_waterfall_room:connect_two_ways(sp_after_waterfall_room)
sp_waterfall_room:connect_one_way("SP - Waterfall Room")

sp_after_waterfall_room:connect_two_ways(sp_boss_room)
sp_after_waterfall_room:connect_one_way("SP - Waterway Pot Key")

sp_boss_room:connect_one_way("SP - Boss")