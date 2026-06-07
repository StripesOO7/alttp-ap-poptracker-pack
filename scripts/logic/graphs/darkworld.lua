-- region names

-- Big_bomb_shop_area
-- Swamp_area
-- Mire_area
-- Dark_lake_hylia
-- Dark_icerod_area
-- Village_of_the_outcast
-- South_of_Village_of_the_outcast
-- Skull_woods_area
-- Dark_lumpberjacks
-- Dark_chapel_area
-- Dark_potion_shop
-- Catfish_area
-- pyramid
-- PoD_area
-- ice_palace
-- Dark_death_mountain_left_top
-- Dark_death_mountain_right_top
-- Dark_death_mountain_left_bottom
-- Dark_death_mountain_right_bottom

--




Dark_flute_map:connect_one_way(Dark_death_mountain_left_bottom)
Dark_flute_map:connect_one_way(Dark_potion_shop_area)
Dark_flute_map:connect_one_way(Village_of_the_outcast)
Dark_flute_map:connect_one_way(Big_bomb_shop_area)
Dark_flute_map:connect_one_way(PoD_area)
Dark_flute_map:connect_one_way(Mire_area)
Dark_flute_map:connect_one_way(Swamp_area)
Dark_flute_map:connect_one_way(Dark_icerod_area)


Teleporter_at_village_of_the_outcast:connect_one_way(Teleporter_at_kakariko_village, function()
    return ALL(
        "glove",
        Inverted
    )
end)


Teleporter_at_dark_turtle_rock:connect_one_way(Teleporter_at_light_turtle_rock, function() return ALL(Inverted, "titans") end)

Teleporter_at_dark_death_mountain_left_bottom:connect_one_way(Teleporter_at_light_death_mountain_left_bottom, function() return Inverted() end)

Teleporter_at_dark_death_mountain_right_bottom:connect_one_way(Teleporter_at_light_death_mountain_right_bottom, function() return Inverted() end)

Teleporter_at_pod:connect_one_way(Teleporter_at_eastern, function()
    return ALL(
        "glove",
        Inverted
    )
end)

Teleporter_at_mire:connect_one_way(Teleporter_at_desert, function()
    return ALL(
        "titans",
        Inverted
    )
end)

Teleporter_at_swamp:connect_one_way(Teleporter_at_dam, function()
    return ALL(
        "glove",
        Inverted
    )
end)

Teleporter_at_ice_palace:connect_one_way(Teleporter_at_upgrade_fairy, function() return Inverted() end)



Darkworld_spawns:connect_one_way(Dark_spawn_links_house)
Darkworld_spawns:connect_one_way(Dark_spawn_Dark_chapel)
Darkworld_spawns:connect_one_way(Dark_spawn_old_man, function() return CanReach("Old_man_cave_right_inside") end) --has rescued old man

Dark_spawn_links_house:connect_one_way(Links_house_inside, function() return Inverted() end)
-- Dark_spawn_links_house:connect_two_ways_entrance("Big Bomb Shop", Big_bomb_shop, OpenOrStandard)
Dark_spawn_Dark_chapel:connect_one_way(Dark_chapel_inside, function() return Inverted() end)
Dark_spawn_old_man:connect_one_way(Old_man_home_bottom_inside, function() return Inverted() end)

-- Big_bomb_shop_area
-- Links_house_outside:connect_two_ways(Big_bomb_shop_area, Inverted) --probably dupes
Big_bomb_shop_area:connect_two_ways(Big_bomb_shop_outside)--, OpenOrStandard) --probably dupes
Big_bomb_shop_area:connect_one_way(Swamp_area)
Big_bomb_shop_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Big_bomb_shop_area:connect_one_way(Dark_lake_hylia)
Big_bomb_shop_area:connect_one_way(South_of_Village_of_the_outcast)
-- Big_bomb_shop_area:connect_one_way(PoD_area, function()
--     return "hammer"
-- end)

-- Links_house_outside:connect_two_ways_entrance("Inverted Spawn", Links_house_inside)
Big_bomb_shop_outside:connect_two_ways_entrance("Big Bomb Shop", Big_bomb_shop_inside, function() return OpenOrStandard() end)
Big_bomb_shop_outside:connect_two_ways_entrance("Big Bomb Shop", Links_house_inside, function() return Inverted() end)

Big_bomb_shop_area:connect_two_ways_stuck(Big_bomb_shop_fairy_cave_outside, function()
    return ALL(
        "boots",
        CanInteract(Big_bomb_shop_area)
    )
end)
Big_bomb_shop_fairy_cave_outside:connect_two_ways_entrance("Big Bomb Shop Fairy Cave", Big_bomb_shop_fairy_cave_inside)

Big_bomb_shop_area:connect_one_way(Cave45_ledge, function()
    return ALL(
        CanChangeWorldWithMirror,
        OpenOrStandard
    )
end)
Big_bomb_shop_area:connect_one_way(Hyrule_castle_area, function()
    return ALL(
        Inverted,
        "aga1"
    )
end)

Big_bomb_shop_inside:connect_one_way("Buy Big Bomb", function() return ALL(Has("crystal56",2, 2, 2, 2), CanInteract(Big_bomb_shop_inside)) end)

-- Swamp_area
Swamp_area:connect_one_way(Teleporter_at_swamp, function()
    return ALL(
        Inverted,
        "hammer",
        CanInteract(Swamp_area)
    )
end)
Teleporter_at_swamp:connect_one_way(Swamp_area, function()
    return ALL(
        "pearl",
        "hammer",
        CanInteract(Teleporter_at_swamp)
    )
end)

