-- region names

-- big_bomb_shop_area
-- swamp_area
-- mire_area
-- dark_lake_hylia
-- dark_icerod_area
-- village_of_the_outcast
-- south_of_village_of_the_outcast
-- skull_woods_area
-- dark_lumpberjacks
-- dark_chapel_area
-- dark_potion_shop
-- catfish_area
-- pyramid
-- pod_area
-- ice_palace
-- dark_death_mountain_left_top
-- dark_death_mountain_right_top
-- dark_death_mountain_left_bottom
-- dark_death_mountain_right_bottom

-- 




dark_flute_map:connect_one_way(dark_death_mountain_left_bottom)
dark_flute_map:connect_one_way(dark_potion_shop)
dark_flute_map:connect_one_way(village_of_the_outcast)
dark_flute_map:connect_one_way(big_bomb_shop_area)
dark_flute_map:connect_one_way(pod_area)
dark_flute_map:connect_one_way(mire_area)
dark_flute_map:connect_one_way(swamp_area)
dark_flute_map:connect_one_way(dark_icerod_area)


teleporter_at_village_of_the_outcast:connect_one_way(teleporter_at_kakariko_village, function() 
    return all(
        has("glove"),
        inverted()
    )
end)


teleporter_at_dark_turtle_rock:connect_one_way(teleporter_at_light_turtle_rock, function() return all(inverted(), has("titans")) end)

teleporter_at_dark_death_mountain_left_bottom:connect_one_way(teleporter_at_light_death_mountain_left_bottom, function() return inverted() end)

teleporter_at_dark_death_mountain_right_bottom:connect_one_way(teleporter_at_light_death_mountain_right_bottom, function() return inverted() end)

teleporter_at_pod:connect_one_way(teleporter_at_eastern, function() 
    return all(
        has("glove"),
        inverted()
    )
end)

teleporter_at_mire:connect_one_way(teleporter_at_desert, function() 
    return all(
        has("titans"),
        inverted()
    )
end)

teleporter_at_swamp:connect_one_way(teleporter_at_dam, function()
    return all(
        has("glove"), 
        inverted()
    )
end)

teleporter_at_ice_palace:connect_one_way(teleporter_at_upgrade_fairy, function() return inverted() end)



darkworld_spawns:connect_one_way(dark_spawn_links_house)
darkworld_spawns:connect_one_way(dark_spawn_dark_chapel_area)
darkworld_spawns:connect_one_way(dark_spawn_old_man, function() return CanReach(light_death_mountain_ascent) end) --has rescued old man

dark_spawn_links_house:connect_one_way(links_house, function() return inverted() end)
-- dark_spawn_links_house:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop, function() return openOrStandard() end)
dark_spawn_dark_chapel_area:connect_one_way(dark_chapel, function() return inverted() end)
dark_spawn_old_man:connect_one_way(dark_old_man_cave, function() return inverted() end)

-- big_bomb_shop_area
links_house:connect_two_ways_entrance("Inverted Spawn", big_bomb_shop_area, function() return inverted() end)
big_bomb_shop_area:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop, function() return openOrStandard() end)
big_bomb_shop_area:connect_one_way(swamp_area)
big_bomb_shop_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
big_bomb_shop_area:connect_one_way(dark_lake_hylia)
big_bomb_shop_area:connect_one_way(south_of_village_of_the_outcast)
-- big_bomb_shop_area:connect_one_way(pod_area, function()
--     return has("hammer")
-- end)


big_bomb_shop_area:connect_two_ways_entrance("Big Bomb Shop Fairy Cave", big_bomb_shop_fairy_cave, function() return has("boots") end)

big_bomb_shop_area:connect_one_way(cave45_ledge, function() 
    return all(
        canChangeWorldWithMirror(), 
        openOrStandard()
    ) 
end)

big_bomb_shop:connect_one_way("Buy Big Bomb", function() return all(has("crystal56",2, 2, 2, 2), can_interact("dark",1 )) end)

-- swamp_area
swamp_area:connect_one_way(teleporter_at_swamp, function() 
    return all(
        inverted(),
        has("hammer")
    )
end)
teleporter_at_swamp:connect_one_way(swamp_area, function() 
    return all(
        has("pearl"), 
        has("hammer")
    ) 
end)

