pod_entrance = alttp_location.new()
local pod_three_way_room = alttp_location.new()
local pod_shooter_room = alttp_location.new()
local pod_teleporter_room = alttp_location.new()
local pod_mimic_room = alttp_location.new()
local pod_switch_room_top = alttp_location.new()
local pod_switch_room_bottom = alttp_location.new()
local pod_arena = alttp_location.new()
local pod_big_key_chest_room = alttp_location.new()
local pod_basement_ledge = alttp_location.new()
local pod_basement_floor = alttp_location.new()
local pod_big_key_chest_ledge = alttp_location.new()
local pod_collapsin_bridge = alttp_location.new()
local pod_dark_maze = alttp_location.new()
local pod__compass_room = alttp_location.new()
local pod_dark_basement = alttp_location.new()
local pod_harmless_hellway = alttp_location.new()
local pod_boss_room = alttp_location.new()


gt_entrance:connect_two_ways(pod_three_way_room)
pod_three_way_room:connect_two_ways(pod_shooter_room)
pod_three_way_room:connect_two_ways(pod_big_key_chest_room)
pod_three_way_room:connect_two_ways(pod_teleporter_room)
pod_three_way_room:connect_one_way(pod_basement_ledge)

pod_shooter_room:connect_one_way("PoD - Shooter Room")

pod_basement_ledge:connect_one_way(pod_basement_floor)
pod_basement_ledge:connect_two_ways(pod_big_key_chest_ledge)

pod_big_key_chest_ledge:connect_one_way(pod_basement_floor)
pod_big_key_chest_ledge:connect_one_way("PoD - Big Key Chest")

pod_basement_floor:connect_one_way(pod_teleporter_room)
pod_basement_floor:connect_one_way("PoD - Stalfos Basement")

pod_teleporter_room:connect_two_ways(pod_mimic_room)

pod_mimic_room:connect_two_ways(pod_switch_room_top)

pod_switch_room_top:connect_one_way(pod_switch_room_bottom)
pod_switch_room_top:connect_one_way("PoD - Map Chest")
pod_switch_room_top:connect_one_way("PoD - Arena Ledge")

pod_switch_room_bottom:connect_two_ways(pod_boss_room)
pod_switch_room_bottom:connect_two_ways(pod_arena)

pod_big_key_chest_room:connect_two_ways(pod_arena)

pod_area:connect_one_way(pod_collapsin_bridge)
pod_area:connect_one_way("PoD - Arena Bridge")

pod_collapsin_bridge:connect_two_ways(pod_dark_maze)
pod_collapsin_bridge:connect_two_ways(pod__compass_room)

pod_dark_maze:connect_one_way("PoD - Dark Maze Top")
pod_dark_maze:connect_one_way("PoD - Dark Maze Bottom")
pod_dark_maze:connect_one_way("PoD - Big Chest")

pod__compass_room:connect_two_ways(pod_dark_basement)
pod__compass_room:connect_two_ways(pod_harmless_hellway)

pod_dark_basement:connect_one_way("PoD - Dark Basement LEft")
pod_dark_basement:connect_one_way("PoD - Dark Basement Right")

pod_harmless_hellway:connect_one_way(pod_arena)
pod_harmless_hellway:connect_one_way("PoD - Harmless Hellway")

pod_boss_room:connect_one_way("PoD - Boss")