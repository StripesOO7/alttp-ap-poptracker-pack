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
    return any(
        all(
            has("hammer"), 
            has("glove"),
            inverted()
        ),
        all(
            has("titans"),
            inverted()
        )
    )
end)

teleporter_at_dark_turtle_rock:connect_one_way(teleporter_at_light_turtle_rock, function() 
    return all(
        has("gloves"), 
        has("hammer"),
        inverted()
    ) 
end)

teleporter_at_dark_death_mountain_left_bottom:connect_one_way(teleporter_at_light_death_mountain_right_bottom, function() 
    return all(
        has("hammer"), 
        has("glove"),
        inverted()
    )
end)

teleporter_at_dark_death_mountain_right_bottom:connect_one_way(teleporter_at_light_death_mountain_left_bottom, function() 
    return all(
        has("glove"),
        inverted()
    ) 
end)

teleporter_at_pod:connect_one_way(teleporter_at_eastern, function() 
    return all(
        has("gloves"), 
        has("hammer"),
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
        has("gloves"), 
        has("hammer")
    )
end)

teleporter_at_ice_palace:connect_one_way(teleporter_at_upgrade_fairy, function() 
    return all(
        has("titans"),
        inverted()
    )
end)



darkworld_spawns:connect_one_way(dark_spawn_links_house)
darkworld_spawns:connect_one_way(dark_spawn_dark_chapel_area)
darkworld_spawns:connect_one_way(dark_spawn_old_man, function() return can_reach(light_death_mountain_ascend) end) --has rescued old man

dark_spawn_links_house:connect_two_ways_entrance("Link's House", links_house, function() return inverted() end)
dark_spawn_links_house:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop, function() return openOrStandard() end)
dark_spawn_dark_chapel_area:connect_one_way(dark_chapel)
dark_spawn_old_man:connect_one_way(dark_old_man_cave)

-- big_bomb_shop_area
big_bomb_shop_area:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop)
big_bomb_shop_area:connect_one_way(swamp_area)
big_bomb_shop_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
big_bomb_shop_area:connect_one_way(dark_lake_hylia)
big_bomb_shop_area:connect_one_way(south_of_village_of_the_outcast)
-- big_bomb_shop_area:connect_one_way(pod_area, function()
--     return has("hammer")
-- end)


big_bomb_shop_area:connect_two_ways_entrance("Big Bomb Shop Fairy Cave", big_bomb_shop_fairy_cave, function() return has("boots") end)

big_bomb_shop_area:connect_one_way(cave45_ledge, function() return has("mirror") end)



-- swamp_area
swamp_area:connect_one_way(teleporter_at_swamp, function() return inverted() end)
teleporter_at_swamp:connect_one_way(swamp_area, function() return has("pearl") end)

swamp_area:connect_one_way(big_bomb_shop_area)
swamp_area:connect_one_way(dark_lake_hylia)
swamp_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- swamp_area:connect_one_way(desert_area, function() return(all(has("mirror"), canActivateTablets())) end)
swamp_area:connect_two_ways(bombos_tablet, function() 
    return any(
        all(
            has("mirror"),
            openOrStandard()
        ),
        inverted(),
        all(
            checkGlitches(2), 
            has("boots")
        )
    ) 
end)

swamp_area:connect_two_ways_entrance("Hype Cave", hype_cave, function() return has("bombs") end)
swamp_area:connect_two_ways_entrance("Swamp Palace", swamp_palace, function() return can_reach(dam_inside) end)

hype_cave:connect_one_way("Hype Cave_Generous Guy")
hype_cave:connect_two_ways(hype_cave_back, function() return has("bombs") end)

hype_cave_back:connect_one_way("Hype Cave_Top")
hype_cave_back:connect_one_way("Hype Cave_Middle Left")
hype_cave_back:connect_one_way("Hype Cave_Middle Right")
hype_cave_back:connect_one_way("Hype Cave_Bottom")






-- mire_area
-- mire_area:connect_one_way()
mire_ledge:connect_one_way(mire_area)
mire_ledge:connect_one_way(teleporter_at_mire, function() return inverted() end)
teleporter_at_mire:connect_one_way(mire_ledge)
mire_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)