swamp_area:connect_one_way(big_bomb_shop_area)
swamp_area:connect_one_way(dark_lake_hylia)
swamp_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- swamp_area:connect_one_way(desert_area, function() return(all(has("mirror"), canActivateTablets())) end)
swamp_area:connect_two_ways(bombos_tablet_ledge, function() 
    return any(
        all(
            canChangeWorldWithMirror(),
            openOrStandard()
        ),
        all(
            checkGlitches(2), 
            has("boots"),
            canChangeWorldWithMirror()
        )
    ) 
end)

swamp_area:connect_two_ways_entrance("Hype Cave", hype_cave, function() return all(has("bombs"), can_interact("dark",1 )) end)
swamp_area:connect_two_ways_entrance("Swamp Palace", sp_entrance, function() return CanReach(dam_inside) end)

hype_cave:connect_one_way("Hype Cave_Generous Guy")
hype_cave:connect_two_ways(hype_cave_back, function() return all(has("bombs"), can_interact("dark",1 )) end)

hype_cave_back:connect_one_way("Hype Cave Top")
hype_cave_back:connect_one_way("Hype Cave Middle Left")
hype_cave_back:connect_one_way("Hype Cave Middle Right")
hype_cave_back:connect_one_way("Hype Cave Bottom")

-- swamp_area:connect_one_way("Purple Chest Return", function() return CanReach(purple_chest_pickup) end)




-- mire_area
-- mire_area:connect_one_way()
mire_ledge:connect_one_way(mire_area)
mire_ledge:connect_one_way(teleporter_at_mire, function() 
    return all(
        inverted(), 
        has("titans")
    ) 
end)
teleporter_at_mire:connect_one_way(mire_ledge)

mire_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

mire_area:connect_two_ways_entrance("Misery Mire", mm_entrance,function() 
    return all(
        any(
            has("mm_medallion"), 
            has("medallion", 3, 3, 3, 3)
        ),
        canUseMedallions(),
        can_interact("dark",1 )
    )
end)
mire_area:connect_two_ways_entrance("Mire Shed Left", mire_shed_left)
mire_area:connect_two_ways_entrance("Mire Shed Right", mire_shed_right)
mire_area:connect_two_ways_entrance("Dark Desert Hint", dark_desert_hint_cave)

mire_shed_left:connect_one_way("Mire Shed_Left", function() return can_interact("dark",1 ) end)
mire_shed_left:connect_one_way("Mire Shed_Right", function() return can_interact("dark",1 ) end)


mire_area:connect_one_way(desert_ledge, function() 
    return all(
        canChangeWorldWithMirror(),
        openOrStandard()
    ) 
end)

mire_area:connect_one_way(checkerboard_lege, function() 
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    ) 
end)
-- mire_area:connect_one_way(teleper, function() return has("mirror") end)





-- dark_lake_hylia
-- dark_lake_hylia:connect_one_way(big_bomb_shop_area)
-- dark_lake_hylia:connect_one_way(ice_palace, function()
--     return all(
--         has("flippers"),
--         can_interact("dark",1)
--     )
-- end)
dark_lake_hylia:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
dark_lake_hylia:connect_one_way(dark_icerod_area, function()
    return all(
        has("flippers"),
        can_interact("dark",1)
    )
end)
dark_lake_hylia:connect_one_way(pod_area, function()
    return all(
        any(
            has("hammer"),
            has("flippers")
        ),
        can_interact("dark",1)
    )
end)
dark_lake_hylia:connect_one_way(lake_hylia_island, function()
    return all(
        canChangeWorldWithMirror(),
        canSwim("flippers"),
        openOrStandard(),
        can_interact("dark", 1)
    )
end)

dark_lake_shop:connect_one_way("Dark Lake Shop Left")
dark_lake_shop:connect_one_way("Dark Lake Shop Center")
dark_lake_shop:connect_one_way("Dark Lake Shop Right")

dark_lake_hylia:connect_two_ways_entrance("Dark Lake Shop", dark_lake_shop)
dark_lake_hylia:connect_one_way(lake_hylia_island, function()
    return all(
        has("flippers"),
        openOrStandard(),
        canChangeWorldWithMirror(),
        can_interact("dark", 1)
    ) 
end)
dark_lake_hylia:connect_two_ways(ice_palace_island, function() 
    return all(
        canSwim(), 
        inverted(),
        can_interact("dark",1 )
    ) 
end)

ice_palace_island:connect_one_way(teleporter_at_ice_palace, function() 
    return all(
        inverted(), 
        has("titans")
    ) 
end)
teleporter_at_ice_palace:connect_one_way(ice_palace_island)

