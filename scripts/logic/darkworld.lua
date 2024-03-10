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


dark_spawn_big_bomb_shop = alttp_location.new()
dark_spawn_dark_chapel = alttp_location.new()
dark_spawn_old_man = alttp_location.new()

big_bomb_shop = alttp_location.new()
big_bomb_shop:connect_one_way(swamp_area)
big_bomb_shop:connect_one_way(dark_lake_hylia)
big_bomb_shop:connect_one_way(south_of_village_of_the_outcast)
-- big_bomb_shop:connect_one_way(pod_area, function()
--     return has("hammer")
-- end)
big_bomb_shop = alttp_location.new()
big_bomb_shop_fairy = alttp_location.new()

swamp_area = alttp_location.new()
swamp_area:connect_one_way(big_bomb_shop)
swamp_area:connect_one_way(dark_lake_hylia)
-- swamp_area:connect_one_way(desert_area, function() return(all(has("mirror"), canActivateTablets())) end)

hype_cave = alttp_location.new()
hype_cave:connect_one_way("Hype Cave - Generous Guy")
hype_cave:connect_one_way("Hype Cave - Top", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Middle Left", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Middle Right", function() return has("bombs") end)
hype_cave:connect_one_way("Hype Cave - Bottom", function() return has("bombs") end)

mire_area = alttp_location.new()
mire_area:connect_one_way()

mire_shed_left = alttp_location.new()
mire_shed_left:connect_one_way("Mire Shed - Left")
mire_shed_left:connect_one_way("Mire Shed - Right")
mire_shed_right = alttp_location.new()
dark_aghina = alttp_location.new()



dark_lake_hylia = alttp_location.new()
dark_lake_hylia:connect_one_way(big_bomb_shop)
dark_lake_hylia:connect_one_way(ice_palace)
dark_lake_hylia:connect_one_way(dark_icerod_area, function()
    return has("flippers")
end)
dark_lake_hylia:connect_one_way(pod_area, function()
    return any(
        has("hammer"),
        has("flippers")
    )
end)

dark_lake_shop = alttp_location.new()
dark_lake_shop:connect_one_way("Dark Lake Shop Left")
dark_lake_shop:connect_one_way("Dark Lake Shop Center")
dark_lake_shop:connect_one_way("Dark Lake Shop Right")

dark_icerod_area = alttp_location.new()
dark_icerod_area:connect_one_way(dark_lake_hylia, function()
    return has("flippers")
end)

dark_icerod_cave = alttp_location.new()
dark_icerod_fairy = alttp_location.new()
dark_icerod_stone = alttp_location.new()


village_of_the_outcast = alttp_location.new()
village_of_the_outcast:connect_one_way(skull_woods_area)
village_of_the_outcast:connect_one_way(south_of_village_of_the_outcast)

chest_game = alttp_location.new()
chest_game:connect_one_way("Chest Game")
c_shaped_house = alttp_location.new()
c_shaped_house:connect_one_way("C-Shaped House")
dark_village_shop = alttp_location.new()
dark_village_shop:connect_one_way("Village of Outcasts Shop Left")
dark_village_shop:connect_one_way("Village of Outcasts Shop Center")
dark_village_shop:connect_one_way("Village of Outcasts Shop Right")
brewery = alttp_location.new()
brewery:connect_one_way("Brewery Chest")
peg_cave = alttp_location.new()
peg_cave:connect_one_way("Peg-Cave Item")

south_of_village_of_the_outcast = alttp_location.new()
south_of_village_of_the_outcast:connect_one_way(village_of_the_outcast, function()
    return has("titans")
end)
south_of_village_of_the_outcast:connect_one_way(big_bomb_shop)
-- south_of_village_of_the_outcast:connect_one_way(mire_area) -- glitches

archery_minigame = alttp_location.new()


skull_woods_area = alttp_location.new()
skull_woods_area:connect_one_way(village_of_the_outcast)
skull_woods_area:connect_one_way(dark_lumpberjacks)

dark_lumpberjacks = alttp_location.new()
dark_lumpberjacks:connect_one_way(skull_woods_area)
dark_lumpberjacks:connect_one_way(dark_chapel)

dark_lumpberjacks_shop = alttp_location.new()
dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Left")
dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Center")
dark_lumpberjacks_shop:connect_one_way("Dark Lumberjack Shop Right")
red_shield_shop = alttp_location.new()
red_shield_shop:connect_one_way("Red Shield Shop Left")
red_shield_shop:connect_one_way("Red Shield Shop Center")
red_shield_shop:connect_one_way("Red Shield Shop Right")
dark_death_mountain_decent = alttp_location.new()
bumber_cave = alttp_location.new()

dark_chapel = alttp_location.new()
dark_chapel:connect_one_way(dark_lumpberjacks)
dark_chapel:connect_one_way(dark_potion_shop, function()
    return has("flippers")
end)

dark_chapel = alttp_location.new()

dark_potion_shop = alttp_location.new()
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

dark_potion_shop_inside = alttp_location.new()
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Left")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Center")
dark_potion_shop_inside:connect_one_way("Dark Potion Shop Right")


catfish_area = alttp_location.new()
catfish_area:connect_one_way(dark_potion_shop, function()
    return any(
        has("flippers"),
        has("gloves")
    )
end)
-- catfish_area:connect_one_way() --glicht to pod

pyramid = alttp_location.new()
pyramid:connect_one_way(pod_area)

pyramid_inside = alttp_location.new()
pyramid_fairy_cave = alttp_location.new()
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Left")
pyramid_fairy_cave:connect_one_way("Pyramid Fairy Right")

pod_area = alttp_location.new()
pod_area:connect_one_way(pyramid)
pod_area:connect_one_way(dark_potion_shop,function()
    return any(
        has("hammer"),
        has("gloves")
    )
end)

pod_teleport_cave = alttp_location.new()
pod_fairy_cave = alttp_location.new()
kiki_cave = alttp_location.new()

-- ice_palace = alttp_location.new()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()
-- ice_palace:connect_one_way()



-- dark_death_mountain_left_top = alttp_location.new()
-- dark_death_mountain_left_top



-- dark_death_mountain_right_top = alttp_location.new()
-- dark_death_mountain_right_top



-- dark_death_mountain_left_bottom = alttp_location.new()
-- dark_death_mountain_left_bottom



-- dark_death_mountain_right_bottom = alttp_location.new()
-- dark_death_mountain_right_bottom







