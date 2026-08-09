-- HC_main_entrance =alttp_location.new("", nil, nil, "HC", true)
-- HC_left_entrance =alttp_location.new("", nil, nil, "HC", true)
-- HC_right_entrance =alttp_location.new("", nil, nil, "HC", true)
local HC_throne_room = alttp_location.new("HC_throne_room", "HC Throne Room", nil, "HC", true)
local HC_main_hall = alttp_location.new("HC_main_hall", "HC Main Hall", nil, "HC", true)
local HC_left_wing_lobby = alttp_location.new("HC_left_wing_lobby", "HC Left Wing Loby", nil, "HC", true)
local HC_left_wing = alttp_location.new("HC_left_wing", "HC Left Wing", nil, "HC", true)
local HC_right_wing_lobby = alttp_location.new("HC_right_wing_lobby", "HC Right Wing Loby", nil, "HC", true)
local HC_right_wing = alttp_location.new("HC_right_wing", "HC Right Wing", nil, "HC", true)
local HC_back_wing = alttp_location.new("HC_back_wing", "HC Back Hallway", nil, "HC", true)
local HC_map_chest_room = alttp_location.new("HC_map_chest_room", "HC First Guard", nil, "HC", true)
local HC_before_boomerang_chest_room = alttp_location.new("HC_before_boomerang_chest_room", "HC Before Boomerang", nil, "HC", true)
local HC_boomerang_chest_room = alttp_location.new("HC_boomerang_chest_room", "HC Boomerang Chest", nil, "HC", true)
local HC_stairs = alttp_location.new("HC_stairs", "HC Stairs", nil, "HC", true)
local HC_ball_guard_room = alttp_location.new("HC_ball_guard_room", "HC Cell Guard", nil, "HC", true)
local HC_zeldas_cell = alttp_location.new("HC_zeldas_cell", "HC Zeldas Cell", nil, "HC", true)
-- CE_stairs =alttp_location.new("", nil, nil, "CE", true)
-- CE_dropdown_entrance =alttp_location.new("", nil, nil, "CE", true)
local CE_dark_cross = alttp_location.new("CE_dark_cross", "CE ", nil, "CE", true)
local CE_rat_key_room = alttp_location.new("CE_rat_key_room", "CE ", nil, "CE", true)
local CE_secret_room = alttp_location.new("CE_secret_room", "CE ", nil, "CE", true)
local CE_dropdown_room = alttp_location.new("CE_dropdown_room", "CE ", nil, "CE", true)

local HC_north_abyss = alttp_location.new("HC_north_abyss", "HC North abyss")
local HC_north_abyss_balcony = alttp_location.new("HC_north_abyss_balcony", "HC North Abyss balcony")
local HC_abyss_balcony = alttp_location.new("HC_abyss_balcony", "HC Abyss balcony")
local HC_abyss_catwalk = alttp_location.new("HC_abyss_catwalk", "HC Abyss catwalk")
local HC_armory = alttp_location.new("HC_armory", "HC armory")
local HC_cell_hallway = alttp_location.new("HC_cell_hallway", "HC Cell Hallway")

