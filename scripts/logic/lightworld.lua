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

teleporter_at_kakariko_village:connect_one_way(teleporter_at_village_of_the_outcast, function() return has("glove") end)

teleporter_at_light_turtle_rock:connect_one_way(teleporter_at_dark_turtle_rock)
teleporter_at_light_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom)

teleporter_at_light_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom)

teleporter_at_eastern:connect_one_way(teleporter_at_pod, function() return has("glove") end)

teleporter_at_desert:connect_one_way(teleporter_at_mire)

teleporter_at_dam:connect_one_way(teleporter_at_swamp, function() return has("glove") end)

teleporter_at_upgrade_fairy:connect_one_way(teleporter_at_ice_palace)


-- 
lightworld_spawns:connect_one_way(light_spawn_sanctuary)
lightworld_spawns:connect_one_way(light_spawn_links_house_area)
lightworld_spawns:connect_one_way(light_spawn_old_man, function() return can_reach(light_death_mountain_ascent) end) --rescued old man

light_spawn_sanctuary:connect_one_way(sanctuary, function() return openOrStandard() end)
light_spawn_links_house_area:connect_one_way(links_house, function() return openOrStandard() end)
light_spawn_old_man:connect_one_way(old_man_cave, function() return openOrStandard() end)

-- kakariko_village
kakariko_village:connect_one_way(south_of_village)
kakariko_village:connect_one_way(lost_woods)
kakariko_village:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)







-- 
kakariko_village:connect_one_way(teleporter_at_kakariko_village, function() 
    return any(
        has("hammer"),
        has("titans")
    ) 
end)
teleporter_at_kakariko_village:connect_one_way(kakariko_village, function() 
    return all(
        any(
        has("hammer"),
        has("titans")
        ),
        inverted(), 
        has("pearl")
    )
end)

kakariko_village:connect_one_way_entrance("Kakariko Well Hole", kakariko_well_hole)
kakariko_village:connect_one_way_entrance("Kakariko Magic Bat Hole", magic_bat_hole, function() 
    return all(
        any(
            has("hammer"),
            all(
                canChangeWorldWithMirror(),
                can_reach(purple_chest_pickup),
                openOrStandard()
            )
        ),
        can_interact("light",1 )
    ) 
end)
kakariko_village:connect_two_ways_entrance("Kakariko Well Cave", kakariko_well_cave)
kakariko_village:connect_two_ways_entrance("Kakariko Blind's hideout", kakariko_blinds_hideout, function() return can_interact("light",1 ) end)
kakariko_village:connect_two_ways_entrance("Kakariko Hill House", kakariko_house_hill_top)
kakariko_village:connect_two_ways_entrance("Kakariko House Top Left", kakariko_house_top_left)
kakariko_village:connect_two_ways_entrance("Kakariko House Top Right", kakariko_house_right_top)
kakariko_village:connect_two_ways_entrance("Kakariko House Center Right", kakariko_house_right_center)
kakariko_village:connect_two_ways_entrance("Kakariko Sick Kid", kakariko_sick_kid)
kakariko_village:connect_two_ways_entrance("Kakariko Chickenhut", kakariko_chickenhut)
kakariko_village:connect_two_ways_entrance("Kakariko Bombhut", kakariko_bombhut, function() 
    return all(
        has("bombs"),
        can_interact("light",1 )
    ) 
end)
kakariko_village:connect_two_ways_entrance("Kakariko Backside Pub", kakariko_backside_pub)
kakariko_village:connect_two_ways_entrance("Kakariko Frontside Pub", kakariko_frontside_pub)
kakariko_village:connect_two_ways_entrance("Kakariko Shop", kakariko_shop)
kakariko_village:connect_two_ways_entrance("Kakariko Magic Bat Cave", magic_bat_cave)
kakariko_village:connect_two_ways_entrance("Kakariko Dwarf Smiths", darf_smiths)



kakariko_well_hole:connect_one_way(kakariko_well_item)
kakariko_well_hole:connect_one_way(kakariko_well_cave)
kakariko_well_item:connect_one_way("Kakariko Well - Top", function() 
    return all(
        has("bombs"),
        can_interact("light",1 )
    ) 
end)
kakariko_well_item:connect_one_way("Kakariko Well - Left") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Middle") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Right") -- can interact as bunny
kakariko_well_item:connect_one_way("Kakariko Well - Bottom") -- can interact as bunny





kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Back", function() return has("bombs") end)
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Far Left", function() return can_interact("light",1 ) end)
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Left", function() return can_interact("light",1 ) end)
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Right", function() return can_interact("light",1 ) end)
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Far Right", function() return can_interact("light",1 ) end)






kakariko_chickenhut:connect_one_way("Chicken Hut", function() return all(has("bombs"), can_interact("light",1 )) end)


kakariko_sick_kid:connect_one_way("Sick Kid", function() return has("bottle") end) -- can interact as bunny






kakariko_shop:connect_one_way("Kakariko Shop Left")
kakariko_shop:connect_one_way("Kakariko Shop Center")
kakariko_shop:connect_one_way("Kakariko Shop Right")


kakariko_backside_pub:connect_one_way("Backside Pub", function() return can_interact("light",1 ) end)




darf_smiths:connect_one_way("Rescue Dwarf")


-- kakariko_village:connect_one_way(magic_bat_hole, function() 
--     return any(
--         has("hammer"),
--         all(
--             can_reach(purple_chest_pickup),
--             has("mirror")
--         )
--     ) 
-- end)


magic_bat_hole:connect_one_way(magic_bat_item)
magic_bat_hole:connect_one_way(magic_bat_cave)

magic_bat_item:connect_one_way("Magic Bat", function()
    return all(
        any(
            has("powder"),
            all(
                checkGlitches(2),
                has("somaria"),
                has("mushroom")
            )
        ),
        can_interact("light",1 )
    )
end)


kakariko_village:connect_one_way("Bottle Merchant")



kakariko_village:connect_two_ways(light_activate_flute, function() return has("flute") end)




-- south_of_village
south_of_village:connect_one_way(kakariko_village)
south_of_village:connect_one_way(links_house_area)
south_of_village:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)

south_of_village:connect_one_way(helpless_frog, function() 
    return all(
        inverted(), 
        canChangeWorldWithMirror()
    ) 
end)

south_of_village:connect_two_ways_entrance("Library", library)
south_of_village:connect_two_ways_entrance("Light Archery Mini Game", archery_minigame)
south_of_village:connect_two_ways_entrance("Twin House Right", twin_house_right)
-- south_of_village:connect_two_ways_entrance()


library:connect_one_way("Library Item", function() 
    return all(
        any(
            has("boots"),
            AccessibilityLevel.Inspect
        ),
        can_interact("light",1 )
    )
end)



-- 


twin_house_right:connect_two_ways(twin_house_left, function() 
    return all(
        any(
            has("bombs"), 
            has("boots")
        ),
        can_interact("light",1 )
    )
end)
twin_house_left:connect_two_ways_entrance("Race Ledge Exit", race_ledge)
-- twin_house_left:connect_one_way(south_of_village)
race_ledge:connect_one_way(south_of_village)
race_ledge:connect_one_way("Race Minigame", function() return can_interact("light",1 ) end)
south_of_village:connect_two_ways(race_ledge, function() 
    return all(
        checkGlitches(2),
        has("boots")
    )
end)

-- sanctuary_area
sanctuary_area:connect_one_way(lost_woods)
sanctuary_area:connect_one_way(eastern_palace_area)
sanctuary_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
sanctuary_area:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport

sanctuary_area:connect_two_ways(kings_tomb, function() 
    return all(
        has("titans"), 
        can_interact("light",1 )
    )
end)

kings_tomb:connect_two_ways_entrance("King's_Tomb_Entrance", kings_tomb_inside, function() 
    return all(
        has("boots"), 
        can_interact("light",1 )
    ) 
end)

kings_tomb_inside:connect_one_way("King's Tomb", function() return can_interact("light",1 ) end)

sanctuary_area:connect_two_ways_entrance("Bonk Pile Cave", sanctuary_bonk_pile_cave, function() 
    return all(
        has("boots"), 
        can_interact("light",1 )
    ) 
end)
sanctuary_bonk_pile_cave:connect_one_way("Bonk Pile Chest", function() return can_interact("light",1 ) end)