Swamp_area:connect_one_way(Big_bomb_shop_area)
Swamp_area:connect_one_way(Dark_lake_hylia)
Swamp_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
-- Swamp_area:connect_one_way(Desert_area, function() return(ALL("mirror", CanActivateTablets())) end)
Swamp_area:connect_two_ways(Bombos_tablet_ledge, function()
    return ANY(
        ALL(
            CanChangeWorldWithMirror,
            OpenOrStandard
        ),
        ALL(
            CheckGlitches(2),
            "boots",
            CanChangeWorldWithMirror
        )
    )
end)

Swamp_area:connect_two_ways_stuck(Hype_cave_outside, function()
    return ALL(
        "bombs",
        CanInteract(Swamp_area)
    )
end)
Swamp_area:connect_two_ways(SP_entrance_outside)

Hype_cave_outside:connect_two_ways_entrance("Hype Cave", Hype_cave_inside)
SP_entrance_outside:connect_two_ways_entrance("Swamp Palace", SP_entrance_inside)

Hype_cave_inside:connect_one_way("Hype Cave_Generous Guy")
Hype_cave_inside:connect_two_ways(Hype_cave_back, function() 
    return ALL(
        "bombs",
        CanInteract(Hype_cave_inside, "bombs")
    )
end)

Hype_cave_back:connect_one_way("Hype Cave Top")
Hype_cave_back:connect_one_way("Hype Cave Middle Left")
Hype_cave_back:connect_one_way("Hype Cave Middle Right")
Hype_cave_back:connect_one_way("Hype Cave Bottom")

-- Swamp_area:connect_one_way("Purple Chest Return", function() return CanReach("Hammer_peg_field")) end)




-- Mire_area
-- Mire_area:connect_one_way()
Mire_ledge:connect_one_way(Mire_area)
Mire_ledge:connect_one_way(Teleporter_at_mire, function()
    return ALL(
        Inverted,
        "titans"
    )
end)

-- OWG
Mire_area:connect_one_way(Mire_ledge, function()
    return ALL(
        Inverted,
        CheckGlitches(2),
        "boots"
    )
end)

Mire_area:connect_one_way(DP_right_entrance_outside, function()
    return ALL(
        OpenOrStandard,
        CheckGlitches(2),
        "mirror"
    )
end) --Desert East Mirror Clip
-- OWG end

Teleporter_at_mire:connect_one_way(Mire_ledge)

Mire_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)

Mire_area:connect_two_ways_stuck(MM_entrance_outside, function()
    return ALL(
        ANY(
            "mm_medallion",
            Has("medallion", 3, 3, 3, 3)
        ),
        CanUseMedallions,
        CanInteract(Mire_area)
    )
end)
Mire_area:connect_two_ways(Mire_shed_outside)
Mire_area:connect_two_ways(Dark_desert_hint_outside)
Mire_area:connect_two_ways(Dark_desert_fairy_cave_outside)

MM_entrance_outside:connect_one_way(Mire_area)
MM_entrance_outside:connect_two_ways_entrance("Misery Mire", MM_entrance_inside)
Mire_shed_outside:connect_two_ways_entrance("Mire Shed Left", Mire_shed_inside)
Dark_desert_hint_outside:connect_two_ways_entrance("Dark Desert Hint", Dark_desert_hint_inside)
Dark_desert_fairy_cave_outside:connect_two_ways_entrance("Dark Desert Fairy", Dark_desert_fairy_cave_inside)

Mire_shed_inside:connect_one_way("Mire Shed Left", function() return CanInteract(Mire_shed_inside) end)
Mire_shed_inside:connect_one_way("Mire Shed Right", function() return CanInteract(Mire_shed_inside) end)


Mire_area:connect_one_way(Desert_ledge, function()
    return ALL(
        CanChangeWorldWithMirror,
        OpenOrStandard
    )
end)
Mire_area:connect_one_way(DP_back_entrance_outside, function()
    return ALL(
        CanChangeWorldWithMirror,
        OpenOrStandard
    )
end)
Mire_area:connect_one_way(Checkerboard_lege, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)
-- Mire_area:connect_one_way(teleper, function() return "mirror" end)
Mire_area:connect_one_way(Dp_entranCE_stairs, function()
    return ALL(
        CanChangeWorldWithMirror, 
        OpenOrStandard
    )
end)




