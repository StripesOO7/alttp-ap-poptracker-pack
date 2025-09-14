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
dark_flute_map:connect_one_way(dark_potion_shop_area)
dark_flute_map:connect_one_way(village_of_the_outcast)
dark_flute_map:connect_one_way(big_bomb_shop_area)
dark_flute_map:connect_one_way(pod_area)
dark_flute_map:connect_one_way(mire_area)
dark_flute_map:connect_one_way(swamp_area)
dark_flute_map:connect_one_way(dark_icerod_area)


teleporter_at_village_of_the_outcast:connect_one_way(teleporter_at_kakariko_village, function() 
    return all(
        "glove",
        inverted()
    )
end)


teleporter_at_dark_turtle_rock:connect_one_way(teleporter_at_light_turtle_rock, function() return all(inverted(), "titans") end)

teleporter_at_dark_death_mountain_left_bottom:connect_one_way(teleporter_at_light_death_mountain_left_bottom, function() return inverted() end)

teleporter_at_dark_death_mountain_right_bottom:connect_one_way(teleporter_at_light_death_mountain_right_bottom, function() return inverted() end)

teleporter_at_pod:connect_one_way(teleporter_at_eastern, function() 
    return all(
        "glove",
        inverted()
    )
end)

teleporter_at_mire:connect_one_way(teleporter_at_desert, function() 
    return all(
        "titans",
        inverted()
    )
end)

teleporter_at_swamp:connect_one_way(teleporter_at_dam, function()
    return all(
        "glove", 
        inverted()
    )
end)

teleporter_at_ice_palace:connect_one_way(teleporter_at_upgrade_fairy, function() return inverted() end)



darkworld_spawns:connect_one_way(dark_spawn_links_house)
darkworld_spawns:connect_one_way(dark_spawn_dark_chapel)
darkworld_spawns:connect_one_way(dark_spawn_old_man, function() return CanReach(old_man_cave_right_inside) end) --has rescued old man

dark_spawn_links_house:connect_one_way(links_house_inside, function() return inverted() end)
-- dark_spawn_links_house:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop, function() return openOrStandard() end)
dark_spawn_dark_chapel:connect_one_way(dark_chapel_inside, function() return inverted() end)
dark_spawn_old_man:connect_one_way(old_man_home_bottom_inside, function() return inverted() end)

-- big_bomb_shop_area
-- links_house_outside:connect_two_ways(big_bomb_shop_area, function() return inverted() end) --probably dupes
big_bomb_shop_area:connect_two_ways(big_bomb_shop_outside)--, function() return openOrStandard() end) --probably dupes
big_bomb_shop_area:connect_one_way(swamp_area)
big_bomb_shop_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
big_bomb_shop_area:connect_one_way(dark_lake_hylia)
big_bomb_shop_area:connect_one_way(south_of_village_of_the_outcast)
-- big_bomb_shop_area:connect_one_way(pod_area, function()
--     return "hammer"
-- end)

-- links_house_outside:connect_two_ways_entrance("Inverted Spawn", links_house_inside)
big_bomb_shop_outside:connect_two_ways_entrance("Big Bomb Shop", big_bomb_shop_inside, function() return openOrStandard() end)
big_bomb_shop_outside:connect_two_ways_entrance("Big Bomb Shop", links_house_inside, function() return inverted() end)

big_bomb_shop_area:connect_two_ways(big_bomb_shop_fairy_cave_outside, function() return all("boots", can_interact(big_bomb_shop_area.worldstate, 1)) end)
big_bomb_shop_fairy_cave_outside:connect_two_ways_entrance("Big Bomb Shop Fairy Cave", big_bomb_shop_fairy_cave_inside)

big_bomb_shop_area:connect_one_way(cave45_ledge, function() 
    return all(
        canChangeWorldWithMirror(),
        openOrStandard()
    )
end)

big_bomb_shop_inside:connect_one_way("Buy Big Bomb", function() return all(has("crystal56",2, 2, 2, 2), can_interact(big_bomb_shop_inside.worldstate, 1)) end)

-- swamp_area
swamp_area:connect_one_way(teleporter_at_swamp, function() 
    return all(
        inverted(),
        "hammer",
        can_interact(swamp_area.worldstate, 1)
    )
end)
teleporter_at_swamp:connect_one_way(swamp_area, function()
    return all(
        "pearl",
        "hammer",
        can_interact(teleporter_at_swamp.worldstate, 1)
    ) 
end)