HC_main_hall_N_door = alttp_location.new("HC_main_hall_N_door", "HC Main Hall N Door", nil, "", true, 97, 760, 760, 3100, 3140, {"Hyrule Castle Doors", "HC Main Hall N Door", "HC Main Hall N Door"})
HC_main_hall_1W_door = alttp_location.new("HC_main_hall_1W_door", "HC Main Hall 1W Door", nil, "", true, 97, 495, 540, 3192, 3192, {"Hyrule Castle Doors", "HC Main Hall 1W Door", "HC Main Hall 1W Door"})
HC_main_hall_W_door = alttp_location.new("HC_main_hall_W_door", "HC Main Hall W Door", nil, "", true, 97, 490, 540, 3320, 3320, {"Hyrule Castle Doors", "HC Main Hall W Door", "HC Main Hall W Door"})
HC_main_hall_E_door = alttp_location.new("HC_main_hall_E_door", "HC Main Hall E Door", nil, "", true, 97, 995, 1030, 3320, 3320, {"Hyrule Castle Doors", "HC Main Hall E Door", "HC Main Hall E Door"})
HC_left_wing_lobby_2E_door = alttp_location.new("HC_left_wing_lobby_2E_door", "HC Left Wing Lobby 2E Door", nil, "", true, 96, 460, 520, 3192, 3192, {"Hyrule Castle Doors", "HC Left Wing Lobby 2E Door", "HC Left Wing Lobby 2E Door"})
HC_left_wing_lobby_E_door = alttp_location.new("HC_left_wing_lobby_E_door", "HC Left Wing Lobby E Door", nil, "", true, 96, 480, 520, 3320, 3320, {"Hyrule Castle Doors", "HC Left Wing Lobby E Door", "HC Left Wing Lobby E Door"})
HC_left_wing_lobby_2N_door = alttp_location.new("HC_left_wing_lobby_2N_door", "HC Left Wing Lobby 2N Door", nil, "", true, 96, 376, 376, 3050, 3110, {"Hyrule Castle Doors", "HC Left Wing Lobby 2N Door", "HC Left Wing Lobby 2N Door"})
HC_left_wing_4S_door = alttp_location.new("HC_left_wing_4S_door", "HC Left Wing 4S Door", nil, "", true, 80, 376, 376, 3030, 3090, {"Hyrule Castle Doors", "HC Left Wing 4S Door", "HC Left Wing 4S Door"})
HC_left_wing_2E_door = alttp_location.new("HC_left_wing_2E_door", "HC Left Wing 2E Door", nil, "", true, 80, 465, 520, 2680, 2680, {"Hyrule Castle Doors", "HC Left Wing 2E Door", "HC Left Wing 2E Door"})
HC_right_wing_lobby_3W_door = alttp_location.new("HC_right_wing_lobby_3W_door", "HC Right Wing Lobby 3W Door", nil, "", true, 98, 1005, 1050, 3315, 3320, {"Hyrule Castle Doors", "HC Right Wing Lobby 3W Door", "HC Right Wing Lobby 3W Door"})
HC_right_wing_lobby_1N_door = alttp_location.new("HC_right_wing_lobby_1N_door", "HC Right Wing Lobby 1N Door", nil, "", true, 98, 1144, 1144, 3055, 3115, {"Hyrule Castle Doors", "HC Right Wing Lobby 1N Door", "HC Right Wing Lobby 1N Door"})
HC_right_wing_lobby_N_door = alttp_location.new("HC_right_wing_lobby_N_door", "HC Right Wing Lobby N Door", nil, "", true, 98, 1272, 1272, 3055, 3115, {"Hyrule Castle Doors", "HC Right Wing Lobby N Door", "HC Right Wing Lobby N Door"})
HC_right_wing_3S_door = alttp_location.new("HC_right_wing_3S_door", "HC Right Wing 3S Door", nil, "", true, 82, 1144, 1144, 3040, 3090, {"Hyrule Castle Doors", "HC Right Wing 3S Door", "HC Right Wing 3S Door"})
HC_right_wing_S_door = alttp_location.new("HC_right_wing_S_door", "HC Right Wing S Door", nil, "", true, 82, 1272, 1272, 3020, 3090, {"Hyrule Castle Doors", "HC Right Wing S Door", "HC Right Wing S Door"})
HC_right_wing_1W_door = alttp_location.new("HC_right_wing_1W_door", "HC Right Wing 1W Door", nil, "", true, 82, 1005, 1030, 2680, 2680, {"Hyrule Castle Doors", "HC Right Wing 1W Door", "HC Right Wing 1W Door"})
HC_throne_room_S_door = alttp_location.new("HC_throne_room_S_door", "HC Throne Room S Door", nil, "", true, 81, 760, 760, 2990, 3000, {"Hyrule Castle Doors", "HC Throne Room S Door", "HC Throne Room S Door"})
HC_throne_room_N_door = alttp_location.new("HC_throne_room_N_door", "HC Throne Room N Door", nil, "", true, 81, 760, 760, 2550, 2600, {"Hyrule Castle Doors", "HC Throne Room N Door", "HC Throne Room N Door"})
HC_back_wing_2E_door = alttp_location.new("HC_back_wing_2E_door", "HC Back Wing 2E Door", nil, "", true, 1, 980, 1045, 120, 120, {"Hyrule Castle Doors", "HC Back Wing 2E Door", "HC Back Wing 2E Door"})
HC_back_wing_1W_door = alttp_location.new("HC_back_wing_1W_door", "HC Back Wing 1W Door", nil, "", true, 1, 495, 545, 120, 120, {"Hyrule Castle Doors", "HC Back Wing 1W Door", "HC Back Wing 1W Door"})
HC_back_wing_N_door = alttp_location.new("HC_back_wing_N_door", "HC Back Wing N Door", nil, "", true, 1, 755, 770, 80, 100, {"Hyrule Castle Doors", "HC Back Wing N Door", "HC Back Wing N Door"})
HC_map_chest_room_N_door = alttp_location.new("HC_map_chest_room_N_door", "HC_map Chest Room N Door", nil, "", true, 114, 1272, 1273, 3650, 3660, {"Hyrule Castle Doors", "HC_map Chest Room N Door", "HC_map Chest Room N Door"})
HC_north_abyss_S_door = alttp_location.new("HC_north_abyss_S_door", "HC North Abyss S Door", nil, "", true, 114, 1180, 1205, 4035, 4100, {"Hyrule Castle Doors", "HC North Abyss S Door", "HC North Abyss S Door"})
HC_north_abyss_balcony_3S_door = alttp_location.new("HC_north_abyss_balcony_3S_door", "HC North Abyss Balcony 3S Door", nil, "", true, 114, 1060, 1075, 4050, 4100, {"Hyrule Castle Doors", "HC North Abyss Balcony 3S Door", "HC North Abyss Balcony 3S Door"})
HC_abyss_balcony_1N_door = alttp_location.new("HC_abyss_balcony_1N_door", "HC Abyss Balcony 1N Door", nil, "", true, 130, 1060, 1075, 4055, 4120, {"Hyrule Castle Doors", "HC Abyss Balcony 1N Door", "HC Abyss Balcony 1N Door"})
HC_abyss_balcony_1W_door = alttp_location.new("HC_abyss_balcony_1W_door", "HC Abyss Balcony 1W Door", nil, "", true, 130, 995, 1050, 4185, 4215, {"Hyrule Castle Doors", "HC Abyss Balcony 1W Door", "HC Abyss Balcony 1W Door"})
HC_abyss_catwalk_N_door = alttp_location.new("HC_abyss_catwalk_N_door", "HC Abyss Catwalk N Door", nil, "", true, 130, 1180, 1205, 4055, 4015, {"Hyrule Castle Doors", "HC Abyss Catwalk N Door", "HC Abyss Catwalk N Door"})
HC_abyss_catwalk_3W_door = alttp_location.new("HC_abyss_catwalk_3W_door", "HC Abyss Catwalk 3W Door", nil, "", true, 130, 995, 1055, 4465, 4500, {"Hyrule Castle Doors", "HC Abyss Catwalk 3W Door", "HC Abyss Catwalk 3W Door"})
HC_armory_2E_door = alttp_location.new("HC_armory_2E_door", "HC Armory 2E Door", nil, "", true, 129, 980, 1040, 4185, 4215, {"Hyrule Castle Doors", "HC Armory 2E Door", "HC Armory 2E Door"})
HC_armory_4E_door = alttp_location.new("HC_armory_4E_door", "HC Armory 4E Door", nil, "", true, 129, 975, 1040, 4465, 4500, {"Hyrule Castle Doors", "HC Armory 4E Door", "HC Armory 4E Door"})
HC_armory_1N_door = alttp_location.new("HC_armory_1N_door", "HC Armory 1N Door", nil, "", true, 129, 632, 632, 4075, 4130, {"Hyrule Castle Doors", "HC Armory 1N Door", "HC Armory 1N Door"})
HC_before_boomerang_chest_room_3S_door = alttp_location.new("HC_before_boomerang_chest_room_3S_door", "HC Before Boomerang Chest Room 3S Door", nil, "", true, 113, 632, 632, 4040, 4120, {"Hyrule Castle Doors", "HC Before Boomerang Chest Room 3S Door", "HC Before Boomerang Chest Room 3S Door"})
HC_cell_hallway_1N_door = alttp_location.new("HC_cell_hallway_1N_door", "HC Cell Hallway 1N Door", nil, "", true, 113, 672, 672, 3655, 3670, {"Hyrule Castle Doors", "HC Cell Hallway 1N Door", "HC Cell Hallway 1N Door"})
HC_stairs_1N_door = alttp_location.new("HC_stairs_1N_door", "HC Stairs 1N Door", nil, "", true, 112, 161, 162, 3630, 3640, {"Hyrule Castle Doors", "HC Stairs 1N Door", "HC Stairs 1N Door"})
HC_stairs_N_door = alttp_location.new("HC_stairs_N_door", "HC Stairs N Door", nil, "", true, 112, 80, 81, 3615, 3635, {"Hyrule Castle Doors", "HC Stairs N Door", "HC Stairs N Door"})

