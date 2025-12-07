-- dungeons
--lightworld
at_entrance_outside = alttp_location.new("at_entrance_outside", "Aga Tower", "light", false, 27, 2040, 1588, 1623, nil, {"Central Hyrule - Entrances", "Agahnims Tower", "Agahnims Tower"})
at_entrance_inside = alttp_location.new("at_entrance_inside", "Aga Tower", nil, true, 224, 120, 7640, 7668, nil, {"Central Hyrule - Insides", "Agahnims Tower", "Agahnims Tower"}, "dungeon")

ce_dropdown_entrance_outside = alttp_location.new("ce_dropdown_entrance_outside", "Castle Escape Drop", "light", false, 20, 2120, 1068, 1068, nil, {"Central Hyrule - Entrances", "Sanctuary Grave", "Sanctuary Grave"})
ce_dropdown_entrance_inside = alttp_location.new("ce_dropdown_entrance_inside", "Castle Escape Drop", nil, true, 17, 915, 669, 669, nil, {"Central Hyrule - Insides", "Sanctuary Grave", "Sanctuary Grave"}, "dungeon")
ce_stairs_outside = alttp_location.new("ce_stairs_outside", "Castle Escape Stairs", nil, false)
ce_stairs_inside = alttp_location.new("ce_stairs_insidetrue", "Castle Escape Stairs", "dungeon", true)

dp_back_entrance_outside = alttp_location.new("dp_back_entrance_outside", "DP Back", "light", false, 48, 296, 3112, 3128, nil, {"Desert - Entrances", "Desert Palace Entrance (North)", "Desert Palace Entrance (North)"})
dp_back_entrance_inside = alttp_location.new("dp_back_entrance_inside", "DP Back", nil, true, 99, 1656, 3544, 3572, nil, {"Desert - Insides", "Desert Palace Entrance (North)", "Desert Palace Entrance (North)"}, "dungeon")
dp_left_entrance_outside = alttp_location.new("dp_left_entrance_outside", "DP Left", "light", false, 48, 136, 3224, 3253, nil, {"Desert - Entrances", "Desert Palace Entrance (West)", "Desert Palace Entrance (West)"})
dp_left_entrance_inside = alttp_location.new("dp_left_entrance_inside", "DP Left", nil, true, 131, 1656, 4568, 4597, nil, {"Desert - Insides", "Desert Palace Entrance (West)", "Desert Palace Entrance (West)"}, "dungeon")
dp_main_entrance_outside = alttp_location.new("dp_main_entrance_outside", "DP Main", "light", false, 48, 296, 3224, 3253, nil, {"Desert - Entrances", "Desert Palace Entrance (South)", "Desert Palace Entrance (South)"})
dp_main_entrance_inside = alttp_location.new("dp_main_entrance_inside", "DP Main", nil, true, 132, 2296, 4568, 4597, nil, {"Desert - Insides", "Desert Palace Entrance (South)", "Desert Palace Entrance (South)"}, "dungeon")
dp_right_entrance_outside = alttp_location.new("dp_right_entrance_outside", "DP Right", "light", false, 48, 456, 3224, 3253, nil, {"Desert - Entrances", "Desert Palace Entrance (East)", "Desert Palace Entrance (East)"})
dp_right_entrance_inside = alttp_location.new("dp_right_entrance_inside", "DP Right", nil, true, 133, 2936, 4568, 4597, nil, {"Desert - Insides", "Desert Palace Entrance (East)", "Desert Palace Entrance (East)"}, "dungeon")

ep_entrance_outside = alttp_location.new("ep_entrance_outside", "EP Main", "light", false, 30, 3920, 1560, 1576, nil, {"Eastern Area - Entrances", "Eastern Palace", "Eastern Palace"})
ep_entrance_inside = alttp_location.new("ep_entrance_inside", "EP Main", nil, true, 201, 4856, 6616, 6645, nil, {"Eastern Area - Insides", "Eastern Palace", "Eastern Palace"}, "dungeon")

