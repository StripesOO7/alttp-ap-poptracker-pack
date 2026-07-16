-- region names

-- kakariko village
-- south of village
-- cemetary
-- lost woods
-- dam-area
-- desert
-- lake hylia
-- light death mountain
-- eastern palace
-- zora river
-- hyrule castle/centre area

-- AccessibilityLevel.None
-- AccessibilityLevel.Partial
-- ACCESS_INSPECT
-- ACCESS_SEQUENCEBREAK
-- ACCESS_NORMAL
-- AccessibilityLevel.Cleared




Light_flute_map:connect_one_way(Light_death_mountain_left_bottom)
Light_flute_map:connect_one_way(Witchhut)
Light_flute_map:connect_one_way(Kakariko_village)
Light_flute_map:connect_one_way(Links_house_area)
Light_flute_map:connect_one_way(Eastern_palace_area)
Light_flute_map:connect_one_way(Teleporter_at_Desert_ledge)
Light_flute_map:connect_one_way(Dam_area)
Light_flute_map:connect_one_way(Light_lake_hylia)

Teleporter_at_kakariko_village:connect_one_way(Teleporter_at_village_of_the_outcast, function() return Has("glove") end)

Teleporter_at_light_turtle_rock:connect_one_way(Teleporter_at_dark_turtle_rock)
Teleporter_at_light_death_mountain_left_bottom:connect_one_way(Teleporter_at_dark_death_mountain_left_bottom)

Teleporter_at_light_death_mountain_right_bottom:connect_one_way(Teleporter_at_dark_death_mountain_right_bottom)

Teleporter_at_eastern:connect_one_way(Teleporter_at_pod, function() return Has("glove") end)

Teleporter_at_desert:connect_one_way(Teleporter_at_mire)

Teleporter_at_dam:connect_one_way(Teleporter_at_swamp, function() return Has("glove") end)

Teleporter_at_upgrade_fairy:connect_one_way(Teleporter_at_ice_palace, function() return ALL("titans", OpenOrStandard)  end)


--
Lightworld_spawns:connect_one_way(Light_spawn_sanctuary)
Lightworld_spawns:connect_one_way(Light_spawn_Links_house_area)
Lightworld_spawns:connect_one_way(Light_spawn_old_man, function() return CanReach("Old_man_cave_right_inside") end) --rescued old man

Light_spawn_sanctuary:connect_one_way(Sanctuary_entrance_inside, function() return OpenOrStandard() end)
Light_spawn_Links_house_area:connect_one_way(Links_house_inside, function() return OpenOrStandard() end)
Light_spawn_old_man:connect_one_way(Old_man_home_bottom_inside, function() return OpenOrStandard() end)

-- Kakariko_village
Kakariko_village:connect_one_way(South_of_village)
Kakariko_village:connect_one_way(Lost_woods)
-- Kakariko_village:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)







--
Kakariko_village:connect_one_way(Teleporter_at_kakariko_village, function()
    return ANY(
        "hammer",
        "titans"
    )
end)
Teleporter_at_kakariko_village:connect_one_way(Kakariko_village, function()
    return ALL(
        ANY(
        "hammer",
        "titans"
        ),
        Inverted,
        "pearl"
    )
end)

Kakariko_village:connect_one_way(Kakariko_well_hole_outside)
Kakariko_village:connect_two_ways(Kakariko_well_cave_outside)
Kakariko_village:connect_two_ways(Kakariko_blinds_hideout_outside)
Kakariko_village:connect_two_ways(Kakariko_elder_house_left_outside)
Kakariko_village:connect_two_ways(Kakariko_elder_house_right_outside)
Kakariko_village:connect_two_ways(Kakariko_snitch_house_left_outside)
Kakariko_village:connect_two_ways(Kakariko_snitch_house_right_outside)
Kakariko_village:connect_two_ways(Kakariko_chickenhut_outside)
Kakariko_village:connect_two_ways(Kakariko_sick_kid_outside)
Kakariko_village:connect_two_ways(Kakariko_overgrown_house_outside, function() return CanInteract(Kakariko_village) end)
Kakariko_village:connect_two_ways_stuck(Kakariko_bombhut_outside, function()
    return ALL(
        "bombs",
        CanInteract(Kakariko_village)
    )
end,
function()
    return CanInteract(Kakariko_village)
end)
Kakariko_village:connect_two_ways(Kakariko_shop_outside)
Kakariko_village:connect_two_ways(Kakariko_frontside_pub_outside)
Kakariko_village:connect_two_ways(Kakariko_backside_pub_outside)

Kakariko_village:connect_two_ways(Dwarf_smiths_outside)
Kakariko_village:connect_one_way(Hammer_peg_field, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)
Kakariko_village:connect_two_ways(Magic_bat_hole_ledge, function()
    return ALL(
        ANY(
            "hammer",
            ALL(
                CanChangeWorldWithMirror,
                CanReach("Hammer_peg_field"),
                OpenOrStandard
            )
        ),
        CanInteract(Kakariko_village)
    )
end)
Kakariko_village:connect_two_ways(Magic_bat_cave_outside)
Kakariko_village:connect_two_ways(Kakariko_furtune_teller_outside)

Kakariko_village:connect_two_ways(Light_activate_flute, function() return ALL("flute", CanInteract(Kakariko_village)) end)