mire_area:connect_two_ways_entrance("Misery Mire", mm_entrance,function() 
    return all(
        any(
            has("mm_medallion"), 
            has("medallion", 3, 3)
        ),
        canUseMedallions()
    )
end)
mire_area:connect_two_ways_entrance("Mire Shed Left", mire_shed_left)
mire_area:connect_two_ways_entrance("Mire Shed Right", mire_shed_right)
mire_area:connect_two_ways_entrance("Dark Desert Hint", dark_desert_hint_cave)

mire_shed_left:connect_one_way("Mire Shed_Left")
mire_shed_left:connect_one_way("Mire Shed_Right")


mire_area:connect_one_way(desert_ledge, function() 
    return has("mirror") 
end)
mire_area:connect_one_way(desert_ledge, function() 
    return has("mirror") 
end)
-- mire_area:connect_one_way(teleper, function() return has("mirror") end)





-- dark_lake_hylia
dark_lake_hylia:connect_one_way(big_bomb_shop_area)
dark_lake_hylia:connect_one_way(ice_palace)
dark_lake_hylia:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_lake_hylia:connect_one_way(dark_icerod_area, function()
    return has("flippers")
end)
dark_lake_hylia:connect_one_way(pod_area, function()
    return any(
        has("hammer"),
        has("flippers")
    )
end)
dark_lake_hylia:connect_one_way(lake_hylia_island, function() 
    return all(
        has("mirror"),
        canSwim()
) end)

dark_lake_shop:connect_one_way("Dark Lake Shop Left")
dark_lake_shop:connect_one_way("Dark Lake Shop Center")
dark_lake_shop:connect_one_way("Dark Lake Shop Right")

dark_lake_hylia:connect_two_ways_entrance("Dark Lake Shop", dark_lake_shop)
dark_lake_hylia:connect_one_way(lake_hylia_island, function() 
    return all(
        has("flippers"),
        openOrStandard(),
        has("mirror")
    ) 
end)
dark_lake_hylia:connect_two_ways(ice_palace_island, function() 
    return all(
        canSwim(), 
        inverted()
    ) 
end)
ice_palace_island:connect_one_way(teleporter_at_ice_palace, function() return inverted() end)
teleporter_at_ice_palace:connect_one_way(ice_palace_island)
ice_palace_island:connect_two_ways_entrance("Ice Palace", ice_palace)




-- dark_icerod_area
dark_icerod_area:connect_one_way(dark_lake_hylia, function()
    return has("flippers")
end)
dark_icerod_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)

dark_icerod_area:connect_two_ways_entrance("Dark Icerod Cave", dark_icerod_cave)
dark_icerod_area:connect_two_ways_entrance("Dark Icerod Fairy", dark_icerod_fairy, function() return has("bombs") end)
dark_icerod_area:connect_two_ways_entrance("Dark Icerod Stone", dark_icerod_stone, function() return has("glove") end)









-- village_of_the_outcast
village_of_the_outcast:connect_one_way(teleporter_at_village_of_the_outcast, function() return inverted() end)
teleporter_at_village_of_the_outcast:connect_one_way(village_of_the_outcast, function() return has("pearl") end)

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
        can_reach(inverted_activate_flute)
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
village_of_the_outcast:connect_two_ways_entrance("Dark Village Shop", dark_village_shop, function() return has("hammer") end)
village_of_the_outcast:connect_two_ways_entrance("Brewery", brewery, function() return has("bombs") end)

chest_game:connect_one_way("Chest Game Item")

c_shaped_house:connect_one_way("C-Shaped House")

dark_village_shop:connect_one_way("Village of Outcasts Shop Left")
dark_village_shop:connect_one_way("Village of Outcasts Shop Center")
dark_village_shop:connect_one_way("Village of Outcasts Shop Right")

brewery:connect_one_way("Brewery Chest")


village_of_the_outcast:connect_two_ways(purple_chest_pickup, function() return has("titans") end)
purple_chest_pickup:connect_two_ways_entrance("Peg Cave", peg_cave_inside, function() return has("hammer") end)

peg_cave_inside:connect_one_way("Peg-Cave Item")