hc_left_entrance_outside = alttp_location.new("hc_left_entrance_outside", "HC Left", "light", false, 27, 1832, 1540, 1575, nil, {"Central Hyrule - Entrances", "Hyrule Castle Entrance (West)", "Hyrule Castle Entrance (West)"})
hc_left_entrance_inside = alttp_location.new("hc_left_entrance_inside", "HC Left", nil, true, 96, 376, 3544, 3575, nil, {"Central Hyrule - Insides", "Hyrule Castle Entrance (West)", "Hyrule Castle Entrance (West)"}, "dungeon")
hc_main_entrance_outside = alttp_location.new("hc_main_entrance_outside", "HC Main", "light", false, 27, 2040, 1740, 1782, nil, {"Central Hyrule - Entrances", "Hyrule Castle Entrance (South)", "Hyrule Castle Entrance (South)"})
hc_main_entrance_inside = alttp_location.new("hc_main_entrance_inside", "HC Main", nil, true, 97, 760, 3520, 3573, nil, {"Central Hyrule - Insides", "Hyrule Castle Entrance (South)", "Hyrule Castle Entrance (South)"}, "dungeon")
hc_right_entrance_outside = alttp_location.new("hc_right_entrance_outside", "HC Right", "light", false, 27, 2248, 1540, 1575, nil, {"Central Hyrule - Entrances", "Hyrule Castle Entrance (East)", "Hyrule Castle Entrance (East)"})
hc_right_entrance_inside = alttp_location.new("hc_right_entrance_inside", "HC Right", nil, true, 98, 1144, 3544, 3572, nil, {"Central Hyrule - Insides", "Hyrule Castle Entrance (East)", "Hyrule Castle Entrance (East)"}, "dungeon")

toh_entrance_outside = alttp_location.new("toh_entrance_outside", "ToH Main", "light", false, 3, 2288, 104, 119, nil, {"Light Death Mountain - Entrances", "Tower of Hera", "Tower of Hera"})
toh_entrance_outside_weird_state = alttp_location.new("toh_entrance_outside_weird_state", "ToH Main", "light", false)
toh_entrance_inside = alttp_location.new("toh_entrance_inside", "ToH Main", nil, true, 119, 3832, 4032, 4084, nil, {"Light Death Mountain - Insides", "Tower of Hera", "Tower of Hera"}, "dungeon")


--darkworld

gt_entrance_outside = alttp_location.new("gt_entrance_outside", "GT Main", "dark", false, 67, 2296, 40, 164, nil, {"Dark Death Mountain - Entrances", "Ganons Tower", "Ganons Tower"})
gt_entrance_inside = alttp_location.new("gt_entrance_inside", "GT Main", nil, true, 12, 6392, 472, 501, nil, {"Dark Death Mountain - Insides", "Ganons Tower", "Ganons Tower"}, "dungeon")

ip_entrance_outside = alttp_location.new("ip_entrance_outside", "IP Main", "dark", false, 117, 3256, 3512, 3528, nil, {"Dark Lake Hylia - Entrances", "Ice Palace", "Ice Palace"})
ip_entrance_inside = alttp_location.new("ip_entrance_inside", "IP Main", nil, true, 14, 7544, 472, 501, nil, {"Dark Lake Hylia - Insides", "Ice Palace", "Ice Palace"}, "dungeon")

mm_entrance_outside = alttp_location.new("mm_entrance_outside", "MM Main", "dark", false, 112, 296, 3271, 3288, nil, {"Misery Mire - Entrances", "Misery Mire", "Misery Mire"})
mm_entrance_inside = alttp_location.new("mm_entrance_inside", "MM Main", nil, true, 152, 4216, 5080, 5109, nil, {"Misery Mire - Insides", "Misery Mire", "Misery Mire"}, "dungeon")

pod_entrance_outside = alttp_location.new("pod_entrance_outside", "PoD Main", "dark", false, 94, 3920, 1576, 1592, nil, {"PoD Area - Entrances", "Palace of Darkness", "Palace of Darkness"})
pod_entrance_inside = alttp_location.new("pod_entrance_inside", "PoD Main", nil, true, 74, 5368, 2520, 2548, nil, {"PoD Area - Insides", "Palace of Darkness", "Palace of Darkness"}, "dungeon")