Magic_bat_hole_ledge:connect_one_way(Magic_bat_hole_outside)
-- OWG
Kakariko_village:connect_one_way(Magic_bat_hole_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Bat Cave River Clip Spot
-- OWG end

Kakariko_village:connect_one_way("Bottle Merchant")


Kakariko_well_hole_outside:connect_one_way_entrance("Kakariko Well Hole", Kakariko_well_hole_inside)
Magic_bat_hole_outside:connect_one_way_entrance("Kakariko Magic Bat Hole", Magic_bat_hole_inside)
Kakariko_well_cave_outside:connect_two_ways_entrance("Kakariko Well Cave", Kakariko_well_cave_inside)
Kakariko_blinds_hideout_outside:connect_two_ways_entrance("Kakariko Blind's hideout", Kakariko_blinds_hideout_inside)
Kakariko_elder_house_left_outside:connect_two_ways_entrance("Kakariko Elder House Left", Kakariko_elder_house_left_inside)
Kakariko_elder_house_right_outside:connect_two_ways_entrance("Kakariko Elder House Right", Kakariko_elder_house_right_inside)
Kakariko_snitch_house_left_outside:connect_two_ways_entrance("Kakariko Snitch House Left", Kakariko_snitch_house_left_inside)
Kakariko_snitch_house_right_outside:connect_two_ways_entrance("Kakariko Snitch House Right", Kakariko_snitch_house_right_inside)
Kakariko_overgrown_house_outside:connect_two_ways_entrance("Kakariko Overgrown House", Kakariko_overgrown_house_inside)
Kakariko_sick_kid_outside:connect_two_ways_entrance("Kakariko Sick Kid", Kakariko_sick_kid_inside)
Kakariko_chickenhut_outside:connect_two_ways_entrance("Kakariko Chickenhut", Kakariko_chickenhut_inside)
Kakariko_bombhut_outside:connect_two_ways_entrance("Kakariko Bombhut", Kakariko_bombhut_inside)
Kakariko_backside_pub_outside:connect_two_ways_entrance("Kakariko Backside Pub", Kakariko_backside_pub_inside)
Kakariko_frontside_pub_outside:connect_two_ways_entrance("Kakariko Frontside Pub", Kakariko_frontside_pub_inside)
Kakariko_shop_outside:connect_two_ways_entrance("Kakariko Shop", Kakariko_shop_inside)
Magic_bat_cave_outside:connect_two_ways_entrance("Kakariko Magic Bat Cave", Magic_bat_cave_inside)
Dwarf_smiths_outside:connect_two_ways_entrance("Kakariko Dwarf Smiths", Dwarf_smiths_inside)
Kakariko_furtune_teller_outside:connect_two_ways_entrance("Kakariko Fortune Teller", Kakariko_furtune_teller_inside)
-- Kakariko_village:connect_one_way(Hammer_peg_field, function()
--     return ALL(
--         Inverted,
--         CanChangeWorldWithMirror()
--     )
-- end)
Kakariko_overgrown_house_outside:connect_one_way(Dark_village_shop_outside, function() 
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Kakariko_well_hole_inside:connect_one_way(Kakariko_well_ledge)
Kakariko_well_ledge:connect_one_way(Kakariko_well_cave_inside)
Kakariko_well_ledge:connect_one_way("Kakariko Well - Top", function()
    return ALL(
        "bombs",
        CanInteract(Kakariko_well_ledge)
    )
end)
Kakariko_well_ledge:connect_one_way("Kakariko Well - Left", function() return CanInteract(Kakariko_well_ledge) end) -- can interact as bunny
Kakariko_well_ledge:connect_one_way("Kakariko Well - Middle", function() return CanInteract(Kakariko_well_ledge) end) -- can interact as bunny
Kakariko_well_ledge:connect_one_way("Kakariko Well - Right", function() return CanInteract(Kakariko_well_ledge) end) -- can interact as bunny
Kakariko_well_ledge:connect_one_way("Kakariko Well - Bottom", function() return CanInteract(Kakariko_well_ledge) end) -- can interact as bunny





Kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Back", function() return ALL("bombs", CanInteract(Kakariko_blinds_hideout_inside, "bombs")) end)
Kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Far Left", function() return CanInteract(Kakariko_blinds_hideout_inside) end)
Kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Left", function() return CanInteract(Kakariko_blinds_hideout_inside) end)
Kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Right", function() return CanInteract(Kakariko_blinds_hideout_inside) end)
Kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Far Right", function() return CanInteract(Kakariko_blinds_hideout_inside) end)

Kakariko_elder_house_left_inside:connect_two_ways(Kakariko_elder_house_right_inside)


Kakariko_chickenhut_inside:connect_one_way("Chicken Hut", function() return ALL("bombs", CanInteract(Kakariko_chickenhut_inside, "bombs")) end)


Kakariko_sick_kid_inside:connect_one_way("Sick Kid", function() return Has("bottle") end) -- can interact as bunny






Kakariko_shop_inside:connect_one_way("Kakariko Shop Left")
Kakariko_shop_inside:connect_one_way("Kakariko Shop Center")
Kakariko_shop_inside:connect_one_way("Kakariko Shop Right")


Kakariko_backside_pub_inside:connect_one_way("Backside Pub", function() return CanInteract(Kakariko_backside_pub_inside) end)




Dwarf_smiths_inside:connect_one_way("Rescue Dwarf")


-- Kakariko_village:connect_one_way(Magic_bat_hole, function()
--     return ANY(
--         "hammer",
--         ALL(
--             CanReach("Hammer_peg_field")),
--             "mirror"
--         )
--     )
-- end)


Magic_bat_hole_inside:connect_one_way(Magic_bat_item)
Magic_bat_hole_inside:connect_one_way(Magic_bat_cave_inside)

Magic_bat_item:connect_one_way("Magic Bat", function()
    return ANY(
        ALL(
            "powder", CanInteract(Magic_bat_item, "powder")
        ),
        ALL(
            CheckGlitches(2),
            ALL("somaria", CanInteract(Magic_bat_item, "somaria")),
            ALL("mushroom", CanInteract(Magic_bat_item, "mushroom"))
        )
    )
end)


-- South_of_village
South_of_village:connect_one_way(Kakariko_village)
South_of_village:connect_one_way(Links_house_area)
-- South_of_village:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard
--     )
-- end)


South_of_village:connect_two_ways(Library_outside)
South_of_village:connect_two_ways(Kakariko_chest_minigame_outside)
South_of_village:connect_two_ways(Twin_house_right_outside)

South_of_village:connect_one_way(Helpless_frog, function() 
    return ALL(
        Inverted, 
        CanChangeWorldWithMirror
    )
end)

-- OWG
South_of_village:connect_one_way(Cave45_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end)
South_of_village:connect_one_way(Checkerboard_lege, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end)
-- OWG end

-- South_of_village:connect_two_ways_entrance()

Library_outside:connect_two_ways_entrance("Library", Library_inside)
Kakariko_chest_minigame_outside:connect_two_ways_entrance("Light Chest Minigame", Kakariko_chest_minigame_inside)
Twin_house_right_outside:connect_two_ways_entrance("Twin House Right", Twin_house_right_inside)

Library_inside:connect_one_way("Library Item", function()
    return ANY(
        ALL(
            "boots",
            CanInteract(Library_inside, "boots")
        ),
        ACCESS_INSPECT
    )
end)



--


Twin_house_right_inside:connect_one_way(Twin_house_left_inside, function()
    return ANY(
        ALL("bombs", CanInteract(Twin_house_right_inside, "bombs")),
        ALL("boots", CanInteract(Twin_house_right_inside, "boots"))
    )
end)
Twin_house_left_inside:connect_one_way(Twin_house_right_inside, function()
    return ANY(
        ALL("bombs", CanInteract(Twin_house_right_inside, "bombs")),
        ALL("boots", CanInteract(Twin_house_right_inside, "boots"))
    )
end)

Twin_house_left_outside:connect_two_ways_entrance("Twin House Left", Twin_house_left_inside)

Twin_house_left_outside:connect_two_ways(Race_ledge)
-- Twin_house_left:connect_one_way(South_of_village)
Race_ledge:connect_one_way(South_of_village)
Race_ledge:connect_two_ways(Race_ledge_finish, function() return CanInteract(Race_ledge) end)
Race_ledge_finish:connect_one_way("Race Minigame")
South_of_village:connect_one_way("Race Minigame", function() return ACCESS_INSPECT end)

-- OWG
South_of_village:connect_two_ways(Race_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end)

South_of_village:connect_two_ways(Race_ledge_finish, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end)

South_of_village:connect_two_ways(Desert_area_boots_clip, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end)
-- OWG end

-- Sanctuary_area
Sanctuary_area:connect_one_way(Lost_woods)
Sanctuary_area:connect_one_way(Eastern_palace_area)
-- Sanctuary_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Sanctuary_area:connect_one_way(Light_lake_hylia, function()
    return Has("flippers")
end) --teleport

