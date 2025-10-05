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
-- AccessibilityLevel.Inspect
-- AccessibilityLevel.SequenceBreak
-- AccessibilityLevel.Normal
-- AccessibilityLevel.Cleared




light_flute_map:connect_one_way(light_death_mountain_left_bottom)
light_flute_map:connect_one_way(witchhut)
light_flute_map:connect_one_way(kakariko_village)
light_flute_map:connect_one_way(links_house_area)
light_flute_map:connect_one_way(eastern_palace_area)
light_flute_map:connect_one_way(teleporter_at_desert_ledge)
light_flute_map:connect_one_way(dam_area)
light_flute_map:connect_one_way(light_lake_hylia)

teleporter_at_kakariko_village:connect_one_way(teleporter_at_village_of_the_outcast, function() return Has("glove") end)

teleporter_at_light_turtle_rock:connect_one_way(teleporter_at_dark_turtle_rock)
teleporter_at_light_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom)

teleporter_at_light_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom)

teleporter_at_eastern:connect_one_way(teleporter_at_pod, function() return Has("glove") end)

teleporter_at_desert:connect_one_way(teleporter_at_mire)

teleporter_at_dam:connect_one_way(teleporter_at_swamp, function() return Has("glove") end)

teleporter_at_upgrade_fairy:connect_one_way(teleporter_at_ice_palace, function() return ALL("titans",OpenOrStandard)  end)


--
lightworld_spawns:connect_one_way(light_spawn_sanctuary)
lightworld_spawns:connect_one_way(light_spawn_links_house_area)
lightworld_spawns:connect_one_way(light_spawn_old_man, function() return CanReach(old_man_cave_right_inside) end) --rescued old man

light_spawn_sanctuary:connect_one_way(sanctuary_entrance_inside, function() return OpenOrStandard() end)
light_spawn_links_house_area:connect_one_way(links_house_inside, function() return OpenOrStandard() end)
light_spawn_old_man:connect_one_way(old_man_home_bottom_inside, function() return OpenOrStandard() end)

-- kakariko_village
kakariko_village:connect_one_way(south_of_village)
kakariko_village:connect_one_way(lost_woods)
kakariko_village:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)







--
kakariko_village:connect_one_way(teleporter_at_kakariko_village, function()
    return ANY(
        "hammer",
        "titans"
    )
end)
teleporter_at_kakariko_village:connect_one_way(kakariko_village, function()
    return ALL(
        ANY(
        "hammer",
        "titans"
        ),
        Inverted,
        "pearl"
    )
end)

kakariko_village:connect_one_way(kakariko_well_hole_outside)
kakariko_village:connect_two_ways(kakariko_well_cave_outside)
kakariko_village:connect_two_ways(kakariko_blinds_hideout_outside)
kakariko_village:connect_two_ways(kakariko_elder_house_left_outside)
kakariko_village:connect_two_ways(kakariko_elder_house_right_outside)
kakariko_village:connect_two_ways(kakariko_snitch_house_left_outside)
kakariko_village:connect_two_ways(kakariko_snitch_house_right_outside)
kakariko_village:connect_two_ways(kakariko_chickenhut_outside)
kakariko_village:connect_two_ways(kakariko_sick_kid_outside)
kakariko_village:connect_two_ways(kakariko_overgrown_house_outside, function() return Can_interact(kakariko_village.worldstate, 1) end)
kakariko_village:connect_two_ways_stuck(kakariko_bombhut_outside, function()
    return ALL(
        "bombs",
        Can_interact(kakariko_village.worldstate, 1)
    )
end)
kakariko_village:connect_two_ways(kakariko_shop_outside)
kakariko_village:connect_two_ways(kakariko_frontside_pub_outside)
kakariko_village:connect_two_ways(kakariko_backside_pub_outside)

kakariko_village:connect_two_ways(dwarf_smiths_outside)
kakariko_village:connect_one_way(purple_chest_pickup, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)
kakariko_village:connect_one_way(magic_bat_hole_outside, function()
    return ALL(
        ANY(
            "hammer",
            ALL(
                CanChangeWorldWithMirror,
                CanReach(purple_chest_pickup),
                OpenOrStandard
            )
        ),
        Can_interact(kakariko_village.worldstate, 1)
    )
end)
kakariko_village:connect_two_ways(magic_bat_cave_outside)
kakariko_village:connect_two_ways(kakariko_furtune_teller_outside)

kakariko_village:connect_two_ways(light_activate_flute, function() return ALL("flute", Can_interact(kakariko_village.worldstate, 1)) end)


kakariko_village:connect_one_way("Bottle Merchant")


kakariko_well_hole_outside:connect_one_way_entrance("Kakariko Well Hole", kakariko_well_hole_inside)
magic_bat_hole_outside:connect_one_way_entrance("Kakariko Magic Bat Hole", magic_bat_hole_inside)
kakariko_well_cave_outside:connect_two_ways_entrance("Kakariko Well Cave", kakariko_well_cave_inside)
kakariko_blinds_hideout_outside:connect_two_ways_entrance("Kakariko Blind's hideout", kakariko_blinds_hideout_inside, function() return Can_interact(kakariko_blinds_hideout_outside.worldstate, 1) end)
kakariko_elder_house_left_outside:connect_two_ways_entrance("Kakariko Elder House Left", kakariko_elder_house_left_inside)
kakariko_elder_house_right_outside:connect_two_ways_entrance("Kakariko Elder House Right", kakariko_elder_house_right_inside)
kakariko_snitch_house_left_outside:connect_two_ways_entrance("Kakariko Snitch House Left", kakariko_snitch_house_left_inside)
kakariko_snitch_house_right_outside:connect_two_ways_entrance("Kakariko Snitch House Right", kakariko_snitch_house_right_inside)
kakariko_overgrown_house_outside:connect_two_ways_entrance("Kakariko Overgrown House", kakariko_overgrown_house_inside)
kakariko_sick_kid_outside:connect_two_ways_entrance("Kakariko Sick Kid", kakariko_sick_kid_inside)
kakariko_chickenhut_outside:connect_two_ways_entrance("Kakariko Chickenhut", kakariko_chickenhut_inside)
kakariko_bombhut_outside:connect_two_ways_entrance("Kakariko Bombhut", kakariko_bombhut_inside)
kakariko_backside_pub_outside:connect_two_ways_entrance("Kakariko Backside Pub", kakariko_backside_pub_inside)
kakariko_frontside_pub_outside:connect_two_ways_entrance("Kakariko Frontside Pub", kakariko_frontside_pub_inside)
kakariko_shop_outside:connect_two_ways_entrance("Kakariko Shop", kakariko_shop_inside)
magic_bat_cave_outside:connect_two_ways_entrance("Kakariko Magic Bat Cave", magic_bat_cave_inside)
dwarf_smiths_outside:connect_two_ways_entrance("Kakariko Dwarf Smiths", dwarf_smiths_inside)
kakariko_furtune_teller_outside:connect_two_ways_entrance("Kakariko Fortune Teller", kakariko_furtune_teller_inside)
-- kakariko_village:connect_one_way(purple_chest_pickup, function()
--     return ALL(
--         Inverted,
--         CanChangeWorldWithMirror()
--     )
-- end)


