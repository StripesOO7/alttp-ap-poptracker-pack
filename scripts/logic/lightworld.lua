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



light_spawn_links_house_area = alttp_location.new()
-- light_spawn_links_house_area:connect_two_ways_entrance("links_house_door", links_house_area, function()
--     return any(
--         openOrStandard(),
--         all(
--             has("inverted"),
--             has("pearl"),
--             any(
--                 all(
--                     has("hammer"),
--                     has("glove"),
--                 ),
--                 has("titans"),
--                 has("aga1"),
--             )
--         )
--     )
-- end)



light_spawn_sanctuary = alttp_location.new()
-- light_spawn_sanctuary:connect_two_ways_entrance("sanctuary_door", sanctuary_area, function()
--     return any(
--         openOrStandard(),
--         all(
--             has("inverted"),
--             has("pearl"),
--             any(
--                 all(
--                     has("hammer"),
--                     has("glove"),
--                 ),
--                 has("titans"),
--                 has("aga1"),
--             )
--         )
--     )
-- end)



light_spawn_old_man = alttp_location.new()
-- light_spawn_old_man:connect_two_ways_entrance("old_man_cave_front_exit", light_death_mountain_left_bottom, function()
--     return any(
--         openOrStandard(),
--         all(
--             has("inverted"),
--             has("pearl"),
--             any(
--                 all(
--                     has("hammer"),
--                     has("glove"),
--                 ),
--                 has("titans"),
--                 has("aga1"),
--             )
--         )
--     )
-- end)
AccessibilityLevel.None
AccessibilityLevel.Partial
AccessibilityLevel.Inspect
AccessibilityLevel.SequenceBreak
AccessibilityLevel.Normal
AccessibilityLevel.Cleared

kakariko_village = alttp_location.new()
south_of_village = alttp_location.new()
sanctuary_area = alttp_location.new()
lost_woods = alttp_location.new()
dam_area = alttp_location.new()
desert_area = alttp_location.new()
lumberjacks = alttp_location.new()
light_lake_hylia = alttp_location.new()
links_house_area = alttp_location.new()
eastern_palace_area = alttp_location.new()
zora_river = alttp_location.new()
hyrule_castle_area = alttp_location.new()
witchhut = alttp_location.new()
light_death_mountain_left_bottom = alttp_location.new()
light_death_mountain_left_top = alttp_location.new()
light_death_mountain_right_bottom = alttp_location.new()
light_death_mountain_right_top = alttp_location.new()

hyrule_castle = alttp_location.new()
eastern_palace = alttp_location.new()
desert_palace = alttp_location.new()
tower_of_hera = alttp_location.new()
agahnims_tower = alttp_location.new()

hyrule_castle_front = alttp_location.new()
hyrule_castle_top_left = alttp_location.new()
hyrule_castle_top_right = alttp_location.new()
desert_palace_front = alttp_location.new()
desert_palace_left = alttp_location.new()
desert_palace_right = alttp_location.new()
desert_palace_back = alttp_location.new()


light_flute_map = alttp_location.new()
light_flute_map:connect_one_way(light_death_mountain_left_bottom)
light_flute_map:connect_one_way(witchhut)
light_flute_map:connect_one_way(kakariko_village)
light_flute_map:connect_one_way(links_house_area)
light_flute_map:connect_one_way(eastern_palace_area)
light_flute_map:connect_one_way(desert_area)
light_flute_map:connect_one_way(dam_area)
light_flute_map:connect_one_way(light_lake_hylia)





-- kakariko_village
kakariko_village:connect_one_way(south_of_village)
kakariko_village:connect_one_way(lost_woods)
kakariko_village:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)







-- kakariko_well = alttp_location.new()
kakariko_well_cave = alttp_location.new()
kakariko_well_hole = alttp_location.new()
kakariko_well_item = alttp_location.new()

kakariko_well_hole:connect_one_way(kakariko_well_item)
kakariko_well_hole:connect_one_way(kakariko_well_cave)
kakariko_well_item:connect_one_way("Kakariko Well - Top", function() return has("bombs") end)
kakariko_well_item:connect_one_way("Kakariko Well - Left")
kakariko_well_item:connect_one_way("Kakariko Well - Middle")
kakariko_well_item:connect_one_way("Kakariko Well - Right")
kakariko_well_item:connect_one_way("Kakariko Well - Bottom")


kakariko_house_top_left = alttp_location.new()

