-- toh_entrance = alttp_location.new("", nil, nil, true)
local toh_basement_cage = alttp_location.new("toh_basement_cage", "ToH Basement Cage", nil, true)
local toh_main_room = alttp_location.new("toh_main_room", "ToH Main", nil, true)
local toh_big_key_chest = alttp_location.new("toh_big_key_chest", "ToH Basement Back", nil, true)
local toh_big_chest_room = alttp_location.new("toh_big_chest_room", "ToH Big Chest Floor", nil, true)
local toh_boss_room = alttp_location.new("toh_boss_room", "ToH Boss Floor", nil, true)
local toh_above_big_chest = alttp_location.new("toh_above_big_chest", "ToH Boss Dropdown", nil, true)


toh_entrance_inside:connect_two_ways(toh_main_room, function()
    return ALL(
        CanInteract(toh_entrance_inside),
        ANY(
            DealDamage,
            "redboomerang",
            "blueboomerang",
            "icerod"
        )
    )
end)
toh_main_room:connect_two_ways(toh_big_key_chest, function(keys) return ALL(Has("toh_smallkey", keys + 1, 1, keys + 1, 1), CanInteract(toh_main_room)), keys + 1 end)
toh_main_room:connect_two_ways(toh_big_chest_room, function()
    return ALL(
        ANY(
            "toh_bigkey",
            ALL(
                CheckGlitches(2),
                "hookshot"
            )
        ),
        CanInteract(toh_main_room)
    )
end)
toh_main_room:connect_one_way("ToH - Map Chest", function() return CanInteract(toh_main_room) end)

toh_basement_cage:connect_one_way("ToH - Basement Cage", function() return CanInteract(toh_basement_cage) end)
toh_big_key_chest:connect_one_way("ToH - Big Key Chest", function() return Has("firesource") end)

toh_big_chest_room:connect_two_ways(toh_above_big_chest)
toh_big_chest_room:connect_one_way("ToH - Compass Chest")

toh_above_big_chest:connect_two_ways(toh_boss_room)
toh_above_big_chest:connect_one_way("ToH - Big Chest", function() return Has("toh_bigkey") end)

toh_boss_room:connect_one_way("ToH - Boss", function() return GetBossRef("toh_boss") end)