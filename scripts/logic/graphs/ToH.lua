-- ToH_entrance = alttp_location.new("", nil, nil, "ToH", true)
local ToH_basement_cage = alttp_location.new("ToH_basement_cage", "ToH Basement Cage", nil, "ToH", true)
local ToH_main_room = alttp_location.new("ToH_main_room", "ToH Main", nil, "ToH", true)
local ToH_big_key_chest = alttp_location.new("ToH_big_key_chest", "ToH Basement Back", nil, "ToH", true)
local ToH_big_chest_room = alttp_location.new("ToH_big_chest_room", "ToH Big Chest Floor", nil, "ToH", true)
local ToH_boss_room = alttp_location.new("ToH_boss_room", "ToH Boss Floor", nil, "ToH", true)
-- local ToH_before_boss_floor = alttp_location.new("ToH_before_boss_floor", "ToH Below Boss", nil, "ToH", true)
ToH_fairy_drop = alttp_location.new("ToH_fairy_drop", "ToH Boss Floor", nil, "ToH", true)
local ToH_above_big_chest = alttp_location.new("ToH_above_big_chest", "ToH Boss Dropdown", nil, "ToH", true)


ToH_entrance_inside:connect_two_ways(ToH_main_room, function()
    return ALL(
        CanInteract(ToH_entrance_inside),
        ANY(
            DealDamage,
            "redboomerang",
            "blueboomerang",
            "icerod"
        )
    )
end)
ToH_main_room:connect_two_ways(ToH_big_key_chest, function(keys) return ALL(Has("toh_smallkey", keys + 1, 1, keys + 1, 1), CanInteract(ToH_main_room)), keys + 1 end)
ToH_main_room:connect_two_ways(ToH_big_chest_room, function()
    return ALL(
        ANY(
            "toh_bigkey",
            ALL(
                CheckGlitches(2),
                "hookshot"
            ) -- hera pot
        ),
        CanInteract(ToH_main_room)
    )
end)
ToH_main_room:connect_one_way("ToH - Map Chest", function() return CanInteract(ToH_main_room) end)
ToH_main_room:connect_two_ways(ToH_basement_cage)

ToH_basement_cage:connect_one_way("ToH - Basement Cage", function() return CanInteract(ToH_basement_cage) end)
ToH_big_key_chest:connect_one_way("ToH - Big Key Chest", function() return Has("firesource") end)

ToH_big_chest_room:connect_two_ways(ToH_above_big_chest)
ToH_big_chest_room:connect_one_way("ToH - Compass Chest")

ToH_above_big_chest:connect_two_ways(ToH_boss_room)
ToH_above_big_chest:connect_one_way(ToH_fairy_drop)
ToH_above_big_chest:connect_one_way("ToH - Big Chest", function() return Has("toh_bigkey") end)

ToH_fairy_drop:connect_one_way(ToH_above_big_chest)

ToH_boss_room:connect_one_way("ToH - Boss", function() return GetBossRef("toh_boss") end)