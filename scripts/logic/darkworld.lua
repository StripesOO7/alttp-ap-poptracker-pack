-- region names

-- big_bomb_shop
-- swamp_area
-- mire_area
-- dark_lake_hylia
-- dark_icerod_area
-- village_of_the_outcast
-- south_of_village_of_the_outcast
-- skull_woods_area
-- dark_lumpberjacks
-- dark_chapel
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
dark_flute_map:connect_one_way(big_bomb_shop)
dark_flute_map:connect_one_way(pod_area)
dark_flute_map:connect_one_way(mire_area)
dark_flute_map:connect_one_way(swamp_area)
dark_flute_map:connect_one_way(dark_icerod_area)





darkworld_spawns:connect_one_way(dark_spawn_links_house)
darkworld_spawns:connect_one_way(dark_spawn_dark_chapel)
darkworld_spawns:connect_one_way(dark_spawn_old_man, function() return has() end) --has rescued old man


-- big_bomb_shop
big_bomb_shop:connect_one_way(swamp_area)
big_bomb_shop:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
big_bomb_shop:connect_one_way(dark_lake_hylia)
big_bomb_shop:connect_one_way(south_of_village_of_the_outcast)
-- big_bomb_shop:connect_one_way(pod_area, function()
--     return has("hammer")
-- end)








-- swamp_area
swamp_area:connect_one_way(big_bomb_shop)
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
        ),
    ) 
end)

hype_cave:connect_one_way("Hype Cave - Generous Guy")
hype_cave:connect_one_way("Hype Cave - Top", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Middle Left", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Middle Right", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Bottom", function() return has("bombs") end)






-- mire_area
mire_area:connect_one_way()
mire_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)


mire_shed_left:connect_one_way("Mire Shed - Left")
mire_shed_left:connect_one_way("Mire Shed - Right")


mire_area:connect_one_way(desert_ledge, function() 
    return has("mirror") 
end)
mire_area:connect_one_way(desert_ledge, function() 
    return has("mirror") 
end)
-- mire_area:connect_one_way(teleper, function() return has("mirror") end)

mire_area:connect_two_ways(misery_mire, function() 
    return all(
        canUseMedallions(),
        any(
            has(mm_medallion),
            has(medallion, 3, 3)
            )
        ) 
end)





-- dark_lake_hylia
dark_lake_hylia:connect_one_way(big_bomb_shop)
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











-- village_of_the_outcast
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

chest_game:connect_one_way("Chest Game")

c_shaped_house:connect_one_way("C-Shaped House")

dark_village_shop:connect_one_way("Village of Outcasts Shop Left")
dark_village_shop:connect_one_way("Village of Outcasts Shop Center")
dark_village_shop:connect_one_way("Village of Outcasts Shop Right")

brewery:connect_one_way("Brewery Chest")



peg_cave_inside:connect_one_way("Peg-Cave Item")

village_of_the_outcast:connect_two_ways(purple_chest_pickup, function() return has("titans") end)
purple_chest_pickup:connect_two_ways(peg_cave, function() return has("hammer") end)



-- south_of_village_of_the_outcast
south_of_village_of_the_outcast:connect_one_way(village_of_the_outcast, function()
    return has("titans")
end)
south_of_village_of_the_outcast:connect_one_way(big_bomb_shop)
south_of_village_of_the_outcast:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- south_of_village_of_the_outcast:connect_one_way(mire_area) -- glitches

big_bomb_shop:connect_two_ways(stumpy)
big_bomb_shop:connect_two_ways(cave45, function() return all(openOrStandard(), ))
stumpy:connect_one_way("Stumpy")







-- skull_woods_area
skull_woods_area:connect_one_way(village_of_the_outcast)
skull_woods_area:connect_one_way(dark_lumpberjacks)






-- dark_lumpberjacks
dark_lumpberjacks:connect_one_way(skull_woods_area)
dark_lumpberjacks:connect_one_way(dark_chapel)
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








-- dark_chapel
dark_chapel:connect_one_way(dark_lumpberjacks)
dark_chapel:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_chapel:connect_one_way(dark_potion_shop, function()
    return has("flippers")
end)

dark_chapel:connect_one_way(graveyard_ledge_cave, function()
    return all(
        openOrStandard(),
        has("mirror")
    )
end)
dark_chapel:connect_one_way(kings_tomb, function()
    return all(
        openOrStandard(),
        has("mirror")
    )
end)






-- dark_potion_shop
dark_potion_shop:connect_one_way(dark_chapel, function()
    return has("hookshot")
end)
dark_potion_shop:connect_one_way(catfish_area, function()
    return has("titans")
end)
dark_potion_shop:connect_one_way(pod_area, function()
    return any(
        has("hammer"),
        has("gloves")
    )
end)
dark_potion_shop:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)


dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")







-- catfish_area
catfish_area:connect_one_way(dark_potion_shop, function()
    return any(
        has("flippers"),
        has("gloves")
    )
end)
catfish_area:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
-- catfish_area:connect_one_way() --glicht to pod






-- pyramid
pyramid:connect_one_way(pod_area)
pyramid:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)



pyramid_fairy_cave:connect_one_way("Pyramid Fairy Left")
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Right")






-- pod_area
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
        has("gloves")
    )
end)










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
dark_death_mountain_left_top:connect_one_way()







-- dark_death_mountain_right_top
dark_death_mountain_right_top:cnnconnect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_death_mountain_right_top:connect_one_way()







-- dark_death_mountain_left_bottom
dark_death_mountain_left_bottom:connnconnect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_death_mountain_left_bottom:connect_one_way()







-- dark_death_mountain_right_bottom
dark_death_mountain_right_bottom:connect_one_way(dark_flute_map, function() 
    return all(
        has("flute"),
        inverted(),
        can_reach(inverted_activate_flute)
    ) 
end)
dark_death_mountain_right_bottom:connect_one_way()