kakariko_blinds_hideout = alttp_location.new()
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Back", function() return has("bombs") end)
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Far Left")
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Left")
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Right")
kakariko_blinds_hideout:connect_one_way("Blind's Hideout - Far Right")

kakariko_house_hill_top = alttp_location.new()

kakariko_house_right_top = alttp_location.new()

kakariko_chickenhut = alttp_location.new()
kakariko_chickenhut:connect_one_way("Chicken House", function() return has("bombs") end)

kakariko_sick_kid = alttp_location.new()
kakariko_sick_kid:connect_one_way("Sick Kid", function() return has("bottle") end)

kakariko_house_right_center = alttp_location.new()

kakariko_bombhut = alttp_location.new()

kakariko_shop = alttp_location.new()
kakariko_shop:connect_one_way("Kakariko Shop Left")
kakariko_shop:connect_one_way("Kakariko Shop Center")
kakariko_shop:connect_one_way("Kakariko Shop Right")

kakariko_backside_pub = alttp_location.new()
kakariko_backside_pub:connect_one_way("Backside Pub")

kakariko_frontside_pub = alttp_location.new()

magic_bat_hole = alttp_location.new()
magic_bat_item = alttp_location.new()
magic_bat_item:connect_one_way("Magic Bat", function()
    return any(
        has("powder")--,
        -- all(
        --     checkGlitches(2),
        --     has("somaria"),
        --     has("mushroom")
        -- )
    )
end)
magic_bat_cave = alttp_location.new()
magic_bat_hole:connect_one_way(magic_bat_item)
magic_bat_hole:connect_one_way(magic_bat_cave)

darf_smiths = alttp_location.new()
-- darf_smiths:connect_one_way("Rescue Dwarf")








-- south_of_village
south_of_village:connect_one_way(kakariko_village)
south_of_village:connect_one_way(links_house_area)
south_of_village:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)


library = alttp_location.new()
library:connect_one_way("Library Item", function() 
    return any(
        has("boots"),
        AccessibilityLevel.Inspect
    ) 
end)

shooting_gallery = alttp_location.new()

-- twin_house = alttp_location.new()
twin_house_left = alttp_location.new()
twin_house_right = alttp_location.new()
twin_house_right:connect_two_ways(twin_house_left, function() return any(has("bombs"), has("boots")) end)





-- sanctuary_area
sanctuary_area:connect_one_way(lost_woods)
sanctuary_area:connect_one_way(eastern_palace_area)
sanctuary_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
sanctuary_area:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport


kings_tomb = alttp_location.new()
kings_tomb_inside = alttp_location.new()
kings_tomb_inside:connect_one_way("King's Tomb")

graveyard_ledge_cave = alttp_location.new()
graveyard_ledge_inside = alttp_location.new()
graveyard_ledge_inside:connect_one_way("Graveyard Ledge")

graveyard_fairy = alttp_location.new()
-- castle_escape_dropdown_room

sanctuary = alttp_location.new()
sanctuary:connect_one_way("Sanctuary Chest")







-- lost_woods
lost_woods:connect_one_way(lumberjacks)
lost_woods:connect_one_way(kakariko_village)
lost_woods:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)


lost_woods_fortune = alttp_location.new()

lost_woods_hideout_cave = alttp_location.new()
lost_woods_hideout_hole = alttp_location.new()
lost_woods_hideout_item = alttp_location.new()
lost_woods_hideout_hole:connect_one_way(hideout_item)
lost_woods_hideout_item:connect_one_way("Lost Woods Hideout")
lost_woods_hideout_hole:connect_one_way(lost_woods_hideout_cave)

lost_woods_top = alttp_location.new()
lost_woods_pedestal = alttp_location.new()
lost_woods_pedestal:connect_one_way("Pedestal", function() 
    return any(
        has("pendant", 3),
        canCheckWithBook()
    )
end)






-- dam_area
dam_area:connect_one_way(desert_area)
dam_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
dam_area:connect_one_way(links_house_area)
dam_area:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport


dam_top_right_cave = alttp_location.new()

dam_inside = alttp_location.new()
dam_inside:connect_one_way("Floodgate Chest")

sunken_treasure = alttp_location.new()
sunken_treasure:connect_one_way("Sunken Treasure", function() return can_reach(dam_inside) end)