swamp_area:connect_one_way(big_bomb_shop_area)
swamp_area:connect_one_way(dark_lake_hylia)
swamp_area:connect_one_way(dark_flute_map, function()
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- swamp_area:connect_one_way(desert_area, function() return(all("mirror", canActivateTablets())) end)
swamp_area:connect_two_ways(bombos_tablet_ledge, function() 
    return any(
        all(
            canChangeWorldWithMirror(),
            openOrStandard()
        ),
        all(
            checkGlitches(2),
            "boots",
            canChangeWorldWithMirror()
        )
    ) 
end)

swamp_area:connect_two_ways(hype_cave_outside, function() 
    return all(
        "bombs",
        can_interact(swamp_area.worldstate, 1)
    )
end)
swamp_area:connect_two_ways(sp_entrance_outside)

hype_cave_outside:connect_two_ways_entrance("Hype Cave", hype_cave_inside)
sp_entrance_outside:connect_two_ways_entrance("Swamp Palace", sp_entrance_inside)

hype_cave_inside:connect_one_way("Hype Cave_Generous Guy")
hype_cave_inside:connect_two_ways(hype_cave_back, function() return all("bombs", can_interact(hype_cave_inside.worldstate, 1)) end)

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
        "titans"
    ) 
end)
teleporter_at_mire:connect_one_way(mire_ledge)

mire_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

mire_area:connect_two_ways(mm_entrance_outside, function() 
    return all(
        any(
            "mm_medallion", 
            has("medallion", 3, 3, 3, 3)
        ),
        canUseMedallions(),
        can_interact(mire_area.worldstate, 1)
    )
end)
mire_area:connect_two_ways(mire_shed_outside)
mire_area:connect_two_ways(dark_desert_hint_outside)
mire_area:connect_two_ways(dark_desert_fairy_cave_outside)

mm_entrance_outside:connect_two_ways_entrance("Misery Mire", mm_entrance_inside)
mire_shed_outside:connect_two_ways_entrance("Mire Shed Left", mire_shed_inside)
dark_desert_hint_outside:connect_two_ways_entrance("Dark Desert Hint", dark_desert_hint_inside)
dark_desert_fairy_cave_outside:connect_two_ways_entrance("Dark Desert Fairy", dark_desert_fairy_cave_inside)

mire_shed_inside:connect_one_way("Mire Shed Left", function() return can_interact(mire_shed_inside.worldstate, 1) end)
mire_shed_inside:connect_one_way("Mire Shed Right", function() return can_interact(mire_shed_inside.worldstate, 1) end)


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
-- mire_area:connect_one_way(teleper, function() return "mirror" end)





-- dark_lake_hylia
-- dark_lake_hylia:connect_one_way(big_bomb_shop_area)
-- dark_lake_hylia:connect_one_way(ice_palace, function()
--     return all(
--         "flippers",
--         can_interact("dark",1)
--     )
-- end)
dark_lake_hylia:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
dark_lake_hylia:connect_one_way(dark_icerod_area, function()
    return all(
        "flippers",
        can_interact(dark_lake_hylia.worldstate, 1)
    )
end)
dark_lake_hylia:connect_one_way(pod_area, function()
    return all(
        any(
            "hammer",
            "flippers"
        ),
        can_interact(dark_lake_hylia.worldstate, 1)
    )
end)
dark_lake_hylia:connect_one_way(lake_hylia_island, function()
    return all(
        canChangeWorldWithMirror(),
        canSwim("flippers"),
        openOrStandard(),
        can_interact(dark_lake_hylia.worldstate, 1)
    )
end)
dark_lake_hylia:connect_two_ways(dark_lake_shop_outside)


dark_lake_shop_inside:connect_one_way("Dark Lake Shop Left")
dark_lake_shop_inside:connect_one_way("Dark Lake Shop Center")
dark_lake_shop_inside:connect_one_way("Dark Lake Shop Right")

dark_lake_shop_outside:connect_two_ways_entrance("Dark Lake Shop", dark_lake_shop_inside)
dark_lake_hylia:connect_one_way(lake_hylia_island, function()
    return all(
        "flippers",
        openOrStandard(),
        canChangeWorldWithMirror(),
        can_interact(dark_lake_hylia.worldstate, 1)
    ) 
end)
dark_lake_hylia:connect_two_ways(ice_palace_island, function() 
    return all(
        canSwim(), 
        inverted(),
        can_interact(dark_lake_hylia.worldstate, 1)
    ) 
end)