sp_entrance_outside = alttp_location.new("sp_entrance_outside", "SP Main", "dark", false, 123, 1912, 3800, 3816, nil, {"Swamp - Entrances", "Swamp Palace", "Swamp Palace"})
sp_entrance_inside = alttp_location.new("sp_entrance_inside", "SP Main", nil, true, 40, 4344, 1496, 1525, nil, {"Swamp - Insides", "Swamp Palace", "Swamp Palace"}, "dungeon")

sw_back_entrance_outside = alttp_location.new("sw_back_entrance_outside", "SW Back", "dark", false, 64, 152, 184, 248, nil, {"Skull Woods - Entrances", "Skull Woods Back Entrance", "Skull Woods Back Entrance"})
sw_back_entrance_inside = alttp_location.new("sw_back_entrance_inside", "SW Back", nil, true, 89, 4728, 3032, 3060, nil, {"Skull Woods - Insides", "Skull Woods Back Entrance", "Skull Woods Back Entrance"}, "dungeon")
sw_big_chest_entrance_outside = alttp_location.new("sw_big_chest_entrance_outside", "SW Big Chest", "dark", false, 64, 744, 584, 599, nil, {"Skull Woods - Entrances", "Skull Woods Big Chest Entrance", "Skull Woods Big Chest Entrance"})
sw_big_chest_entrance_inside = alttp_location.new("sw_big_chest_entrance_inside", "SW Big Chest", nil, true, 88, 4216, 3032, 3060, nil, {"Skull Woods - Insides", "Skull Woods Big Chest Entrance", "Skull Woods Big Chest Entrance"}, "dungeon")
sw_bottom_left_drop_outside = alttp_location.new("sw_bottom_left_drop_outside", "SW Front Left Drop", "dark", false, 64, 632, 590, 594, nil, {"Skull Woods - Entrances", "Skull Woods Bottom Left Drop", "Skull Woods Bottom Left Drop"})
sw_bottom_left_drop_inside = alttp_location.new("sw_bottom_left_drop_inside", "SW Front Left Drop", nil, true, 103, 3712, 3056, 3056, nil, {"Skull Woods - Insides", "Skull Woods Bottom Left Drop", "Skull Woods Bottom Left Drop"}, "dungeon")
sw_gibdo_entrance_outside = alttp_location.new("sw_gibdo_entrance_outside", "SW Gibdo", "dark", false, 64, 584, 568, 584, nil, {"Skull Woods - Entrances", "Skull Woods Gibdo Entrance", "Skull Woods Gibdo Entrance"})
sw_gibdo_entrance_inside = alttp_location.new("sw_gibdo_entrance_inside", "SW Gibdo", nil, true, 87, 3704, 3032, 3060, nil, {"Skull Woods - Insides", "Skull Woods Gibdo Entrance", "Skull Woods Gibdo Entrance"}, "dungeon")
sw_north_drop_outside = alttp_location.new("sw_north_drop_outside", "SW North Drop", "dark", false, 64, 488, 238, 242, nil, {"Skull Woods - Entrances", "Skull Woods Back Hole", "Skull Woods Back Hole"})
sw_north_drop_inside = alttp_location.new("sw_north_drop_inside", "SW North Drop", nil, true, 86, 3392, 2544, 2544, nil, {"Skull Woods - Insides", "Skull Woods Back Hole", "Skull Woods Back Hole"}, "dungeon")
sw_pinball_drop_outside = alttp_location.new("sw_pinball_drop_outside", "SW Pinball Drop", "dark", false, 64, 792, 556, 562, nil, {"Skull Woods - Entrances", "Skull Woods Pinball Drop", "Skull Woods Pinball Drop"})
sw_pinball_drop_inside = alttp_location.new("sw_pinball_drop_inside", "SW Pinball Drop", nil, true, 104, 4352, 3097, 3097, nil, {"Skull Woods - Insides", "Skull Woods Pinball Drop", "Skull Woods Pinball Drop"}, "dungeon")
sw_pot_circle_drop_outside = alttp_location.new("sw_pot_circle_drop_outside", "SW Pot Circle Drop", "dark", false, 64, 768, 406, 410, nil, {"Skull Woods - Entrances", "Skull Woods Circle Pot Drop", "Skull Woods Circle Pot Drop"})
sw_pot_circle_drop_inside = alttp_location.new("sw_pot_circle_drop_inside", "SW Pot Circle Drop", nil, true, 88, 4496, 2544, 2544, nil, {"Skull Woods - Insides", "Skull Woods Circle Pot Drop", "Skull Woods Circle Pot Drop"}, "dungeon")
sw_west_lobby_entrance_outside = alttp_location.new("sw_west_lobby_entrance_outside", "SW West Lobby", "dark", false, 64, 232, 504, 520, nil, {"Skull Woods - Entrances", "Skull Woods West Lobby", "Skull Woods West Lobby"})
sw_west_lobby_entrance_inside = alttp_location.new("sw_west_lobby_entrance_inside", "SW West Lobby", nil, true, 86, 3192, 3032, 3060, nil, {"Skull Woods - Insides", "Skull Woods West Lobby", "Skull Woods West Lobby"}, "dungeon")