-- Dark_lake_hylia
-- Dark_lake_hylia:connect_one_way(Big_bomb_shop_area)
-- Dark_lake_hylia:connect_one_way(ice_palace, function()
--     return ALL(
--         "flippers",
--         CanInteract("",
--     )
-- end)
Dark_lake_hylia:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Dark_lake_hylia:connect_one_way(Dark_icerod_area, function()
    return ALL(
        "flippers",
        CanInteract(Dark_lake_hylia)
    )
end)
Dark_lake_hylia:connect_one_way(PoD_area, function()
    return ALL(
        ANY(
            "hammer",
            "flippers"
        ),
        CanInteract(Dark_lake_hylia)
    )
end)
Dark_lake_hylia:connect_one_way(Lake_hylia_island, function()
    return ALL(
        CanChangeWorldWithMirror,
        CanSwim,
        OpenOrStandard,
        CanInteract(Dark_lake_hylia)
    )
end)
Dark_lake_hylia:connect_two_ways(Dark_lake_shop_outside)
Dark_lake_hylia:connect_one_way(Big_bomb_shop_area)


Dark_lake_shop_inside:connect_one_way("Dark Lake Shop Left")
Dark_lake_shop_inside:connect_one_way("Dark Lake Shop Center")
Dark_lake_shop_inside:connect_one_way("Dark Lake Shop Right")

Dark_lake_shop_outside:connect_two_ways_entrance("Dark Lake Shop", Dark_lake_shop_inside)
Dark_lake_hylia:connect_one_way(Lake_hylia_island, function()
    return ALL(
        "flippers",
        OpenOrStandard,
        CanChangeWorldWithMirror,
        CanInteract(Dark_lake_hylia)
    )
end)
Dark_lake_hylia:connect_two_ways(Ice_palace_island, function()
    return ALL(
        CanSwim,
        Inverted,
        CanInteract(Dark_lake_hylia)
    )
end)

-- OWG
Dark_lake_hylia:connect_one_way(Ice_palace_island, function()
    return ALL(
        "flippers",
        CheckGlitches(2),
        "boots",
        ANY(
            OpenOrStandard,
            ALL(
                Inverted,
                "moonpearl"
            )
        )
    )
end) -- Ice Palace Clip
-- OWG end

Ice_palace_island:connect_one_way(Teleporter_at_ice_palace, function()
    return ALL(
        Inverted,
        "titans"
    )
end)
Teleporter_at_ice_palace:connect_one_way(Ice_palace_island)

Ice_palace_island:connect_two_ways(IP_entrance_outside)
IP_entrance_outside:connect_two_ways_entrance("Ice Palace", IP_entrance_inside)




-- Dark_icerod_area
Dark_icerod_area:connect_one_way(Ice_palace_island, function()
    return ALL(
        Inverted,
        "flippers",
        CanInteract(Dark_icerod_area)
    )
end)

Dark_icerod_area:connect_one_way(PoD_area, function()
    return ALL(
        "flippers",
        CanInteract(Dark_icerod_area)
    )
end)

Dark_icerod_area:connect_one_way(Lake_hylia_island, function()
    return ALL(
        CanChangeWorldWithMirror,
        CanSwim,
        OpenOrStandard,
        CanInteract(Dark_icerod_area)
    )
end)

Dark_icerod_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)

Dark_icerod_area:connect_two_ways_stuck(Dark_lake_hylia_ledge_fairy_outside, function() return ALL("bombs", CanInteract(Dark_icerod_area)) end)
Dark_icerod_area:connect_two_ways(Dark_lake_hylia_ledge_hint_outside)
Dark_icerod_area:connect_two_ways_stuck(Dark_lake_hylia_ledge_spike_hint_outside, function() return ALL("glove", CanInteract(Dark_icerod_area)) end)


Dark_lake_hylia_ledge_fairy_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Fairy", Dark_lake_hylia_ledge_fairy_inside)
Dark_lake_hylia_ledge_hint_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Hint", Dark_lake_hylia_ledge_hint_inside)
Dark_lake_hylia_ledge_spike_hint_outside:connect_two_ways_entrance("Dark Lake Hylia Ledge Spike Hint", Dark_lake_hylia_ledge_spike_hint_inside)






-- Village_of_the_outcast
Village_of_the_outcast:connect_one_way(Teleporter_at_village_of_the_outcast, function()
    return ALL(
        Inverted,
        ANY(
            "hammer",
            "titans"
        )
    )
end)
Teleporter_at_village_of_the_outcast:connect_one_way(Village_of_the_outcast, function()
    return ALL(
        "pearl",
        ANY(
            "hammer",
            "titans"
        )
    )
end)

Village_of_the_outcast:connect_two_ways(Inverted_activate_flute, function()
    return ALL(
        "flute",
        Inverted
    )
end)
Village_of_the_outcast:connect_one_way(Skull_woods_area)
Village_of_the_outcast:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Village_of_the_outcast:connect_one_way(South_of_Village_of_the_outcast)
Village_of_the_outcast:connect_two_ways(Inverted_activate_flute, function()
    return ALL(
        "flute",
        Inverted
    )
end)

Village_of_the_outcast:connect_two_ways(C_shaped_house_outside)
Village_of_the_outcast:connect_two_ways(Chest_game_outside)
Village_of_the_outcast:connect_two_ways(TT_entrance_outside, function() return CanInteract(Village_of_the_outcast) end) -- maybe perl????
Village_of_the_outcast:connect_two_ways(Dark_village_shop_outside, function() return ALL("hammer", CanInteract(Village_of_the_outcast)) end)
Village_of_the_outcast:connect_two_ways_stuck(Brewery_outside, function() return ALL("bombs", CanInteract(Village_of_the_outcast)) end)
Village_of_the_outcast:connect_two_ways(Dark_village_fortune_teller_outside)

C_shaped_house_outside:connect_two_ways_entrance("C-Shaped House", C_shaped_house_inside)
Chest_game_outside:connect_two_ways_entrance("Chest Game Entrance", Chest_game_inside)
TT_entrance_outside:connect_two_ways_entrance("Thieves Town Entrance", TT_entrance_inside)
Dark_village_shop_outside:connect_two_ways_entrance("Dark Village Shop", Dark_village_shop_inside)
Dark_village_shop_outside:connect_one_way(Kakariko_overgrown_house_outside, function() 
    return ALL(
        OpenOrStandard, 
        CanChangeWorldWithMirror
    )
end)
Brewery_outside:connect_two_ways_entrance("Brewery", Brewery_inside)
Dark_village_fortune_teller_outside:connect_two_ways_entrance("Dark Village Fortune Teller", Dark_village_fortune_teller_inside)

Chest_game_inside:connect_one_way("Chest Game Item", function() return CanInteract(Chest_game_inside) end)

C_shaped_house_inside:connect_one_way("C-Shaped House", function() return CanInteract(C_shaped_house_inside) end)

Dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Left")
Dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Center")
Dark_village_shop_inside:connect_one_way("Village of Outcasts Shop Right")

Brewery_inside:connect_one_way("Brewery Chest", function() return CanInteract(Brewery_inside) end)