kakariko_well_hole_inside:connect_one_way(kakariko_well_item)
kakariko_well_hole_inside:connect_one_way(kakariko_well_cave_inside)
kakariko_well_item:connect_one_way("Kakariko Well - Top", function()
    return ALL(
        "bombs",
        Can_interact(kakariko_well_item.worldstate, 1)
    )
end)
kakariko_well_item:connect_one_way("Kakariko Well - Left") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Middle") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Right") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Bottom") -- can interact as bunny





kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Back", function() return ALL("bombs", Can_interact(kakariko_blinds_hideout_inside.worldstate, 1)) end)
kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Far Left", function() return Can_interact(kakariko_blinds_hideout_inside.worldstate, 1) end)
kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Left", function() return Can_interact(kakariko_blinds_hideout_inside.worldstate, 1) end)
kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Right", function() return Can_interact(kakariko_blinds_hideout_inside.worldstate, 1) end)
kakariko_blinds_hideout_inside:connect_one_way("Blind's Hideout - Far Right", function() return Can_interact(kakariko_blinds_hideout_inside.worldstate, 1) end)

kakariko_elder_house_left_inside:connect_two_ways(kakariko_elder_house_right_inside)


kakariko_chickenhut_inside:connect_one_way("Chicken Hut", function() return ALL("bombs", Can_interact(kakariko_chickenhut_inside.worldstate, 1)) end)


kakariko_sick_kid_inside:connect_one_way("Sick Kid", function() return Has("bottle") end) -- can interact as bunny






kakariko_shop_inside:connect_one_way("Kakariko Shop Left")
kakariko_shop_inside:connect_one_way("Kakariko Shop Center")
kakariko_shop_inside:connect_one_way("Kakariko Shop Right")


kakariko_backside_pub_inside:connect_one_way("Backside Pub", function() return Can_interact(kakariko_backside_pub_inside.worldstate, 1) end)




dwarf_smiths_inside:connect_one_way("Rescue Dwarf")


-- kakariko_village:connect_one_way(magic_bat_hole, function()
--     return ANY(
--         "hammer",
--         ALL(
--             CanReach(purple_chest_pickup),
--             "mirror"
--         )
--     )
-- end)


magic_bat_hole_inside:connect_one_way(magic_bat_item)
magic_bat_hole_inside:connect_one_way(magic_bat_cave_inside)

magic_bat_item:connect_one_way("Magic Bat", function()
    return ALL(
        ANY(
            "powder",
            ALL(
                CheckGlitches(2),
                "somaria",
                "mushroom"
            )
        ),
        Can_interact(magic_bat_item.worldstate, 1)
    )
end)


-- south_of_village
south_of_village:connect_one_way(kakariko_village)
south_of_village:connect_one_way(links_house_area)
south_of_village:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard
    )
end)

south_of_village:connect_one_way(helpless_frog, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

south_of_village:connect_two_ways(library_outside)
south_of_village:connect_two_ways(kakariko_chest_minigame_outside)
south_of_village:connect_two_ways(twin_house_right_outside)
-- south_of_village:connect_two_ways_entrance()

library_outside:connect_two_ways_entrance("Library", library_inside)
kakariko_chest_minigame_outside:connect_two_ways_entrance("Light Chest Minigame", kakariko_chest_minigame_inside)
twin_house_right_outside:connect_two_ways_entrance("Twin House Right", twin_house_right_inside)

library_inside:connect_one_way("Library Item", function()
    return ANY(
        ALL(
            "boots",
            Can_interact(library_inside.worldstate, 1)
        ),
        AccessibilityLevel.Inspect
    )
end)



--


twin_house_right_inside:connect_two_ways(twin_house_left_inside, function()
    return ALL(
        ANY(
            "bombs",
            "boots"
        ),
        Can_interact(twin_house_right_inside.worldstate, 1)
    )
end)
twin_house_left_outside:connect_two_ways_entrance("Twin House Left", twin_house_left_inside)

twin_house_left_outside:connect_two_ways(race_ledge)
-- twin_house_left:connect_one_way(south_of_village)
race_ledge:connect_one_way(south_of_village)
race_ledge:connect_two_ways(race_ledge_finish, function() return Can_interact(race_ledge.worldstate, 1) end)
race_ledge_finish:connect_one_way("Race Minigame")
south_of_village:connect_one_way("Race Minigame", function() return AccessibilityLevel.Inspect end)
south_of_village:connect_two_ways(race_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end)
south_of_village:connect_two_ways(race_ledge_finish, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end)
-- sanctuary_area
sanctuary_area:connect_one_way(lost_woods)
sanctuary_area:connect_one_way(eastern_palace_area)
sanctuary_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
sanctuary_area:connect_one_way(light_lake_hylia, function()
    return Has("flippers")
end) --teleport

sanctuary_area:connect_two_ways(kings_tomb_area, function()
    return ALL(
        "titans",
        Can_interact(sanctuary_area.worldstate, 1)
    )
end)
sanctuary_area:connect_two_ways_stuck(sanctuary_bonk_pile_cave_outside, function()
    return ALL(
        "boots",
        Can_interact(sanctuary_area.worldstate, 1)
    )
end)
sanctuary_area:connect_two_ways(graveyard_ledge, function() return Inverted() end)
sanctuary_area:connect_two_ways(north_fairy_drop_outside, function() return Can_interact(sanctuary_area.worldstate, 1) end)
sanctuary_area:connect_two_ways(north_fairy_cave_outside)

kings_tomb_area:connect_two_ways_stuck(kings_tomb_outside, function()
    return ALL(
        "boots",
        Can_interact(kings_tomb_area.worldstate, 1)
    )
end)

kings_tomb_outside:connect_two_ways_entrance("King's_Tomb_Entrance", kings_tomb_inside)
kings_tomb_inside:connect_one_way("King's Tomb", function() return Can_interact(kings_tomb_inside.worldstate, 1) end)


sanctuary_bonk_pile_cave_outside:connect_two_ways_entrance("Sanctuary Bonk Pile", sanctuary_bonk_pile_cave_inside)
sanctuary_bonk_pile_cave_inside:connect_one_way("Bonk Pile Chest", function() return Can_interact(sanctuary_bonk_pile_cave_inside.worldstate, 1) end)

graveyard_ledge:connect_two_ways(graveyard_ledge_outside)
graveyard_ledge:connect_one_way(sanctuary_area, function() return OpenOrStandard() end)

graveyard_ledge_outside:connect_two_ways_entrance("Graveyardledge Cave", graveyard_ledge_inside)

graveyard_ledge_inside:connect_one_way("Graveyard Ledge Item", function()
    return ALL(
        Can_interact(graveyard_ledge_inside.worldstate, 1),
        "bombs"
    )
end)

north_fairy_drop_outside:connect_one_way_entrance("North Fairy Drop", north_fairy_drop_inside)
north_fairy_cave_outside:connect_two_ways_entrance("North Fairy Cave", north_fairy_cave_inside)
north_fairy_drop_inside:connect_two_ways(north_fairy_cave_inside)

-- castle_escape_dropdown_room

sanctuary_entrance_outside:connect_two_ways_entrance("Santuary", sanctuary_entrance_inside)
sanctuary_entrance_inside:connect_one_way("Sanctuary Chest", function() return Can_interact(sanctuary_entrance_inside.worldstate, 1) end)

sanctuary_entrance_outside:connect_two_ways(sanctuary_area)

sanctuary_area:connect_two_ways(ce_dropdown_entrance_outside, function()
    return ALL(
        "glove",
        Can_interact("light",1 )
    )
end)
ce_dropdown_entrance_outside:connect_one_way_entrance("Castle Escape secret Grave Drop", ce_dropdown_entrance_inside)


-- lost_woods
lost_woods:connect_one_way(lumberjacks_area)
lost_woods:connect_one_way(kakariko_village)
lost_woods:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)