sanctuary_area:connect_two_ways(graveyard_ledge, function() return inverted() end)

graveyard_ledge:connect_two_ways(graveyard_ledge_inside)
graveyard_ledge:connect_one_way(sanctuary_area, function() return openOrStandard() end)

graveyard_ledge_inside:connect_one_way("Graveyard Ledge", function() return can_interact("light",1 ) end)


-- castle_escape_dropdown_room

sanctuary:connect_two_ways(sanctuary_area)
sanctuary:connect_one_way("Sanctuary Chest", function() return can_interact("light",1 ) end)

sanctuary_area:connect_one_way_entrance("Castel Escape Dropdown", ce_dropdown_entrance, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)







-- lost_woods
lost_woods:connect_one_way(lumberjacks_area)
lost_woods:connect_one_way(kakariko_village)
lost_woods:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)


lost_woods:connect_one_way_entrance("Lost Woods Hideout Hole", lost_woods_hideout_hole, function() return can_interact("light",1 ) end)
lost_woods:connect_two_ways_entrance("Lost Woods Hideout Cave", lost_woods_hideout_cave)
lost_woods:connect_two_ways_entrance("Lost Woods Top", lost_woods_top)
lost_woods:connect_two_ways_entrance("Pedestal Glade", lost_woods_pedestal)
lost_woods:connect_one_way("Lost Woods Mushroom", function() return can_interact("light",1 ) end)

lost_woods_hideout_hole:connect_one_way(lost_woods_hideout_item)
lost_woods_hideout_item:connect_one_way("Lost Woods Hideout")
lost_woods_hideout_hole:connect_one_way(lost_woods_hideout_cave)



lost_woods_pedestal:connect_one_way("Pedestal", function() 
    return any(
        all(
            has("pendant", 2, 2, 2, 2),
            has("greenpendant")
        ),
        canCheckWithBook()
    )
end)






-- dam_area
teleporter_at_dam:connect_one_way(dam_area,function() 
    return all(
        inverted(),
        has("pearl"),
        has("hammer")
    ) 
end)
dam_area:connect_one_way(teleporter_at_dam, function() return has("hammer") end)

dam_area:connect_one_way(desert_area)
dam_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
dam_area:connect_one_way(links_house_area)
dam_area:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport


dam_area:connect_two_ways_entrance("Dam Inside", dam_inside)
dam_area:connect_two_ways_entrance("Dam Area Top Cave", dam_top_right_cave, function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
dam_area:connect_two_ways_entrance("Dam Fairy", dam_desert_fairy)
dam_area:connect_two_ways_entrance("Dam 20 Rupee Cave", twenty_rupee_thief, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)
dam_area:connect_two_ways_entrance("Mini Moldorm Cave", mini_moldorm_cave, function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)


dam_inside:connect_one_way("Floodgate Chest", function() return can_interact("light",1 ) end)

mini_moldorm_cave:connect_two_ways(mini_moldorm_cave_back, function() 
    return all(
        dealDamage(), 
        can_interact("light",1 )
    ) 
end)
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Left")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Left")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Generous Guy")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Right")
mini_moldorm_cave_back:connect_one_way("Mini Moldorm Cave - Far Right")


dam_area:connect_one_way("Sunken Treasure", function() return can_reach("Floodgate Chest") end)

dam_area:connect_one_way("Purple Chest Return", function() return purple_chest_pickup:accessibility() end)






-- desert_area

teleporter_at_desert_ledge:connect_one_way(desert_area)
teleporter_at_desert_ledge:connect_one_way(teleporter_at_desert, function() return has("titans") end)
teleporter_at_desert:connect_one_way(teleporter_at_desert_ledge)

desert_area:connect_one_way(dam_area)
desert_area:connect_two_ways(checkerboard_lege, function() 
    return all(
        inverted(), 
        can_interact("light",1 )
    ) 
end)
checkerboard_lege:connect_one_way(desert_area)