mini_moldorm_cave = alttp_location.new()
mini_moldorm_cave:connect_one_way("Mini Moldorm Cave - Far Left", function() return dealDamage() end)
mini_moldorm_cave:connect_one_way("Mini Moldorm Cave - Left", function() return dealDamage() end)
mini_moldorm_cave:connect_one_way("Mini Moldorm Cave - Generous Guy", function() return dealDamage() end)
mini_moldorm_cave:connect_one_way("Mini Moldorm Cave - Right", function() return dealDamage() end)
mini_moldorm_cave:connect_one_way("Mini Moldorm Cave - Far Right", function() return dealDamage() end)

dam_desert_fairy = alttp_location.new()

twenty_rupee_thief = alttp_location.new()







-- desert_area
desert_area:connect_one_way(dam_area)


aginah_cave = alttp_location.new()
aginah_cave:connect_one_way("Aginah Item", function() return has("bombs") end)

checkerboard_cave = alttp_location.new()
checkerboard_cave:connect_one_way("Checkerboard Cave")






-- lumberjacks
lumberjacks:connect_one_way(lost_woods)
lumberjacks:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
lumberjacks:connect_one_way(sanctuary_area)
lumberjacks:connect_one_way(light_lake_hylia, function()
    return has("flippers")
end) --teleport
-- lumberjacks:connect_one_way(light_death_mountain_left_bottom)


lumberjacks_hole = alttp_location.new()
lumberjacks_cave = alttp_location.new() -- aga item cave
lumberjacks_item = alttp_location.new()

lumberjacks_hole:connect_one_way(lumberjacks_item, function() retrun has("aga1") end)
lumberjacks_hole:connect_one_way(lumberjacks_cave)
lumberjacks_item:connect_one_way("Lumberjacks Item")

lumberjacks_house = alttp_location.new()

death_mountain_accend = alttp_location.new() -- rescue old man

light_bumper_cave = alttp_location.new()

sanctuary_bonk_cave = alttp_location.new()







-- light_lake_hylia
light_lake_hylia:connect_one_way(links_house_area)
light_lake_hylia:connect_one_way(dam_area)
light_lake_hylia:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
light_lake_hylia:connect_one_way(eastern_palace_area)
light_lake_hylia:connect_one_way(witchhut, function() 
    return canSwim()
end) --teleport
light_lake_hylia:connect_one_way(lumberjacks, function() 
    return canSwim()
end) --teleport
light_lake_hylia:connect_one_way(zora_river, function() 
    return canSwim()
end) --teleport


light_lake_fortune = alttp_location.new()

light_lake_shop = alttp_location.new()
light_lake_shop:connect_one_way("Lake Hylia Shop - Left")
light_lake_shop:connect_one_way("Lake Hylia Shop - Center")
light_lake_shop:connect_one_way("Lake Hylia Shop - Right")

upgrade_fairy = alttp_location.new()
upgrade_fairy:connect_one_way("Capacity Upgrade Left")
upgrade_fairy:connect_one_way("Capacity Upgrade Center")
upgrade_fairy:connect_one_way("Capacity Upgrade Right")

hobo = alttp_location.new()

icerod_cave = alttp_location.new()
icerod_cave_inside = alttp_location.new()
icerod_cave_inside:connect_one_way("Icerod Chest")

icerod_fairy = alttp_location.new()

icerod_stone = alttp_location.new()








-- links_house_area
links_house_area:connect_one_way(south_of_village)
links_house_area:connect_one_way(dam_area)
links_house_area:connect_one_way(light_lake_hylia)
links_house_area:connect_one_way(eastern_palace_area)
links_house_area:connect_one_way(hyrule_castle_area)
links_house_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)


links_fairy_fountain = alttp_location.new()

links_house = alttp_location.new()
links_house:connect_one_way("Link's House Chest")

cave45 = alttp_location.new()
cave45:connect_one_way("Cave 45")







-- eastern_palace_area
eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_lake_hylia)
eastern_palace_area:connect_one_way(witchhut)
eastern_palace_area:connect_one_way(links_house_area)
eastern_palace_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)


eastern_teleporter_cave = alttp_location.new()

easter_fairy = alttp_location.new()

sahasralahs_hut = alttp_location.new()
sahasralahs_hut:connect_one_way("Sahasrahla", function() return has("greenpendant") end)
sahasralahs_hut:connect_one_way("Sahasrahla's Hut - Left", function() return has("bombs") end)
sahasralahs_hut:connect_one_way("Sahasrahla's Hut - Center", function() return has("bombs") end)
sahasralahs_hut:connect_one_way("Sahasrahla's Hut - Right", function() return has("bombs") end)