lost_woods:connect_two_ways(lost_woods_hideout_hole_outside, function() return Can_interact(lost_woods.worldstate, 1) end)
lost_woods:connect_two_ways(lost_woods_hideout_cave_outside)
lost_woods:connect_two_ways(lost_woods_gamble_outside)
lost_woods:connect_two_ways(mastersword_meadow_outside)
-- lost_woods:connect_two_ways(lost_woods_pedestal)
lost_woods:connect_one_way("Lost Woods Mushroom", function()
    return ANY(
        Can_interact(lost_woods.worldstate, 1),
        AccessibilityLevel.Inspect
    )
end)

lost_woods_hideout_hole_outside:connect_one_way_entrance("Lost Woods Hideout Hole", lost_woods_hideout_hole_inside)
lost_woods_hideout_cave_outside:connect_two_ways_entrance("Lost Woods Hideout Cave", lost_woods_hideout_cave_inside)
lost_woods_gamble_outside:connect_two_ways_entrance("Lost Woods Gamble", lost_woods_gamble_inside)
mastersword_meadow_outside:connect_two_ways_entrance("Mastersword Meador (Pedastal)", mastersword_meadow_inside)

lost_woods_hideout_hole_inside:connect_one_way("Lost Woods Hideout")
lost_woods_hideout_hole_inside:connect_one_way(lost_woods_hideout_cave_inside)
lost_woods_hideout_cave_inside:connect_one_way("Lost Woods Hideout", function() return AccessibilityLevel.Inspect end)


mastersword_meadow_inside:connect_one_way("Pedestal", function()
    return ANY(
        ALL(
            Has("pendant", 2, 2, 2, 2),
            "greenpendant"
        ),
        CanCheckWithBook
    )
end)






-- dam_area
teleporter_at_dam:connect_one_way(dam_area,function()
    return ALL(
        Inverted,
        "pearl",
        "hammer"
    )
end)
dam_area:connect_one_way(teleporter_at_dam, function() return Has("hammer") end)

dam_area:connect_one_way(desert_area)
dam_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
dam_area:connect_one_way(links_house_area)
dam_area:connect_one_way(light_lake_hylia, function()
    return Has("flippers")
end) --teleport

dam_area:connect_two_ways(dam_outside)
dam_area:connect_two_ways_stuck(light_hype_fairy_outside, function()
    return ALL(
        "bombs",
        Can_interact(dam_area.worldstate, 1)
    )
end)
dam_area:connect_two_ways(dam_desert_fairy_outside)
dam_area:connect_two_ways_stuck(fifty_rupee_thief_outside, function()
    return ALL(
        "glove",
        Can_interact(dam_area.worldstate, 1)
    )
end)
dam_area:connect_two_ways_stuck(mini_moldorm_cave_outside, function()
    return ALL(
        "bombs",
        Can_interact(dam_area.worldstate, 1)
    )
end)


dam_outside:connect_two_ways_entrance("Dam Inside", dam_inside)
light_hype_fairy_outside:connect_two_ways_entrance("Light Hype Fairy", light_hype_fairy_inside)
dam_desert_fairy_outside:connect_two_ways_entrance("Desert Fairy", dam_desert_fairy_inside)
fifty_rupee_thief_outside:connect_two_ways_entrance("50 Rupee Cave", fifty_rupee_thief_inside)
mini_moldorm_cave_outside:connect_two_ways_entrance("Mini Moldorm Cave", mini_moldorm_cave_inside)


dam_inside:connect_one_way("Floodgate Chest", function() return Can_interact(dam_inside.worldstate, 1) end)

mini_moldorm_cave_inside:connect_two_ways(mini_moldorm_cave_back, function()
    return ALL(
        DealDamage(),
        Can_interact(mini_moldorm_cave_inside.worldstate, 1)
    )
end)
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Left")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Left")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Generous Guy")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Right")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Right")


dam_area:connect_one_way("Sunken Treasure", function() return CanReach("Floodgate Chest") end)

dam_area:connect_one_way("Purple Chest Return", function() return purple_chest_pickup:accessibility() end)






-- desert_area

teleporter_at_desert_ledge:connect_one_way(desert_area)
teleporter_at_desert_ledge:connect_one_way(teleporter_at_desert, function() return ALL("titans", Can_interact(teleporter_at_desert_ledge.worldstate, 1)) end)
teleporter_at_desert:connect_one_way(teleporter_at_desert_ledge)

desert_area:connect_one_way(dam_area)
desert_area:connect_two_ways(checkerboard_lege, function()
    return ALL(
        Inverted,
        Can_interact(desert_area.worldstate, 1)
    )
end)
-- desert_area:connect_two_ways_entrance("aginah_cave_entrance", aginah_cave)
-- desert_area:connect_one_way_entrance("desert_palace_front_entrance", desert_palace_front, function() return "book" end)
-- desert_area:connect_one_way_entrance("desert_palace_front_entrance", desert_palace_front, function() return "book" end)
-- desert_area:connect_one_way(desert_palace_front, function() return "book" end)
desert_area:connect_two_ways(aginah_cave_outside)
desert_area:connect_one_way(dp_main_entrance_outside, function() return Has("book") end)