ice_palace_island:connect_one_way(teleporter_at_ice_palace, function() 
    return all(
        inverted(),
        "titans"
    ) 
end)
teleporter_at_ice_palace:connect_one_way(ice_palace_island)

ice_palace_island:connect_two_ways(ip_entrance_outside)
ip_entrance_outside:connect_two_ways_entrance("Ice Palace", ip_entrance_inside)




-- dark_icerod_area
dark_icerod_area:connect_one_way(ice_palace_island, function()
    return all(
        inverted(),
        "flippers",
        can_interact(dark_icerod_area.worldstate, 1)
    )
end)

dark_icerod_area:connect_one_way(pod_area, function()
    return all(
        "flippers",
        can_interact(dark_icerod_area.worldstate, 1)
    )
end)

dark_icerod_area:connect_one_way(lake_hylia_island, function() 
    return all(
        canChangeWorldWithMirror(),
        canSwim(),
        openOrStandard(),
        can_interact(dark_icerod_area.worldstate, 1)
    )
end)

dark_icerod_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

dark_icerod_area:connect_two_ways(dark_lake_hylia_ledge_fairy_outside, function() return all("bombs", can_interact(dark_icerod_area.worldstate, 1)) end)
dark_icerod_area:connect_two_ways(dark_lake_hylia_ledge_hint_outside)
dark_icerod_area:connect_two_ways(dark_lake_hylia_ledge_spike_hint_outside, function() return all("glove", can_interact(dark_icerod_area.worldstate, 1)) end)


dark_lake_hylia_ledge_fairy_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Fairy", dark_lake_hylia_ledge_fairy_inside)
dark_lake_hylia_ledge_hint_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Hint", dark_lake_hylia_ledge_hint_inside)
dark_lake_hylia_ledge_spike_hint_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Spike Hint", dark_lake_hylia_ledge_spike_hint_inside)






-- village_of_the_outcast
village_of_the_outcast:connect_one_way(teleporter_at_village_of_the_outcast, function() 
    return all(
        inverted(),
        any(
            "hammer", 
            "titans"
        )
    ) 
end)
teleporter_at_village_of_the_outcast:connect_one_way(village_of_the_outcast, function() 
    return all(
        "pearl", 
        any(
            "hammer", 
            "titans"
        )
    ) 
end)

village_of_the_outcast:connect_two_ways(inverted_activate_flute, function() 
    return all(
        "flute",
        inverted()
    ) 
end)
village_of_the_outcast:connect_one_way(skull_woods_area)
village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
village_of_the_outcast:connect_one_way(south_of_village_of_the_outcast)
village_of_the_outcast:connect_two_ways(inverted_activate_flute, function() 
    return all(
        "flute",
        inverted()
    )
end)

village_of_the_outcast:connect_two_ways(c_shaped_house_outside)
village_of_the_outcast:connect_two_ways(chest_game_outside)
village_of_the_outcast:connect_two_ways(tt_entrance_outside)
village_of_the_outcast:connect_two_ways(dark_village_shop_outside, function() return all("hammer", can_interact(village_of_the_outcast.worldstate, 1)) end)
village_of_the_outcast:connect_two_ways(brewery_outside, function() return all("bombs", can_interact(village_of_the_outcast.worldstate, 1)) end)
village_of_the_outcast:connect_two_ways(dark_village_fortune_teller_outside)

c_shaped_house_outside:connect_two_ways_entrance("C-Shaped House", c_shaped_house_inside)
chest_game_outside:connect_two_ways_entrance("Chest Game Entrance", chest_game_inside)
tt_entrance_outside:connect_two_ways_entrance("Thieves Town Entrance", tt_entrance_inside)
dark_village_shop_outside:connect_two_ways_entrance("Dark Village Shop", dark_village_shop_inside)
brewery_outside:connect_two_ways_entrance("Brewery", brewery_inside)
dark_village_fortune_teller_outside:connect_two_ways_entrance("Dark Village Fortune Teller", dark_village_fortune_teller_inside)

chest_game_inside:connect_one_way("Chest Game Item", function() return can_interact(chest_game_inside.worldstate, 1) end)