-- south_of_village_of_the_outcast
south_of_village_of_the_outcast:connect_one_way(village_of_the_outcast, function()
    return has("titans")
end)
south_of_village_of_the_outcast:connect_one_way(big_bomb_shop_area)
south_of_village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
south_of_village_of_the_outcast:connect_two_ways_entrance("Dark Archery", dark_archery_minigame)
south_of_village_of_the_outcast:connect_one_way("Digging Game")

-- south_of_village_of_the_outcast:connect_one_way(mire_area) -- glitches

big_bomb_shop_area:connect_two_ways(stumpy)
big_bomb_shop_area:connect_two_ways(cave45, function() return all(openOrStandard()) end)
stumpy:connect_one_way("Stumpy")







-- skull_woods_area
skull_woods_area:connect_one_way(village_of_the_outcast)
skull_woods_area:connect_one_way(dark_lumpberjacks)

skull_woods_area:connect_one_way_entrance("Skull Woods Back North Drop", skull_woods_north_drop, function() return can_reach(skull_woods_west_lobby_entrance) end)
skull_woods_area:connect_one_way_entrance("Skull Woods Pinball Drop", skull_woods_pinball_drop)
skull_woods_area:connect_one_way_entrance("Skull Woods Pot Circle Drop", skull_woods_pot_circle_drop)
skull_woods_area:connect_one_way_entrance("Skull Woods Bottom Left Drop", sw_bottom_left_drop)
skull_woods_area:connect_two_ways_entrance("Skull Woods Front", skull_woods_big_chest_entrance)
skull_woods_area:connect_two_ways_entrance("Skull Woods Back", skull_woods_back_entrance, function() 
    return all(
        can_reach(skull_woods_west_lobby_entrance),
        has("firerod")
    )
end)
skull_woods_area:connect_two_ways_entrance("Skull Woods West Lobby", skull_woods_west_lobby_entrance)
skull_woods_area:connect_two_ways_entrance("Skull Woods Gibdo Lobby", skull_woods_gibdo_entrance)




-- dark_lumpberjacks
dark_lumpberjacks:connect_one_way(skull_woods_area)
dark_lumpberjacks:connect_one_way(dark_chapel_area)
dark_lumpberjacks:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
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
dark_lumpberjacks:connect_two_ways_entrance("Bumper Cave", bumper_cave, function() return has("glove") end)





-- dark_chapel_area
dark_chapel_area:connect_one_way(dark_lumpberjacks)
dark_chapel_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_chapel_area:connect_one_way(dark_potion_shop, function()
    return has("flippers")
end)

dark_chapel_area:connect_one_way(graveyard_ledge_cave, function()
    return all(
        openOrStandard(),
        has("mirror")
    )
end)
dark_chapel_area:connect_one_way(kings_tomb, function()
    return all(
        openOrStandard(),
        has("mirror")
    )
end)


dark_chapel_area:connect_two_ways_entrance("Dark Chapel", dark_chapel)



-- dark_potion_shop
dark_potion_shop:connect_one_way(dark_chapel_area, function()
    return has("hookshot")
end)
dark_potion_shop:connect_one_way(catfish_area, function()
    return has("titans")
end)
dark_potion_shop:connect_one_way(pod_area, function()
    return any(
        has("hammer"),
        has("glove")
    )
end)
dark_potion_shop:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)

dark_potion_shop:connect_two_ways_entrance("Dark Porion Shop", dark_potion_shop_inside)

dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")







-- catfish_area
catfish_area:connect_one_way(dark_potion_shop, function()
    return any(
        has("flippers"),
        has("glove")
    )
end)
catfish_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
catfish_area:connect_one_way("Catfish Item")
catfish_area:connect_one_way() --glicht to pod






-- pyramid
pyramid:connect_one_way(pod_area)
pyramid:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)

pyramid:connect_one_way("Pyramid Item")
pyramid:connect_two_ways_entrance("Fat Fairy", pyramid_fairy_cave, function() return can_reach(big_bomb_shop) end)
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Left")
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Right")






-- pod_area
pod_area:connect_one_way(teleporter_at_pod, function() return inverted() end)
teleporter_at_pod:connect_one_way(pod_area, function() return has("pearl") end)