Sanctuary_area:connect_two_ways(Kings_tomb_area, function()
    return ALL(
        "titans",
        CanInteract(Sanctuary_area)
    )
end)
Sanctuary_area:connect_two_ways_stuck(Sanctuary_bonk_pile_cave_outside, function()
    return ALL(
        "boots",
        CanInteract(Sanctuary_area)
    )
end)
Sanctuary_area:connect_two_ways(Graveyard_ledge, Inverted)
Sanctuary_area:connect_two_ways(North_fairy_drop_outside, function() return CanInteract(Sanctuary_area) end)
Sanctuary_area:connect_two_ways(North_fairy_cave_outside)
Sanctuary_area:connect_one_way(Dark_chapel_area, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Kings_tomb_area:connect_two_ways_stuck(Kings_tomb_outside, function()
    return ALL(
        "boots",
        CanInteract(Kings_tomb_area)
    )
end)

Kings_tomb_outside:connect_two_ways_entrance("King's_Tomb_Entrance", Kings_tomb_inside)
Kings_tomb_inside:connect_one_way("King's Tomb", function() return CanInteract(Kings_tomb_inside) end)


Sanctuary_bonk_pile_cave_outside:connect_two_ways_entrance("Sanctuary Bonk Pile", Sanctuary_bonk_pile_cave_inside)
Sanctuary_bonk_pile_cave_inside:connect_one_way("Bonk Pile Chest", function() return CanInteract(Sanctuary_bonk_pile_cave_inside) end)

Graveyard_ledge:connect_two_ways(Graveyard_ledge_outside)
Graveyard_ledge:connect_one_way(Sanctuary_area, OpenOrStandard)

Graveyard_ledge_outside:connect_two_ways_entrance("Graveyardledge Cave", Graveyard_ledge_inside)

Graveyard_ledge_inside:connect_one_way("Graveyard Ledge Item", function()
    return ALL(
        CanInteract(Graveyard_ledge_inside, "bombs"),
        "bombs"
    )
end)

North_fairy_drop_outside:connect_one_way_entrance("North Fairy Drop", North_fairy_drop_inside)
North_fairy_cave_outside:connect_two_ways_entrance("North Fairy Cave", North_fairy_cave_inside)
North_fairy_drop_inside:connect_one_way(North_fairy_cave_inside)

-- castle_escape_dropdown_room

Sanctuary_entrance_outside:connect_two_ways_entrance("Santuary", Sanctuary_entrance_inside)
Sanctuary_entrance_inside:connect_one_way("Sanctuary Chest", function() return CanInteract(Sanctuary_entrance_inside) end)

Sanctuary_entrance_outside:connect_two_ways(Sanctuary_area)

Sanctuary_area:connect_two_ways(CE_dropdown_entrance_outside, function()
    return ALL(
        "glove",
        CanInteract(Sanctuary_area)
    )
end)
CE_dropdown_entrance_outside:connect_one_way_entrance("Castle Escape secret Grave Drop", CE_dropdown_entrance_inside)


-- Lost_woods
Lost_woods:connect_one_way(Lumberjacks_area)
Lost_woods:connect_one_way(Kakariko_village)
-- Lost_woods:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)

Lost_woods:connect_two_ways(Lost_woods_hideout_hole_outside, function() return CanInteract(Lost_woods) end)
Lost_woods:connect_two_ways(Lost_woods_hideout_cave_outside)
Lost_woods:connect_two_ways(Lost_woods_gamble_outside)
Lost_woods:connect_two_ways(Mastersword_meadow_outside)
-- Lost_woods:connect_two_ways(Lost_woods_pedestal)
Lost_woods:connect_one_way("Lost Woods Mushroom", function()
    return ANY(
        CanInteract(Lost_woods),
        ACCESS_INSPECT
    )
end)
Lost_woods:connect_one_way(Skull_woods_area_back, function() 
    return ALL(
        Inverted, 
        CanChangeWorldWithMirror
    )
end)

Lost_woods_hideout_hole_outside:connect_one_way_entrance("Lost Woods Hideout Hole", Lost_woods_hideout_hole_inside)
Lost_woods_hideout_cave_outside:connect_two_ways_entrance("Lost Woods Hideout Cave", Lost_woods_hideout_cave_inside)
Lost_woods_gamble_outside:connect_two_ways_entrance("Lost Woods Gamble", Lost_woods_gamble_inside)
Mastersword_meadow_outside:connect_two_ways_entrance("Mastersword Meador (Pedastal)", Mastersword_meadow_inside)

Lost_woods_hideout_hole_inside:connect_one_way("Lost Woods Hideout")
Lost_woods_hideout_hole_inside:connect_one_way(Lost_woods_hideout_cave_inside)
Lost_woods_hideout_cave_inside:connect_one_way("Lost Woods Hideout", function() return ACCESS_INSPECT end)


Mastersword_meadow_inside:connect_one_way("Pedestal", function()
    return ANY(
        ALL(
            Has("pendant", 2, 2, 2, 2),
            "greenpendant"
        ),
        CanCheckWithBook
    )
end)






-- Dam_area
Teleporter_at_dam:connect_one_way(Dam_area,function()
    return ALL(
        Inverted,
        "pearl",
        "hammer"
    )
end)
Dam_area:connect_one_way(Teleporter_at_dam, function() return Has("hammer") end)

Dam_area:connect_one_way(Desert_area)
-- Dam_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Dam_area:connect_one_way(Links_house_area)
Dam_area:connect_one_way(Light_lake_hylia, function()
    return Has("flippers")
end) --teleport

Dam_area:connect_two_ways(Dam_outside)
Dam_area:connect_two_ways_stuck(Light_hype_fairy_outside, function()
    return ALL(
        "bombs",
        CanInteract(Dam_area)
    )
end)
Dam_area:connect_two_ways(Dam_desert_fairy_outside)
Dam_area:connect_two_ways_stuck(Fifty_rupee_thief_outside, function()
    return ALL(
        "glove",
        CanInteract(Dam_area)
    )
end)
Dam_area:connect_two_ways_stuck(Mini_moldorm_cave_outside, function()
    return ALL(
        "bombs",
        CanInteract(Dam_area)
    )
end)


Dam_outside:connect_two_ways_entrance("Dam Inside", Dam_inside)
Light_hype_fairy_outside:connect_two_ways_entrance("Light Hype Fairy", Light_hype_fairy_inside)
Dam_desert_fairy_outside:connect_two_ways_entrance("Desert Fairy", Dam_desert_fairy_inside)
Fifty_rupee_thief_outside:connect_two_ways_entrance("50 Rupee Cave", Fifty_rupee_thief_inside)
Mini_moldorm_cave_outside:connect_two_ways_entrance("Mini Moldorm Cave", Mini_moldorm_cave_inside)


Dam_inside:connect_one_way("Floodgate Chest", function() return CanInteract(Dam_inside) end)

Mini_moldorm_cave_inside:connect_two_ways(Mini_moldorm_cave_back, function()
    return ALL(
        DealDamage,
        CanInteract(Mini_moldorm_cave_inside, "sword")
    )
end)
Mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Left")
Mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Left")
Mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Generous Guy")
Mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Right")
Mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Right")


Dam_area:connect_one_way("Sunken Treasure", function() return CanReach("Floodgate Chest") end)

Dam_area:connect_one_way("Purple Chest Return", function() return Purple_chest_spawn:accessibility() > 5 end)






-- Desert_area

Teleporter_at_Desert_ledge:connect_one_way(Desert_area)
Teleporter_at_Desert_ledge:connect_one_way(Teleporter_at_desert, function() return ALL("titans", CanInteract(Teleporter_at_Desert_ledge)) end)
Teleporter_at_desert:connect_one_way(Teleporter_at_Desert_ledge)

Desert_area:connect_one_way(Dam_area)
Desert_area:connect_two_ways(Checkerboard_lege, function()
    return ALL(
        Inverted,
        CanInteract(Desert_area)
    )
end)
-- Desert_area:connect_two_ways_entrance("Aginah_cave_entrance", aginah_cave)
-- Desert_area:connect_one_way_entrance("Desert_palace_front_entrance", Desert_palace_front, function() return "book" end)
-- Desert_area:connect_one_way_entrance("Desert_palace_front_entrance", Desert_palace_front, function() return "book" end)
-- Desert_area:connect_one_way(Desert_palace_front, function() return "book" end)
Desert_area:connect_two_ways(Aginah_cave_outside)
Desert_area:connect_one_way(Dp_entranCE_stairs, function() return Has("book") end)

-- OWG
-- Desert_area_boots_clip:connect_one_way(Desert_area) --?
Desert_area_boots_clip:connect_one_way(Desert_ledge) -- jumping down to desert ledge
Desert_area_boots_clip:connect_one_way(DP_back_entrance_outside) -- jumping down right behind de bolders. you are basically stuck here
-- Desert_area_boots_clip:connect_one_way(Checkerboard_lege, function() return OpenOrStandard() end) -- checkerboard clip

Desert_area:connect_one_way(Bombos_tablet_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end)
-- OWG end

Dp_entranCE_stairs:connect_one_way(DP_main_entrance_outside)