checkerboard_lege:connect_one_way(desert_area)
aginah_cave_outside:connect_two_ways_entrance("Aginah Cave", aginah_cave_inside)
dp_main_entrance_outside:connect_two_ways_entrance("Desert Palace Front", dp_main_entrance_inside)
-- desert_area:connect_two_ways_entrance()
-- desert_area:connect_two_ways_entrance()
-- desert_area:connect_two_ways_entrance()

aginah_cave_inside:connect_one_way("Aginah Item", function()
    return ALL(
        "bombs",
        Can_interact(aginah_cave_inside.worldstate, 1)
    )
end)

checkerboard_lege:connect_two_ways_stuck(checkerboard_cave_outside, function()
    return ALL(
        "glove",
        Can_interact(checkerboard_lege.worldstate, 1)
    )
end)

checkerboard_cave_outside:connect_two_ways_entrance("Checkerboard Cave", checkerboard_cave_inside, function()
    return ALL(
        "glove",
        Can_interact(checkerboard_cave_outside.worldstate, 1)
    )
end)
checkerboard_cave_inside:connect_one_way("Checkerboard Cave Item")


desert_ledge:connect_one_way("Desert Ledge Item")
desert_ledge:connect_one_way(desert_area)

desert_area:connect_one_way("Desert Ledge Item", function() return AccessibilityLevel.Inspect end)

dp_back_entrance_outside:connect_two_ways_entrance("Desert Palace Back Entrance", dp_back_entrance_inside)
dp_back_entrance_outside:connect_two_ways(desert_ledge, function()
    return ALL(
        "glove",
        Can_interact(dp_back_entrance_outside.worldstate, 1)
    )
end)

dp_left_entrance_outside:connect_two_ways_entrance("Desert Palace Left Entrance", dp_left_entrance_inside)
dp_left_entrance_outside:connect_two_ways(desert_ledge)

dp_right_entrance_outside:connect_two_ways_entrance("Desert Palace Right Entrance", dp_right_entrance_inside)
dp_right_entrance_outside:connect_one_way(desert_area)

