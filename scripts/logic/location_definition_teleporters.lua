--teleporter

teleporter_at_kakariko_village = alttp_location.new("teleporter_at_kakariko_village", nil, "light", false)
teleporter_at_village_of_the_outcast = alttp_location.new("teleporter_at_village_of_the_outcast", nil, "dark", false)
teleporter_at_light_turtle_rock = alttp_location.new("teleporter_at_light_turtle_rock", nil, "light", false)
teleporter_at_dark_turtle_rock = alttp_location.new("teleporter_at_dark_turtle_rock", nil, "dark", false)
teleporter_at_light_death_mountain_right_bottom = alttp_location.new("teleporter_at_light_death_mountain_right_bottom", nil, "light", false)
teleporter_at_light_death_mountain_left_bottom = alttp_location.new("teleporter_at_light_death_mountain_left_bottom", nil, "light", false)
teleporter_at_dark_death_mountain_left_bottom = alttp_location.new("teleporter_at_dark_death_mountain_left_bottom", nil, "dark", false)
teleporter_at_dark_death_mountain_right_bottom = alttp_location.new("teleporter_at_dark_death_mountain_right_bottom", nil, "dark", false)
teleporter_at_eastern = alttp_location.new("teleporter_at_eastern", nil, "light", false)
teleporter_at_pod = alttp_location.new("teleporter_at_pod", nil, "dark", false)
teleporter_at_desert = alttp_location.new("teleporter_at_desert", nil, "light", false)
teleporter_at_mire = alttp_location.new("teleporter_at_mire", nil, "dark", false)
teleporter_at_dam = alttp_location.new("teleporter_at_dam", nil, "light", false)
teleporter_at_swamp = alttp_location.new("teleporter_at_swamp", nil, "dark", false)
teleporter_at_upgrade_fairy = alttp_location.new("teleporter_at_upgrade_fairy", nil, "light", false)
teleporter_at_ice_palace = alttp_location.new("teleporter_at_ice_palace", nil, "dark", false)


old_man_cave_left_outside = alttp_location.new("old_man_cave_left_outside", "Old Man Cave Left", "light", false, 10, 1448, 696, 711, nil, {"Lost Woods - Entrances", "Old Man Cave Exit (West)", "Old Man Cave Exit (West)"})
old_man_cave_left_inside = alttp_location.new("old_man_cave_left_inside", "Old Man Cave Left", nil, false, 240, 120, 8152, 8180, nil, {"Lost Woods - Insides", "Old Man Cave Exit (West)", "Old Man Cave Exit (West)"}, "connector")
old_man_cave_right_outside = alttp_location.new("old_man_cave_right_outside", "Old Man Cave Right", "light", false, 3, 1656, 744, 757, nil, {"Light Death Mountain - Entrances", "Old Man Cave (East)","Old Man Cave (East)"})
old_man_cave_right_inside = alttp_location.new("old_man_cave_right_inside", "Old Man Cave Right", nil, false, 241, 888, 8128, 8181, nil, {"Light Death Mountain - Insides", "Old Man Cave (East)","Old Man Cave (East)"}, "connector")

light_death_mountain_return_left_outside = alttp_location.new("light_death_mountain_return_left_outside", "DM Return Left", "light", false, 10, 1464, 599, 615, nil, {"Lost Woods - Entrances", "Death Mountain Return Cave Exit (West)", "Death Mountain Return Cave Exit (West)"})
light_death_mountain_return_left_inside = alttp_location.new("light_death_mountain_return_left_inside", "DM Return Left", nil, false, 230, 3192, 7616, 7668, nil, {"Lost Woods - Insides", "Death Mountain Return Cave Exit (West)", "Death Mountain Return Cave Exit (West)"}, "connector")
light_death_mountain_return_right_outside = alttp_location.new("light_death_mountain_return_right_outside", "DM Return Right", "light", false, 3, 1608, 536, 550, nil, {"Light Death Mountain - Entrances", "Death Mountain Return Cave (East)", "Death Mountain Return Cave (East)"})
light_death_mountain_return_right_inside = alttp_location.new("light_death_mountain_return_right_inside", "DM Return Right", nil, false, 231, 3960, 7616, 7668, nil, {"Light Death Mountain - Insides", "Death Mountain Return Cave (East)", "Death Mountain Return Cave (East)"}, "connector")

bumpercave_bottom_outside = alttp_location.new("bumpercave_bottom_outside", "Bumpercave Bottom", "dark", false, nil, nil, nil, nil, nil, {"Skull Woods - Entrances", "Bumper Cave (Bottom)", "Bumper Cave (Bottom)"})
bumpercave_bottom_inside = alttp_location.new("bumpercave_bottom_inside", "Bumpercave Bottom", nil, false, nil, nil, nil, nil, nil, {"Skull Woods - Insides", "Bumper Cave (Bottom)", "Bumper Cave (Bottom)"}, "connector")
bumpercave_top_outside = alttp_location.new("bumpercave_top_outside", "Bumpercave Top", "dark", false, nil, nil, nil, nil, nil, {"Skull Woods - Entrances", "Bumper Cave (Top)", "Bumper Cave (Top)"})
bumpercave_top_inside = alttp_location.new("bumpercave_top_inside", "Bumpercave Top", nil, false, nil, nil, nil, nil, nil, {"Skull Woods - Insides", "Bumper Cave (Top)", "Bumper Cave (Top)"}, "connector")
bumpercave_top_back = alttp_location.new("bumpercave_top_back", nil, "dark", false)
bumpercave_top_front = alttp_location.new("bumpercave_top_front", nil, "dark", false)

empty_location = alttp_location.new("empty_location")