c_shaped_house_inside:connect_one_way("C-Shaped House", function() return can_interact(c_shaped_house_inside.worldstate, 1) end)

dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Left")
dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Center")
dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Right")

brewery_inside:connect_one_way("Brewery Chest", function() return can_interact(brewery_inside.worldstate, 1) end)


village_of_the_outcast:connect_two_ways(purple_chest_pickup, function() return all("titans", can_interact(village_of_the_outcast.worldstate, 1)) end)
purple_chest_pickup:connect_two_ways(peg_cave_outside, function() return all("hammer", can_interact(purple_chest_pickup.worldstate, 1)) end)
peg_cave_outside:connect_two_ways_entrance("Peg Cave", peg_cave_inside)

peg_cave_inside:connect_one_way("Peg-Cave Item")

village_of_the_outcast:connect_two_ways(helpless_frog, function() return all("titans", can_interact(village_of_the_outcast.worldstate, 1)) end)

-- south_of_village_of_the_outcast
south_of_village_of_the_outcast:connect_one_way(village_of_the_outcast, function()
    return all(
        "titans",
        can_interact(south_of_village_of_the_outcast.worldstate, 1)
    )
end)
south_of_village_of_the_outcast:connect_one_way(big_bomb_shop_area)
south_of_village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
south_of_village_of_the_outcast:connect_two_ways(dark_archery_minigame_outside)
dark_archery_minigame_outside:connect_two_ways_entrance("Dark Archery", dark_archery_minigame_inside)
south_of_village_of_the_outcast:connect_one_way("Digging Game", function() return can_interact(south_of_village_of_the_outcast.worldstate, 1) end)
south_of_village_of_the_outcast:connect_one_way(race_ledge, function() 
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    )
end)

-- south_of_village_of_the_outcast:connect_one_way(mire_area) -- glitches

big_bomb_shop_area:connect_two_ways(stumpy, function() return can_interact("dark", 1) end)
big_bomb_shop_area:connect_two_ways(cave45_ledge, function() 
    return all(
        openOrStandard(), 
        canChangeWorldWithMirror()
    ) 
end)
stumpy:connect_one_way("Stumpy")







-- skull_woods_area
skull_woods_area:connect_one_way(village_of_the_outcast)
skull_woods_area:connect_one_way(dark_lumpberjacks)

skull_woods_area:connect_two_ways(sw_pinball_drop_outside)
skull_woods_area:connect_two_ways(sw_pot_circle_drop_outside, function() return can_interact(skull_woods_area.worldstate, 1) end)
skull_woods_area:connect_two_ways(sw_bottom_left_drop_outside)

skull_woods_area:connect_two_ways(sw_big_chest_entrance_outside)
skull_woods_area:connect_two_ways(sw_west_lobby_entrance_outside)
skull_woods_area:connect_two_ways(sw_gibdo_entrance_outside)

skull_woods_area:connect_two_ways(sw_north_drop_outside, function() return CanReach(sw_west_lobby_entrance_outside) end)
skull_woods_area:connect_two_ways(sw_back_entrance_outside, function() 
    return all(
        CanReach(sw_west_lobby_entrance_outside),
        "firerod",
        can_interact(skull_woods_area.worldstate, 1)
    )
end)

sw_pinball_drop_outside:connect_one_way_entrance("Skull Woods Pinball Drop", sw_pinball_drop_inside)
sw_pot_circle_drop_outside:connect_one_way_entrance("Skull Woods Pot Circle Drop", sw_pot_circle_drop_inside)
sw_bottom_left_drop_outside:connect_one_way_entrance("Skull Woods Bottom Left Drop", sw_bottom_left_drop_inside)

sw_big_chest_entrance_outside:connect_two_ways_entrance("Skull Woods Front", sw_big_chest_entrance_inside)
sw_west_lobby_entrance_outside:connect_two_ways_entrance("Skull Woods West Lobby", sw_west_lobby_entrance_inside)
sw_gibdo_entrance_outside:connect_two_ways_entrance("Skull Woods Gibdo Lobby", sw_gibdo_entrance_inside)

sw_north_drop_outside:connect_one_way_entrance("Skull Woods Back North Drop", sw_north_drop_inside)
sw_back_entrance_outside:connect_two_ways_entrance("Skull Woods Back", sw_back_entrance_inside)