Village_of_the_outcast:connect_two_ways(Hammer_peg_field, function() return ALL("titans", CanInteract(Village_of_the_outcast)) end)
Hammer_peg_field:connect_two_ways(Purple_chest_spawn, function() 
    return ALL(
        Helpless_frog:accessibility() > 5,
        Dwarf_smiths_inside:accessibility() > 5
    )
end)
Hammer_peg_field:connect_two_ways_stuck(Peg_cave_outside, function() return ALL("hammer", CanInteract(Hammer_peg_field)) end)
Hammer_peg_field:connect_one_way(Magic_bat_cave_outside, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)
Peg_cave_outside:connect_two_ways_entrance("Peg Cave", Peg_cave_inside)

Peg_cave_inside:connect_one_way("Peg-Cave Item")

Village_of_the_outcast:connect_two_ways(Helpless_frog, function() return ALL("titans", CanInteract(Village_of_the_outcast)) end)

-- South_of_Village_of_the_outcast
South_of_Village_of_the_outcast:connect_one_way(Village_of_the_outcast, function()
    return ALL(
        "titans",
        CanInteract(South_of_Village_of_the_outcast)
    )
end)
South_of_Village_of_the_outcast:connect_one_way(Big_bomb_shop_area)
South_of_Village_of_the_outcast:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
South_of_Village_of_the_outcast:connect_two_ways(Dark_archery_minigame_outside)
Dark_archery_minigame_outside:connect_two_ways_entrance("Dark Archery", Dark_archery_minigame_inside)
South_of_Village_of_the_outcast:connect_one_way("Digging Game", function() return CanInteract(South_of_Village_of_the_outcast) end)
South_of_Village_of_the_outcast:connect_one_way(Race_ledge, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)

-- OWG
South_of_Village_of_the_outcast:connect_one_way(Mire_area, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Dark Desert Cliffs Clip Spot
-- OWG end

-- South_of_Village_of_the_outcast:connect_one_way(Mire_area) -- glitches

Big_bomb_shop_area:connect_two_ways(Stumpy, function() return CanInteract(Big_bomb_shop_area) end)
Big_bomb_shop_area:connect_one_way(Cave45_ledge, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)
Stumpy:connect_one_way("Stumpy")







-- Skull_woods_area
Skull_woods_area:connect_one_way(Village_of_the_outcast)
Skull_woods_area:connect_one_way(Dark_lumpberjacks)

Skull_woods_area:connect_two_ways(SW_pinball_drop_outside)
Skull_woods_area:connect_two_ways(SW_pot_circle_drop_outside, function() return CanInteract(Skull_woods_area) end)
Skull_woods_area:connect_two_ways(SW_bottom_left_drop_outside)

Skull_woods_area:connect_two_ways(SW_big_chest_entrance_outside)
Skull_woods_area_back:connect_two_ways(SW_west_lobby_entrance_outside)
Skull_woods_area:connect_two_ways(SW_gibdo_entrance_outside)

Skull_woods_area_back:connect_two_ways(SW_north_drop_outside, function() return ALL(CanReach("SW_west_lobby_entrance_outside"), CanInteract(Skull_woods_area_back)) end)
Skull_woods_area_back:connect_two_ways_stuck(SW_back_entrance_outside, function()
    return ALL(
        CanReach("SW_west_lobby_entrance_outside"),
        "firerod",
        CanInteract(Skull_woods_area_back)
    )
end)

SW_pinball_drop_outside:connect_one_way_entrance("Skull Woods Pinball Drop", SW_pinball_drop_inside)
SW_pot_circle_drop_outside:connect_one_way_entrance("Skull Woods Pot Circle Drop", SW_pot_circle_drop_inside)
SW_bottom_left_drop_outside:connect_one_way_entrance("Skull Woods Bottom Left Drop", SW_bottom_left_drop_inside)

SW_big_chest_entrance_outside:connect_two_ways_entrance("Skull Woods Front", SW_big_chest_entrance_inside)
SW_west_lobby_entrance_outside:connect_two_ways_entrance("Skull Woods West Lobby", SW_west_lobby_entrance_inside)
SW_gibdo_entrance_outside:connect_two_ways_entrance("Skull Woods Gibdo Lobby", SW_gibdo_entrance_inside)

SW_north_drop_outside:connect_one_way_entrance("Skull Woods Back North Drop", SW_north_drop_inside)
SW_back_entrance_outside:connect_two_ways_entrance("Skull Woods Back", SW_back_entrance_inside)


-- Dark_lumpberjacks
Dark_lumpberjacks:connect_one_way(Skull_woods_area)
Dark_lumpberjacks:connect_one_way(Dark_chapel_area)
Dark_lumpberjacks:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Dark_lumpberjacks:connect_two_ways(Dark_lumpberjacks_shop_outside)
Dark_lumpberjacks:connect_two_ways(Red_shield_shop_outside)
Dark_lumpberjacks:connect_one_way("Bumper Cave Item", function() return ACCESS_INSPECT end)

Dark_lumpberjacks:connect_two_ways(Dark_bumper_cave_bottom_ledge, function()
    return ALL(
        "glove",
        CanInteract(Dark_lumpberjacks)
    )
end)

-- OWG
Dark_lumpberjacks:connect_one_way(Dark_death_mountain_left_bottom, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        Inverted
    )
end) -- Dark World DMA Clip Spot