ice_palace_island:connect_two_ways_entrance("Ice Palace", ip_entrance)




-- dark_icerod_area
dark_icerod_area:connect_one_way(ice_palace_island, function()
    return all(
        inverted(),
        has("flippers"),
        can_interact("dark",1 )
    )
end)

dark_icerod_area:connect_one_way(pod_area, function()
    return all(
        has("flippers"),
        can_interact("dark",1 )
    )
end)

dark_icerod_area:connect_one_way(lake_hylia_island, function() 
    return all(
        canChangeWorldWithMirror(),
        canSwim(),
        openOrStandard(),
        can_interact("dark",1 )
    )
end)

dark_icerod_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

dark_icerod_area:connect_two_ways_entrance("Dark Icerod Cave", dark_icerod_cave, function() return all(has("bombs"), can_interact("dark",1 )) end)
dark_icerod_area:connect_two_ways_entrance("Dark Icerod Fairy", dark_icerod_fairy)
dark_icerod_area:connect_two_ways_entrance("Dark Icerod Stone", dark_icerod_stone, function() return all(has("glove"), can_interact("dark",1 )) end)









-- village_of_the_outcast
village_of_the_outcast:connect_one_way(teleporter_at_village_of_the_outcast, function() 
    return all(
        inverted(),
        any(
            has("hammer"), 
            has("titans")
        )
    ) 
end)
teleporter_at_village_of_the_outcast:connect_one_way(village_of_the_outcast, function() 
    return all(
        has("pearl"), 
        any(
            has("hammer"), 
            has("titans")
        )
    ) 
end)

village_of_the_outcast:connect_two_ways(inverted_activate_flute, function() 
    return all(
        has("flute"),
        inverted()
    ) 
end)
village_of_the_outcast:connect_one_way(skull_woods_area)
village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
village_of_the_outcast:connect_one_way(south_of_village_of_the_outcast)
village_of_the_outcast:connect_two_ways(inverted_activate_flute, function() 
    return all(
        has("flute"),
        inverted()
    )
end)


village_of_the_outcast:connect_two_ways_entrance("C-Shaped House", c_shaped_house)
village_of_the_outcast:connect_two_ways_entrance("Chest Game Entrance", chest_game)
village_of_the_outcast:connect_two_ways_entrance("Thieves Town Entrance", tt_entrance)
village_of_the_outcast:connect_two_ways_entrance("Dark Village Shop", dark_village_shop, function() return all(has("hammer"), can_interact("dark",1 )) end)
village_of_the_outcast:connect_two_ways_entrance("Brewery", brewery, function() return all(has("bombs"), can_interact("dark",1 )) end)

chest_game:connect_one_way("Chest Game Item", function() return can_interact("dark",1 ) end)

c_shaped_house:connect_one_way("C-Shaped House", function() return can_interact("dark",1 ) end)

dark_village_shop:connect_one_way("Village of Outcasts Shop Left")
dark_village_shop:connect_one_way("Village of Outcasts Shop Center")
dark_village_shop:connect_one_way("Village of Outcasts Shop Right")

brewery:connect_one_way("Brewery Chest", function() return can_interact("dark",1 ) end)


village_of_the_outcast:connect_two_ways(purple_chest_pickup, function() return all(has("titans"), can_interact("dark",1 )) end)
purple_chest_pickup:connect_two_ways_entrance("Peg Cave", peg_cave_inside, function() return all(has("hammer"), can_interact("dark",1 )) end)

peg_cave_inside:connect_one_way("Peg-Cave Item")

village_of_the_outcast:connect_two_ways(helpless_frog, function() return all(has("titans"), can_interact("dark",1 )) end)

-- south_of_village_of_the_outcast
south_of_village_of_the_outcast:connect_one_way(village_of_the_outcast, function()
    return has("titans")
end)
south_of_village_of_the_outcast:connect_one_way(big_bomb_shop_area)
south_of_village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
south_of_village_of_the_outcast:connect_two_ways_entrance("Dark Archery", dark_archery_minigame)
south_of_village_of_the_outcast:connect_one_way("Digging Game", function () return can_interact("dark",1 ) end)
south_of_village_of_the_outcast:connect_one_way(twin_house_left, function() 
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    )
end)

-- south_of_village_of_the_outcast:connect_one_way(mire_area) -- glitches