-- dark_lumpberjacks
dark_lumpberjacks:connect_one_way(skull_woods_area)
dark_lumpberjacks:connect_one_way(dark_chapel_area)
dark_lumpberjacks:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
dark_lumpberjacks:connect_two_ways(dark_lumpberjacks_shop_outside)
dark_lumpberjacks:connect_two_ways(red_shield_shop_outside)
dark_lumpberjacks:connect_one_way("Bumper Cave Item", function() return AccessibilityLevel.Inspect end)

dark_lumpberjacks:connect_two_ways(dark_bumper_cave_bottom_ledge, function() 
    return all(
        "glove", 
        can_interact(dark_lumpberjacks.worldstate, 1)
    )
end)


dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Left")
dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Center")
dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Right")

red_shield_shop_inside:connect_one_way("Red Shield Shop Left")
red_shield_shop_inside:connect_one_way("Red Shield Shop Center")
red_shield_shop_inside:connect_one_way("Red Shield Shop Right")


dark_lumpberjacks_shop_outside:connect_two_ways_entrance("Dark Lumberjacks Shop", dark_lumpberjacks_shop_inside)
red_shield_shop_outside:connect_two_ways_entrance("Red Shield Shop", red_shield_shop_inside)


-- dark_bumper_cave_outside:connect_two_ways_entrance("Bumper Cave", dark_bumper_cave_inside, function() return all(openOrStandard(), "glove", can_interact("dark",1 )) end)


dark_bumper_cave_bottom_ledge:connect_one_way(dark_lumpberjacks)
dark_bumper_cave_bottom_ledge:connect_two_ways(dark_bumper_cave_bottom_outside)

-- dark_bumper_cave_bottom_ledge:connect_one_way(dark_death_mountain_ascent, function() return darkRooms() end)
dark_bumper_cave_bottom_outside:connect_two_ways_entrance("Bumper Cave Bottom", dark_bumper_cave_bottom_inside, function() return openOrStandard() end)
dark_bumper_cave_bottom_outside:connect_two_ways_entrance("Old Man Cave Left", old_man_cave_left_inside, function() return inverted() end)

dark_bumper_cave_bottom_inside:connect_two_ways(bumpercave_top_back)
bumpercave_top_back:connect_two_ways(bumpercave_top_front, function() 
    return all(
        "cape", 
        can_interact(bumpercave_top_back.worldstate, 1)
    )
end)
bumpercave_top_front:connect_two_ways(dark_bumper_cave_top_inside)

dark_bumper_cave_top_outside:connect_two_ways_entrance("Bumper Cave Top", dark_bumper_cave_top_inside, function() return openOrStandard() end)
dark_bumper_cave_top_outside:connect_two_ways_entrance("Dark Death Mountain Fairy Inside", dark_death_mountain_fairy_inside, function() return inverted() end)

dark_bumper_cave_top_ledge:connect_two_ways(dark_bumper_cave_top_outside)
-- dark_bumper_cave_top_ledge:connect_two_ways(dark_death_mountain_fairy_outside, function() return inverted() end)


dark_bumper_cave_top_ledge:connect_one_way(dark_lumpberjacks)
dark_bumper_cave_top_ledge:connect_one_way("Bumper Cave Item")

-- dark_death_mountain_ascent:connect_two_ways_entrance("Upper Dark Death Mountain Ascent", dark_death_mountain_left_bottom, function() return darkRooms() end)

-- dark_bumper_cave_outside:connect_one_way_entrance("Normal Bumpercave", dark_bumper_cave_ledge,function() return all(openOrStandard(), "cape", can_interact("dark",1 )) end)
-- dark_bumper_cave_ledge:connect_one_way_entrance("Reverse Bumpercave", dark_bumper_cave_outside, function() 
--     return all(
--         any(
--             "hookshot", 
--             "cape"
--         ),
--         can_interact("dark",1 )
--     )
-- end)
-- dark_bumper_cave_ledge:connect_one_way("Bumper Cave Item", function() 
--     return any(
--         dark_bumper_cave_ledge:accessibility(),
--         AccessibilityLevel.Inspect
--     ) 
-- end)
-- dark_bumper_cave_ledge:connect_one_way(light_bumper_cave_ledge, function() 
--     return all(
--         canChangeWorldWithMirror(), 
--         openOrStandard()
--     )
-- end)
-- dark_bumper_cave_ledge:connect_one_way(dark_lumpberjacks)


