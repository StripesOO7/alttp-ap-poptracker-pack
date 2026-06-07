-- HC_main_entrance =alttp_location.new("", nil, nil, "HC", true)
-- HC_left_entrance =alttp_location.new("", nil, nil, "HC", true)
-- HC_right_entrance =alttp_location.new("", nil, nil, "HC", true)
local HC_back_hall = alttp_location.new("HC_back_hall", "HC Back Hall", nil, "HC", true)
local HC_main_hall = alttp_location.new("HC_main_hall", "HC Main Hall", nil, "HC", true)
local HC_left_wing = alttp_location.new("HC_left_wing", "HC Left Wing", nil, "HC", true)
local HC_right_wing = alttp_location.new("HC_right_wing", "HC Right Wing", nil, "HC", true)
local HC_back_wing = alttp_location.new("HC_back_wing", "HC Back Hallway", nil, "HC", true)
local HC_map_chest_room = alttp_location.new("HC_map_chest_room", "HC First Guard", nil, "HC", true)
local HC_before_boomerang_chest_room = alttp_location.new("HC_before_boomerang_chest_room", "HC Before Boomerang", nil, "HC", true)
local HC_boomerang_chest_room = alttp_location.new("HC_boomerang_chest_room", "HC Boomerang Chest", nil, "HC", true)
local HC_ball_guard_room = alttp_location.new("HC_ball_guard_room", "HC Cell Guard", nil, "HC", true)
local HC_zeldas_cell = alttp_location.new("HC_zeldas_cell", "HC Zeldas Cell", nil, "HC", true)
-- CE_stairs =alttp_location.new("", nil, nil, "CE", true)
-- CE_dropdown_entrance =alttp_location.new("", nil, nil, "CE", true)
local CE_dark_cross = alttp_location.new("CE_dark_cross", "CE ", nil, "CE", true)
local CE_rat_key_room = alttp_location.new("CE_rat_key_room", "CE ", nil, "CE", true)
local CE_secret_room = alttp_location.new("CE_secret_room", "CE ", nil, "CE", true)
local CE_dropdown_room = alttp_location.new("CE_dropdown_room", "CE ", nil, "CE", true)

HC_main_entrance_inside:connect_two_ways(HC_main_hall)

HC_main_hall:connect_two_ways(HC_left_wing)
HC_main_hall:connect_two_ways(HC_right_wing)
HC_main_hall:connect_two_ways(HC_back_hall)

HC_left_wing:connect_two_ways(HC_left_entrance_inside)
HC_left_wing:connect_two_ways(HC_back_wing)
HC_right_wing:connect_two_ways(HC_right_entrance_inside)
HC_right_wing:connect_two_ways(HC_back_wing)
HC_back_hall:connect_one_way(CE_stairs_inside, function() return CanInteract(HC_back_hall) end)

-- HC_left_entrance:connect_two_ways(HC_back_hall, function() return CanInteract("", end)
-- HC_right_entrance:connect_two_ways(HC_back_hall, function() return CanInteract("", end)

HC_back_wing:connect_two_ways(HC_map_chest_room)
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

HC_map_chest_room:connect_two_ways(HC_before_boomerang_chest_room, function(keys)
    return ALL(
        ANY(
            "standard",
            Has("hc_smallkey", keys, 0, keys + 1, 3)
        ),
        CanInteract(HC_map_chest_room)
    ), KDSreturn(keys, keys + 1)
end)
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

HC_before_boomerang_chest_room:connect_two_ways(HC_ball_guard_room, function(keys)
    return ANY(
        "standard",
        Has("hc_smallkey", keys, 0, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
HC_ball_guard_room:connect_one_way("HC - Big Key", function()
    return ANY(
        DealDamage,
        "standard"
    )
end)

HC_ball_guard_room:connect_two_ways(HC_zeldas_cell, function() return Has("hc_bigkey") end)
HC_zeldas_cell:connect_one_way("HC - Zelda's Chest")

CE_stairs_inside:connect_two_ways(CE_dark_cross, function(keys)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)

CE_dark_cross:connect_two_ways(CE_rat_key_room, function(keys)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("hc_smallkey", keys + 1, 1, keys + 1, 3)
        ),
        ALL(
            DarkRooms(true),
            Has("hc_smallkey", keys + 1, 1, keys + 1, 3),
            "glove"
        ),
        "standard"
    ), keys + 1
end)
CE_dark_cross:connect_one_way("CE - Dark Cross", function() return CanInteract(CE_dark_cross) end)

-- CE_rat_key_room:connect_two_ways(CE_dropdown_entrance)
CE_rat_key_room:connect_two_ways(CE_dropdown_room, function(keys)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("hc_smallkey", keys, 1, keys + 1, 4)
        ),
        -- ALL(
        --     Has("golve"),
        --     OpenOrStandard,
        --     DarkRooms(),
        --     Has("hc_smallkey", keys, 1, keys + 1, 1)
        -- ),
        ALL(
            OpenOrStandard,
            DarkRooms(true),
            Has("hc_smallkey", keys, 1, keys + 1, 4)
        ),
        "standard"
    ), KDSreturn(keys, keys + 1)
end)
CE_rat_key_room:connect_one_way("CE - Rat Key Drop", function(keys)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("hc_smallkey", keys, 1, keys, 3),
            DealDamage
        ),
        "standard"
    ), keys
end)
CE_dropdown_entrance_inside:connect_one_way(CE_dropdown_room)
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

CE_dropdown_room:connect_one_way(Sanctuary_entrance_inside, function() return CanInteract(CE_dropdown_entrance_inside) end)