Checkerboard_lege:connect_one_way(Desert_area)
Aginah_cave_outside:connect_two_ways_entrance("Aginah Cave", Aginah_cave_inside)
DP_main_entrance_outside:connect_two_ways_entrance("Desert Palace Front", DP_main_entrance_inside)
-- Desert_area:connect_two_ways_entrance()
-- Desert_area:connect_two_ways_entrance()
-- Desert_area:connect_two_ways_entrance()

Aginah_cave_inside:connect_one_way("Aginah Item", function()
    return ALL(
        "bombs",
        CanInteract(Aginah_cave_inside, "bombs")
    )
end)

Checkerboard_lege:connect_two_ways_stuck(Checkerboard_cave_outside, function()
    return ALL(
        "glove",
        CanInteract(Checkerboard_lege)
    )
end)

Checkerboard_cave_outside:connect_two_ways_entrance("Checkerboard Cave", Checkerboard_cave_inside, function()
    return ALL(
        "glove",
        CanInteract(Checkerboard_cave_outside)
    )
end)
Checkerboard_cave_inside:connect_one_way("Checkerboard Cave Item")


Desert_ledge:connect_one_way("Desert Ledge Item")
Desert_ledge:connect_one_way(Desert_area)

Desert_area:connect_one_way("Desert Ledge Item", function() return ACCESS_INSPECT end)

DP_back_entrance_outside:connect_two_ways_entrance("Desert Palace Back Entrance", DP_back_entrance_inside)
DP_back_entrance_outside:connect_two_ways(Desert_ledge, function()
    return ALL(
        "glove",
        CanInteract(DP_back_entrance_outside)
    )
end)

DP_left_entrance_outside:connect_two_ways_entrance("Desert Palace Left Entrance", DP_left_entrance_inside)
DP_left_entrance_outside:connect_two_ways(Desert_ledge)

DP_right_entrance_outside:connect_two_ways_entrance("Desert Palace Right Entrance", DP_right_entrance_inside)
DP_right_entrance_outside:connect_one_way(Desert_area)