Dark_lumpberjacks:connect_one_way(Dark_bumper_cave_top_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Bumper Cave Ledge Clip Spot

Dark_lumpberjacks:connect_one_way(Dark_bumper_cave_bottom_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Bumper Cave Entrance Clip Spot
-- OWG end

Dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Left")
Dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Center")
Dark_lumpberjacks_shop_inside:connect_one_way("Dark Lumberjack Shop Right")

Red_shield_shop_inside:connect_one_way("Red Shield Shop Left")
Red_shield_shop_inside:connect_one_way("Red Shield Shop Center")
Red_shield_shop_inside:connect_one_way("Red Shield Shop Right")


Dark_lumpberjacks_shop_outside:connect_two_ways_entrance("Dark Lumberjacks Shop", Dark_lumpberjacks_shop_inside)
Red_shield_shop_outside:connect_two_ways_entrance("Red Shield Shop", Red_shield_shop_inside)


-- Dark_bumper_cave_outside:connect_two_ways_entrance("Bumper Cave", Dark_bumper_cave_inside, function() return ALL(OpenOrStandard, "glove", CanInteract("", end)


Dark_bumper_cave_bottom_ledge:connect_one_way(Dark_lumpberjacks)
Dark_bumper_cave_bottom_ledge:connect_two_ways(Dark_bumper_cave_bottom_outside)

-- Dark_bumper_cave_bottom_ledge:connect_one_way(Dark_death_mountain_ascent, function() return DarkRooms() end)
Dark_bumper_cave_bottom_outside:connect_two_ways_entrance("Bumper Cave Bottom", Dark_bumper_cave_bottom_inside, function() return OpenOrStandard() end)
Dark_bumper_cave_bottom_outside:connect_two_ways_entrance("Old Man Cave Left", Old_man_cave_left_inside, function() return Inverted() end)

Dark_bumper_cave_bottom_inside:connect_two_ways(Bumpercave_top_back)
Bumpercave_top_back:connect_two_ways(Bumpercave_top_front, function()
    return ALL(
        "cape",
        CanInteract(Bumpercave_top_back, "cape")
    )
end)
Bumpercave_top_front:connect_two_ways(Dark_bumper_cave_top_inside)

Dark_bumper_cave_top_outside:connect_two_ways_entrance("Bumper Cave Top", Dark_bumper_cave_top_inside, function() return OpenOrStandard() end)
Dark_bumper_cave_top_outside:connect_two_ways_entrance("Dark Death Mountain Fairy Inside", Dark_death_mountain_fairy_inside, function() return Inverted() end)

Dark_bumper_cave_top_ledge:connect_two_ways(Dark_bumper_cave_top_outside)
Dark_bumper_cave_top_ledge:connect_one_way(Light_death_mountain_return_ledge, function() return ALL(CanChangeWorldWithMirror, OpenOrStandard)end)
-- Dark_bumper_cave_top_ledge:connect_two_ways(Dark_death_mountain_fairy_outside, Inverted)


Dark_bumper_cave_top_ledge:connect_one_way(Dark_lumpberjacks)
Dark_bumper_cave_top_ledge:connect_one_way("Bumper Cave Item")

-- Dark_death_mountain_ascent:connect_two_ways_entrance("Upper Dark Death Mountain Ascent", Dark_death_mountain_left_bottom, function() return DarkRooms() end)

-- Dark_bumper_cave_outside:connect_one_way_entrance("Normal Bumpercave", Dark_bumper_cave_ledge,function() return ALL(OpenOrStandard(), "cape", CanInteract("", end)
-- Dark_bumper_cave_ledge:connect_one_way_entrance("Reverse Bumpercave", Dark_bumper_cave_outside, function()
--     return ALL(
--         ANY(
--             "hookshot",
--             "cape"
--         ),
--         CanInteract("",
--     )
-- end)
-- Dark_bumper_cave_ledge:connect_one_way("Bumper Cave Item", function()
--     return ANY(
--         Dark_bumper_cave_ledge:accessibility(),
--         ACCESS_INSPECT
--     )
-- end)
-- Dark_bumper_cave_ledge:connect_one_way(Light_bumper_cave_ledge, function()
--     return ALL(
--         CanChangeWorldWithMirror,
--         OpenOrStandard()
--     )
-- end)
-- Dark_bumper_cave_ledge:connect_one_way(Dark_lumpberjacks)


-- Dark_chapel_area
Dark_chapel_area:connect_one_way(Dark_lumpberjacks)
Dark_chapel_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Dark_chapel_area:connect_one_way(Dark_potion_shop_area, function()
    return ALL(
        "flippers",
        CanInteract(Dark_chapel_area)
    )
end)

Dark_chapel_area:connect_one_way(Graveyard_ledge, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror,
        CanInteract(Dark_chapel_area)
    )
end)
Dark_chapel_area:connect_one_way(Kings_tomb_area, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror,
        CanInteract(Dark_chapel_area)
    )
end)


Dark_chapel_area:connect_two_ways(Dark_chapel_outside)
Dark_chapel_outside:connect_two_ways_entrance("Dark Chapel", Dark_chapel_inside)

Dark_chapel_area:connect_one_way(Sanctuary_area, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)

-- Dark_potion_shop
Dark_potion_shop_area:connect_one_way(Dark_chapel_area, function()
    return ALL(
        "hookshot",
        CanInteract(Dark_potion_shop_area)
    )
end)
Dark_potion_shop_area:connect_one_way(Catfish_area, function()
    return ALL(
        "glove",
        CanInteract(Dark_potion_shop_area)
    )
end)
Dark_potion_shop_area:connect_one_way(PoD_area, function()
    return ALL(
        ANY(
            "hammer",
            "glove"
        ),
        CanInteract(Dark_potion_shop_area)
    )
end)
Dark_potion_shop_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)

Dark_potion_shop_area:connect_two_ways(Dark_potion_shop_outside)
Dark_potion_shop_outside:connect_two_ways_entrance("Dark Potion Shop", Dark_potion_shop_inside)

Dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
Dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
Dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")







-- Catfish_area
Catfish_area:connect_one_way(Dark_potion_shop_area, function()
    return ALL(
        ANY(
            "flippers",
            "glove"
        ),
        CanInteract(Catfish_area)
    )
end)
Catfish_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
Catfish_area:connect_one_way("Catfish Item", function() return CanInteract(Catfish_area) end)
-- Catfish_area:connect_one_way() --glicht to pod






-- pyramid
Pyramid_area:connect_one_way(PoD_area)
Pyramid_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)

Pyramid_area:connect_one_way("Pyramid Item")
Pyramid_area:connect_two_ways_stuck(Pyramid_fairy_cave_outside, function()
    return ALL(
        Has("crystal56", 2, 2, 2, 2),
        Big_bomb_shop_inside:accessibility(),
        CanInteract(Pyramid_area),
        ANY(
            ALL(
                "mirror",
                Inverted
            ),
            OpenOrStandard
        )
    )
end)

Pyramid_area:connect_two_ways(Pyramid_hole_outside, function() return ALL(CheckPyramidState, OpenOrStandard) end)
Pyramid_exit_outside:connect_two_ways(Pyramid_exit_ledge, function() return OpenOrStandard() end)

Pyramid_exit_ledge:connect_one_way(Pyramid_area)

Pyramid_hole_outside:connect_one_way(Pyramid_hole_inside)
Pyramid_exit_outside:connect_two_ways(Pyramid_exit_inside)

Pyramid_hole_inside:connect_one_way(Pyramid_exit_inside, function() 
    return ANY(
        "mastersword",
        ALL(
            "swordless",
            "hammer"
        )
    )
end)

Pyramid_fairy_cave_outside:connect_one_way_entrance("Fat Fairy", Pyramid_fairy_cave_inside)

Pyramid_fairy_cave_inside:connect_one_way("Pyramid Fairy Left", function() return CanInteract(Pyramid_fairy_cave_inside) end)
Pyramid_fairy_cave_inside:connect_one_way("Pyramid Fairy Right", function() return CanInteract(Pyramid_fairy_cave_inside) end)

Pyramid_area:connect_one_way(Hyrule_castle_top, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)




-- PoD_area
PoD_area:connect_one_way(Teleporter_at_pod, function()
    return ALL(
        Inverted,
        "hammer"
    )
end)
Teleporter_at_pod:connect_one_way(PoD_area, function()
    return ALL(
        "pearl",
        "hammer"
    )
end)

PoD_area:connect_one_way(Pyramid_area)
PoD_area:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
PoD_area:connect_one_way(Dark_potion_shop_area,function()
    return ALL(
        ANY(
            "hammer",
            "glove",
            "flippers"
        ),
        CanInteract(PoD_area)
    )
end)

PoD_area:connect_one_way(Ice_palace_island, function()
    return ALL(
        "flippers",
        CanInteract(PoD_area),
        Inverted
    )
end)
PoD_area:connect_one_way(Dark_icerod_area, function()
    return ALL(
        "flippers",
        CanInteract(PoD_area)
    )
end)

PoD_area:connect_one_way(Big_bomb_shop_area, function()
    return ALL(
        "hammer",
        CanInteract(PoD_area)
    )
end)

PoD_area:connect_two_ways(PoD_hint_house_outside)
PoD_area:connect_two_ways_stuck(PoD_entrance_outside, function() return CanInteract(PoD_area) end)
PoD_area:connect_two_ways(Dark_lake_hylia_fairy_outside)
PoD_area:connect_two_ways(PoD_east_darkworld_hint_outside)
-- PoD_area:connect_two_ways(PoD_entrance_outside, function() return CanInteract("", end)

-- OWG
PoD_area:connect_one_way(Dark_icerod_area, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Dark Lake Hylia Ledge Clip Spot

PoD_area:connect_one_way(Hammer_peg_field, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Hammer Pegs River Clip Spot 
-- OWG end

PoD_hint_house_outside:connect_two_ways_entrance("Kiki Cave", PoD_hint_house_inside)
PoD_entrance_outside:connect_two_ways_entrance("Palace of Darkness", PoD_entrance_inside)
Dark_lake_hylia_fairy_outside:connect_two_ways_entrance("Dark PoD Fairy", Dark_lake_hylia_fairy_inside)
PoD_east_darkworld_hint_outside:connect_two_ways_entrance("PoD Teleporter Cave", PoD_east_darkworld_hint_inside)

-- PoD_entrance_outside:connect_two_ways_entrance("Palace of Darkness Entrance", PoD_entrance_inside)






-- ice_palace
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()








-- Dark_death_mountain_left_top
Dark_death_mountain_left_top:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
-- Dark_death_mountain_left_top:connect_one_way()
Dark_death_mountain_left_top:connect_one_way(Light_death_mountain_left_top, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)
Dark_death_mountain_left_top:connect_two_ways(GT_entrance_outside, function()
    return ANY(
        ALL(
            GTCrystalCount,
            OpenOrStandard
        ),
        Inverted
    )
end)
-- Dark_death_mountain_left_top:connect_two_ways(AT_entrance_outside, Inverted)

Dark_death_mountain_left_top:connect_two_ways(Dark_death_mountain_right_top)
Dark_death_mountain_left_top:connect_one_way(Dark_death_mountain_left_bottom)

-- OWG
Dark_death_mountain_left_top:connect_one_way(Dark_bumper_cave_top_ledge, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Dark Death Mountain Descent to bumper ledge
-- OWG end

GT_entrance_outside:connect_two_ways_entrance("Ganons Tower", GT_entrance_inside, function() return OpenOrStandard() end)
GT_entrance_outside:connect_two_ways_entrance("Aga Tower", AT_entrance_inside, function() return Inverted() end)



-- Dark_death_mountain_right_top
Dark_death_mountain_right_top:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
-- Dark_death_mountain_right_top:connect_one_way()
Dark_death_mountain_right_top:connect_one_way(Teleporter_at_dark_turtle_rock, function()
    return ALL(
        Inverted
    )
end)
Teleporter_at_dark_turtle_rock:connect_one_way(Dark_death_mountain_right_top)

Teleporter_at_dark_turtle_rock:connect_one_way(Dark_death_mountain_tr_medallion_spot)

Dark_death_mountain_right_top:connect_two_ways_stuck(TR_main_entrance_outside, function()
    return ALL(
        ANY(
            "tr_medallion",
            Has("medallion", 3, 3, 3, 3)
        ),
        CanUseMedallions,
        CanReach("Dark_death_mountain_tr_medallion_spot")
    )
end)

Dark_death_mountain_right_top:connect_two_ways_stuck(Hookshot_cave_outside, function()
    return ANY(
        ALL(
            "glove",
            CanInteract(Dark_death_mountain_right_top)
        )
    )
end)

-- OWG
Dark_death_mountain_right_top:connect_one_way(Catfish_area, function()
    return ALL(
        Inverted,
        CheckGlitches(2),
        "boots"
    )
end) -- Catfish Descent

Dark_death_mountain_right_top:connect_one_way(Dark_death_mountain_tr_medallion_spot, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Turtle Rock (Top) Clip Spot
--OWG end

TR_main_entrance_outside:connect_two_ways_entrance("Turtle Rock Main Entrance", TR_main_entrance_inside)
Hookshot_cave_outside:connect_two_ways_entrance("Hookshot Cave", Hookshot_cave_inside)


Hookshot_cave_inside:connect_two_ways(Dark_floating_island_inside, function()
    return ALL(
        "bombs",
        CanInteract(Hookshot_cave_inside, "bombs")
    )
end)
Dark_floating_island_inside:connect_two_ways_entrance("Dark Floating Island", Dark_floating_island_outside)

Dark_floating_island_outside:connect_two_ways(Dark_floating_island)
-- Dark_floating_island:connect_two_ways(Floating_island, function()
--     return ALL(
--         CanChangeWorldWithMirror,
--         OpenOrStandard()
--     )
-- end)

--# TODO: inverted: light floating island -> mirror -> dark floating island -> hookshot cave available
Dark_floating_island:connect_one_way(Floating_island, function() return ALL(CanChangeWorldWithMirror,OpenOrStandard) end)
Floating_island:connect_one_way(Dark_floating_island, function() return ALL(CanChangeWorldWithMirror,Inverted) end)
Dark_floating_island:connect_one_way(Dark_death_mountain_right_top)


Hookshot_cave_inside:connect_one_way("Hookshot Cave Item Bottom Right", function()
    return ANY(
        ALL("hookshot", CanInteract(Hookshot_cave_inside, "hookshot")),
        ALL("boots", CanInteract(Hookshot_cave_inside, "boots"))
    )
end)
Hookshot_cave_inside:connect_one_way("Hookshot Cave Item Top Right", function()
    return ALL(
        "hookshot",
        CanInteract(Hookshot_cave_inside, "hookshot")
    )
end)
Hookshot_cave_inside:connect_one_way("Hookshot Cave Item Top Left", function()
    return ALL(
        "hookshot",
        CanInteract(Hookshot_cave_inside, "hookshot")
    )
end)
Hookshot_cave_inside:connect_one_way("Hookshot Cave Item Bottom Left", function()
    return ALL(
        "hookshot",
        CanInteract(Hookshot_cave_inside, "hookshot")
    )
end)

TR_eye_bridge_entrance_outside:connect_two_ways(TR_eye_bridge_entrance_ledge)
TR_eye_bridge_entrance_ledge:connect_one_way(Light_eyebridge_fairy_ledge, function()
    return ALL(
        OpenOrStandard,
        CanChangeWorldWithMirror
    )
end)
-- Dark_death_mountain_lonely_ledge:connect_one_way(TR_eye_bridge_entrance, Inverted)
Dark_death_mountain_right_top:connect_one_way(Dark_death_mountain_right_bottom)


-- Dark_death_mountain_left_bottom
Dark_death_mountain_left_bottom:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
-- Dark_death_mountain_left_bottom:connect_one_way()
Dark_death_mountain_left_bottom:connect_one_way(Teleporter_at_dark_death_mountain_left_bottom, function() return Inverted() end)
-- Teleporter_at_dark_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_left_bottom, function() return "pearl" end)
Teleporter_at_dark_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_left_bottom)

Dark_death_mountain_left_bottom:connect_two_ways(Spike_cave_outside)
Spike_cave_outside:connect_two_ways_entrance("Spike Cave", Spike_cave_inside)


Dark_death_mountain_left_bottom:connect_one_way(Light_death_mountain_left_top, function()
    return ALL(
        CanChangeWorldWithMirror,
        OpenOrStandard
    )
end)
Spike_cave_inside:connect_one_way("Spike Cave Chest", function()
    return ALL(
        "hammer",
        "glove",
        CanInteract(Spike_cave_inside),
        ANY(
            ALL(
                "cape",
                SpikeCaveMagicLogic(16)
            ),
            ALL(
                "byrna",
                ANY(
                    SpikeCaveMagicLogic(12),
                    ALL(
                        false ,-- not in ohko mode
                        ANY(
                            "boots",
                            CalcHealth() > 4
                        )
                    )
                )
            )
        )
    )
end)
Dark_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_left_top, function() return Inverted() end)

Dark_death_mountain_left_bottom:connect_two_ways(Dark_death_mountain_fairy_outside)

-- OWG
Dark_death_mountain_left_bottom:connect_one_way(Dark_lumpberjacks, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- Dark Death Mountain Descent 

-- Dark_death_mountain_left_bottom:connect_one_way(Skull_woods_area_back, function()
--     return ALL(
--         CheckGlitches(2),
--         "boots",
--         OpenOrStandard
--     )
-- end) -- Dark Death Mountain Descent 

-- Dark_death_mountain_left_bottom:connect_one_way(Swamp_area, function()
--     return ALL(
--         CheckGlitches(2),
--         "boots",
--         OpenOrStandard
--     )
-- end) -- Mire superjump DMD

Dark_death_mountain_left_bottom:connect_one_way(GT_entrance_outside, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Ganons Tower Ascent

Dark_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_right_top, function()
    return ALL(
        CheckGlitches(2),
        "boots",
        OpenOrStandard
    )
end) -- Dark Death Mountain Glitched Bridge

Dark_death_mountain_left_bottom:connect_one_way(Dark_death_mountain_right_bottom, function()
    return ALL(
        CheckGlitches(2),
        "mirror",
        OpenOrStandard
    )
end) -- Dark Death Mountain (East Bottom) Jump

Dark_death_mountain_left_bottom:connect_one_way(Dark_chapel_area, function()
    return ALL(
        CheckGlitches(2),
        "mirror",
        OpenOrStandard
    )
end) -- West Dark World Bunny Descent

Dark_death_mountain_left_bottom:connect_one_way(PoD_area, function()
    return ALL(
        CheckGlitches(2),
        "mirror",
        OpenOrStandard
    )
end) -- Dark Death Mountain Offset Mirror -- mirror spot displacement

Dark_death_mountain_left_bottom:connect_one_way(Hyrule_castle_area, function()
    return ALL(
        CheckGlitches(2),
        "mirror",
        OpenOrStandard
    )
end) -- Death Mountain Offset Mirror -- mirror spot displacement

Dark_death_mountain_left_bottom:connect_one_way(Hyrule_castle_top, function()
    return ALL(
        CheckGlitches(2),
        "mirror",
        "pearl",
        "boots"
    )
end) -- Death Mountain Offset Mirror (Houlihan Exit) -- mirror spot displacement
-- OWG end

Dark_death_mountain_fairy_outside:connect_two_ways_entrance("Dark Death Mountain Fairy", Dark_death_mountain_fairy_inside, function() return OpenOrStandard() end)

Dark_death_mountain_fairy_outside:connect_two_ways_entrance("Old Man Cave Right Inside", Old_man_cave_right_inside, function() return Inverted() end)


-- Dark_death_mountain_right_bottom
Dark_death_mountain_right_bottom:connect_one_way(Dark_flute_map, function()
    return ALL(
        "flute",
        Inverted,
        CanReach("Inverted_activate_flute")
    )
end)
-- Dark_death_mountain_right_bottom:connect_one_way()
Dark_death_mountain_right_bottom:connect_one_way(Teleporter_at_dark_death_mountain_right_bottom, function()
    return ALL(
        Inverted,
        "titans"
    )
end)
Teleporter_at_dark_death_mountain_right_bottom:connect_one_way(Dark_death_mountain_right_bottom)

-- OWG
Dark_death_mountain_right_bottom:connect_one_way(Dark_floating_island, function()
    return ALL(
        CheckGlitches(2),
        "boots"
    )
end) -- DW Floating Island Clip Spot
-- OWG end


Turtle_rock_ledge:connect_two_ways(TR_big_chest_entrance_outside)
Turtle_rock_ledge:connect_two_ways(TR_laser_entrance_outside, function()
    return ALL(
        "bombs",
        CanInteract(Turtle_rock_ledge)
    )
end)
Turtle_rock_ledge:connect_one_way(Mimic_cave_ledge, function()
    return ALL(
        CanChangeWorldWithMirror,
        OpenOrStandard
    )
end)

TR_big_chest_entrance_outside:connect_two_ways_entrance("Turtle Rock Big Chest Entrance", TR_big_chest_entrance_inside)
TR_laser_entrance_outside:connect_two_ways_entrance("Turtle Rock Laser Entrance", TR_laser_entrance_inside)
TR_eye_bridge_entrance_outside:connect_two_ways_entrance("Turtle Eye Bridge Entrance", TR_eye_bridge_entrance_inside)
-- TR_laser_entrance:connect_two_ways_entrance("Light Death Mountain Fairy", Light_death_mountain_cave1, function() return "mirror" end)

Dark_death_mountain_right_bottom:connect_two_ways(Dark_death_mountain_shop_outside)
Dark_death_mountain_right_bottom:connect_two_ways(Superbunny_cave_bottom_outside)
Dark_death_mountain_right_top:connect_two_ways(Superbunny_cave_top_outside)

Dark_death_mountain_shop_outside:connect_two_ways_entrance("Dark Death Mountain Shop", Dark_death_mountain_shop_inside)

Superbunny_cave_bottom_outside:connect_two_ways_entrance("Super Bunny Cave Bottom Entrance", Superbunny_cave_bottom_inside)
Superbunny_cave_top_outside:connect_two_ways_entrance("Super Bunny Cave Top Entrance", Superbunny_cave_top_inside)

Superbunny_cave_bottom_inside:connect_one_way(Superbunny_cave_top_inside)
Superbunny_cave_top_inside:connect_one_way("Super Bunny Cave Chest Top", function() return CanInteract(Superbunny_cave_top_inside) end)
Superbunny_cave_top_inside:connect_one_way("Super Bunny Cave Chest Bottom", function() return CanInteract(Superbunny_cave_top_inside) end)