-- desert_area:connect_two_ways_entrance("aginah_cave_entrance", aginah_cave)
-- desert_area:connect_one_way_entrance("desert_palace_front_entrance", desert_palace_front, function() return has("book") end)
-- desert_area:connect_one_way_entrance("desert_palace_front_entrance", desert_palace_front, function() return has("book") end)
-- desert_area:connect_one_way(desert_palace_front, function() return has("book") end)
desert_area:connect_two_ways_entrance("Aginah Cave", aginah_cave)
desert_area:connect_one_way_entrance("Desert Palace Front", dp_main_entrance, function() 
    return all(
        has("book"), 
        can_interact("light",1 )
    ) 
end)
-- desert_area:connect_two_ways_entrance()
-- desert_area:connect_two_ways_entrance()
-- desert_area:connect_two_ways_entrance()

aginah_cave:connect_one_way("Aginah Item", function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)

checkerboard_lege:connect_two_ways_entrance("Checkerboard Cave", checkerboard_cave, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)
checkerboard_cave:connect_one_way("Checkerboard Cave Item")


desert_ledge:connect_one_way("Desert Ledge Item", function() 
    return any(
        can_reach(desert_ledge),
        all(
            can_reach(desert_area),
            AccessibilityLevel.Inspect
        )
    )
end)
desert_ledge:connect_one_way(desert_area)

dp_back_entrance:connect_two_ways_entrance("Deser Palace Back Entrance", desert_ledge, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)
dp_left_entrance:connect_two_ways_entrance("Deser Palace Left Entrance", desert_ledge)

dp_right_entrance:connect_one_way(desert_area)

desert_area:connect_two_ways(bombos_tablet_ledge, function() return inverted() end)

bombos_tablet_ledge:connect_one_way(desert_area)
bombos_tablet_ledge:connect_one_way(bombos_tablet)
bombos_tablet:connect_one_way("Bombos Tablet", function() return 
    all(
        any(
            all(
                has("book"), 
                canActivateTablets()
            ), 
            all(
                has("book"),
                AccessibilityLevel.Inspect
            )
        ),
        can_interact("light",1 )
    )
end)


-- lumberjacks_area
lumberjacks_area:connect_one_way(lost_woods)
lumberjacks_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
lumberjacks_area:connect_one_way(sanctuary_area)
lumberjacks_area:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport
-- lumberjacks_area:connect_one_way(light_death_mountain_left_bottom)

lumberjacks_area:connect_one_way_entrance("Tree Hole", lumberjacks_hole, function() 
    return all(
        has("aga1"), 
        has("boots"),
        can_interact("light",1 )
    ) 
end)
lumberjacks_area:connect_two_ways_entrance("Lumberjacks Cave", lumberjacks_cave)
lumberjacks_area:connect_two_ways_entrance("Lumberjacks House", lumberjacks_house)
-- lumberjacks_area:connect_two_ways_entrance("Light Death Mountain Ascent", light_death_mountain_ascent, function() return has("glove") end)
 -- aga item cave

lumberjacks_hole:connect_one_way(lumberjacks_item)
lumberjacks_item:connect_one_way(lumberjacks_cave)
lumberjacks_item:connect_one_way("Lumberjacks Item")

lumberjacks_area:connect_two_ways_entrance("Lower Light Death Mountain Ascent Ledge", death_mountain_ascent_ledge, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)

 -- rescue old man

lumberjacks_area:connect_two_ways(light_bumper_cave_ledge, function() return inverted() end)

light_bumper_cave_ledge:connect_one_way(lumberjacks_area)

light_bumper_cave_ledge:connect_two_ways_entrance("Light Bumper Cave", light_bumper_cave)
light_bumper_cave_ledge:connect_one_way(dark_bumper_cave_ledge, function() 
    return all(
        canChangeWorldWithMirror(),
        inverted()
    ) 
end)







-- light_lake_hylia
light_lake_hylia:connect_one_way(links_house_area)
light_lake_hylia:connect_one_way(dam_area)
light_lake_hylia:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
light_lake_hylia:connect_one_way(eastern_palace_area)
light_lake_hylia:connect_one_way(witchhut, function() 
    return all(
        canSwim(), 
        can_interact("light",1 )
    )
end) --teleport
light_lake_hylia:connect_one_way(lumberjacks_area, function() 
    return all(
        canSwim(), 
        can_interact("light",1 )
    )
end) --teleport
light_lake_hylia:connect_one_way(zora_river, function() 
    return all(
        canSwim(), 
        can_interact("light",1 )
    )
end) --teleport
-- light_lake_hylia:connect_one_way()