desert_area:connect_two_ways(bombos_tablet_ledge, function() return Inverted() end)
desert_area:connect_one_way(mire_area, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

bombos_tablet_ledge:connect_one_way(desert_area)
bombos_tablet_ledge:connect_one_way(bombos_tablet)
bombos_tablet:connect_one_way("Bombos Tablet", function() return
    ALL(
        ANY(
            ALL(
                "book",
                CanActivateTablets
            ),
            CanCheckWithBook
        ),
        Can_interact(bombos_tablet.worldstate, 1)
    )
end)


-- lumberjacks_area
lumberjacks_area:connect_one_way(lost_woods)
lumberjacks_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
lumberjacks_area:connect_one_way(sanctuary_area)
lumberjacks_area:connect_one_way(light_lake_hylia, function()
    return Has("flippers")
end) --teleport
-- lumberjacks_area:connect_one_way(light_death_mountain_left_bottom)

lumberjacks_area:connect_one_way(lumberjacks_hole_outside, function()
    return ALL(
        "aga1",
        "boots",
        Can_interact(lumberjacks_area.worldstate, 1)
    )
end)
lumberjacks_area:connect_two_ways(lumberjacks_cave_outside)
lumberjacks_area:connect_two_ways(lumberjacks_house_outside)

lumberjacks_hole_outside:connect_one_way_entrance("Tree Hole", lumberjacks_hole_inside, function()
    return ALL(
        "aga1",
        "boots",
        Can_interact(lumberjacks_hole_outside.worldstate, 1)
    )
end)
lumberjacks_cave_outside:connect_two_ways_entrance("Lumberjacks Cave", lumberjacks_cave_inside)
lumberjacks_house_outside:connect_two_ways_entrance("Lumberjacks House", lumberjacks_house_inside)
-- lumberjacks_area:connect_two_ways_entrance("Light Death Mountain Ascent", light_death_mountain_ascent, function() return "glove" end)
 -- aga item cave

lumberjacks_hole_inside:connect_one_way(lumberjacks_item)
lumberjacks_item:connect_one_way(lumberjacks_cave_inside)
lumberjacks_item:connect_one_way("Lumberjacks Item")

lumberjacks_cave_inside:connect_one_way("Lumberjacks Item", function() return AccessibilityLevel.Inspect end)

lumberjacks_area:connect_two_ways(old_man_cave_left_ledge, function()
    return ALL(
        "glove",
        Can_interact(lumberjacks_area.worldstate, 1)
    )
end)
light_death_mountain_return_ledge:connect_one_way(lumberjacks_area)
light_death_mountain_return_ledge:connect_two_ways(light_death_mountain_return_left_outside, function() return OpenOrStandard() end)

old_man_cave_left_ledge:connect_two_ways(old_man_cave_left_outside)

old_man_cave_left_outside:connect_two_ways_entrance("Old Man Cave Left", old_man_cave_left_inside, function() return OpenOrStandard() end)
old_man_cave_left_outside:connect_two_ways_entrance("Bumper Cave Bottom", dark_bumper_cave_bottom_inside, function() return Inverted() end)

old_man_cave_left_inside:connect_one_way(old_man_cave, function() return DarkRooms(false) end)


light_death_mountain_return_left_outside:connect_two_ways_entrance("Light Death Mountain Return Left", light_death_mountain_return_left_inside, function() return OpenOrStandard() end)
light_death_mountain_return_left_outside:connect_two_ways_entrance("Bumper Cave Top", dark_bumper_cave_top_inside, function() return Inverted() end)
 -- rescue old man
---------------- HARD TO DO -------------

-- light_death_mountain_return_ledge:connect_two_ways(dark_bumper_cave_top_outside, function() return Inverted() end)
-- old_man_cave_left_ledge:connect_two_ways(dark_bumper_cave_bottom_outside, function() return Inverted() end)

-- light_bumper_cave_ledge:connect_one_way_entrance("Light Bumper Cave", Inverted_bumper_cave, function() return Inverted() end)
-- light_death_mountain_return_ledge:connect_one_way(dark_bumper_cave_top_ledge, function()
--     return ALL(
--         CanChangeWorldWithMirror(),
--         Inverted()
--     )
-- end)
---------------- HARD TO DO -------------






-- light_lake_hylia
light_lake_hylia:connect_one_way(links_house_area)
light_lake_hylia:connect_one_way(dam_area)
light_lake_hylia:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
light_lake_hylia:connect_one_way(eastern_palace_area)
light_lake_hylia:connect_one_way(witchhut, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end) --teleport
light_lake_hylia:connect_one_way(lumberjacks_area, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end) --teleport
light_lake_hylia:connect_one_way(zora_river, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end) --teleport
-- light_lake_hylia:connect_one_way()


light_lake_hylia:connect_two_ways(light_lake_fortune_outside)
light_lake_hylia:connect_two_ways(light_lake_shop_outside)
light_lake_hylia:connect_two_ways_stuck(icerod_cave_outside, function()
    return ALL(
        "bombs",
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end)
light_lake_hylia:connect_two_ways(good_bee_cave_outside)
light_lake_hylia:connect_two_ways_stuck(twenty_rupee_thief_outside, function()
    return ALL(
        "glove",
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end)
light_lake_hylia:connect_two_ways(upgrade_fairy_island, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end)

light_lake_fortune_outside:connect_two_ways_entrance("Light Lake Forune", light_lake_fortune_inside)
light_lake_shop_outside:connect_two_ways_entrance("Light Lake Shop", light_lake_shop_inside)
icerod_cave_outside:connect_two_ways_entrance("Icerod Cave", icerod_cave_inside)
good_bee_cave_outside:connect_two_ways_entrance("Good Bee Cave", good_bee_cave_inside)
twenty_rupee_thief_outside:connect_two_ways_entrance("Twenty Rupee Cave", twenty_rupee_thief_inside, function()
    return ALL(
        "glove",
        Can_interact(twenty_rupee_thief_outside.worldstate, 1)
    )
end)
light_lake_hylia:connect_two_ways(upgrade_fairy_island, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end)

light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Left")
light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Center")
light_lake_shop_inside:connect_one_way("Lake Hylia Shop - Right")

upgrade_fairy_island:connect_two_ways(upgrade_fairy_outside)
upgrade_fairy_outside:connect_two_ways_entrance("Upgrade Fairy Entrance", upgrade_fairy_inside)
upgrade_fairy_inside:connect_one_way("Capacity Upgrade Left")
upgrade_fairy_inside:connect_one_way("Capacity Upgrade Center")
upgrade_fairy_inside:connect_one_way("Capacity Upgrade Right")

upgrade_fairy_island:connect_one_way(teleporter_at_upgrade_fairy, function()
    return ALL(
        "titans",
        Can_interact(upgrade_fairy_island.worldstate, 1)
    )
end)
teleporter_at_upgrade_fairy:connect_one_way(upgrade_fairy_island, function() return Inverted() end)

light_lake_hylia:connect_two_ways(hobo, function()
    return ALL(
        CanSwim(),
        Can_interact(light_lake_hylia.worldstate, 1)
    )
end)

hobo:connect_one_way("Hobo Item")

icerod_cave_inside:connect_one_way("Icerod Chest", function() return Can_interact(icerod_cave_inside.worldstate, 1) end)

light_lake_hylia:connect_two_ways(lake_hylia_island, function()
    return ALL(
        Inverted,
        CanSwim,
        "pearl"
    )
end)
light_lake_hylia:connect_one_way("Lake Hylia Item", function() return AccessibilityLevel.Inspect end)

lake_hylia_island:connect_one_way("Lake Hylia Item")










-- links_house_area
links_house_area:connect_one_way(south_of_village)
links_house_area:connect_one_way(dam_area)
links_house_area:connect_one_way(light_lake_hylia)
links_house_area:connect_one_way(eastern_palace_area)
links_house_area:connect_one_way(hyrule_castle_area)
links_house_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)

links_house_area:connect_two_ways(links_house_outside)--, function() return OpenOrStandard() end)
-- links_house_area:connect_two_ways(big_bomb_shop_outside, function() return Inverted() end)
links_house_area:connect_two_ways_stuck(links_fairy_fountain_outside, function()
    return ALL(
        "boots",
        Can_interact(links_house_area.worldstate, 1)
    )
end)

links_house_outside:connect_two_ways_entrance("Link's House", links_house_inside, function() return OpenOrStandard() end)
links_house_outside:connect_two_ways_entrance("Link's House", big_bomb_shop_inside, function() return Inverted() end)
links_fairy_fountain_outside:connect_two_ways_entrance("Links Fairy", links_fairy_fountain_inside)

links_house_inside:connect_one_way("Link's House Chest")

cave45_ledge:connect_two_ways(cave45_outside)
cave45_outside:connect_two_ways_entrance("Cave 45", cave45_inside)
cave45_ledge:connect_one_way(links_house_area, function() return OpenOrStandard() end)
cave45_ledge:connect_two_ways(links_house_area, function() return Inverted() end)
cave45_inside:connect_one_way("Cave 45", function() return Can_interact(cave45_inside.worldstate, 1) end)

links_house_area:connect_one_way("Flute Spot", function()
    return ALL(
        "shovel",
        Can_interact(links_house_area.worldstate, 1)
    )
end)

links_house_area:connect_one_way(pyramid, function() 
    return ALL(
        "aga1", 
        OpenOrStandard
    )
end)




-- eastern_palace_area

eastern_palace_area:connect_one_way(teleporter_at_eastern, function()
    return ALL(
        "hammer",
        Can_interact(eastern_palace_area.worldstate, 1)
    )
end)
teleporter_at_eastern:connect_one_way(eastern_palace_area, function()
    return ALL(
        Inverted,
        "pearl",
        "hammer"
    )
end)

eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(witchhut, function() return Can_interact(eastern_palace_area.worldstate,1 ) end)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)

eastern_palace_area:connect_two_ways(eastern_tree_fairy_cave_outside)
eastern_palace_area:connect_two_ways(eastern_long_fairy_cave_outside)
eastern_palace_area:connect_two_ways(sahasralahs_hut_outside)
eastern_palace_area:connect_two_ways(ep_entrance_outside)

eastern_tree_fairy_cave_outside:connect_two_ways_entrance("Eastern Tree Fairy Cave", eastern_tree_fairy_cave_inside)
eastern_long_fairy_cave_outside:connect_two_ways_entrance("Eastern Long Fairy Cave", eastern_long_fairy_cave_inside)
sahasralahs_hut_outside:connect_two_ways_entrance("Sahasralah", sahasralahs_hut_inside)
ep_entrance_outside:connect_two_ways_entrance("Eastern Palace Entrance", ep_entrance_inside)



sahasralahs_hut_inside:connect_one_way("Sahasralah", function() return Has("greenpendant") end)
sahasralahs_hut_inside:connect_two_ways(sahasralahs_hut_back, function()
    return ALL(
        ANY(
            "bombs",
            "boots"
        ),
        Can_interact(sahasralahs_hut_inside.worldstate, 1)
    )
end)
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Left")
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Center")
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Right")