big_bomb_shop_area:connect_two_ways(stumpy)
big_bomb_shop_area:connect_two_ways(cave45, function() 
    return all(
        openOrStandard(), 
        canChangeWorldWithMirror()
    ) 
end)
stumpy:connect_one_way("Stumpy")







-- skull_woods_area
skull_woods_area:connect_one_way(village_of_the_outcast)
skull_woods_area:connect_one_way(dark_lumpberjacks)

skull_woods_area:connect_one_way_entrance("Skull Woods Pinball Drop", sw_pinball_drop)
skull_woods_area:connect_one_way_entrance("Skull Woods Pot Circle Drop", sw_pot_circle_drop)
skull_woods_area:connect_one_way_entrance("Skull Woods Bottom Left Drop", sw_bottom_left_drop)

skull_woods_area:connect_two_ways_entrance("Skull Woods Front", sw_big_chest_entrance)
skull_woods_area:connect_two_ways_entrance("Skull Woods West Lobby", sw_west_lobby_entrance)
skull_woods_area:connect_two_ways_entrance("Skull Woods Gibdo Lobby", sw_gibdo_entrance)

skull_woods_area:connect_one_way_entrance("Skull Woods Back North Drop", sw_north_drop, function() return CanReach(sw_west_lobby_entrance) end)
skull_woods_area:connect_two_ways_entrance("Skull Woods Back", sw_back_entrance, function() 
    return all(
        CanReach(sw_west_lobby_entrance),
        has("firerod"),
        can_interact("dark",1 )
    )
end)


-- dark_lumpberjacks
dark_lumpberjacks:connect_one_way(skull_woods_area)
dark_lumpberjacks:connect_one_way(dark_chapel_area)
dark_lumpberjacks:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)


dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Left")
dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Center")
dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Right")

red_shield_shop:connect_one_way("Red Shield Shop Left")
red_shield_shop:connect_one_way("Red Shield Shop Center")
red_shield_shop:connect_one_way("Red Shield Shop Right")


dark_lumpberjacks:connect_two_ways_entrance("Dark Lumberjacks Shop", dark_lumpberjacks_shop)
dark_lumpberjacks:connect_two_ways_entrance("Red Shield Shop", red_shield_shop)
dark_lumpberjacks:connect_two_ways_entrance("Bumper Cave", dark_bumper_cave, function() return all(openOrStandard(), has("glove"), can_interact("dark",1 )) end)
dark_lumpberjacks:connect_one_way("Bumper Cave Item", function() return AccessibilityLevel.Inspect end)
dark_lumpberjacks:connect_one_way(dark_death_mountain_ascent_ledge, function() 
    return all(
        inverted(),
        has("glove")
    )
end)
dark_death_mountain_ascent_ledge:connect_one_way(dark_lumpberjacks)
dark_death_mountain_ascent_ledge:connect_one_way(dark_death_mountain_ascent, function() return darkRooms() end)
dark_death_mountain_ascent:connect_two_ways_entrance("Upper Dark Death Mountain Ascent", dark_death_mountain_left_bottom, function() return darkRooms() end)

dark_bumper_cave:connect_one_way_entrance("Normal Bumpercave", dark_bumper_cave_ledge,function() return all(openOrStandard(), has("cape"), can_interact("dark",1 )) end)
dark_bumper_cave_ledge:connect_one_way_entrance("Reverse Bumpercave", dark_bumper_cave, function() 
    return all(
        any(
            has("hookshot"), 
            has("cape")
        ),
        can_interact("dark",1 )
    )
end)
dark_bumper_cave_ledge:connect_one_way("Bumper Cave Item", function() 
    return any(
        dark_bumper_cave_ledge:accessibility(),
        AccessibilityLevel.Inspect
    ) 
end)
dark_bumper_cave_ledge:connect_one_way(light_bumper_cave_ledge, function() 
    return all(
        canChangeWorldWithMirror(), 
        openOrStandard()
    )
end)
dark_bumper_cave_ledge:connect_one_way(dark_lumpberjacks)


-- dark_chapel_area
dark_chapel_area:connect_one_way(dark_lumpberjacks)
dark_chapel_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
dark_chapel_area:connect_one_way(dark_potion_shop, function()
    return all(
        has("flippers"),
        can_interact("dark",1 )
    )
end)

dark_chapel_area:connect_one_way(graveyard_ledge, function()
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    )
end)
dark_chapel_area:connect_one_way(kings_tomb, function()
    return all(
        openOrStandard(),
        canChangeWorldWithMirror(),
        has("pearl")
    )
end)


