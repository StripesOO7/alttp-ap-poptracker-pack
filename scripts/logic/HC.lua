-- hc_main_entrance =alttp_location.new("", nil, nil, true)
-- hc_left_entrance =alttp_location.new("", nil, nil, true)
-- hc_right_entrance =alttp_location.new("", nil, nil, true)
local hc_back_hall = alttp_location.new("hc_back_hall", nil, nil, true)
local hc_main_hall = alttp_location.new("hc_main_hall", nil, nil, true)
local hc_left_wing = alttp_location.new("hc_left_wing", nil, nil, true)
local hc_right_wing = alttp_location.new("hc_right_wing", nil, nil, true)
local hc_back_wing = alttp_location.new("hc_back_wing", nil, nil, true)
local hc_map_chest_room = alttp_location.new("hc_map_chest_room", nil, nil, true)
local hc_before_boomerang_chest_room = alttp_location.new("hc_before_boomerang_chest_room", nil, nil, true)
local hc_boomerang_chest_room = alttp_location.new("hc_boomerang_chest_room", nil, nil, true)
local hc_ball_guard_room = alttp_location.new("hc_ball_guard_room", nil, nil, true)
local hc_zeldas_cell = alttp_location.new("hc_zeldas_cell", nil, nil, true)
-- ce_stairs =alttp_location.new("", nil, nil, true)
-- ce_dropdown_entrance =alttp_location.new("", nil, nil, true)
local ce_dark_cross = alttp_location.new("ce_dark_cross", nil, nil, true)
local ce_rat_key_room = alttp_location.new("ce_rat_key_room", nil, nil, true)
local ce_secret_room = alttp_location.new("ce_secret_room", nil, nil, true)
local ce_dropdown_room = alttp_location.new("ce_dropdown_room", nil, nil, true)

hc_main_entrance_inside:connect_two_ways(hc_main_hall)

hc_main_hall:connect_two_ways(hc_left_wing)
hc_main_hall:connect_two_ways(hc_right_wing)
hc_main_hall:connect_two_ways(hc_back_hall)

hc_left_wing:connect_two_ways(hc_left_entrance_inside)
hc_left_wing:connect_two_ways(hc_back_wing)
hc_right_wing:connect_two_ways(hc_right_entrance_inside)
hc_right_wing:connect_two_ways(hc_back_wing)
hc_back_hall:connect_one_way(ce_stairs_inside, function() return CanInteract(hc_back_hall) end)

-- hc_left_entrance:connect_two_ways(hc_back_hall, function() return CanInteract("", end)
-- hc_right_entrance:connect_two_ways(hc_back_hall, function() return CanInteract("", end)

hc_back_wing:connect_two_ways(hc_map_chest_room)
hc_map_chest_room:connect_one_way("HC - Map Chest", function() return CanInteract(hc_map_chest_room) end)
hc_map_chest_room:connect_one_way("HC - Map Guard Key Drop", function()
    return ALL(
        ANY(
            DealDamage,
            "standard"
        ),
        CanInteract(hc_map_chest_room)
    )
end)

hc_map_chest_room:connect_two_ways(hc_before_boomerang_chest_room, function(keys)
    return ALL(
        ANY(
            "standard",
            Has("hc_smallkey", keys, 0, keys + 1, 3)
        ),
        CanInteract(hc_map_chest_room)
    ), KDSreturn(keys, keys + 1)
end)
hc_before_boomerang_chest_room:connect_two_ways(hc_boomerang_chest_room, function()
    return ANY(
        DealDamage,
        "standard"
    )
end)
hc_boomerang_chest_room:connect_one_way("HC - Boomerang Chest")
hc_boomerang_chest_room:connect_one_way("HC - Booomerang Guard Key Drop", function()
    return ANY(
        DealDamage,
        "standard"
    )
end)

hc_before_boomerang_chest_room:connect_two_ways(hc_ball_guard_room, function(keys)
    return ANY(
        "standard",
        Has("hc_smallkey", keys, 0, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
hc_ball_guard_room:connect_one_way("HC - Big Key", function()
    return ANY(
        DealDamage,
        "standard"
    )
end)

hc_ball_guard_room:connect_two_ways(hc_zeldas_cell, function() return Has("hc_bigkey") end)
hc_zeldas_cell:connect_one_way("HC - Zelda's Chest")

ce_stairs_inside:connect_two_ways(ce_dark_cross, function(keys)
    return ANY(
        DarkRooms(true),
        "standard"
    )
end)

ce_dark_cross:connect_two_ways(ce_rat_key_room, function(keys)
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
ce_dark_cross:connect_one_way("CE - Dark Cross", function() return CanInteract(ce_dark_cross) end)

-- ce_rat_key_room:connect_two_ways(ce_dropdown_entrance)
ce_rat_key_room:connect_two_ways(ce_dropdown_room, function(keys)
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
ce_rat_key_room:connect_one_way("CE - Rat Key Drop", function(keys)
    return ANY(
        ALL(
            DarkRooms(true),
            Has("hc_smallkey", keys, 1, keys, 3),
            DealDamage
        ),
        "standard"
    ), keys
end)
ce_dropdown_entrance_inside:connect_one_way(ce_dropdown_room)
ce_dropdown_room:connect_two_ways(ce_secret_room, function()
    return ALL(
        ANY(
            "boots",
            "bombs"
        ),
        CanInteract(ce_dropdown_room)
    )
end)
ce_secret_room:connect_one_way("CE - Secret Room Left", function() return CanInteract(ce_secret_room) end)
ce_secret_room:connect_one_way("CE - Secret Room Center", function() return CanInteract(ce_secret_room) end)
ce_secret_room:connect_one_way("CE - Secret Room Right", function() return CanInteract(ce_secret_room) end)

ce_dropdown_room:connect_one_way(sanctuary_entrance_inside, function() return CanInteract(ce_dropdown_entrance_inside) end)