light_lake_hylia:connect_two_ways_entrance("Light Lake Forune", light_lake_fortune)
light_lake_hylia:connect_two_ways_entrance("Light Lake Shop", light_lake_shop)
light_lake_hylia:connect_two_ways_entrance("Icerod Cave", icerod_cave, function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
light_lake_hylia:connect_two_ways_entrance("Icerod Fairy", icerod_fairy)
light_lake_hylia:connect_two_ways_entrance("Icerod Stone", icerod_stone, function() 
    return all(
        has("glove"), 
        can_interact("light",1 )
    ) 
end)
light_lake_hylia:connect_two_ways(upgrade_fairy_island, function() 
    return all(
        canSwim(), 
        can_interact("light",1 )
    ) 
end)

light_lake_shop:connect_one_way("Lake Hylia Shop - Left")
light_lake_shop:connect_one_way("Lake Hylia Shop - Center")
light_lake_shop:connect_one_way("Lake Hylia Shop - Right")

upgrade_fairy_island:connect_two_ways_entrance("Upgrade Fairy Entrance", upgrade_fairy)
upgrade_fairy:connect_one_way("Capacity Upgrade Left")
upgrade_fairy:connect_one_way("Capacity Upgrade Center")
upgrade_fairy:connect_one_way("Capacity Upgrade Right")

upgrade_fairy_island:connect_one_way(teleporter_at_upgrade_fairy, function() 
    return all(
        has("titans"), 
        can_interact("light",1 )
    ) 
end)
teleporter_at_upgrade_fairy:connect_one_way(upgrade_fairy_island, function() return inverted() end)

light_lake_hylia:connect_two_ways(hobo, function() 
    return all(
        canSwim(), 
        can_interact("light",1 )
    ) 
end)

hobo:connect_one_way("Hobo Item")

icerod_cave:connect_one_way("Icerod Chest", function() return can_interact("light",1 ) end)

lake_hylia_island:connect_one_way("Lake Hylia Item")










-- links_house_area
links_house_area:connect_one_way(south_of_village)
links_house_area:connect_one_way(dam_area)
links_house_area:connect_one_way(light_lake_hylia)
links_house_area:connect_one_way(eastern_palace_area)
links_house_area:connect_one_way(hyrule_castle_area)
links_house_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)


links_house_area:connect_two_ways_entrance("Link's House", links_house, function() return openOrStandard() end)
links_house_area:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop, function() return inverted() end)
links_house_area:connect_two_ways_entrance("Links Fairy", links_fairy_fountain, function() 
    return all(
        has("boots"), 
        can_interact("light",1 )
    ) 
end)

links_house:connect_one_way("Link's House Chest")

cave45_ledge:connect_two_ways_entrance("Cave 45", cave45)
cave45_ledge:connect_one_way(links_house_area, function() return openOrStandard() end)
cave45_ledge:connect_two_ways(links_house_area, function() return inverted() end)
cave45:connect_one_way("Cave 45", function() return can_interact("light",1 ) end)
links_house_area:connect_one_way("Flute Spot", function() 
    return all(
        has("shovel"), 
        can_interact("light",1 )
    ) 
end)

links_house_area:connect_one_way(pyramid, function() return has("aga1") end)




-- eastern_palace_area

eastern_palace_area:connect_one_way(teleporter_at_eastern, function() 
    return all(
        has("hammer"), 
        can_interact("light",1 )
    ) 
end)
teleporter_at_eastern:connect_one_way(eastern_palace_area, function() 
    return all(
        inverted(),
        has("pearl"), 
        has("hammer")
    ) 
end)

eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(witchhut, function() return can_interact("light", 1) end)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)