dark_chapel_area:connect_two_ways_entrance("Dark Chapel", dark_chapel)



-- dark_potion_shop
dark_potion_shop:connect_one_way(dark_chapel_area, function()
    return all(
        has("hookshot"),
        can_interact("dark",5)
    )
end)
dark_potion_shop:connect_one_way(catfish_area, function()
    return all(
        has("glove"),
        can_interact("dark",1 )
    )
end)
dark_potion_shop:connect_one_way(pod_area, function()
    return all(
        any(
            has("hammer"),
            has("glove")
        ),
        can_interact("dark",1 )
    )
end)
dark_potion_shop:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

dark_potion_shop:connect_two_ways_entrance("Dark Potion Shop", dark_potion_shop_inside)

dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")







-- catfish_area
catfish_area:connect_one_way(dark_potion_shop, function()
    return all(
        any(
            has("flippers"),
            has("glove")
        ),
        can_interact("dark",1 )
    )
end)
catfish_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
catfish_area:connect_one_way("Catfish Item", function() return can_interact("dark",1 ) end)
-- catfish_area:connect_one_way() --glicht to pod






-- pyramid
pyramid:connect_one_way(pod_area)
pyramid:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

pyramid:connect_one_way("Pyramid Item")
pyramid:connect_one_way_entrance("Fat Fairy", pyramid_fairy_cave, function() 
    return all(
        has("crystal56", 2, 2, 2, 2), 
        big_bomb_shop:accessibility(),
        can_interact("dark",1 ),
        any(
            all(
                has("mirror"),
                inverted()
            ),
            openOrStandard()
        )
    )
end)

pyramid_fairy_cave:connect_one_way("Pyramid Fairy Left")
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Right")






-- pod_area
pod_area:connect_one_way(teleporter_at_pod, function() 
    return all(
        inverted(), 
        has("hammer")
    ) 
end)
teleporter_at_pod:connect_one_way(pod_area, function() 
    return all(
        has("pearl"), 
        has("hammer")
    ) 
end)

pod_area:connect_one_way(pyramid)
pod_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
pod_area:connect_one_way(dark_potion_shop,function()
    return all(
        any(
            has("hammer"),
            has("glove"),
            has("flippers")
        ),
        can_interact("dark",5)
    )
end)

pod_area:connect_one_way(ice_palace_island, function()
    return all(
        has("flippers"),
        can_interact("dark",5),
        inverted()
    )
end)
pod_area:connect_one_way(dark_icerod_area, function()
    return all(
        has("flippers"),
        can_interact("dark",5)
    )
end)

pod_area:connect_one_way(big_bomb_shop_area, function()
    return all(
        has("hammer"),
        can_interact("dark", 5)
    )
end)

pod_area:connect_two_ways_entrance("Kiki Cave", kiki_cave)
pod_area:connect_two_ways_entrance("Palace of Darkness", palace_of_darkness, function() return can_interact("dark",4) end)
pod_area:connect_two_ways_entrance("Dark PoD Fairy", pod_fairy_cave)
pod_area:connect_two_ways_entrance("PoD Teleporter Cave", pod_teleport_cave)

pod_area:connect_two_ways_entrance("Palace of Darkness Entrance", pod_entrance, function() return can_interact("dark",4) end)






-- ice_palace
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()








-- dark_death_mountain_left_top
dark_death_mountain_left_top:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_left_top:connect_one_way()
dark_death_mountain_left_top:connect_one_way(light_death_mountain_left_top, function() 
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    ) 
end)
dark_death_mountain_left_top:connect_two_ways_entrance("Ganons Tower", gt_entrance, function() 
    return all(
        gtCrystalCount(), 
        openOrStandard()
    ) 
end)
dark_death_mountain_left_top:connect_two_ways_entrance("Ganons Tower", at_entrance, function() return inverted() end)

dark_death_mountain_left_top:connect_two_ways(dark_death_mountain_right_top)



-- dark_death_mountain_right_top
dark_death_mountain_right_top:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_right_top:connect_one_way()
dark_death_mountain_right_top:connect_one_way(teleporter_at_dark_turtle_rock, function() 
    return all(
        inverted()
    )
end)
teleporter_at_dark_turtle_rock:connect_one_way(dark_death_mountain_right_top)