tr_big_chest_entrance_outside = alttp_location.new("tr_big_chest_entrance_outside", "TR Big Chest", "dark", false, 69, 3448, 343, 358, nil, {"Dark Death Mountain - Entrances", "Turtle Rock Ledge Exit (East)", "Turtle Rock Ledge Exit (East)"})
tr_big_chest_entrance_inside = alttp_location.new("tr_big_chest_entrance_inside", "TR Big Chest", nil, true, 36, 2424, 1496, 1525, nil, {"Dark Death Mountain - Insides", "Turtle Rock Ledge Exit (East)", "Turtle Rock Ledge Exit (East)"}, "dungeon")
tr_eye_bridge_entrance_outside = alttp_location.new("tr_eye_bridge_entrance_outside", "TR Eye-Bridge", "dark", false, 69, 3352, 440, 452, nil, {"Dark Death Mountain - Entrances", "Turtle Rock Isolated Ledge Exit", "Turtle Rock Isolated Ledge Exit"})
tr_eye_bridge_entrance_inside = alttp_location.new("tr_eye_bridge_entrance_inside", "TR Eye-Bridge", nil, true, 213, 2680, 7128, 7159, nil, {"Dark Death Mountain - Insides", "Turtle Rock Isolated Ledge Exit", "Turtle Rock Isolated Ledge Exit"}, "dungeon")
tr_laser_entrance_outside = alttp_location.new("tr_laser_entrance_outside", "TR Laser-Exit", "dark", false, 69, 3256, 343, 358, nil, {"Dark Death Mountain - Entrances", "Turtle Rock Ledge Exit (West)", "Turtle Rock Ledge Exit (West)"})
tr_laser_entrance_inside = alttp_location.new("tr_laser_entrance_inside", "TR Laser-Exit", nil, true, 35, 1912, 1496, 1525, nil, {"Dark Death Mountain - Insides", "Turtle Rock Ledge Exit (West)", "Turtle Rock Ledge Exit (West)"}, "dungeon")
tr_main_entrance_outside = alttp_location.new("tr_main_entrance_outside", "TR Main", "dark", false, 71, 3848, 296, 310, nil, {"Dark Death Mountain - Entrances", "Turtle Rock", "Turtle Rock"})
tr_main_entrance_inside = alttp_location.new("tr_main_entrance_inside", "TR Main", nil, true, 214, 3448, 7128, 7156, nil, {"Dark Death Mountain - Insides", "Turtle Rock", "Turtle Rock"}, "dungeon")

tt_entrance_outside = alttp_location.new("tt_entrance_outside", "TT Main", "dark", false, 88, 504, 1960, 1976, nil, {"Village of the Outcast - Entrances", "Thieves Town", "Thieves Town"})
tt_entrance_inside = alttp_location.new("tt_entrance_inside", "TT Main", nil, true, 219, 5880, 7128, 7156, nil, {"Village of the Outcast - Insides", "Thieves Town", "Thieves Town"}, "dungeon")