HC_ball_guard_room_1N_door = alttp_location.new("HC_ball_guard_room_1N_door", "HC Ball Guard Room 1N Door", nil, "", true, 128, 80, 81, 4130, 4145, {"Hyrule Castle Doors", "HC Ball Guard Room 1N Door", "HC Ball Guard Room 1N Door"})

local CE_tapestry = alttp_location.new("CE_tapestry", "CE Tapestry")
local CE_snake_hall = alttp_location.new("CE_snake_hall", "CE Snake Hall")
local CE_small_sewers = alttp_location.new("CE_small_sewers", "CE Small Sewers")
local CE_large_sewers = alttp_location.new("CE_large_sewers", "CE Large Sewers")
local CE_pulley = alttp_location.new("CE_pulley", "CE Pulley")

CE_tapestry_S_door = alttp_location.new("CE_tapestry_S_door", "CE Tapestry S Door", nil, "", true, 65, 760, 760, 2530, 2585, {"Castle Escape Doors", "CE Tapestry S Door", "CE Tapestry S Door"})
CE_tapestry_N_door = alttp_location.new("CE_tapestry_N_door", "CE Tapestry N Door", nil, "", true, 65, 936, 936, 2075, 2105, {"Castle Escape Doors", "CE Tapestry N Door", "CE Tapestry N Door"})
CE_snake_hall_1N_door = alttp_location.new("CE_snake_hall_1N_door", "CE Snake Hall 1N Door", nil, "", true, 66, 1448, 1449, 2080, 2115, {"Castle Escape Doors", "CE Snake Hall 1N Door", "CE Snake Hall 1N Door"})
CE_snake_hall_2N_door = alttp_location.new("CE_snake_hall_2N_door", "CE Snake Hall 2N Door", nil, "", true, 66, 1272, 1272, 2080, 2110, {"Castle Escape Doors", "CE Snake Hall 2N Door", "CE Snake Hall 2N Door"})
CE_dark_cross_N_door = alttp_location.new("CE_dark_cross_N_door", "CE Dark Cross N Door", nil, "", true, 50, 1272, 1272, 1520, 1580, {"Castle Escape Doors", "CE Dark Cross N Door", "CE Dark Cross N Door"})
CE_dark_cross_S_door = alttp_location.new("CE_dark_cross_S_door", "CE Dark Cross S Door", nil, "", true, 50, 1272, 1272, 1975, 2000, {"Castle Escape Doors", "CE Dark Cross S Door", "CE Dark Cross S Door"})
CE_small_sewers_S_door = alttp_location.new("CE_small_sewers_S_door", "CE Small Sewers S Door", nil, "", true, 34, 1272, 1272, 1500, 1560, {"Castle Escape Doors", "CE Small Sewers S Door", "CE Small Sewers S Door"})
CE_small_sewers_W_door = alttp_location.new("CE_small_sewers_W_door", "CE Small Sewers W Door", nil, "", true, 34, 995, 1030, 1400, 1400, {"Castle Escape Doors", "CE Small Sewers W Door", "CE Small Sewers W Door"})
CE_large_sewers_E_door = alttp_location.new("CE_large_sewers_E_door", "CE Large Sewers E Door", nil, "", true, 33, 1005, 1050, 1400, 1400, {"Castle Escape Doors", "CE Large Sewers E Door", "CE Large Sewers E Door"})
-- CE_large_sewers_N_door = alttp_location.new("CE_large_sewers_N_door", "CE Large Sewers N Door", nil, "", true, 1, 1, 1, 1, 1, {"Castle Escape Doors", "CE Large Sewers N Door", "CE Large Sewers N Door"})
CE_rat_key_room_N_door = alttp_location.new("CE_rat_key_room_N_door", "CE Rat Key Room N Door", nil, "", true, 33, 888, 888, 1010, 1065, {"Castle Escape Doors", "CE Rat Key Room N Door", "CE Rat Key Room N Door"})
CE_dropdown_room_S_door = alttp_location.new("CE_dropdown_room_S_door", "CE Dropdown Room S Door", nil, "", true, 17, 888, 888, 975, 1045, {"Castle Escape Doors", "CE Dropdown Room S Door", "CE Dropdown Room S Door"})
CE_dropdown_room_N_door = alttp_location.new("CE_dropdown_room_N_door", "CE Dropdown Room N Door", nil, "", true, 17, 888, 889, 540, 570, {"Castle Escape Doors", "CE Dropdown Room N Door", "CE Dropdown Room N Door"})
CE_pulley_S_door = alttp_location.new("CE_pulley_S_door", "CE Pulley S Door", nil, "", true, 2, 1272, 1272, 460, 535, {"Castle Escape Doors", "CE Pulley S Door", "CE Pulley S Door"})
CE_yet_more_rats_N_door = alttp_location.new("CE_yet_more_rats_N_door", "CE Yet More Rats N Door", nil, "", true, 2, 1400, 1400, 65, 70, {"Castle Escape Doors", "CE Yet More Rats N Door", "CE Yet More Rats N Door"})