Desert_area:connect_two_ways(Bombos_tablet_ledge, function() return Inverted() end)
Desert_area:connect_one_way(Mire_area, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Bombos_tablet_ledge:connect_one_way(Desert_area)
Bombos_tablet_ledge:connect_one_way(Bombos_tablet)
Bombos_tablet:connect_one_way("Bombos Tablet", function() return
    -- ALL(
    ANY(
        ALL(
            "book",
            CanActivateTablets
        ),
        CanCheckWithBook
    -- ),
    --     CanInteract(Bombos_tablet)
    )
end)


-- Lumberjacks_area
Lumberjacks_area:connect_one_way(Lost_woods)
-- Lumberjacks_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Lumberjacks_area:connect_one_way(Sanctuary_area)
Lumberjacks_area:connect_one_way(Light_lake_hylia, function()
    return Has("flippers")
end) --teleport
-- Lumberjacks_area:connect_one_way(Light_death_mountain_left_bottom)

Lumberjacks_area:connect_one_way(Lumberjacks_hole_outside, function()
    return ALL(
        "aga1",
        "boots",
        CanInteract(Lumberjacks_area)
    )
end)
Lumberjacks_area:connect_two_ways(Lumberjacks_cave_outside)
Lumberjacks_area:connect_two_ways(Lumberjacks_house_outside)

Lumberjacks_hole_outside:connect_one_way_entrance("Tree Hole", Lumberjacks_hole_inside, function()
    return ALL(
        "aga1",
        "boots",
        CanInteract(Lumberjacks_hole_outside)
    )
end)
Lumberjacks_cave_outside:connect_two_ways_entrance("Lumberjacks Cave", Lumberjacks_cave_inside)
Lumberjacks_house_outside:connect_two_ways_entrance("Lumberjacks House", Lumberjacks_house_inside)
-- Lumberjacks_area:connect_two_ways_entrance("Light Death Mountain Ascent", Light_death_mountain_ascent, function() return "glove" end)
 -- aga item cave

Lumberjacks_hole_inside:connect_one_way(Lumberjacks_item)
Lumberjacks_item:connect_one_way(Lumberjacks_cave_inside)
Lumberjacks_item:connect_one_way("Lumberjacks Item")

Lumberjacks_cave_inside:connect_one_way("Lumberjacks Item", function() return ACCESS_INSPECT end)

Lumberjacks_area:connect_one_way(Old_man_cave_left_ledge, function()
    return ALL(
        "glove",
        CanInteract(Lumberjacks_area)
    )
end)
Old_man_cave_left_ledge:connect_one_way(Lumberjacks_area, function()
    return true
end)

-- OWG
Lumberjacks_area:connect_one_way(Light_death_mountain_return_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Death Mountain Return Ledge Clip Spot

Lumberjacks_area:connect_one_way(Old_man_cave_left_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Death Mountain Entrance Clip Spot

Lumberjacks_area:connect_one_way(Light_death_mountain_left_bottom, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Light World DMA Clip Spot
-- OWG end

Light_death_mountain_return_ledge:connect_one_way(Lumberjacks_area)
Light_death_mountain_return_ledge:connect_two_ways(Light_death_mountain_return_left_outside)

Light_death_mountain_return_ledge:connect_one_way(Dark_bumper_cave_top_ledge, function() return ALL(CanChangeWorldWithMirror, Inverted) end)

Old_man_cave_left_ledge:connect_two_ways(Old_man_cave_left_outside)

Old_man_cave_left_outside:connect_two_ways_entrance("Old Man Cave Left", Old_man_cave_left_inside, function() return OpenOrStandard() end)
Old_man_cave_left_outside:connect_two_ways_entrance("Bumper Cave Bottom", Dark_bumper_cave_bottom_inside, function() return Inverted() end)

Old_man_cave_left_inside:connect_one_way(Old_man_cave, function() return DarkRooms end)


Light_death_mountain_return_left_outside:connect_two_ways_entrance("Light Death Mountain Return Left", Light_death_mountain_return_left_inside, function() return OpenOrStandard() end)
Light_death_mountain_return_left_outside:connect_two_ways_entrance("Bumper Cave Top", Dark_bumper_cave_top_inside, function() return Inverted() end)
 -- rescue old man
---------------- HARD TO DO -------------

-- Light_death_mountain_return_ledge:connect_two_ways(Dark_bumper_cave_top_outside, Inverted)
-- Old_man_cave_left_ledge:connect_two_ways(Dark_bumper_cave_bottom_outside, Inverted)

-- Light_bumper_cave_ledge:connect_one_way_entrance("Light Bumper Cave", Inverted_bumper_cave, Inverted)
-- Light_death_mountain_return_ledge:connect_one_way(Dark_bumper_cave_top_ledge, function()
--     return ALL(
--         CanChangeWorldWithMirror(),
--         Inverted()
--     )
-- end)
---------------- HARD TO DO -------------






-- Light_lake_hylia
Light_lake_hylia:connect_one_way(Links_house_area)
Light_lake_hylia:connect_one_way(Dam_area)
-- Light_lake_hylia:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Light_lake_hylia:connect_one_way(Eastern_palace_area)
Light_lake_hylia:connect_one_way(Witchhut, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end) --teleport
Light_lake_hylia:connect_one_way(Lumberjacks_area, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end) --teleport
Light_lake_hylia:connect_one_way(Zora_river, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end) --teleport
-- Light_lake_hylia:connect_one_way()


Light_lake_hylia:connect_two_ways(Light_lake_fortune_outside)
Light_lake_hylia:connect_two_ways(Light_lake_shop_outside)
Light_lake_hylia:connect_two_ways_stuck(Icerod_cave_outside, function()
    return ALL(
        "bombs",
        CanInteract(Light_lake_hylia)
    )
end)
Light_lake_hylia:connect_two_ways(Good_bee_cave_outside)
Light_lake_hylia:connect_two_ways_stuck(Twenty_rupee_thief_outside, function()
    return ALL(
        "glove",
        CanInteract(Light_lake_hylia)
    )
end)
Light_lake_hylia:connect_two_ways(Upgrade_fairy_island, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end)

Light_lake_hylia:connect_one_way(Dark_icerod_area, function() 
    return ALL(
        Inverted, 
        CanChangeWorldWithMirror
    )
end)

-- OWG
Light_lake_hylia:connect_one_way(Lake_hylia_island, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Lake Hylia Island Clip Spot
--OWG end

Light_lake_fortune_outside:connect_two_ways_entrance("Light Lake Forune", Light_lake_fortune_inside)
Light_lake_shop_outside:connect_two_ways_entrance("Light Lake Shop", Light_lake_shop_inside)
Icerod_cave_outside:connect_two_ways_entrance("Icerod Cave", Icerod_cave_inside)
Good_bee_cave_outside:connect_two_ways_entrance("Good Bee Cave", Good_bee_cave_inside)
Twenty_rupee_thief_outside:connect_two_ways_entrance("Twenty Rupee Cave", Twenty_rupee_thief_inside, function()
    return ALL(
        "glove",
        CanInteract(Twenty_rupee_thief_outside)
    )
end)
Light_lake_hylia:connect_two_ways(Upgrade_fairy_island, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end)

Light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Left")
Light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Center")
Light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Right")

Upgrade_fairy_island:connect_two_ways(Upgrade_fairy_outside)
Upgrade_fairy_outside:connect_two_ways_entrance("Upgrade Fairy Entrance", Upgrade_fairy_inside)
Upgrade_fairy_inside:connect_one_way("Capacity Upgrade Left")
Upgrade_fairy_inside:connect_one_way("Capacity Upgrade Center")
Upgrade_fairy_inside:connect_one_way("Capacity Upgrade Right")

Upgrade_fairy_island:connect_one_way(Teleporter_at_upgrade_fairy, function()
    return ALL(
        "titans",
        CanInteract(Upgrade_fairy_island)
    )
end)
Teleporter_at_upgrade_fairy:connect_one_way(Upgrade_fairy_island, function() return Inverted() end)

Light_lake_hylia:connect_two_ways(Hobo, function()
    return ALL(
        CanSwim,
        CanInteract(Light_lake_hylia)
    )
end)

Hobo:connect_one_way("Hobo Item")

Icerod_cave_inside:connect_one_way("Icerod Chest", function() return CanInteract(Icerod_cave_inside) end)

Light_lake_hylia:connect_two_ways(Lake_hylia_island, function()
    return ALL(
        Inverted,
        CanSwim,
        "pearl"
    )
end)
Light_lake_hylia:connect_one_way("Lake Hylia Item", function() return ACCESS_INSPECT end)

Lake_hylia_island:connect_one_way("Lake Hylia Item")










-- Links_house_area
Links_house_area:connect_one_way(South_of_village)
Links_house_area:connect_one_way(Dam_area)
Links_house_area:connect_one_way(Light_lake_hylia)
Links_house_area:connect_one_way(Eastern_palace_area)
Links_house_area:connect_one_way(Hyrule_castle_area)
-- Links_house_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)

Links_house_area:connect_two_ways(Links_house_outside)--, OpenOrStandard)
-- Links_house_area:connect_two_ways(Big_bomb_shop_outside, Inverted)
Links_house_area:connect_two_ways_stuck(Links_fairy_fountain_outside, function()
    return ALL(
        "boots",
        CanInteract(Links_house_area)
    )
end)

Links_house_outside:connect_two_ways_entrance("Link's House", Links_house_inside, function() return OpenOrStandard() end)
Links_house_outside:connect_two_ways_entrance("Link's House", Big_bomb_shop_inside, function() return Inverted() end)
Links_fairy_fountain_outside:connect_two_ways_entrance("Links Fairy", Links_fairy_fountain_inside)

Links_house_inside:connect_one_way("Link's House Chest")

Cave45_ledge:connect_two_ways(Cave45_outside)
Cave45_outside:connect_two_ways_entrance("Cave 45 Inside", Cave45_inside)
Cave45_ledge:connect_one_way(Links_house_area, function() return OpenOrStandard() end)
Cave45_ledge:connect_two_ways(Links_house_area, function() return Inverted() end)
Cave45_inside:connect_one_way("Cave 45", function() return ANY(CanInteract(Cave45_inside), ACCESS_INSPECT) end)

Links_house_area:connect_one_way("Flute Spot", function()
    return ALL(
        "shovel",
        CanInteract(Links_house_area)
    )
end)

Links_house_area:connect_one_way(Pyramid_area, function() 
    return ALL(
        "aga1", 
        OpenOrStandard
    )
end)




-- Eastern_palace_area

Eastern_palace_area:connect_one_way(Teleporter_at_eastern, function()
    return ALL(
        "hammer",
        CanInteract(Eastern_palace_area)
    )
end)
Teleporter_at_eastern:connect_one_way(Eastern_palace_area, function()
    return ALL(
        Inverted,
        "pearl",
        "hammer"
    )
end)

Eastern_palace_area:connect_one_way(Light_lake_hylia)
Eastern_palace_area:connect_one_way(Links_house_area)
Eastern_palace_area:connect_one_way(Light_lake_hylia)
Eastern_palace_area:connect_one_way(Witchhut, function() return CanInteract(Eastern_palace_area) end)
Eastern_palace_area:connect_one_way(Links_house_area)
-- Eastern_palace_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)

Eastern_palace_area:connect_two_ways(Eastern_tree_fairy_cave_outside)
Eastern_palace_area:connect_two_ways(Eastern_long_fairy_cave_outside)
Eastern_palace_area:connect_two_ways(Sahasralahs_hut_outside)
Eastern_palace_area:connect_two_ways(EP_entrance_outside)

Eastern_tree_fairy_cave_outside:connect_two_ways_entrance("Eastern Tree Fairy Cave", Eastern_tree_fairy_cave_inside)
Eastern_long_fairy_cave_outside:connect_two_ways_entrance("Eastern Long Fairy Cave", Eastern_long_fairy_cave_inside)
Sahasralahs_hut_outside:connect_two_ways_entrance("Sahasralah", Sahasralahs_hut_inside)
EP_entrance_outside:connect_two_ways_entrance("Eastern Palace Entrance", EP_entrance_inside)



Sahasralahs_hut_inside:connect_one_way("Sahasralah", function() return Has("greenpendant") end)
Sahasralahs_hut_inside:connect_two_ways(Sahasralahs_hut_back, function()
    return ANY(
        ALL("bombs", CanInteract(Twin_house_right_inside, "bombs")),
        ALL("boots", CanInteract(Twin_house_right_inside, "boots"))
    )
end)
Sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Left")
Sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Center")
Sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Right")









-- Zora_river
Zora_river:connect_one_way(Witchhut, function()
    return ALL(
        ANY(
            "glove",
            "flippers"
        ),
        CanInteract(Zora_river)
    )
end)
Zora_river:connect_one_way(Light_lake_hylia)
Zora_river:connect_one_way("Zora", function() return CanInteract(Zora_river) end)
Zora_river:connect_one_way("Zora Ledge", function()
    return ANY(
        "flippers",
        ALL(
            CheckGlitches(2),
            "boots"
        ),
        ACCESS_INSPECT
    )
end)

Zora_river:connect_two_ways(Waterfall_fairy_outside, function()
    return ANY(
        "flippers",
        ALL(
            CanSwim,
            "pearl"
        )
    )
end)
Waterfall_fairy_outside:connect_two_ways_entrance("Waterfall Fairy", Waterfall_fairy_inside)


Waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Left", function() return CanInteract(Waterfall_fairy_inside) end)
Waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Right", function() return CanInteract(Waterfall_fairy_inside) end)







-- Hyrule_castle_area
Hyrule_castle_area:connect_one_way(Links_house_area)
-- Hyrule_castle_area:connect_two_ways(Hyrule_castle_top_outside)
Hyrule_castle_area:connect_one_way(Eastern_palace_area)
Hyrule_castle_area:connect_one_way(Lumberjacks_area)
-- Hyrule_castle_area:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)

Hyrule_castle_area:connect_two_ways(HC_main_entrance_outside)
Hyrule_castle_area:connect_two_ways(Secret_passage_hole_outside, function() return CanInteract(Hyrule_castle_area) end)
Hyrule_castle_area:connect_two_ways(Secret_passage_stairs_outside, function() return CanInteract(Hyrule_castle_area) end)

Hyrule_castle_area:connect_one_way(Pyramid_area, function() return ALL("aga1", OpenOrStandard) end)

Hyrule_castle_area:connect_two_ways(Pyramid_exit_outside, function() return ALL(Inverted) end)

Hyrule_castle_top:connect_one_way(Pyramid_area, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Hyrule_castle_top:connect_two_ways_stuck(AT_entrance_outside, function()
    return ALL(
        ANY(
            ALL(
                CheckGlitches(2),
                "boots",
                CanReach("Sanctuary_area")
            ),
            CanClearAgaTowerBarrier
        ),
        OpenOrStandard,
        CanInteract(Hyrule_castle_top)
    )
end)
Hyrule_castle_top:connect_two_ways_stuck(AT_entrance_outside, function()
    return ALL(
        GTCrystalCount,
        Inverted
    )
end)
Hyrule_castle_top:connect_two_ways(Pyramid_hole_outside, function() 
    return ALL(
        Inverted,
        CheckPyramidState
    )
end)


Hyrule_castle_top:connect_two_ways(HC_left_entrance_outside)
Hyrule_castle_top:connect_two_ways(HC_right_entrance_outside)
Hyrule_castle_top:connect_one_way(Hyrule_castle_area)

AT_entrance_outside:connect_two_ways_entrance("Castle Tower", AT_entrance_inside, function() return OpenOrStandard() end)
AT_entrance_outside:connect_two_ways_entrance("Inverted Ganons Tower", GT_entrance_inside, function() return Inverted() end)
HC_left_entrance_outside:connect_two_ways_entrance("Hyrule Castle Top Left", HC_left_entrance_inside)
HC_right_entrance_outside:connect_two_ways_entrance("Hyrule Castle Top Right", HC_right_entrance_inside)

HC_main_entrance_outside:connect_two_ways_entrance("Hyrule Castle Main Entrance", HC_main_entrance_inside)
Secret_passage_hole_outside:connect_one_way_entrance("Secret Passage Hole", Secret_passage_hole_inside)
Secret_passage_stairs_outside:connect_two_ways_entrance("Secret Passage Stairs", Secret_passage_stairs_inside)

Secret_passage_hole_inside:connect_one_way(Secret_passage)
Secret_passage_stairs_inside:connect_two_ways(Secret_passage)

Secret_passage:connect_one_way("Secret Passage", function() return CanInteract(Secret_passage) end)
Secret_passage:connect_one_way("Link's Uncle")


-- Witchhut
Witchhut:connect_one_way(Eastern_palace_area, function() return CanInteract(Witchhut) end)
Witchhut:connect_one_way(Sanctuary_area)
-- Witchhut:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Witchhut:connect_one_way(Zora_river, function()
    return ALL(
        "glove",
        CanInteract(Witchhut)
    )
end)

Witchhut:connect_two_ways(Light_potion_shop_outside)

Light_potion_shop_outside:connect_two_ways_entrance("Witchhut Shop", Light_potion_shop_inside)

Light_potion_shop_inside:connect_one_way("Deliver Mushroom", function()
    return ALL(
        "mushroom",
        CanReach("Light_potion_shop_outside")
    )
end)
Light_potion_shop_inside:connect_one_way("Potion Shop - Left")
Light_potion_shop_inside:connect_one_way("Potion Shop - Right")
Light_potion_shop_inside:connect_one_way("Potion Shop - Center")




--

--







-- Light_death_mountain_left_bottom
-- Light_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_left_bottom, function() return ALL("mirror", Inverted()) end)

Light_death_mountain_left_bottom:connect_one_way(Teleporter_at_dark_death_mountain_left_bottom)
Teleporter_at_dark_death_mountain_left_bottom:connect_one_way(Light_death_mountain_left_bottom, function() return Inverted() end)

Light_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_left_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
Light_death_mountain_left_bottom:connect_one_way(Light_death_mountain_right_bottom, function()
    return ALL(
        "hookshot",
        CanInteract(Light_death_mountain_left_bottom)
    )
end)
-- Light_death_mountain_left_bottom:connect_one_way("Spectacle Rock", function() return "mirror" end)
-- Light_death_mountain_left_bottom:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
-- Light_death_mountain_left_bottom:connect_one_way()
Old_man_cave_right_outside:connect_two_ways_entrance("Old Man Cave Right Inside",Old_man_cave_right_inside, function() return OpenOrStandard() end)
Old_man_cave_right_outside:connect_two_ways_entrance("Inverted Light Death Mountain Return Left",Light_death_mountain_return_left_inside, function() return Inverted() end)

Light_death_mountain_return_right_outside:connect_two_ways_entrance("Light Death Mountain Return Right",Light_death_mountain_return_right_inside)

Light_death_mountain_return_right_inside:connect_two_ways(Light_death_mountain_return_left_inside, function() return DarkRooms end)
Old_man_cave_right_inside:connect_two_ways(Old_man_cave, function() return DarkRooms end)

-- Light_death_mountain_ascent_ledge:connect_one_way(Light_death_mountain_ascent, function()
--     return ALL(
--         DarkRooms(),
--         OpenOrStandard()
--     )
-- end)
---------------- HARD TO DO -------------
-- Light_death_mountain_ascent_ledge:connect_one_way(Inverted_bumper_cave_outside, function()
--     return ALL(
--         Inverted()
--     )
-- end)
---------------- HARD TO DO -------------
-- Light_death_mountain_ascent:connect_two_ways_entrance("Upper Light Death Mountain Ascent", Light_death_mountain_left_bottom, function() return DarkRooms() end)

-- Light_death_mountain_left_bottom:connect_two_ways(Old_man_cave_right_outside, OpenOrStandard)
-- Light_death_mountain_left_bottom:connect_two_ways(Light_death_mountain_return_left_outside, Inverted)


Light_death_mountain_left_bottom:connect_two_ways(Old_man_cave_right_outside)
Light_death_mountain_left_bottom:connect_two_ways(Light_death_mountain_return_right_outside)
Light_death_mountain_left_bottom:connect_two_ways(Spec_rock_top_entrance_outside)
Light_death_mountain_left_bottom:connect_two_ways(Old_man_home_top_outside)
Light_death_mountain_left_bottom:connect_two_ways(Old_man_home_bottom_outside)
Light_death_mountain_left_bottom:connect_one_way(Spec_rock_ledge_entrance)
Light_death_mountain_left_bottom:connect_one_way(Spec_rock_ledge_exit)
Light_death_mountain_left_bottom:connect_one_way("Old Man Item", function() return CanReach("Old_man_cave") end)
Light_death_mountain_left_bottom:connect_one_way(Spectacle_rock_top, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)

-- OWG
Light_death_mountain_left_bottom:connect_one_way(Graveyard_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Graveyard Ledge Clip Spot

Light_death_mountain_left_bottom:connect_one_way(Kings_tomb_area, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Kings Grave Clip Spot

Light_death_mountain_left_bottom:connect_one_way(Light_death_mountain_left_top_weird_state, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Hera Ascent


Light_death_mountain_left_bottom:connect_one_way(Light_death_mountain_right_top, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Death Mountain Glitched Bridge

Light_death_mountain_left_top_weird_state:connect_one_way(Light_death_mountain_left_top, function() 
    local ToH_entrance_traget = Tracker:FindObjectForCode("from_ToH_entrance_outside").ItemState.Target
    if ToH_entrance_traget ~= nil then
        return Tracker:FindObjectForCode(ToH_entrance_traget).ItemState.IsDungeon
    end
    return false
end) -- TOH only resets weird overworld state when its a dungeon. other caves will stil have weird state after exiting again

Light_death_mountain_left_top_weird_state:connect_two_ways(ToH_entrance_outside_weird_state) -- connector for weird map state after clip up to DM left top

ToH_entrance_outside_weird_state:connect_one_way(ToH_entrance_outside, function() 
    local ToH_entrance_traget = Tracker:FindObjectForCode("from_ToH_entrance_outside").ItemState.Target
    if ToH_entrance_traget ~= nil then
        return Tracker:FindObjectForCode(ToH_entrance_traget).ItemState.IsDungeon
    end
    return false
end) -- TOH only resets weird overworld state when its a dungeon. other caves will stil have weird state after exiting again
-- OWG end

Old_man_home_bottom_outside:connect_two_ways_entrance("Old Man Home Entrance", Old_man_home_bottom_inside)
Spec_rock_top_entrance_outside:connect_two_ways_entrance("Spectecal Rock Top Entrance", Spec_rock_top_entrance_inside)
Old_man_home_top_outside:connect_two_ways_entrance("Old Man Cave Backside", Old_man_home_top_inside)


-- -- Light_death_mountain_left:connect_one_way(Lumberjacks_area)
-- Light_death_mountain_left_bottom:connect_one_way(Light_death_mountain_right_bottom)
-- -- Light_death_mountain_left_bottom:connect_one_way(Light_death_mountain_left_top)


Spec_rock_top_entrance_inside:connect_one_way(Spectacle_rock_top_drop)

Spec_rock_ledge_entrance:connect_two_ways(Spec_rock_ledge_entrance_outside)
Spec_rock_ledge_exit:connect_two_ways(Spec_rock_ledge_exit_outside)

Spec_rock_ledge_entrance_outside:connect_two_ways_entrance("Spectecal Rock Ledge Entrance", Spec_rock_ledge_entrance_inside)
Spec_rock_ledge_exit_outside:connect_two_ways_entrance("Spectecal Rock Ledge exit", Spec_rock_ledge_exit_inside)

Spec_rock_ledge_entrance_inside:connect_two_ways(Spectacle_rock_inside_bottom)
Spec_rock_ledge_exit_inside:connect_two_ways(Spectacle_rock_cave)

-- UWG
Spectacle_rock_cave:connect_one_way(PoD_shooter_room, function() 
    return ALL(
        CheckGlitches(3),
        CanBombClip(Spectacle_rock_cave)
    )
end) -- kiki skip
-- UWG

Spectacle_rock_top_drop:connect_one_way(Spectacle_rock_cave)
Spectacle_rock_top_drop:connect_one_way("Spec Rock Inside Item", function() return ACCESS_INSPECT end)
Spectacle_rock_inside_bottom:connect_one_way(Spectacle_rock_top_drop)
Spectacle_rock_inside_bottom:connect_one_way("Spec Rock Inside Item")

Spec_rock_ledge_entrance:connect_one_way(Light_death_mountain_left_bottom)
Spec_rock_ledge_exit:connect_one_way(Light_death_mountain_left_bottom)

-- cave mide left lightg DM bottom

Old_man_home_bottom_inside:connect_two_ways(Old_man_home_top_inside, function() return DarkRooms end)


-- Light_death_mountain_left_top

Light_death_mountain_left_top:connect_two_ways(ToH_entrance_outside)
Light_death_mountain_left_top:connect_one_way(Dark_death_mountain_left_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
Light_death_mountain_left_top:connect_one_way(Light_death_mountain_left_bottom)
-- Light_death_mountain_left_top:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Light_death_mountain_left_top:connect_one_way(Light_death_mountain_right_top, function()
    return ANY(
        ALL(
            "hammer",
            CanInteract(Light_death_mountain_left_top)
        )
    )
end)
Light_death_mountain_left_top:connect_one_way("Ether Tablet", function()
    return ANY(
        ALL(
            "book",
            CanActivateTablets
        ),
        CanCheckWithBook
    )
end)
Light_death_mountain_left_top:connect_one_way(Spectacle_rock_top, Inverted)
Spectacle_rock_top:connect_one_way("Spec Rock Top Item")
Light_death_mountain_left_bottom:connect_one_way("Spec Rock Top Item", function() return ACCESS_INSPECT end)

-- OWG
Light_death_mountain_left_top:connect_one_way(Spectacle_rock_top, function() 
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end)
-- OWG end

ToH_entrance_outside:connect_two_ways_entrance("Tower of Hera Entrance", ToH_entrance_inside)

-- Light_death_mountain_left_top:connect_one_way(Light_death_mountain_right_top)
-- Light_death_mountain_left_top:connect_one_way(Light_death_mountain_left_bottom)





-- Light_death_mountain_right_bottom
Light_death_mountain_right_bottom:connect_one_way(Dark_death_mountain_right_bottom, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
Light_death_mountain_right_bottom:connect_one_way(Light_death_mountain_left_bottom, function()
    return ALL(
        "hookshot",
        CanInteract(Light_death_mountain_right_bottom)
    )
end)
-- Light_death_mountain_right_bottom:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Light_death_mountain_right_bottom:connect_one_way(Teleporter_at_dark_death_mountain_right_bottom, function() return Has("titans") end)
Teleporter_at_dark_death_mountain_right_bottom:connect_one_way(Light_death_mountain_right_bottom, function() return Inverted() end)

-- Light_death_mountain_right_bottom:connect_one_way()
-- Light_death_mountain_right_bottom:connect_one_way()

Light_death_mountain_right_bottom:connect_two_ways(Spiral_cave_bottom_outside)
Light_death_mountain_right_bottom:connect_two_ways(Paradox_cave_bottom_entrance_outside)
Light_death_mountain_right_bottom:connect_two_ways(Paradox_cave_middle_entrance_outside)
Light_death_mountain_right_bottom:connect_two_ways(Fairy_ascension_cave_bottom_outside, function()
    return ALL(
        CanInteract(Light_death_mountain_right_bottom),
        "titans"
    )
end) --coming from dm
Light_death_mountain_right_bottom:connect_two_ways(Hookshot_fairy_outside)

-- OWG
Dark_death_mountain_right_bottom:connect_one_way(Witchhut, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- light DMD
-- OWG end

Spiral_cave_bottom_outside:connect_two_ways_entrance("Spiral Cave Bottom Entrance", Spiral_cave_bottom_inside)
Paradox_cave_bottom_entrance_outside:connect_two_ways_entrance("Paradox Cave Bottom Entrance", Paradox_cave_bottom_entrance_inside)
Paradox_cave_middle_entrance_outside:connect_two_ways_entrance("Paradox Cave Middle Entrance", Paradox_cave_middle_entrance_inside)
Fairy_ascension_cave_bottom_outside:connect_two_ways_entrance("Fairy Ascension Cave Bottom", Fairy_ascension_cave_bottom_inside)
Fairy_ascension_cave_bottom_outside:connect_one_way(Light_death_mountain_right_bottom) --back to dm
Hookshot_fairy_outside:connect_two_ways_entrance("Hookshot Fairy Cave", Hookshot_fairy_inside)

-- Paradox_cave_bottom:connect_one_way(Paradox_cave_top)
-- Paradox_cave_bottom:connect_two_ways_entrance("Light Death Mountain Shop", Light_death_mountain_shop, function() return "bombs" end)



-- Light_death_mountain_right_top
Light_death_mountain_right_top:connect_one_way(Teleporter_at_light_turtle_rock, function()
    return ALL(
        "hammer",
        "titans",
        CanInteract(Light_death_mountain_right_top)
    )
end)
Teleporter_at_light_turtle_rock:connect_one_way(Light_death_mountain_right_top, function()
    return ALL(
        "pearl",
        Inverted,
        "hammer"
    )
end)

Light_death_mountain_right_top:connect_one_way(Light_death_mountain_right_bottom)
-- Light_death_mountain_right_top:connect_one_way(Light_flute_map, function()
--     return ALL(
--         "flute",
--         OpenOrStandard,
--         CanReach("Light_activate_flute")
--     )
-- end)
Light_death_mountain_right_top:connect_one_way(Light_death_mountain_left_top, function()
    return ANY(
        ALL(
            "hammer",
            CanInteract(Light_death_mountain_right_top)
        )
    )
end)
-- Light_death_mountain_right_top:connect_one_way()
-- Light_death_mountain_right_top:connect_one_way()

Light_death_mountain_right_top:connect_two_ways(Paradox_cave_top_entrance_outside)
Light_death_mountain_right_top:connect_one_way(Spiral_cave_top_Ledge)
Light_death_mountain_right_top:connect_one_way(Mimic_cave_ledge, function() return Inverted() end)
Light_death_mountain_right_top:connect_one_way(Light_eyebridge_fairy_ledge)--, Inverted)

-- OWG
Light_death_mountain_right_top:connect_one_way(Zora_river, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) --Zora Descent Clip Spot
Light_death_mountain_right_top:connect_one_way(Floating_island, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Floating Island Clip Spot
-- OWG end

Paradox_cave_top_entrance_outside:connect_two_ways_entrance("Paradox Cave Top Entrance", Paradox_cave_top_entrance_inside)

Spiral_cave_top_Ledge:connect_two_ways(Spiral_cave_top_outside)
Spiral_cave_top_Ledge:connect_one_way(Light_death_mountain_right_bottom)
Spiral_cave_top_Ledge:connect_one_way(Turtle_rock_ledge, function() 
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Spiral_cave_top_outside:connect_two_ways_entrance("Spiral Cave Top Entrance", Spiral_cave_top_inside)



Light_eyebridge_fairy_ledge:connect_two_ways(Fairy_ascension_cave_top_outside)
Light_eyebridge_fairy_ledge:connect_one_way(Fairy_ascension_cave_bottom_outside)
-- TR_eye_bridge_entrance_outside:connect_one_way_entrance("Light Eyebridge Fairy", Light_eyebridge_fairy_outside, function()
--     return ALL(
--         CanChangeWorldWithMirror(),
--         OpenOrStandard()
--     )
-- end)
Light_eyebridge_fairy_ledge:connect_one_way(TR_eye_bridge_entrance_ledge, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

Fairy_ascension_cave_top_outside:connect_two_ways_entrance("Fairy Ascention Top Entrance", Fairy_ascension_cave_top_inside)
Fairy_ascension_cave_top_inside:connect_two_ways(Fairy_ascension_cave_bottom_inside)

Spiral_cave_top_inside:connect_one_way(Spiral_cave_bottom_inside)
Spiral_cave_top_inside:connect_one_way("Spiral Cave Item", function() return CanInteract(Spiral_cave_top_inside, "sword") end)

Mimic_cave_ledge:connect_two_ways(Mimic_cave_outside)
Mimic_cave_outside:connect_two_ways_entrance("Mimic Cave Entrance", Mimic_cave_inside)
Mimic_cave_inside:connect_one_way("Mimic Cave Chest", function()
    return ALL(
        "hammer",
        CanInteract(Mimic_cave_inside, "hammer")
    )
end)

Paradox_cave_top_entrance_inside:connect_two_ways(Paradox_cave_top_front)
Paradox_cave_top_front:connect_two_ways(Paradox_cave_middle_front)
Paradox_cave_middle_entrance_inside:connect_two_ways(Paradox_cave_middle_front)

Paradox_cave_middle_front:connect_one_way(Paradox_cave_inside_bottom) --drop down from front
Paradox_cave_inside_middle:connect_one_way(Paradox_cave_inside_bottom) -- drop down from back ledge
Paradox_cave_inside_middle:connect_two_ways(Paradox_cave_inside_top)

Paradox_cave_inside_bottom:connect_one_way(Paradox_cave_bottom_back, function()
    return ALL(
        "bombs",
        CanInteract(Paradox_cave_inside_bottom, "bombs")
    )
end) -- fbomb wall
-- Paradox_cave_inside_bottom:connect_two_ways(Paradox_cave_top_back) -- stairs up left
Paradox_cave_inside_bottom:connect_one_way(Paradox_cave_bottom_front, function() return CanInteract(Paradox_cave_inside_bottom) end) --just push block down but not up
Paradox_cave_inside_bottom:connect_two_ways(Paradox_cave_inside_middle) -- go upstairs to middle
Paradox_cave_inside_middle:connect_two_ways(Paradox_cave_inside_top) -- go upstairs to top
Paradox_cave_inside_middle:connect_one_way(Paradox_cave_inside_bottom) -- drop down to bottom floor
Paradox_cave_inside_middle:connect_one_way(Paradox_cave_middle_front, function() return ALL("bombs", CanInteract(Paradox_cave_inside_bottom, "bombs")) end) -- bombjump to middle entrance

Paradox_cave_inside_top:connect_two_ways_entrance_door_stuck("Paradox Cave Top Back", Paradox_cave_top_back, function()
    return ANY(
        ALL("bombs", CanInteract(Paradox_cave_inside_top, "bombs")),
        ALL("boomerangs", CanInteract(Paradox_cave_inside_top, "boomerangs")),
        ALL("somaria", CanInteract(Paradox_cave_inside_top, "somaria")),
        ALL("mastersword", CanInteract(Paradox_cave_inside_top, "mastersword")),
        ALL("icerod", CanInteract(Paradox_cave_inside_top, "icerod")),
        ALL("firerod", CanInteract(Paradox_cave_inside_top, "firerod")),
        ALL("bow", CanInteract(Paradox_cave_inside_top, "bow"))
    )
end) -- go to the 5 chests

Paradox_cave_bottom_entrance_inside:connect_two_ways(Paradox_cave_bottom_front)

Paradox_cave_bottom_front:connect_two_ways(Paradox_cave_bottom_shop_entrance, function() return ALL("bombs", CanInteract(Paradox_cave_bottom_front, "bombs")) end)
Paradox_cave_bottom_front:connect_two_ways(Paradox_cave_inside_bottom, function() return ALL("mirror", CanInteract(Paradox_cave_bottom_front)) end) --block delete with mirror


Paradox_cave_bottom_shop_entrance:connect_two_ways(Light_death_mountain_shop_inside) -- go to shop and bomb it open

Light_death_mountain_right_top:connect_one_way(Dark_death_mountain_right_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
Paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Left", function() return CanInteract(Paradox_cave_bottom_back) end)
Paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Right", function() return CanInteract(Paradox_cave_bottom_back) end)
Paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Left", function() return CanInteract(Paradox_cave_top_back) end)
Paradox_cave_top_back:connect_one_way("Paradox Cave Top Left", function() return CanInteract(Paradox_cave_top_back) end)
Paradox_cave_top_back:connect_one_way("Paradox Cave Top Middle", function() return CanInteract(Paradox_cave_top_back) end)
Paradox_cave_top_back:connect_one_way("Paradox Cave Top Right", function() return CanInteract(Paradox_cave_top_back) end)
Paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Right", function() return CanInteract(Paradox_cave_top_back) end)



Light_death_mountain_right_top:connect_two_ways(Floating_island, function() return Inverted() end)
-- Floating_island:connect_one_way(Light_death_mountain_right_top)

Floating_island:connect_one_way("Floating Island Item")
Light_death_mountain_right_top:connect_one_way("Floating Island Item", function() return ACCESS_INSPECT end)