-- zora_river
zora_river:connect_one_way(witchhut, function()
    return ALL(
        ANY(
            "glove",
            "flippers"
        ),
        Can_interact(zora_river.worldstate, 1)
    )
end)
zora_river:connect_one_way(light_lake_hylia)
zora_river:connect_one_way("Zora", function() return Can_interact(zora_river.worldstate, 1) end)
zora_river:connect_one_way("Zora Ledge", function()
    return ANY(
        "flippers",
        ALL(
            CheckGlitches(2),
            "boots"
        ),
        AccessibilityLevel.Inspect
    )
end)

zora_river:connect_two_ways(waterfall_fairy_outside, function()
    return ANY(
        "flippers",
        ALL(
            CanSwim(),
            "pearl"
        )
    )
end)
waterfall_fairy_outside:connect_two_ways_entrance("Waterfall Fairy", waterfall_fairy_inside)


waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Left", function() return Can_interact(waterfall_fairy_inside.worldstate, 1) end)
waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Right", function() return Can_interact(waterfall_fairy_inside.worldstate, 1) end)







-- hyrule_castle_area
hyrule_castle_area:connect_one_way(links_house_area)
-- hyrule_castle_area:connect_two_ways(hyrule_castle_top_outside)
hyrule_castle_area:connect_one_way(eastern_palace_area)
hyrule_castle_area:connect_one_way(lumberjacks_area)
hyrule_castle_area:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)

hyrule_castle_area:connect_two_ways(hc_main_entrance_outside)
hyrule_castle_area:connect_two_ways(secret_passage_hole_outside, function() return Can_interact(hyrule_castle_area.worldstate, 1) end)
hyrule_castle_area:connect_two_ways(secret_passage_stairs_outside, function() return Can_interact(hyrule_castle_area.worldstate, 1) end)

hyrule_castle_area:connect_two_ways(pyramid_exit_ledge, function() return Inverted() end)

hyrule_castle_top:connect_one_way(pyramid, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

hyrule_castle_top:connect_two_ways_stuck(at_entrance_outside, function()
    return ALL(
        ANY(
            ALL(
                CheckGlitches(2),
                "boots",
                CanReach(sanctuary_area)
            ),
            CanClearAgaTowerBarrier
        ),
        OpenOrStandard,
        Can_interact(hyrule_castle_top.worldstate, 1)
    )
end)
hyrule_castle_top:connect_two_ways_stuck(at_entrance_outside, function()
    return ALL(
        GTCrystalCount,
        Inverted
    )
end)
hyrule_castle_top:connect_two_ways(pyramid_hole_outside, function() 
    return ALL(
        Inverted,
        CheckPyramidState
    )
end)


hyrule_castle_top:connect_two_ways(hc_left_entrance_outside)
hyrule_castle_top:connect_two_ways(hc_right_entrance_outside)
hyrule_castle_top:connect_one_way(hyrule_castle_area)

at_entrance_outside:connect_two_ways_entrance("Castle Tower", at_entrance_inside, function() return OpenOrStandard() end)
at_entrance_outside:connect_two_ways_entrance("Inverted Ganons Tower", gt_entrance_inside, function() return Inverted() end)
hc_left_entrance_outside:connect_two_ways_entrance("Hyrule Castle Top Left", hc_left_entrance_inside)
hc_right_entrance_outside:connect_two_ways_entrance("Hyrule Castle Top Right", hc_right_entrance_inside)

hc_main_entrance_outside:connect_two_ways_entrance("Hyrule Castle Main Entrance", hc_main_entrance_inside)
secret_passage_hole_outside:connect_one_way_entrance("Secret Passage Hole", secret_passage_hole_inside)
secret_passage_stairs_outside:connect_two_ways_entrance("Secret Passage Stairs", secret_passage_stairs_inside)

secret_passage_hole_inside:connect_two_ways(secret_passage)
secret_passage_stairs_inside:connect_two_ways(secret_passage)

secret_passage:connect_one_way("Secret Passage", function() return Can_interact(secret_passage.worldstate, 1) end)
secret_passage:connect_one_way("Link's Uncle")


-- witchhut
witchhut:connect_one_way(eastern_palace_area, function() return Can_interact(witchhut.worldstate, 1) end)
witchhut:connect_one_way(sanctuary_area)
witchhut:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
witchhut:connect_one_way(zora_river, function()
    return ALL(
        "glove",
        Can_interact(witchhut.worldstate, 1)
    )
end)

witchhut:connect_two_ways(light_potion_shop_outside)

light_potion_shop_outside:connect_two_ways_entrance("Witchhut Shop", light_potion_shop_inside)

light_potion_shop_inside:connect_one_way("Deliver Mushroom", function()
    return ALL(
        "mushroom",
        CanReach(light_potion_shop_outside)
    )
end)
light_potion_shop_inside:connect_one_way("Potion Shop - Left")
light_potion_shop_inside:connect_one_way("Potion Shop - Right")
light_potion_shop_inside:connect_one_way("Potion Shop - Center")




--

--







-- light_death_mountain_left_bottom
-- light_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom, function() return ALL("mirror", Inverted()) end)

light_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom)
teleporter_at_dark_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_bottom, function() return Inverted() end)

light_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom, function()
    return ALL(
        "hookshot",
        Can_interact(light_death_mountain_left_bottom.worldstate, 1)
    )
end)
-- light_death_mountain_left_bottom:connect_one_way("Spectacle Rock", function() return "mirror" end)
light_death_mountain_left_bottom:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
-- light_death_mountain_left_bottom:connect_one_way()
old_man_cave_right_outside:connect_one_way_entrance("Old Man Cave Right Inside",old_man_cave_right_inside, function() return OpenOrStandard() end)
old_man_cave_right_outside:connect_one_way_entrance("Inverted Light Death Mountain Return Left",light_death_mountain_return_left_inside, function() return Inverted() end)

light_death_mountain_return_right_outside:connect_two_ways_entrance("Light Death Mountain Return Right",light_death_mountain_return_right_inside)

light_death_mountain_return_right_inside:connect_two_ways(light_death_mountain_return_left_inside, function() return DarkRooms(false) end)
old_man_cave_right_inside:connect_two_ways(old_man_cave, function() return DarkRooms(false) end)

-- light_death_mountain_ascent_ledge:connect_one_way(light_death_mountain_ascent, function()
--     return ALL(
--         DarkRooms(),
--         OpenOrStandard()
--     )
-- end)
---------------- HARD TO DO -------------
-- light_death_mountain_ascent_ledge:connect_one_way(Inverted_bumper_cave_outside, function()
--     return ALL(
--         Inverted()
--     )
-- end)
---------------- HARD TO DO -------------
-- light_death_mountain_ascent:connect_two_ways_entrance("Upper Light Death Mountain Ascent", light_death_mountain_left_bottom, function() return DarkRooms() end)