-- local HC_
Sanctuary_secret_door = alttp_location.new("Sanctuary_secret_door", "Sanctuary Secret Door", nil, "", true, 18, 1272, 1272, 495, 545, {"Sanctuary Doors", "Sanctuary Secret Door", "Sanctuary Secret Door"})



HC_main_entrance_inside:connect_two_ways(HC_main_hall)

HC_main_hall:connect_two_ways(HC_main_hall_N_door)
HC_main_hall:connect_two_ways(HC_main_hall_W_door)
HC_main_hall:connect_two_ways(HC_main_hall_E_door)
HC_main_hall:connect_two_ways(HC_main_hall_1W_door)

HC_main_hall_W_door:connect_two_ways_entrance("", HC_left_wing_lobby_E_door)
HC_left_wing_lobby_E_door:connect_two_ways(HC_left_wing_lobby)
HC_main_hall_1W_door:connect_two_ways_entrance("", HC_left_wing_lobby_2E_door)
HC_left_wing_lobby_2E_door:connect_two_ways(HC_left_wing_lobby)

HC_left_wing_lobby:connect_two_ways(HC_left_wing_lobby_2N_door)
HC_left_wing_lobby_2N_door:connect_two_ways_entrance("", HC_left_wing_4S_door)
HC_left_wing_4S_door:connect_two_ways(HC_left_wing)