-- zora_river
zora_river:connect_one_way(witchhut, function() 
    return any(
        has("gloves"),
        has("flippers")
    )
end)
zora_river:connect_one_way(light_lake_hylia)
zora_river:connect_one_way("Zora")
zora_river:connect_one_way("Zora Ledge", function() 
    return any(
        has("flippers"),
        all(
            checkGlitches(2),
            has("boots")
        )
    )
end)


waterfall_fairy = alttp_location.new()
waterfall_fairy_inside = alttp_location.new()
waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Left")
waterfall_fairy_inside:connect_one_way("Waterfall Fairy - Right")







-- hyrule_castle_area
hyrule_castle_area:connect_one_way(links_house_area)
hyrule_castle_area:connect_one_way(eastern_palace_area)
hyrule_castle_area:connect_one_way(lumberjacks)
hyrule_castle_area:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)


secret_passage_hole = alttp_location.new()
secret_passage_stairs = alttp_location.new()
secret_passage = alttp_location.new()
secret_passage:connect_one_way("Secret Passage")
secret_passage:connect_one_way("Link's Uncle")
secret_passage_hole:connect_one_way(secret_passage)
secret_passage_stairs:connect_two_ways(secret_passage)





-- witchhut
witchhut:connect_one_way(eastern_palace_area)
witchhut:connect_one_way(sanctuary_area)
witchhut:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
witchhut:connect_one_way(zora_river, function() 
    return has("gloves") 
end)


light_potion_shop = alttp_location.new()
light_potion_shop:connect_one_way("Potion Shop", function() return deliverMushroom() end)
light_potion_shop:connect_one_way("Potion Shop - Left")
light_potion_shop:connect_one_way("Potion Shop - Right")
light_potion_shop:connect_one_way("Potion Shop - Center")


darkworld_teleport_kakariko_village = alttp_location.new()
darkworld_teleport_kakariko_village:connect_one_way(skull_woods_area, function() 
    return any(
        has("titans"),
        all(
            has("gloves"),
            has("hammer")
        )
    )
end)


darkworld_teleport_turtle_rock = alttp_location.new()
darkworld_teleport_turtle_rock:connect_one_way(dark_death_mountain_right_top, function() 
    return all(
        has("hammer"), 
        has("titans")
    )
end)


darkworld_teleport_desert_area = alttp_location.new()
darkworld_teleport_desert_area:connect_one_way(mire_area, function() 
    return all(
        has("titans"),
        has("flute")
    )
end)




-- lightworld_overworld = alttp_location.new()

-- light_death_mountain = alttp_location.new()







-- light_death_mountain_left_bottom
light_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top, function() return has("mirror") end)
light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom, function() return has("hookshot") end)
light_death_mountain_left_bottom:connect_one_way("Spectacle Rock", function() return has("mirror") end)
light_death_mountain_left_bottom:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
light_death_mountain_left_bottom:connect_one_way()


spectacle_rock_cave = alttp_location.new()

-- -- light_death_mountain_left:connect_one_way(lumberjacks)
-- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_right_bottom)
-- -- light_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top)







-- light_death_mountain_left_top
light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)
light_death_mountain_left_top:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top, function() retrun has("hammer") end)
light_death_mountain_left_top:connect_one_way("Ether Tablet", function() 
    return any(
        all(
        has("book"), 
        canActivateTablets()
        ),
        canCheckWithBook()
    )
end)


-- light_death_mountain_left_top:connect_one_way(light_death_mountain_right_top)
-- light_death_mountain_left_top:connect_one_way(light_death_mountain_left_bottom)







-- light_death_mountain_right_bottom
light_death_mountain_right_bottom:connect_one_way(light_death_mountain_left_bottom, function() return has("hookshot") end)
light_death_mountain_right_bottom:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
hookshot_cave
-- light_death_mountain_right_bottom:connect_one_way()
-- light_death_mountain_right_bottom:connect_one_way()







-- light_death_mountain_right_top
light_death_mountain_right_top:connect_one_way(light_death_mountain_right_bottom)
light_death_mountain_right_top:connect_one_way(light_flute_map, function() 
    return all(
        has("flute"),
        openOrStandard()
    ) 
end)
light_death_mountain_right_top:connect_one_way(light_death_mountain_left_top, function() return has("hammer") end)
-- light_death_mountain_right_top:connect_one_way()
-- light_death_mountain_right_top:connect_one_way()