-- light_death_mountain_left_bottom:connect_two_ways(old_man_cave_right_outside, function() return OpenOrStandard() end)
-- light_death_mountain_left_bottom:connect_two_ways(light_death_mountain_return_left_outside, function() return Inverted() end)


light_death_mountain_left_bottom:connect_two_ways(old_man_cave_right_outside)
light_death_mountain_left_bottom:connect_two_ways(light_death_mountain_return_right_outside)
light_death_mountain_left_bottom:connect_two_ways(spec_rock_top_entrance_outside)
light_death_mountain_left_bottom:connect_two_ways(old_man_home_top_outside)
light_death_mountain_left_bottom:connect_two_ways(old_man_home_bottom_outside)
light_death_mountain_left_bottom:connect_one_way(spec_rock_ledge_entrance)
light_death_mountain_left_bottom:connect_one_way(spec_rock_ledge_exit)
light_death_mountain_left_bottom:connect_one_way("Old Man Item", function() return CanReach(old_man_cave) end)
light_death_mountain_left_bottom:connect_one_way(spectacle_rock_top, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)

old_man_home_bottom_outside:connect_two_ways_entrance("Old Man Home Entrance", old_man_home_bottom_inside)
spec_rock_top_entrance_outside:connect_two_ways_entrance("Spectecal Rock Top Entrance", spec_rock_top_entrance_inside)
old_man_home_top_outside:connect_two_ways_entrance("Old Man Cave Backside", old_man_home_top_inside)


-- -- light_death_mountain_left:connect_one_way(lumberjacks_area)
-- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom)
-- -- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top)


spec_rock_top_entrance_inside:connect_one_way(spectacle_rock_top_drop)

spec_rock_ledge_entrance:connect_two_ways(spec_rock_ledge_entrance_outside)
spec_rock_ledge_exit:connect_two_ways(spec_rock_ledge_exit_outside)

spec_rock_ledge_entrance_outside:connect_two_ways_entrance("Spectecal Rock Ledge Entrance", spec_rock_ledge_entrance_inside)
spec_rock_ledge_exit_outside:connect_two_ways_entrance("Spectecal Rock Ledge exit", spec_rock_ledge_exit_inside)

spec_rock_ledge_entrance_inside:connect_two_ways(spectacle_rock_inside_bottom)
spec_rock_ledge_exit_inside:connect_two_ways(spectacle_rock_cave)

spectacle_rock_top_drop:connect_one_way(spectacle_rock_cave)
spectacle_rock_top_drop:connect_one_way("Spec Rock Inside Item", function() return AccessibilityLevel.Inspect end)
spectacle_rock_inside_bottom:connect_one_way(spectacle_rock_top_drop)
spectacle_rock_inside_bottom:connect_one_way("Spec Rock Inside Item")

spec_rock_ledge_entrance:connect_one_way(light_death_mountain_left_bottom)
spec_rock_ledge_exit:connect_one_way(light_death_mountain_left_bottom)

-- cave mide left lightg DM bottom

old_man_home_bottom_inside:connect_two_ways(old_man_home_top_inside, function() return DarkRooms(false) end)


-- light_death_mountain_left_top

light_death_mountain_left_top:connect_two_ways(toh_entrance_outside)
light_death_mountain_left_top:connect_one_way(dark_death_mountain_left_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)
light_death_mountain_left_top:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top, function()
    return ANY(
        ALL(
            "hammer",
            Can_interact(light_death_mountain_left_top.worldstate, 1)
        )
    )
end)
light_death_mountain_left_top:connect_one_way("Ether Tablet", function()
    return ANY(
        ALL(
        "book",
        CanActivateTablets
        ),
        CanCheckWithBook
    )
end)
light_death_mountain_left_top:connect_one_way(spectacle_rock_top, function() return Inverted() end)
spectacle_rock_top:connect_one_way("Spec Rock Top Item")
light_death_mountain_left_bottom:connect_one_way("Spec Rock Top Item", function() return AccessibilityLevel.Inspect end)

toh_entrance_outside:connect_two_ways_entrance("Tower of Hera Entrance", toh_entrance_inside)

-- light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top)
-- light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)





-- light_death_mountain_right_bottom
light_death_mountain_right_bottom:connect_one_way(dark_death_mountain_right_bottom, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
light_death_mountain_right_bottom:connect_one_way(light_death_mountain_left_bottom, function()
    return ALL(
        "hookshot",
        Can_interact(light_death_mountain_right_bottom.worldstate,1 )
    )
end)
light_death_mountain_right_bottom:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
light_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom, function() return Has("titans") end)
teleporter_at_dark_death_mountain_right_bottom:connect_one_way(light_death_mountain_right_bottom, function() return Inverted() end)

-- light_death_mountain_right_bottom:connect_one_way()
-- light_death_mountain_right_bottom:connect_one_way()

light_death_mountain_right_bottom:connect_two_ways(spiral_cave_bottom_outside)
light_death_mountain_right_bottom:connect_two_ways(paradox_cave_bottom_entrance_outside)
light_death_mountain_right_bottom:connect_two_ways(paradox_cave_middle_entrance_outside)
light_death_mountain_right_bottom:connect_one_way(fairy_ascension_cave_bottom_outside, function()
    return ALL(
        Can_interact(light_death_mountain_right_bottom.worldstate, 1),
        "glove"
    )
end) --coming from dm
light_death_mountain_right_bottom:connect_two_ways(hookshot_fairy_outside)

spiral_cave_bottom_outside:connect_two_ways_entrance("Spiral Cave Bottom Entrance", spiral_cave_bottom_inside)
paradox_cave_bottom_entrance_outside:connect_two_ways_entrance("Paradox Cave Bottom Entrance", paradox_cave_bottom_entrance_inside)
paradox_cave_middle_entrance_outside:connect_two_ways_entrance("Paradox Cave Middle Entrance", paradox_cave_middle_entrance_inside)
fairy_ascension_cave_bottom_outside:connect_two_ways_entrance("Fairy Ascension Cave Bottom", fairy_ascension_cave_bottom_inside)
fairy_ascension_cave_bottom_outside:connect_one_way(light_death_mountain_right_bottom) --back to dm
hookshot_fairy_outside:connect_two_ways_entrance("Hookshot Fairy Cave", hookshot_fairy_inside)

-- paradox_cave_bottom:connect_one_way(paradox_cave_top)
-- paradox_cave_bottom:connect_two_ways_entrance("Light Death Mountain Shop", light_death_mountain_shop, function() return "bombs" end)



-- light_death_mountain_right_top
light_death_mountain_right_top:connect_one_way(teleporter_at_light_turtle_rock, function()
    return ALL(
        "hammer",
        "titans",
        Can_interact(light_death_mountain_right_top.worldstate, 1)
    )
end)
teleporter_at_light_turtle_rock:connect_one_way(light_death_mountain_right_top, function()
    return ALL(
        "pearl",
        Inverted,
        "hammer"
    )
end)