eastern_palace_area:connect_two_ways_entrance("Eastern Teleporter Cave", eastern_teleporter_cave)
eastern_palace_area:connect_two_ways_entrance("Easter Fairy", eastern_fairy, function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
eastern_palace_area:connect_two_ways_entrance("Sahasrahla", sahasralahs_hut)
eastern_palace_area:connect_two_ways_entrance("Eastern Palace Entrance", ep_entrance)




sahasralahs_hut:connect_one_way("Sahasrahla", function() return has("greenpendant") end)
sahasralahs_hut:connect_two_ways(sahasralahs_hut_back, function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Left")
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Center")
sahasralahs_hut_back:connect_one_way("Sahasrahla's Hut - Right")









-- zora_river
zora_river:connect_one_way(witchhut, function() 
    return all(
        any(
            has("glove"),
            has("flippers")
        ),
        can_interact("light",1 )
    )
end)
zora_river:connect_one_way(light_lake_hylia)
zora_river:connect_one_way("Zora", function() return can_interact("light",1 ) end)
zora_river:connect_one_way("Zora Ledge", function() 
    return any(
        has("flippers"),
        all(
            checkGlitches(2),
            has("boots")
        ),
        AccessibilityLevel.Inspect
    )
end)

zora_river:connect_two_ways_entrance("Waterfall Fairy", waterfall_fairy_inside, function()
    return any(
        has("flippers"),
        all(
            canSwim(),
            has("pearl")
        )
    )
end)


waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Left", function() return can_interact("light",1 ) end)
waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Right", function() return can_interact("light",1 ) end)







-- hyrule_castle_area
hyrule_castle_area:connect_one_way(links_house_area)
hyrule_castle_area:connect_two_ways(hyrule_castle_top_outside)
hyrule_castle_area:connect_one_way(eastern_palace_area)
hyrule_castle_area:connect_one_way(lumberjacks_area)
hyrule_castle_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)

hyrule_castle_top_outside:connect_two_ways_entrance("Castle Tower", at_entrance, function() 
    return all(
        any(
            all(
                checkGlitches(2),
                has("boots"),
                can_reach(sanctuary_area)
            ),
            canClearAgaTowerBarrier()
        ),
        openOrStandard()
    ) 
end)
hyrule_castle_top_outside:connect_two_ways_entrance("Inverted Ganons Tower", gt_entrance, function() 
    return all(
        gtCrystalCount(),
        inverted()
    ) 
end)
hyrule_castle_top_outside:connect_two_ways_entrance("Hyrule Castle Top Left", hc_left_entrance)
hyrule_castle_top_outside:connect_two_ways_entrance("Hyrule Castle Top Right", hc_right_entrance)
hyrule_castle_top_outside:connect_one_way(hyrule_castle_area)
hyrule_castle_area:connect_two_ways_entrance("Hyrule Castle Main Entrance", hc_main_entrance)
hyrule_castle_area:connect_one_way_entrance("Secret Passage Hole", secret_passage_hole, function() return can_interact("light",1 ) end)
hyrule_castle_area:connect_two_ways_entrance("Secret Passage Stairs", secret_passage_stairs)


secret_passage:connect_one_way("Secret Passage", function() return can_interact("light",1 ) end)
secret_passage:connect_one_way("Link's Uncle")
secret_passage_hole:connect_one_way(secret_passage)
secret_passage_stairs:connect_two_ways(secret_passage)





-- witchhut
witchhut:connect_one_way(eastern_palace_area, function() return can_interact("light", 1) end)
witchhut:connect_one_way(sanctuary_area)
witchhut:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
witchhut:connect_one_way(zora_river, function() 
    return all(
        has("glove"),
        can_interact("light", 1)
    )
end)

witchhut:connect_two_ways_entrance("Witchhut Shop", light_potion_shop)

light_potion_shop:connect_one_way("Deliver Mushroom", function() 
    return all(
        has("mushroom"), 
        can_reach(light_potion_shop)
    ) 
end)
light_potion_shop:connect_one_way("Potion Shop - Left")
light_potion_shop:connect_one_way("Potion Shop - Right")
light_potion_shop:connect_one_way("Potion Shop - Center")




-- 

-- 







-- light_death_mountain_left_bottom
-- light_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom, function() return all(has("mirror"), inverted()) end)

