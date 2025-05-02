-- hc_main_entrance =alttp_location.new("")
-- hc_left_entrance =alttp_location.new("")
-- hc_right_entrance =alttp_location.new("")
local hc_back_hall = alttp_location.new("hc_back_hall")
local hc_map_chest_room = alttp_location.new("hc_map_chest_room")
local hc_before_boomerang_chest_room = alttp_location.new("hc_before_boomerang_chest_room")
local hc_boomerang_chest_room = alttp_location.new("hc_boomerang_chest_room")
local hc_ball_guard_room = alttp_location.new("hc_ball_guard_room")
local hc_zeldas_cell = alttp_location.new("hc_zeldas_cell")
-- ce_stairs =alttp_location.new("")
-- ce_dropdown_entrance =alttp_location.new("")
local ce_dark_cross = alttp_location.new("ce_dark_cross")
local ce_rat_key_room = alttp_location.new("ce_rat_key_room")
local ce_secret_room = alttp_location.new("ce_secret_room")

hc_main_entrance:connect_two_ways(hyrule_castle_top_left)
hc_main_entrance:connect_two_ways(hyrule_castle_top_right)
hc_main_entrance:connect_two_ways(hc_back_hall)
hc_main_entrance:connect_one_way(ce_stairs, function() return can_interact("light", 1) end)

hc_left_entrance:connect_two_ways(hc_back_hall, function() return can_interact("light", 1) end)
hc_right_entrance:connect_two_ways(hc_back_hall, function() return can_interact("light", 1) end)

hc_back_hall:connect_two_ways(hc_map_chest_room)
hc_map_chest_room:connect_one_way("HC - Map Chest")
hc_map_chest_room:connect_one_way("HC - Map Guard Key Drop", function() 
    return any(
        dealDamage(), 
        has("standard")
    ) 
end)

hc_map_chest_room:connect_two_ways(hc_before_boomerang_chest_room, function(keys) 
    return any(
        has("standard"),
        has("hc_smallkey", keys, 0, keys + 1, 3)
    ), KDSreturn(keys, keys + 1)
end)
hc_before_boomerang_chest_room:connect_two_ways(hc_boomerang_chest_room, function() 
    return any(
        dealDamage(), 
        has("standard")
    ) 
end)
hc_boomerang_chest_room:connect_one_way("HC - Boomerang Chest")
hc_boomerang_chest_room:connect_one_way("HC - Booomerang Guard Key Drop", function() 
    return any(
        dealDamage(), 
        has("standard")
    ) 
end)

hc_before_boomerang_chest_room:connect_two_ways(hc_ball_guard_room, function(keys) 
    return any(
        has("standard"),
        has("hc_smallkey", keys, 0, keys + 1, 4)
    ), KDSreturn(keys, keys + 1)
end)
hc_ball_guard_room:connect_one_way("HC - Big Key", function() 
    return any(
        dealDamage(), 
        has("standard")
    ) 
end)

hc_ball_guard_room:connect_two_ways(hc_zeldas_cell, function() return has("hc_bigkey") end)
hc_zeldas_cell:connect_one_way("HC - Zelda's Chest")

ce_stairs:connect_two_ways(ce_dark_cross, function(keys) 
    return any(
        darkRooms(),
        has("standard")
    )
end)

ce_dark_cross:connect_two_ways(ce_rat_key_room, function(keys) 
    return any(
        all(
            darkRooms(),
            smallKeys("hc_smallkey", keys + 1, 1, keys + 1, 3)
        ),
        all(
            darkRooms(),
            smallKeys("hc_smallkey", keys + 1, 1, keys + 1, 3),
            has("glove")
        ),
        has("standard")
    ), KDSreturn(keys + 1, keys + 1) 
end)
ce_dark_cross:connect_one_way("CE - Dark Cross")

-- ce_rat_key_room:connect_two_ways(ce_dropdown_entrance) 
ce_rat_key_room:connect_two_ways(ce_dropdown_entrance, function(keys) 
    return any(
        all(
            darkRooms(),
            has("hc_smallkey", keys, 1, keys + 1, 4)
        ),
        -- all(
        --     has("golve"),
        --     openOrStandard(),
        --     darkRooms(),
        --     has("hc_smallkey", keys, 1, keys + 1, 1)
        -- ),
        all(
            openOrStandard(),
            darkRooms(),
            has("hc_smallkey", keys, 1, keys + 1, 4)
        ),
        has("standard")
    ), KDSreturn(keys, keys + 1) 
end)
ce_rat_key_room:connect_one_way("CE - Rat Key Drop", function(keys) 
    return any(
        all(
            darkRooms(),
            has("hc_smallkey", keys, 1, keys, 3),
            dealDamage()
        ),
        has("standard")
    ), KDSreturn(keys, keys)
end)

ce_dropdown_entrance:connect_two_ways(ce_secret_room, function() 
    return any(
        has("boots"), 
        has("bombs")
    )
end)
ce_secret_room:connect_one_way("CE - Secret Room Left")
ce_secret_room:connect_one_way("CE - Secret Room Center")
ce_secret_room:connect_one_way("CE - Secret Room Right")

ce_dropdown_entrance:connect_one_way(sanctuary_entrance)