teleporter_at_dark_turtle_rock:connect_two_ways_entrance("Turtle Rock Main Entrance", tr_main_entrance, function() 
    return all(
        any(
            has("tr_medallion"),
            has("medallion", 3, 3, 3, 3)
        ),
        canUseMedallions(),
        can_interact("dark",1 )
    ) 
end)
dark_death_mountain_right_top:connect_two_ways_entrance("Hookshot Cave", hookshot_cave, function() 
    return any(
        all(
            has("glove"),
            can_interact("dark",5)
        )
    )
end)
hookshot_cave:connect_two_ways(floating_island, function() 
    return all(
        has("bombs"),
        canChangeWorldWithMirror(),
        openOrStandard(),
        can_interact("dark",5)
    ) 
end)

hookshot_cave:connect_one_way("Hookshot Cave Item Bottom Right", function() 
    return all(
        any(
            has("hookshot"),
            has("boots")
        ),
        can_interact("dark",5)
    )
end)
hookshot_cave:connect_one_way("Hookshot Cave Item Top Right", function() 
    return all(
        has("hookshot"), 
        can_interact("dark",5)
    ) 
end)
hookshot_cave:connect_one_way("Hookshot Cave Item Top Left", function() 
    return all(
        has("hookshot"), 
        can_interact("dark",5)
    ) 
end)
hookshot_cave:connect_one_way("Hookshot Cave Item Bottom Left", function() 
    return all(
        has("hookshot"), 
        can_interact("dark",5)
    ) 
end)


tr_eye_bridge_entrance:connect_two_ways_entrance("Light Eyebridge Connector", light_eyebridge_fairy, function() 
    return all(
        openOrStandard(), 
        canChangeWorldWithMirror()
    ) 
end)
-- dark_death_mountain_lonely_ledge:connect_one_way(tr_eye_bridge_entrance, function() return inverted() end)
dark_death_mountain_right_top:connect_one_way(dark_death_mountain_right_bottom)


-- dark_death_mountain_left_bottom
dark_death_mountain_left_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_left_bottom:connect_one_way()
dark_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom, function() return inverted() end)
-- teleporter_at_dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom, function() return has("pearl") end)
teleporter_at_dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom)

dark_death_mountain_left_bottom:connect_two_ways_entrance("Spike Cave", spike_cave)
dark_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top, function() 
    return all(
        canChangeWorldWithMirror(),
        openOrStandard()
    )
end)
spike_cave:connect_one_way("Spike Cave Chest", function() 
    return all(
        has("hammer"),
        has("glove"),
        can_interact("dark",5) --,
        -- has("heartpieces", )
    )
end)
dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_top, function() return inverted() end)

dark_death_mountain_left_bottom:connect_two_ways_entrance("Dark Death Mountain Descent", dark_death_mountain_descent, function() return darkRooms() end)



-- dark_death_mountain_right_bottom
dark_death_mountain_right_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_right_bottom:connect_one_way()
dark_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom, function() 
    return all(
        inverted(), 
        has("titans")
    ) 
end)
teleporter_at_dark_death_mountain_right_bottom:connect_one_way(dark_death_mountain_right_bottom)

turtle_rock_ledge:connect_two_ways_entrance("Turtle Rock Big Chest Entrance", tr_big_chest_entrance)
turtle_rock_ledge:connect_two_ways_entrance("Turtle Rock Laser Entrance", tr_laser_entrance, function() 
    return all(
        has("bombs"), 
        can_interact("dark",1 )
    ) 
end)
turtle_rock_ledge:connect_one_way(mimic_cave_ledge, function() 
    return all(
        canChangeWorldWithMirror(), 
        openOrStandard()
    ) 
end)
-- tr_laser_entrance:connect_two_ways_entrance("Light Death Mountain Fairy", light_death_mountain_cave1, function() return has("mirror") end)


dark_death_mountain_right_bottom:connect_two_ways_entrance("Dark Death Mountain Shop", dark_death_mountain_shop)

dark_death_mountain_right_bottom:connect_two_ways_entrance("Super Bunny Cave Bottom Entrance", superbunny_cave_bottom)
dark_death_mountain_right_top:connect_two_ways_entrance("Super Bunny Cave Top Entrance", superbunny_cave_top)

superbunny_cave_bottom:connect_one_way(superbunny_cave_top)
superbunny_cave_top:connect_one_way("Super Bunny Cave Chest Top")
superbunny_cave_top:connect_one_way("Super Bunny Cave Chest Bottom")