HC_left_wing:connect_two_ways(HC_left_wing_2E_door)
HC_left_wing_2E_door:connect_two_ways_entrance("", HC_back_wing_1W_door)
HC_back_wing_1W_door:connect_two_ways(HC_back_wing)

HC_back_wing:connect_two_ways(HC_back_wing_N_door)
HC_back_wing:connect_two_ways(HC_back_wing_2E_door)
HC_back_wing_N_door:connect_two_ways_entrance("", HC_map_chest_room_N_door)

HC_back_wing_2E_door:connect_two_ways_entrance("", HC_right_wing_1W_door)
HC_right_wing_1W_door:connect_two_ways(HC_right_wing)

HC_right_wing:connect_two_ways(HC_right_wing_3S_door)
HC_right_wing_3S_door:connect_two_ways_entrance("", HC_right_wing_lobby_1N_door)
HC_right_wing_lobby_1N_door:connect_two_ways(HC_right_wing_lobby)

HC_right_wing:connect_two_ways(HC_right_wing_S_door)
HC_right_wing_S_door:connect_two_ways_entrance("", HC_right_wing_lobby_N_door)
HC_right_wing_lobby_N_door:connect_two_ways(HC_right_wing_lobby)

HC_right_wing_lobby:connect_two_ways(HC_right_wing_lobby_3W_door)