light_death_mountain_right_top:connect_one_way(light_death_mountain_right_bottom)
light_death_mountain_right_top:connect_one_way(light_flute_map, function()
    return ALL(
        "flute",
        OpenOrStandard,
        CanReach(light_activate_flute)
    )
end)
light_death_mountain_right_top:connect_one_way(light_death_mountain_left_top, function()
    return ANY(
        ALL(
            "hammer",
            Can_interact(light_death_mountain_right_top.worldstate, 1)
        )
    )
end)
-- light_death_mountain_right_top:connect_one_way()
-- light_death_mountain_right_top:connect_one_way()

light_death_mountain_right_top:connect_two_ways(paradox_cave_top_entrance_outside)
light_death_mountain_right_top:connect_one_way(spiral_cave_top_outside)
light_death_mountain_right_top:connect_one_way(mimic_cave_ledge, function() return Inverted() end)
light_death_mountain_right_top:connect_one_way(light_eyebridge_fairy_ledge)--, function() return Inverted() end)

paradox_cave_top_entrance_outside:connect_two_ways_entrance("Paradox Cave Top Entrance", paradox_cave_top_entrance_inside)
spiral_cave_top_outside:connect_two_ways_entrance("Spiral Cave Top Entrance", spiral_cave_top_inside)

light_eyebridge_fairy_ledge:connect_two_ways(fairy_ascension_cave_top_outside)
light_eyebridge_fairy_ledge:connect_one_way(light_death_mountain_right_bottom)
-- tr_eye_bridge_entrance_outside:connect_one_way_entrance("Light Eyebridge Fairy", light_eyebridge_fairy_outside, function()
--     return ALL(
--         CanChangeWorldWithMirror(),
--         OpenOrStandard()
--     )
-- end)
light_eyebridge_fairy_ledge:connect_one_way(tr_eye_bridge_entrance_ledge, function()
    return ALL(
        Inverted,
        CanChangeWorldWithMirror
    )
end)

fairy_ascension_cave_top_outside:connect_two_ways_entrance("Fairy Ascention Top Entrance", fairy_ascension_cave_top_inside)
fairy_ascension_cave_top_outside:connect_two_ways(fairy_ascension_cave_bottom_inside)

spiral_cave_top_inside:connect_one_way(spiral_cave_bottom_inside)
spiral_cave_top_inside:connect_one_way("Spiral Cave Item", function() return Can_interact(spiral_cave_top_inside.worldstate, 1) end)

mimic_cave_ledge:connect_two_ways(mimic_cave_outside)
mimic_cave_outside:connect_two_ways_entrance("Mimic Cave Entrance", mimic_cave_inside)
mimic_cave_inside:connect_one_way("Mimic Cave Chest", function()
    return ALL(
        "hammer",
        Can_interact(mimic_cave_inside.worldstate, 1)
    )
end)

paradox_cave_top_entrance_inside:connect_two_ways(paradox_cave_top_front)
paradox_cave_top_front:connect_two_ways(paradox_cave_middle_front)
paradox_cave_middle_entrance_inside:connect_two_ways(paradox_cave_middle_front)

paradox_cave_middle_front:connect_one_way(paradox_cave_inside_bottom) --drop down from front
paradox_cave_inside_middle:connect_one_way(paradox_cave_inside_bottom) -- drop down from back ledge
paradox_cave_inside_middle:connect_two_ways(paradox_cave_inside_top)

paradox_cave_inside_bottom:connect_one_way(paradox_cave_bottom_back, function()
    return ALL(
        "bombs",
        Can_interact(paradox_cave_inside_bottom.worldstate, 1)
    )
end) -- fbomb wall
-- paradox_cave_inside_bottom:connect_two_ways(paradox_cave_top_back) -- stairs up left
paradox_cave_inside_bottom:connect_one_way(paradox_cave_bottom_front, function() return Can_interact(paradox_cave_inside_bottom.worldstate, 1) end) --just push block down but not up
paradox_cave_inside_bottom:connect_two_ways(paradox_cave_inside_middle) -- go upstairs to middle
paradox_cave_inside_middle:connect_two_ways(paradox_cave_inside_top) -- go upstairs to top
paradox_cave_inside_middle:connect_one_way(paradox_cave_inside_bottom) -- drop down to bottom floor
paradox_cave_inside_middle:connect_one_way(paradox_cave_middle_front, function() return ALL("bombs", Can_interact(paradox_cave_inside_bottom.worldstate, 2)) end) -- bombjump to middle entrance

paradox_cave_inside_top:connect_two_ways_entrance_door_stuck("Paradox Cave Top Back", paradox_cave_top_back, function()
    return ALL(
        ANY(
            "bombs",
            "boomerangs",
            "somaria",
            "mastersword",
            "icerod",
            "firerod",
            "bow"
        ),
        Can_interact(paradox_cave_inside_top.worldstate, 1)
    )
end) -- go to the 5 chests

paradox_cave_bottom_entrance_inside:connect_two_ways(paradox_cave_bottom_front)

paradox_cave_bottom_front:connect_two_ways(paradox_cave_bottom_shop_entrance, function() return ALL("bombs", Can_interact(paradox_cave_bottom_front.worldstate, 1)) end)
paradox_cave_bottom_front:connect_two_ways(paradox_cave_inside_bottom, function() return ALL("mirror", Can_interact(paradox_cave_bottom_front.worldstate, 2)) end) --block delete with mirror


paradox_cave_bottom_shop_entrance:connect_two_ways(light_death_mountain_shop_inside) -- go to shop and bomb it open

light_death_mountain_right_top:connect_one_way(dark_death_mountain_right_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        Inverted
    )
end)
paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Left", function() return Can_interact(paradox_cave_bottom_back.worldstate, 1) end)
paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Right", function() return Can_interact(paradox_cave_bottom_back.worldstate, 1) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Left", function() return Can_interact(paradox_cave_top_back.worldstate, 1) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Left", function() return Can_interact(paradox_cave_top_back.worldstate, 1) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Middle", function() return Can_interact(paradox_cave_top_back.worldstate, 1) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Right", function() return Can_interact(paradox_cave_top_back.worldstate, 1) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Right", function() return Can_interact(paradox_cave_top_back.worldstate, 1) end)



light_death_mountain_right_top:connect_two_ways(floating_island, function() return Inverted() end)
floating_island:connect_one_way(light_death_mountain_right_top)

floating_island:connect_one_way("Floating Island Item")
light_death_mountain_right_top:connect_one_way("Floating Island Item", function() return AccessibilityLevel.Inspect end)