-- dark_chapel_area
dark_chapel_area:connect_one_way(dark_lumpberjacks)
dark_chapel_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
dark_chapel_area:connect_one_way(dark_potion_shop_area, function()
    return all(
        "flippers",
        can_interact(dark_chapel_area.worldstate, 1)
    )
end)

dark_chapel_area:connect_one_way(graveyard_ledge, function()
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    )
end)
dark_chapel_area:connect_one_way(kings_tomb_outside, function()
    return all(
        openOrStandard(),
        canChangeWorldWithMirror(),
        "pearl"
    )
end)


dark_chapel_area:connect_two_ways(dark_chapel_outside)
dark_chapel_outside:connect_two_ways_entrance("Dark Chapel", dark_chapel_inside)



-- dark_potion_shop
dark_potion_shop_area:connect_one_way(dark_chapel_area, function()
    return all(
        "hookshot",
        can_interact(dark_potion_shop_area.worldstate, 1)
    )
end)
dark_potion_shop_area:connect_one_way(catfish_area, function()
    return all(
        "glove",
        can_interact(dark_potion_shop_area.worldstate, 1)
    )
end)
dark_potion_shop_area:connect_one_way(pod_area, function()
    return all(
        any(
            "hammer",
            "glove"
        ),
        can_interact(dark_potion_shop_area.worldstate, 1)
    )
end)
dark_potion_shop_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

dark_potion_shop_area:connect_two_ways(dark_potion_shop_outside)
dark_potion_shop_outside:connect_two_ways_entrance("Dark Potion Shop", dark_potion_shop_inside)

dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")







-- catfish_area
catfish_area:connect_one_way(dark_potion_shop_area, function()
    return all(
        any(
            "flippers",
            "glove"
        ),
        can_interact(catfish_area.worldstate, 1)
    )
end)
catfish_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
catfish_area:connect_one_way("Catfish Item", function() return can_interact(catfish_area.worldstate, 1) end)
-- catfish_area:connect_one_way() --glicht to pod






-- pyramid
pyramid:connect_one_way(pod_area)
pyramid:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)

pyramid:connect_one_way("Pyramid Item")
pyramid:connect_two_ways(pyramid_fairy_cave_outside, function() 
    return all(
        has("crystal56", 2, 2, 2, 2), 
        big_bomb_shop_inside:accessibility(),
        can_interact(pyramid.worldstate, 1),
        any(
            all(
                "mirror",
                inverted()
            ),
            openOrStandard()
        )
    )
end)

pyramid:connect_two_ways(pyramid_hole_outside)
pyramid_exit_outside:connect_two_ways(pyramid_exit_ledge)

pyramid_exit_ledge:connect_one_way(pyramid)

pyramid_hole_outside:connect_one_way(pyramid_hole_inside)
pyramid_exit_outside:connect_two_ways(pyramid_exit_inside)

pyramid_hole_inside:connect_one_way(pyramid_exit_inside)

pyramid_fairy_cave_outside:connect_one_way_entrance("Fat Fairy", pyramid_fairy_cave_inside)

pyramid_fairy_cave_inside:connect_one_way("Pyramid Fairy Left", function() return can_interact(pyramid_fairy_cave_inside.worldstate, 1) end)
pyramid_fairy_cave_inside:connect_one_way("Pyramid Fairy Right", function() return can_interact(pyramid_fairy_cave_inside.worldstate, 1) end)

pyramid:connect_one_way(hyrule_castle_top, function() 
    return all(
        openOrStandard(),
        canChangeWorldWithMirror()
    )
end)




-- pod_area
pod_area:connect_one_way(teleporter_at_pod, function() 
    return all(
        inverted(), 
        "hammer"
    ) 
end)
teleporter_at_pod:connect_one_way(pod_area, function() 
    return all(
        "pearl", 
        "hammer"
    ) 
end)

pod_area:connect_one_way(pyramid)
pod_area:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
pod_area:connect_one_way(dark_potion_shop_area,function()
    return all(
        any(
            "hammer",
            "glove",
            "flippers"
        ),
        can_interact(pod_area.worldstate, 5)
    )
end)

pod_area:connect_one_way(ice_palace_island, function()
    return all(
        "flippers",
        can_interact(pod_area.worldstate, 5),
        inverted()
    )
end)
pod_area:connect_one_way(dark_icerod_area, function()
    return all(
        "flippers",
        can_interact(pod_area.worldstate, 5)
    )
end)