---


HC_right_wing_lobby:connect_two_ways(HC_right_entrance_inside)
HC_left_wing_lobby:connect_two_ways(HC_left_entrance_inside)

HC_main_hall_E_door:connect_two_ways_entrance("", HC_right_wing_lobby_3W_door)

HC_main_hall_N_door:connect_two_ways_entrance("", HC_throne_room_S_door)
HC_throne_room_S_door:connect_two_ways(HC_throne_room)
HC_throne_room:connect_two_ways(HC_throne_room_N_door)
HC_throne_room_N_door:connect_two_ways_entrance("", CE_tapestry_S_door)

---

HC_map_chest_room_N_door:connect_two_ways(HC_map_chest_room)
HC_map_chest_room:connect_one_way("HC - Map Chest", function() return CanInteract(HC_map_chest_room) end)
HC_map_chest_room:connect_one_way("HC - Map Guard Key Drop", function()
    return ALL(
        ANY(
            DealDamage,
            "standard"
        ),
        CanInteract(HC_map_chest_room)
    )
end)
HC_map_chest_room:connect_two_ways(HC_north_abyss, function(keys, Current_Dungeon)
    return ALL(
        ANY(
            "standard",
            Has("smallkey", keys, 0, keys + 1, 3)
        ),
        CanInteract(HC_map_chest_room)
    ), KDSreturn(keys, keys + 1)
end)

HC_north_abyss:connect_two_ways(HC_north_abyss_S_door)
HC_north_abyss_S_door:connect_two_ways_entrance("", HC_abyss_catwalk_N_door)
HC_abyss_catwalk_N_door:connect_two_ways(HC_abyss_catwalk)

HC_abyss_catwalk:connect_two_ways(HC_abyss_catwalk_3W_door)
HC_abyss_catwalk_3W_door:connect_two_ways_entrance("", HC_armory_4E_door)
HC_armory_4E_door:connect_two_ways(HC_armory)

HC_armory:connect_two_ways(HC_armory_1N_door)
HC_armory:connect_two_ways(HC_armory_2E_door)

HC_armory_2E_door:connect_two_ways_entrance("", HC_abyss_balcony_1W_door)
HC_abyss_balcony_1W_door:connect_two_ways(HC_abyss_balcony)
HC_abyss_balcony:connect_two_ways(HC_abyss_balcony_1N_door)
HC_abyss_balcony_1N_door:connect_two_ways_entrance("", HC_north_abyss_balcony_3S_door)
HC_north_abyss_balcony_3S_door:connect_two_ways(HC_north_abyss_balcony)
HC_north_abyss_balcony:connect_one_way(HC_north_abyss)