light_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom)
teleporter_at_dark_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_bottom, function() return inverted() end)

light_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_top, function() 
    return all(
        canChangeWorldWithMirror(), 
        inverted()
    ) 
end)
light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom, function() 
    return all(
        has("hookshot"), 
        can_interact("light",1 )
    ) 
end)
-- light_death_mountain_left_bottom:connect_one_way("Spectacle Rock", function() return has("mirror") end)
light_death_mountain_left_bottom:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
-- light_death_mountain_left_bottom:connect_one_way()
death_mountain_ascent_ledge:connect_one_way(light_death_mountain_ascent, function() return darkRooms() end)
light_death_mountain_ascent:connect_two_ways_entrance("Upper Light Death Mountain Ascent", light_death_mountain_left_bottom, function() return darkRooms() end)

light_death_mountain_left_bottom:connect_two_ways_entrance("Old Man Cave Entrance", old_man_cave)
light_death_mountain_left_bottom:connect_two_ways_entrance("Spectecal Rock Top Entrance", spec_rock_top_entrance)
light_death_mountain_left_bottom:connect_two_ways_entrance("Old Man Cave Backside", old_man_cave_back)

light_death_mountain_left_bottom:connect_one_way("Old Man Item", function() return can_reach(light_death_mountain_ascent) end)
light_death_mountain_left_bottom:connect_one_way(spectacle_rock_top, function() 
    return all(
        openOrStandard(), 
        canChangeWorldWithMirror()
    )
end)
-- -- light_death_mountain_left:connect_one_way(lumberjacks_area)
-- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom)
-- -- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top)

light_death_mountain_left_bottom:connect_one_way(spec_rock_ledge_entrance)
light_death_mountain_left_bottom:connect_one_way(spec_rock_ledge_exit)
spec_rock_top_entrance:connect_one_way(spectacle_rock_inside_top)

spec_rock_ledge_entrance:connect_two_ways_entrance("Spectecal Rock Ledge Entrance", spectacle_rock_inside_bottom)
spec_rock_ledge_exit:connect_two_ways_entrance("Spectecal Rock Ledge exit", spectacle_rock_cave)

spectacle_rock_inside_top:connect_one_way(spectacle_rock_cave)
spectacle_rock_inside_bottom:connect_one_way(spectacle_rock_cave)
spectacle_rock_inside_bottom:connect_one_way("Spec Rock Item", function() 
    return any(
        openOrStandard(), 
        all(
            has("pearl"), 
            inverted()
        )
    ) 
end)

spec_rock_ledge_entrance:connect_one_way(light_death_mountain_left_bottom)
spec_rock_ledge_exit:connect_one_way(light_death_mountain_left_bottom)

-- cave mide left lightg DM bottom

old_man_cave:connect_two_ways(old_man_cave_back, function() return darkRooms() end)


-- light_death_mountain_left_top

light_death_mountain_left_top:connect_two_ways_entrance("Tower of Hera Entrance", toh_entrance)
light_death_mountain_left_top:connect_one_way(dark_death_mountain_left_top, function() 
    return all(
        canChangeWorldWithMirror(), 
        inverted()
    ) 
end)
light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)
light_death_mountain_left_top:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top, function() return has("hammer") end)
light_death_mountain_left_top:connect_one_way("Ether Tablet", function() 
    return any(
        all(
        has("book"), 
        canActivateTablets()
        ),
        canCheckWithBook()
    )
end)

light_death_mountain_left_top:connect_two_ways_entrance("Tower of Hera", toh_entrance)
light_death_mountain_left_top:connect_one_way(spectacle_rock_top, function() return inverted() end)
spectacle_rock_top:connect_one_way("Spec Rock Top Item")
-- light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top)
-- light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)







-- light_death_mountain_right_bottom
light_death_mountain_right_bottom:connect_one_way(dark_death_mountain_right_bottom, function() 
    return all(
        canChangeWorldWithMirror(), 
        inverted()
    ) 
end)
light_death_mountain_right_bottom:connect_one_way(light_death_mountain_left_bottom, function() 
    return all(
        has("hookshot"), 
        can_interact("light",1 )
    ) 
end)
light_death_mountain_right_bottom:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
light_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom, function() return has("titans") end)
teleporter_at_dark_death_mountain_right_bottom:connect_one_way(light_death_mountain_right_bottom, function() return inverted() end)