pod_area:connect_one_way(big_bomb_shop_area, function()
    return all(
        "hammer",
        can_interact(pod_area.worldstate, 5)
    )
end)

pod_area:connect_two_ways(pod_hint_house_outside)
pod_area:connect_two_ways(pod_entrance_outside, function() return can_interact(pod_area.worldstate,1) end)
pod_area:connect_two_ways(dark_lake_hylia_fairy_outside)
pod_area:connect_two_ways(pod_east_darkworld_hint_outside)
-- pod_area:connect_two_ways(pod_entrance_outside, function() return can_interact("dark",4) end)

pod_hint_house_outside:connect_two_ways_entrance("Kiki Cave", pod_hint_house_inside)
pod_entrance_outside:connect_two_ways_entrance("Palace of Darkness", pod_entrance_inside)
dark_lake_hylia_fairy_outside:connect_two_ways_entrance("Dark PoD Fairy", dark_lake_hylia_fairy_inside)
pod_east_darkworld_hint_outside:connect_two_ways_entrance("PoD Teleporter Cave", pod_east_darkworld_hint_inside)

-- pod_entrance_outside:connect_two_ways_entrance("Palace of Darkness Entrance", pod_entrance_inside)






-- ice_palace
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()








-- dark_death_mountain_left_top
dark_death_mountain_left_top:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
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
dark_death_mountain_left_top:connect_two_ways(gt_entrance_outside, function() 
    return any(
        all(
            gtCrystalCount(), 
            openOrStandard()
        ),
        inverted()
    )
end)
-- dark_death_mountain_left_top:connect_two_ways(at_entrance_outside, function() return inverted() end)

dark_death_mountain_left_top:connect_two_ways(dark_death_mountain_right_top)

gt_entrance_outside:connect_two_ways_entrance("Ganons Tower", gt_entrance_inside, function() return openOrStandard() end)
gt_entrance_outside:connect_two_ways_entrance("Aga Tower", at_entrance_inside, function() return inverted() end)



-- dark_death_mountain_right_top
dark_death_mountain_right_top:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
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


teleporter_at_dark_turtle_rock:connect_two_ways(tr_main_entrance_outside, function() 
    return all(
        any(
            "tr_medallion",
            has("medallion", 3, 3, 3, 3)
        ),
        canUseMedallions(),
        can_interact(teleporter_at_dark_turtle_rock.worldstate, 1)
    ) 
end)
dark_death_mountain_right_top:connect_two_ways(hookshot_cave_outside, function() 
    return any(
        all(
            "glove",
            can_interact(dark_death_mountain_right_top.worldstate, 1)
        )
    )
end)

tr_main_entrance_outside:connect_two_ways_entrance("Turtle Rock Main Entrance", tr_main_entrance_inside)
hookshot_cave_outside:connect_two_ways_entrance("Hookshot Cave", hookshot_cave_inside)


hookshot_cave_inside:connect_two_ways(dark_floating_island_inside, function() 
    return all(
        "bombs",
        can_interact(hookshot_cave_inside.worldstate, 1)
    ) 
end)
dark_floating_island_inside:connect_two_ways_entrance("Dark Floating Island", dark_floating_island_outside)

dark_floating_island_outside:connect_two_ways(dark_floating_island)
dark_floating_island:connect_two_ways(floating_island, function() 
    return all(
        canChangeWorldWithMirror(),
        openOrStandard()
    ) 
end)

hookshot_cave_inside:connect_one_way("Hookshot Cave Item Bottom Right", function() 
    return all(
        any(
            "hookshot",
            "boots"
        ),
        can_interact(hookshot_cave_inside.worldstate, 5)
    )
end)
hookshot_cave_inside:connect_one_way("Hookshot Cave Item Top Right", function() 
    return all(
        "hookshot", 
        can_interact(hookshot_cave_inside.worldstate, 5)
    ) 
end)
hookshot_cave_inside:connect_one_way("Hookshot Cave Item Top Left", function() 
    return all(
        "hookshot", 
        can_interact(hookshot_cave_inside.worldstate, 5)
    ) 
end)
hookshot_cave_inside:connect_one_way("Hookshot Cave Item Bottom Left", function() 
    return all(
        "hookshot", 
        can_interact(hookshot_cave_inside.worldstate, 5)
    ) 
end)