pod_area:connect_one_way(pyramid)
pod_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
pod_area:connect_one_way(dark_potion_shop,function()
    return any(
        has("hammer"),
        has("glove")
    )
end)

pod_area:connect_two_ways_entrance("Kiki Cave", kiki_cave)
pod_area:connect_two_ways_entrance("Palace of Darkness", palace_of_darkness)
pod_area:connect_two_ways_entrance("Dark PoD Fairy", pod_fairy_cave)
pod_area:connect_two_ways_entrance("PoD Teleporter Cave", pod_teleport_cave)

pod_area:connect_two_ways_entrance("Palace of Darkness Entrance", pod_entrance)






-- ice_palace
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()








-- dark_death_mountain_left_top
dark_death_mountain_left_top:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_left_top:connect_one_way()
dark_death_mountain_left_top:connect_one_way(light_death_mountain_left, function() 
    return all(
        openOrStandard(),
        has("mirror")
    ) 
end)
dark_death_mountain_left_top:connect_two_ways_entrance("Ganons Tower", gt_entrance, function() return gt_access() end)





-- dark_death_mountain_right_top
dark_death_mountain_right_top:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_right_top:connect_one_way()
dark_death_mountain_right_top:connect_one_way(teleporter_at_dark_turtle_rock, function() return inverted() end)
teleporter_at_dark_turtle_rock:connect_one_way(dark_death_mountain_right_top)
teleporter_at_dark_turtle_rock:connect_two_ways_entrance("Trutle Rock Main Entrance", tr_main_entrance, function() 
    return all(
        any(
            has("tr_medallion"),
            has("medallion", 3, 3)
        ),
        canUseMedallions()
    ) 
end)
dark_death_mountain_right_top:connect_two_ways_entrance("Hookshot Cave", hookshot_cave, function() return has("glove") end)
hookshot_cave:connect_two_ways(floating_island, function() 
    return all(
        has("bombs"),
        has("mirror")
    ) 
end)
tr_eye_bridge_entrance:connect_two_ways_entrance(light_eyebridge_fairy, function() 
    return all(
        openOrStandard(), 
        has("mirror")
    ) 
end)
dark_death_mountain_right_top:connect_one_way(tr_eye_bridge_entrance, function() return inverted() end)


-- dark_death_mountain_left_bottom
dark_death_mountain_left_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_left_bottom:connect_one_way()
dark_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom, function() return inverted() end)
teleporter_at_dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom, function() return has("pearl") end)
dark_death_mountain_left_bottom:connect_two_ways_entrance("Spike Cave", spike_cave)
dark_death_mountain_left_bottom:connect_one_way()
spike_cave:connect_one_way("Spike Cave Chest", function() 
    return all(
        has("hammer"),
        has("glove") --,
        -- has("heartpieces", )
    )
end)

dark_death_mountain_left_bottom:connect_two_ways_entrance(dark_death_mountain_descent, function() return darkRooms() end)



-- dark_death_mountain_right_bottom
dark_death_mountain_right_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_right_bottom:connect_one_way()
dark_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom, function() return inverted() end)
teleporter_at_dark_death_mountain_right_bottom:connect_one_way(dark_death_mountain_right_bottom)

turtle_rock_ledge:connect_two_ways_entrance("Turtle Rock Big Chest Entrance", tr_big_chest_entrance)
turtle_rock_ledge:connect_two_ways_entrance("Turtle Rock Laser Entrance", tr_laser_entrance)
-- tr_laser_entrance:connect_two_ways_entrance("Light Death Mountain Fairy", light_death_mountain_cave1, function() return has("mirror") end)
tr_big_chest_entrance:connect_two_ways_entrance("Mimic Cave Teleport", mimic_cave, function() return has("mirror") end)



dark_death_mountain_right_bottom:connect_two_ways_entrance("Super Bunny Cave Bottom Entrance", superbunny_cave_bottom)
dark_death_mountain_right_top:connect_two_ways_entrance("Super Bunny Cave Top Entrance", superbunny_cave_top)

superbunny_cave_bottom:connect_one_way(superbunny_cave_top)
superbunny_cave_top:connect_one_way("Super Bunny Cave Chest Top")
superbunny_cave_top:connect_one_way("Super Bunny Cave Chest Bottom")