-- light_death_mountain_right_bottom:connect_one_way()
-- light_death_mountain_right_bottom:connect_one_way()

light_death_mountain_right_bottom:connect_two_ways_entrance("Spiral Cave Bottom Entrance", spiral_cave_bottom)
light_death_mountain_right_bottom:connect_two_ways_entrance("Light Death Mountain Shop", light_death_mountain_shop)
light_death_mountain_right_bottom:connect_two_ways_entrance("Paradox Cave Bottom Entrance", paradox_cave_bottom)
-- light_death_mountain_right_bottom:connect_two_ways_entrance("useless cave1")
-- light_death_mountain_right_bottom:connect_two_ways_entrance("useless cave2")

paradox_cave_bottom:connect_one_way(paradox_cave_top)



-- light_death_mountain_right_top
light_death_mountain_right_top:connect_one_way(teleporter_at_light_turtle_rock, function() 
    return all(
        has("hammer"),
        has("titans")
    ) 
end)
teleporter_at_light_turtle_rock:connect_one_way(light_death_mountain_right_top, function() 
    return all(
        has("pearl"), 
        inverted(), 
        has("hammer")
    ) 
end)

light_death_mountain_right_top:connect_one_way(light_death_mountain_right_bottom)
light_death_mountain_right_top:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard(),
        can_reach(light_activate_flute)
    ) 
end)
light_death_mountain_right_top:connect_one_way(light_death_mountain_left_top, function() return has("hammer") end)
-- light_death_mountain_right_top:connect_one_way()
-- light_death_mountain_right_top:connect_one_way()

light_death_mountain_right_top:connect_two_ways_entrance("Paradox Cave Top Entrance", paradox_cave_top)
light_death_mountain_right_top:connect_two_ways_entrance("Spiral Cave Top Entrance", spiral_cave_top)
tr_eye_bridge_entrance:connect_one_way_entrance("Light Eyebridge Fairy", light_eyebridge_fairy, function() 
    return all(
        canChangeWorldWithMirror(), 
        openOrStandard()
    ) 
end)

spiral_cave_top:connect_one_way(spiral_cave_bottom)
spiral_cave_top:connect_one_way("Spiral Cave Item")

mimic_cave_ledge:connect_two_ways_entrance("Mimic Cave Entrance", mimic_cave)
mimic_cave:connect_one_way("Mimic Cave Chest", function() 
    return all(
        has("hammer"), 
        can_interact("light",1 )
    ) 
end)

paradox_cave_bottom:connect_one_way(paradox_cave_bottom_back)
paradox_cave_bottom:connect_two_ways(paradox_cave_top)

paradox_cave_bottom_back:connect_one_way(light_death_mountain_shop)
paradox_cave_bottom_back:connect_two_ways_entrance_door_stuck("Paradox Cave Top Back", paradox_cave_top_back, function() return true end, function() 
    return any(
        has("bombs"),
        has("boomerang"),
        has("somaria")
    )
end)
light_death_mountain_shop:connect_two_ways(paradox_cave_bottom_back, function() return has("mirror") end) --block delete with mirror
light_death_mountain_right_top:connect_one_way(dark_death_mountain_right_top, function() 
    return all(
        canChangeWorldWithMirror(), 
        inverted()
    ) 
end)
paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Left", function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
paradox_cave_bottom_back:connect_one_way("Paradox Cave Bottom Right", function() 
    return all(
        has("bombs"), 
        can_interact("light",1 )
    ) 
end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Left", function() return can_interact("light",1 ) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Left", function() return can_interact("light",1 ) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Middle", function() return can_interact("light",1 ) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Right", function() return can_interact("light",1 ) end)
paradox_cave_top_back:connect_one_way("Paradox Cave Top Far Right", function() return can_interact("light",1 ) end)



light_death_mountain_right_top:connect_two_ways(floating_island, function() return inverted() end)

floating_island:connect_one_way("Floating Island Item")