tr_eye_bridge_entrance_outside:connect_two_ways(tr_eye_bridge_entrance_ledge)
tr_eye_bridge_entrance_ledge:connect_one_way(light_eyebridge_fairy_ledge, function() 
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
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_left_bottom:connect_one_way()
dark_death_mountain_left_bottom:connect_one_way(teleporter_at_dark_death_mountain_left_bottom, function() return inverted() end)
-- teleporter_at_dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom, function() return "pearl" end)
teleporter_at_dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_bottom)

dark_death_mountain_left_bottom:connect_two_ways(spike_cave_outside)
spike_cave_outside:connect_two_ways_entrance("Spike Cave", spike_cave_inside)


dark_death_mountain_left_bottom:connect_one_way(light_death_mountain_left_top, function() 
    return all(
        canChangeWorldWithMirror(),
        openOrStandard()
    )
end)
spike_cave_inside:connect_one_way("Spike Cave Chest", function() 
    return all(
        "hammer",
        "glove",
        can_interact(spike_cave_inside.worldstate, 5) --,
        -- has("heartpieces", )
    )
end)
dark_death_mountain_left_bottom:connect_one_way(dark_death_mountain_left_top, function() return inverted() end)

dark_death_mountain_left_bottom:connect_two_ways(dark_death_mountain_fairy_outside)

dark_death_mountain_fairy_outside:connect_two_ways_entrance("Dark Death Mountain Fairy", dark_death_mountain_fairy_inside, function() return openOrStandard() end)

dark_death_mountain_fairy_outside:connect_two_ways_entrance("Old Man Cave Right Inside", old_man_cave_right_inside, function() return inverted() end)


-- dark_death_mountain_right_bottom
dark_death_mountain_right_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        "flute",
        inverted(),
        CanReach(inverted_activate_flute)
    ) 
end)
-- dark_death_mountain_right_bottom:connect_one_way()
dark_death_mountain_right_bottom:connect_one_way(teleporter_at_dark_death_mountain_right_bottom, function() 
    return all(
        inverted(), 
        "titans"
    ) 
end)
teleporter_at_dark_death_mountain_right_bottom:connect_one_way(dark_death_mountain_right_bottom)

turtle_rock_ledge:connect_two_ways(tr_big_chest_entrance_outside)
turtle_rock_ledge:connect_two_ways(tr_laser_entrance_outside, function() 
    return all(
        "bombs", 
        can_interact(turtle_rock_ledge.worldstate, 1)
    ) 
end)
turtle_rock_ledge:connect_one_way(mimic_cave_ledge, function() 
    return all(
        canChangeWorldWithMirror(), 
        openOrStandard()
    ) 
end)

tr_big_chest_entrance_outside:connect_two_ways_entrance("Turtle Rock Big Chest Entrance", tr_big_chest_entrance_inside)
tr_laser_entrance_outside:connect_two_ways_entrance("Turtle Rock Laser Entrance", tr_laser_entrance_inside)
tr_eye_bridge_entrance_outside:connect_two_ways_entrance("Turtle Eye Bridge Entrance", tr_eye_bridge_entrance_inside)
-- tr_laser_entrance:connect_two_ways_entrance("Light Death Mountain Fairy", light_death_mountain_cave1, function() return "mirror" end)

dark_death_mountain_right_bottom:connect_two_ways(dark_death_mountain_shop_outside)
dark_death_mountain_right_bottom:connect_two_ways(superbunny_cave_bottom_outside)
dark_death_mountain_right_top:connect_two_ways(superbunny_cave_top_outside)

dark_death_mountain_shop_outside:connect_two_ways_entrance("Dark Death Mountain Shop", dark_death_mountain_shop_inside)

superbunny_cave_bottom_outside:connect_two_ways_entrance("Super Bunny Cave Bottom Entrance", superbunny_cave_bottom_inside)
superbunny_cave_top_outside:connect_two_ways_entrance("Super Bunny Cave Top Entrance", superbunny_cave_top_inside)

superbunny_cave_bottom_inside:connect_one_way(superbunny_cave_top_inside)
superbunny_cave_top_inside:connect_one_way("Super Bunny Cave Chest Top")
superbunny_cave_top_inside:connect_one_way("Super Bunny Cave Chest Bottom")