HC_armory_1N_door:connect_two_ways_entrance_door_stuck("", HC_before_boomerang_chest_room_3S_door, nil, function() return ALL(CanInteract(HC_before_boomerang_chest_room), DealDamage) end)
HC_before_boomerang_chest_room_3S_door:connect_two_ways(HC_before_boomerang_chest_room)

HC_before_boomerang_chest_room:connect_two_ways(HC_boomerang_chest_room, function()
    return ANY(
        DealDamage,
        "standard"
    )
end)
HC_boomerang_chest_room:connect_one_way("HC - Boomerang Chest")
HC_boomerang_chest_room:connect_one_way("HC - Booomerang Guard Key Drop", function()
    return ANY(
        DealDamage,
        "standard"
    )
end)
HC_before_boomerang_chest_room:connect_two_ways(HC_cell_hallway, function(keys, Current_Dungeon)
    return ANY(
        "standard",
        Has("smallkey", keys, 0, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
HC_cell_hallway:connect_two_ways(HC_cell_hallway_1N_door)
HC_cell_hallway_1N_door:connect_two_ways_entrance("", HC_stairs_1N_door)

HC_stairs_1N_door:connect_two_ways(HC_stairs)
HC_stairs:connect_two_ways(HC_stairs_N_door)





HC_stairs_N_door:connect_two_ways_entrance("", HC_ball_guard_room_1N_door)
HC_ball_guard_room_1N_door:connect_two_ways(HC_ball_guard_room)
HC_ball_guard_room:connect_one_way("HC - Big Key", function()
    return ANY(
        DealDamage,
        "standard"
    )
end)

HC_ball_guard_room:connect_two_ways(HC_zeldas_cell, function() return Has("bigkey") end)
HC_zeldas_cell:connect_one_way("HC - Zelda's Chest")

---

CE_tapestry_S_door:connect_two_ways(CE_tapestry, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_tapestry:connect_two_ways(CE_tapestry_N_door, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_tapestry_N_door:connect_one_way_entrance("", CE_snake_hall_2N_door)

CE_snake_hall_2N_door:connect_two_ways(CE_snake_hall, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_snake_hall:connect_two_ways(CE_snake_hall_1N_door, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_snake_hall_1N_door:connect_two_ways_entrance("", CE_dark_cross_S_door)

CE_dark_cross_S_door:connect_two_ways(CE_dark_cross, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_dark_cross:connect_one_way("CE - Dark Cross", function() 
    return ALL(
        ANY(
            DarkRooms(true),
            "standard"
        ),
        CanInteract(CE_dark_cross)
    )
end)
CE_dark_cross:connect_two_ways(CE_dark_cross_N_door, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_dark_cross_N_door:connect_two_ways_entrance("", CE_small_sewers_S_door, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("smallkey", keys + 1, 1, keys + 1, 3)
        ),
        ALL(
            DarkRooms(true),
            Has("smallkey", keys + 1, 1, keys + 1, 3),
            "glove"
        ),
        "standard"
    ), keys + 1
end)

CE_small_sewers_S_door:connect_two_ways(CE_small_sewers, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_small_sewers:connect_one_way(CE_small_sewers_W_door, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_small_sewers_W_door:connect_two_ways_entrance("", CE_large_sewers_E_door)

CE_large_sewers_E_door:connect_two_ways(CE_large_sewers, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)

CE_large_sewers:connect_two_ways(CE_rat_key_room)

CE_rat_key_room:connect_one_way("CE - Rat Key Drop", function(keys, Current_Dungeon)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("smallkey", keys, 1, keys, 3),
            DealDamage
        ),
        "standard"
    ), keys
end)
CE_rat_key_room:connect_two_ways(CE_rat_key_room_N_door, function(keys, Current_Dungeon)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)
CE_rat_key_room_N_door:connect_two_ways_entrance("", CE_dropdown_room_S_door, function(keys, Current_Dungeon)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("smallkey", keys, 1, keys + 1, 4)
        ),
        ALL(
            OpenOrStandard,
            DarkRooms(true),
            Has("smallkey", keys, 1, keys + 1, 4)
        ),
        "standard"
    ), KDSreturn(keys, keys + 1)
end)

CE_dropdown_room_S_door:connect_two_ways(CE_dropdown_room)
CE_dropdown_room:connect_two_ways(CE_secret_room, function()
    return ALL(
        ANY(
            "boots",
            "bombs"
        ),
        CanInteract(CE_dropdown_room)
    )
end)
CE_secret_room:connect_one_way("CE - Secret Room Left", function() return CanInteract(CE_secret_room) end)
CE_secret_room:connect_one_way("CE - Secret Room Center", function() return CanInteract(CE_secret_room) end)
CE_secret_room:connect_one_way("CE - Secret Room Right", function() return CanInteract(CE_secret_room) end)

CE_secret_room:connect_one_way(CE_dropdown_room_N_door)
CE_dropdown_room_N_door:connect_two_ways_entrance("", CE_yet_more_rats_N_door)

CE_yet_more_rats_N_door:connect_two_ways(CE_pulley)
CE_pulley:connect_two_ways(CE_pulley_S_door, function() return CanInteract(CE_pulley) end)
CE_pulley_S_door:connect_one_way_entrance("", Sanctuary_secret_door)

Sanctuary_secret_door:connect_two_ways(Sanctuary_entrance_inside)

-- CE_stairs_inside:connect_two_ways(CE_dark_cross, function(keys, Current_Dungeon)
--     return ANY(
--         DarkRooms(true),
--         "standard"
--     )
-- end)

-- CE_dark_cross:connect_two_ways(CE_rat_key_room, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             DarkRooms(true),
--             Has("smallkey", keys + 1, 1, keys + 1, 3)
--         ),
--         ALL(
--             DarkRooms(true),
--             Has("smallkey", keys + 1, 1, keys + 1, 3),
--             "glove"
--         ),
--         "standard"
--     ), keys + 1
-- end)
-- CE_dark_cross:connect_one_way("CE - Dark Cross", function() return CanInteract(CE_dark_cross) end)

-- -- CE_rat_key_room:connect_two_ways(CE_dropdown_entrance)
-- CE_rat_key_room:connect_two_ways(CE_dropdown_room, function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             DarkRooms(true),
--             Has("smallkey", keys, 1, keys + 1, 4)
--         ),
--         -- ALL(
--         --     Has("golve"),
--         --     OpenOrStandard,
--         --     DarkRooms(),
--         --     Has("smallkey", keys, 1, keys + 1, 1)
--         -- ),
--         ALL(
--             OpenOrStandard,
--             DarkRooms(true),
--             Has("smallkey", keys, 1, keys + 1, 4)
--         ),
--         "standard"
--     ), KDSreturn(keys, keys + 1)
-- end)
-- CE_rat_key_room:connect_one_way("CE - Rat Key Drop", function(keys, Current_Dungeon)
--     return ANY(
--         ALL(
--             DarkRooms(true),
--             Has("smallkey", keys, 1, keys, 3),
--             DealDamage
--         ),
--         "standard"
--     ), keys
-- end)
-- CE_dropdown_entrance_inside:connect_one_way(CE_dropdown_room)
-- CE_dropdown_room:connect_two_ways(CE_secret_room, function()
--     return ALL(
--         ANY(
--             "boots",
--             "bombs"
--         ),
--         CanInteract(CE_dropdown_room)
--     )
-- end)
-- CE_secret_room:connect_one_way("CE - Secret Room Left", function() return CanInteract(CE_secret_room) end)
-- CE_secret_room:connect_one_way("CE - Secret Room Center", function() return CanInteract(CE_secret_room) end)
-- CE_secret_room:connect_one_way("CE - Secret Room Right", function() return CanInteract(CE_secret_room) end)

-- CE_dropdown_room:connect_one_way(Sanctuary_entrance_inside, function() return CanInteract(CE_dropdown_entrance_inside) end)