function UpdateNPCItemFlagsFromMemorySegment(segment)
    print("UpdateNPCItemFlagsFromMemorySegment")
   
    if not IsInGame() then
        return false
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end

    InvalidateReadCaches()
   
    UpdateSectionChestCountFromByteAndFlag(segment, "@Light Death Mountain Left Bottom/Rescue Old Man/Rescue Old Man", 0x7ef410, 0x01) --?
    UpdateSectionChestCountFromByteAndFlag(segment, "@Dark Death Mountain Left/Rescue Old Man/Rescue Old Man", 0x7ef410, 0x01)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Zora's Domain/King Zora (Scam)", 0x7ef410, 0x02)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Sick Kid/Sick Kid", 0x7ef410, 0x04)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Darkworld Bottom/Stumpy/Stumpy", 0x7ef410, 0x08)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Sahasrahla's Hut/Sahasrahla's Item", 0x7ef410, 0x10)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Darkworld Right/Catfish/Catfish Item", 0x7ef410, 0x20)
    -- 0x40 is unused
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Library/Library Item", 0x7ef410, 0x80)

    UpdateSectionChestCountFromByteAndFlag(segment, "@Light Death Mountain Left Top/Ether Tablet/Ether Tablet", 0x7ef411, 0x01)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Bombos Tablet/Bombos Tablet", 0x7ef411, 0x02)
    -- @todo Find the Location where the Dwarven Smiths check is stored
    UpdateSectionChestCountFromByteAndFlag(segment, "@Darkworld Left/BReadsmiths/Rescue Dwarf", 0x7ef411, 0x04)
    -- 0x08 is no longer relevant
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Lost Woods/Mushroom", 0x7ef411, 0x10)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Potion Shop (Witch Hut)/Deliver Mushroom (Brew Drugs)", 0x7ef411, 0x20, UpdateMushroomStatus)
    -- 0x40 is unused
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Magic Bat/Visit Satan", 0x7ef411, 0x80, UpdateBatIndicatorStatus)

end

function UpdateOverworldEventsFromMemorySegment(segment)
    print("UpdateOverworldEventsFromMemorySegment")
    if not IsInGame() then
        return false
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end

    InvalidateReadCaches()

    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Light Death Mountain Left Bottom/Spectacle Rock Top/Top Item",3)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Light Death Mountain Right/Floating Island/Item on Floating Island",5)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Race/Race",40)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Flute Spot/Flute Spot",42, UpdateShovelIndicatorStatus)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Desert Ledge/Ledge Item",48)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Lake Hylia/Lake Island",53)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Dam/Sunken Treasure",59)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Left/Bumper Cave/Bumper Cave Item",74)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Bumper Cave/Bumper Cave Item",74)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Right/Pyramid Ledge/Pyramid Ledge Item",91)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Darkworld Bottom/Digging Game/Digging Game",104)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Master Sword Pedestal/Pedestal",128)
    UpdateSectionChestCountFromOverworldIndexAndFlag(segment, "@Lightworld/Zora's Domain/Zora Ledge",129)
end

function UpdateRoomsFromMemorySegment(segment)
    print("UpdateRoomsFromMemorySegment")

    if not IsInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        UpdateToggleFromRoomSlot(segment, "ep", { 200, 11 })
        UpdateToggleFromRoomSlot(segment, "dp", { 51, 11 })
        UpdateToggleFromRoomSlot(segment, "toh", { 7, 11 })
        UpdateToggleFromRoomSlot(segment, "pod", { 90, 11 })
        UpdateToggleFromRoomSlot(segment, "sp", { 6, 11 })
        UpdateToggleFromRoomSlot(segment, "sw", { 41, 11 })
        UpdateToggleFromRoomSlot(segment, "tt", { 172, 11 })
        UpdateToggleFromRoomSlot(segment, "ip", { 222, 11 })
        UpdateToggleFromRoomSlot(segment, "mm", { 144, 11 })
        UpdateToggleFromRoomSlot(segment, "tr", { 164, 11 })
        -- todo find correct RAM position for tracking defeat of GT refights
        UpdateToggleFromRoomSlot(segment, "gt", { 78, 11 })
        UpdateToggleFromRoomSlot(segment, "gt_ice", { 28, 11 })
        UpdateToggleFromRoomSlot(segment, "gt_lanmo", { 108, 11 })
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end
-- 255 light DM shop
-- 265 witch shop
-- 274 lake hylia shop, dark dm shop,
-- 271 dark witch shop, dark lumberjack, dark kak, dark lake hylia
-- 272 dark red shield shop
-- 287 light kak shop
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Link's House/Chest"}, { { 0, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Link's House/Chest", "@Darkworld Bottom/Link's House/Chest"}, { { 260, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Kakariko Well/Well Items"}, { { 47, 5 }, { 47, 6 }, { 47, 7 }, { 47, 8 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Kakariko Well/Back Chest"}, { { 47, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Hookshot Cave/Bottom Right Chest"}, { { 60, 7 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Hookshot Cave/remaining Hookshot Chests"}, { { 60, 4 }, { 60, 5 }, { 60, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Secret Passage/Secret Passage Chest"}, { { 85, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Lost Woods - Hideout/Hideout"}, { { 225, 9 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Lumberjacks/Tree"}, { { 226, 9 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Left Bottom/Spectacle Rock inside/Item inside"}, { { 234, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Paradox Cave/Lower"}, { { 239, 4 }, { 239, 5 }, { 239, 6 }, { 239, 7 }, { 239, 8 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Right/Superbunny Cave/Superbunny Chest"}, { { 248, 4 }, { 248, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Spiral Cave/Spiral Cave Item"}, { { 254, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Paradox Cave/Upper"}, { { 255, 4 }, { 255, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Backside Pub/Backside Pub"}, { { 259, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Bottom/Link's House/Chest"}, { { 260, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Sahasrahla's Hut/Back Items"}, { { 261, 4 }, { 261, 5 }, { 261, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Brewery (Glory Hole)/Brewery"}, { { 262, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Chest Game (Money Making Game)/Chest Game"}, { { 262, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Chicken Hut/Chicken Hut"}, { { 264, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Aginah's Cave/Aginah's Cave"}, { { 266, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Dam/Dam Chest"}, { { 267, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Light Death Mountain Right/Mimic Cave/Mimic Cave Chest"}, { { 268, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Swamp/Mire Shed/Shed"}, { { 269, 4 }, { 269, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/King's Tomb/King's Tomb"}, { { 275, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Waterfall Fairy/Chest"}, { { 276, 4 }, { 276, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Right/Big Bomb Fairy/Boom"}, { { 278, 4 }, { 278, 5 } }, UpdateBombIndicatorStatus)
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Dark Death Mountain Left/Spike Cave/Spike Cave Chest"}, { { 279, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Graveyard Ledge/Graveyard Ledge"}, { { 283, 9 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Cave 45/Cave 45"}, { { 283, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/C-Shaped House/C-Shaped House"}, { { 284, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Blind's Hideout/Hideout"}, { { 285, 5 }, { 285, 6 }, { 285, 7 }, { 285, 8 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Blind's Hideout/Back Chest"}, { { 285, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Bottom/Hype Cave/Hype"}, { { 286, 4 }, { 286, 5 }, { 286, 6 }, { 286, 7 }, { 286, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Ice Rod Cave/Ice Rod Chest"}, { { 288, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Mini Moldorm Cave/Mini Moldorm Chest"}, { { 291, 4 }, { 291, 5 }, { 291, 6 }, { 291, 7 }, { 291, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Bonk Pile/Bonk Pile Chest"}, { { 292, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Lightworld/Checkerboard Cave/Checkerboard Cave Item"}, { { 294, 9 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Darkworld Left/Peg Cave/Peg Cave"}, { { 295, 10 } })


    -- Hyrule Castle & Escape
    UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Key Drops"}, { { 113, 10 }, { 114, 10 }, { 128, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Map Chest"}, { { 114, 4 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Zelda's Chest"}, { { 128, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Key Drops"}, { { 33, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Secret Room"}, {  { 17, 4 }, { 17, 5 }, { 17, 6 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@CE/Sanctuary/Sanctuary Chest"}, { { 18, 4 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Boomerang Chest","@Hyrule Castle/Boomerang Chest/Boomerang Chest"}, { { 113, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Boomerang Guard Key Drop/Boomerang Guard Key Drop"}, { { 113, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Map Chest","@Hyrule Castle/Map Chest/Map Chest"}, { { 114, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Map Guard Key Drop/Map Guard Key Drop"}, { { 114, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@HC/Hyrule Castle/Zelda's Chest","@Hyrule Castle/Zelda's Chest/Zelda's Chest"}, { { 128, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle/Big Key Drop/Big Key Drop"}, { { 128, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@CE/Castle Escape/Dark Cross","@Castle Escape/Dark Cross/Dark Cross"}, { { 50, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Key Rat Key Drop/Key Rat Key Drop"}, { { 33, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@Hyrule Castle & Sanctuary/Escape"}, { { 113, 4 },{ 114, 4 },{ 128, 4 },{ 50, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Left/Secret Passage Left"}, {  { 17, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Middle/Secret Passage Middle"}, { { 17, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Castle Escape/Secret Passage Right/Secret Passage Right"}, {  { 17, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@CE/Sanctuary/Sanctuary Chest","@Sanctuary/Sanctuary Chest/Sanctuary Chest"}, { { 18, 4 } })

    -- Agahni's Tower
    UpdateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Key Drops", "@AT-inverted/Agahnim's Tower/Key Drops"}, { { 176, 10 }, { 208, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Front","@Agahnim's Tower/Front/Front", "@AT-inverted/Agahnim's Tower/Front"}, { { 224, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@AT/Agahnim's Tower/Maze Chest","@Agahnim's Tower/Maze Chest/Maze Chest", "@AT-inverted/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Agahnim's Tower/Circle of Pots Key Drop/Circle of Pots Key Drop"}, { { 176, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Agahnim's Tower/Dark Archer Key Drop/Dark Archer Key Drop"}, { { 208, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@AT-inverted/Agahnim's Tower/Room 03"}, { { 224, 4 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@AT-inverted/Agahnim's Tower/Maze Chest"}, { { 208, 4 } })
   
   

    -- Eastern palace
    UpdateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Dungeon Chest"}, { { 185, 4 }, { 168, 4 }, { 169, 4 }, { 170, 4 }, { 184, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Key Drops"}, { { 186, 10 }, { 153, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Dark Square Pot Key/Dark Square Pot Key"}, { { 186, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Dark Eyegore Key Drop/Dark Eyegore Key Drop"}, { { 153, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Compass Chest/Compass Chest"}, { { 168, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Big Chest/Big Chest"}, { { 169, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Map Chest/Map Chest"}, { { 170, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment,  {"@Eastern Palace/Cannonball Chest/Cannonball Chest"}, { { 185, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Eastern Palace/Big Key Chest/Big Key Chest"}, { { 184, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@EP/Eastern Palace/Boss Item", "@Eastern Palace/Boss/Boss Item"}, { { 200, 11 } })

    --Desert Palace
    UpdateSectionChestCountFromRoomSlotList(segment, {"@DP/Desert Palace/Dungeon Chest"}, { { 133, 4 },{ 115, 4 },{ 115, 10 },{ 116, 4 },{ 117, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@DP Back/Desert Palace Back/Key Drops"}, { { 67, 10 }, { 83, 10 }, { 99, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Desert Tiles 2 Pot Key/Desert Tiles 2 Pot Key"}, { { 67, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Beamos Hall Pot Key/Beamos Hall Pot Key"}, { { 83, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace Back/Desert Tiles 1 Pot Key/Desert Tiles 1 Pot Key"}, { { 99, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Compass Chest/Compass Chest"}, { { 133, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Big Chest/Big Chest"}, { { 115, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Torch/Torch"}, { { 115, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Map Chest/Map Chest"}, { { 116, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Desert Palace/Big Key Chest/Big Key Chest"}, { { 117, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@DP Back/Desert Palace Back/Boss Item","@Desert Palace Back/Boss/Boss Item"}, { { 51, 11 } })

    -- Tower of Hera
    UpdateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Lower"}, { { 119, 4 },{ 135, 4 },{ 135, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Upper"}, { { 39, 4 },{ 39, 5 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Boss Item"}, { { 7, 11 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Big Key Chest/Big Key Chest"}, { { 119, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Map Chest/Map Chest"}, { { 135, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Basement Cage/Basement Cage"}, { { 135, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Compass Chest/Compass Chest"}, { { 39, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Tower of Hera/Big Chest/Big Chest"}, { { 39, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@ToH/Tower of Hera/Boss Item","@Tower of Hera/Boss/Boss Item"}, { { 7, 11 } })

    -- Palace of Darkness
    UpdateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Dungeon Chest"}, {
        { 58, 4 },{ 42, 4 },{ 42, 5 },{ 43, 4 },{ 25, 4 },{ 25, 5 },{ 26, 4 },
        { 26, 5 },{ 26, 6 },{ 9, 4 },{ 10, 4 },{ 106, 4 },{ 106, 5 }
    })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Boss Item"}, { { 90, 11 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Big Key Chest/Big Key Chest"}, { { 58, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/The Arena Bridge/Bridge"}, { { 42, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/The Arena Ledge/Ledge"}, { { 42, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Map Chest/Map Chest"}, { { 43, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Maze Top/Dark Maze Top"}, { { 25, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Maze Bottom/Dark Maze Bottom"}, { { 25, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Big Chest/Big Chest"}, { { 26, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Compass Chest/Compass Chest"}, { { 26, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Harmless Hellway/Harmless Hellway"}, { { 26, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Shooter Room/Shooter Room"}, {  { 9, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Stalfos Basement/Stalfos Basement"}, { { 10, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Basement Left/Dark Basement Left"}, {{ 106, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Palace of Darkness/Dark Basement Right/Dark Basement Right"}, {{ 106, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@PoD/Palace of Darkness/Boss Item","@Palace of Darkness/Boss/Boss Item"}, { { 90, 11 } })

    -- Swamp Palace
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Key Drops"}, { { 53, 10 }, { 54, 10 }, { 55, 10 }, { 56, 10 }, { 22, 10 } }) -- entrance
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Waterway Pot Key/Waterway Pot Key"}, { { 22, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Trench 2 Pot Key/Trench 2 Pot Key"}, { { 53, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Hookshot Pot Key/Hookshot Pot Key"}, { { 54, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Trench 1 Pot Key/Trench 1 Pot Key"}, { { 55, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Pot Row Pot Key/Pot Row Pot Key"}, { { 56, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Dungeon Chest"}, { { 55, 4 } }) --bombable wall
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Dungeon Chest"}, {
        { 40, 4 },{ 55, 4 },{ 54, 4 },{ 53, 4 },{ 52, 4 },{ 70, 4 },{ 118, 4 },{ 118, 5 },{ 102, 4 }
    })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Boss Item"}, { { 6, 11 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Entrance/Entrance"}, { { 40, 4 } }) -- entrance
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Map Chest/Map Chest"}, { { 55, 4 } }) --bombable wall
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Big Chest/Big Chest"}, { { 54, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Big Key Chest/Big Key Chest"}, { { 53, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/West Chest/West Chest"}, { { 52, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Compass Chest/Compass Chest"}, { { 70, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Flooded Room Left/Flooded Room Left"}, { { 118, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Flooded Room Right/Flooded Room Right"}, { { 118, 5 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Swamp Palace/Waterfall Room/Waterfall Room"}, { { 102, 4 } })
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SP/Swamp Palace/Boss Item","@Swamp Palace/Boss/Boss Item"}, { { 6, 11 } })

    -- Skull Woods
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Front/Dungeon Chest"}, {
        { 103, 4 },{ 104, 4 },{ 87, 4 },{ 87, 5 },{ 88, 4 },{ 88, 5 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Front/Key Drops", "@Skull Woods Front/West Lobby Pot Key/West Lobby Pot Key"}, { { 86, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Key Drops", "@Skull Woods Back/Spike Corner Key Drop/Spike Corner Key Drop"}, { { 57, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Dungeon Chest"}, { { 89, 4 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Boss Item"}, { { 41, 11 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Compass Chest/Compass Chest"}, { { 103, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Pinball Room/Pinball Room"}, { { 104, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Big Key Chest/Big Key Chest"}, { { 87, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Pot Prison/Pot Prison"}, { { 87, 5 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Big Chest/Big Chest"}, { { 88, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Skull Woods Front/Map Chest/Map Chest"}, { { 88, 5 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Dungeon Chest","@Skull Woods Back/Bridge Room/Bridge Room"}, { { 89, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@SW/Skull Woods Back/Boss Item","@Skull Woods Back/Boss/Boss Item"}, { { 41, 11 } })

    -- Thieves Town
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Front"}, { { 203, 4 }, { 219, 4 }, { 219, 5 }, { 220, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Back"}, { { 101, 4 }, { 69, 4 }, { 68, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Key Drops"}, { { 171, 10}, { 188, 10 } })
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Spike Switch Pot Key/Spike Switch Pot Key"}, { { 171, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Hallway Pot Key/Hallway Pot Key"}, { { 188, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Back"}, { { 68, 4 } }) --big chest
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Boss Item"}, { { 172, 11 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Ambush Chest/Ambush Chest"}, { { 203, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Map Chest/Map Chest"}, { { 219, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Big Key Chest/Big Key Chest"}, { { 219, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Front/Compass Chest/Compass Chest"}, { { 220, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Attic/Attic"}, { { 101, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Blind's Cell/Blind's Cell"}, { { 69, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Thieves Town Back/Big Chest/Big Chest"}, { { 68, 4 } }) --big chest
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TT/Thieves Town/Boss Item","@Thieves Town Back/Boss/Boss Item"}, { { 172, 11 } })

    -- Ice Palace
    UpdateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Dungeon Chest"}, {
        { 174, 4 },{ 158, 4 },{ 126, 4 },{ 95, 4 },{ 63, 4 },{ 46, 4 },{ 31, 4 }
    })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Boss Item"}, { { 222, 11 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Key Drops"}, { { 14, 10 }, { 62, 10 }, { 63, 10 }, { 159, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Jelly Key Drop/Jelly Key Drop"}, { { 14, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Conveyor Key Drop/Conveyor Key Drop"}, { { 62, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Hammer Block Key Drop/Hammer Block Key Drop"}, { { 63, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Many Pots Pot Key/Many Pots Pot Key"}, { { 159, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Iced T Room/Iced T Room"}, { { 174, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Big Chest/Big Chest"}, { { 158, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Freezor Chest/Freezor Chest"}, { { 126, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Spike Room/Spike Room"}, { { 95, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Map Chest/Map Chest"}, { { 63, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Compass Chest/Compass Chest"}, { { 46, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ice Palace/Big Key Chest/Big Key Chest"}, { { 31, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@IP/Ice Palace/Boss Item","@Ice Palace/Boss/Boss Item"}, { { 222, 11 } })

    -- Misery Mire
    UpdateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Dungeon Chest"}, {
        { 162, 4 },{ 179, 4 },{ 193, 4 },{ 194, 4 },{ 195, 4 },{ 195, 5 },{ 209, 4 }
    })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Boss Item"}, { { 144, 11 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Key Drops"}, { { 161, 10 }, { 179, 10 }, { 193, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"}, { { 161, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Spikes Pot Key/Spikes Pot Key"}, { { 179, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop"}, { { 193, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Bridge Chest/Bridge Chest"}, { { 162, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Spike Chest/Spike Chest"}, { { 179, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Compass Chest/Compass Chest"}, { { 193, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Main Lobby/Main Lobby"}, { { 194, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Map Chest/Map Chest"}, { { 195, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Big Chest/Big Chest"}, { { 195, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Misery Mire/Big Key Chest/Big Key Chest"}, { { 209, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@MM/Misery Mire/Boss Item","@Misery Mire/Boss/Boss Item"}, { { 144, 11 } })

    -- @todo: split TR into  completable w/o bosskey
    -- Turtle Rock
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Front/Dungeon Chest"}, {
        { 214, 4 },{ 182, 4 },{ 183, 4 },{ 183, 5 },{ 20, 4 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Dungeon Chest"}, {
       { 213, 4 },{ 213, 5 },{ 213, 6 },{ 213, 7 },{ 36, 4 },{ 4,4 }
    })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Boss Item"}, { { 164, 11 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Front/Key Drops"}, { { 19, 10 }, { 182, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Pokey 1 Key Drop/Pokey 1 Key Drop"}, { { 182, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Pokey 2 Key Drop/Pokey 2 Key Drop"}, { { 19, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Compass Chest/Compass Chest"}, { { 214, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Chain Chomps/Chain Chomps"}, { { 182, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Map Chest/Map Chest"}, { { 183, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Roller Room Right/Roller Room Right"}, { { 183, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Front/Big Key Chest/Big Key Chest"}, { { 20, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Top Left/Eye Bridge Top Left"}, { { 213, 4 }, })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Top Right/Eye Bridge Top Right"}, { { 213, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Bottom Left/Eye Bridge Bottom Left"}, { { 213, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Eye Bridge Bottom Right/Eye Bridge Bottom Right"}, { { 213, 7 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Big Chest/Big Chest"}, { { 36, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Turtle Rock Back/Crystalroller Room/Crystalroller Room"}, { { 4,4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@TR/Turtle Rock Back/Boss Item","@Turtle Rock Back/Boss/Boss Item"}, { { 164, 11 } })
   
    -- @todo: split GT into right/left side
    -- Ganon's Tower
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Key Drops", "@GT-inverted/Ganon's Tower/Key Drops"}, {
        { 138, 10 }, { 155, 10 }, { 61, 10 }, { 123, 10 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Leftside"}, {
        { 140, 10 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 },
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Leftside"}, {
        { 140, 10 }, { 125, 4 }, { 124, 4 }, { 124, 5 }, { 124, 6 }, { 124, 7 },
        { 123, 4 }, { 123, 5 }, { 123, 6 }, { 123, 7 }, { 139, 4 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Rightside"}, {
       { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Rightside"}, {
       { 140, 5 }, { 140, 6 }, { 141, 4 }, { 157, 4 }, { 157, 5 }, { 157, 6 }, { 157, 7 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/Big Chest + Ice refight"}, {
       { 140, 7 }, { 140, 4 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {
       { 140, 7 }, { 140, 4 }, { 28, 4 }, { 28, 5 }, { 28, 6 }
    })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 }, { 61, 5 }, { 61, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 }, { 61, 5 }, { 61, 6 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@GT/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@GT-inverted/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Conveyor Cross Pot Key/Conveyor Cross Pot Key"}, {{ 138, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Double Switch Pot Key/Double Switch Pot Key"}, {{ 155, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Key Drop/Mini Helmasaur Key Drop"}, {{ 61, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Conveyor Star Pits Pot Key/Conveyor Star Pits Pot Key"}, {{ 123, 10 } })

    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Bob's Torch/Bob's Torch", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 140, 10 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Firesnake Room/Firesnake Room", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 125, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Top Left/Randomizer Room Top Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Top Right/Randomizer Room Top Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Bottom Left/Randomizer Room Bottom Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Randomizer Room Bottom Right/Randomizer Room Bottom Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 124, 7 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Top Left/DMs Room Top Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Top Right/DMs Room Top Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Bottom Left/DMs Room Bottom Left", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/DMs Room Bottom Right/DMs Room Bottom Right", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 123, 7 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Left/Map Chest/Map Chest", "@GT-inverted/Ganon's Tower/Leftside"}, {{ 139, 4 } })
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Hope Room Left/Hope Room Left", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 140, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Hope Room Right/Hope Room Right", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 140, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Tile Room/Tile Room", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 141, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Chest/Compass Chest", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Top Right/Compass Room Top Right", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Bottom Left/Compass Room Bottom Left", "@GT-inverted/Ganon's Tower/Rightside"}, {{ 157, 6 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Right/Compass Room Bottom Right/Compass Room Bottom Right", "@GT-inverted/Ganon's Tower/Rightside"}, { { 157, 7 } })
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Bob's Chest/Bob's Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 140, 7 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Chest/Big Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 140, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Chest/Big Key Chest", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 4 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Room Left/Big Key Room Left", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 5 }})
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Bottom Refight/Big Key Room Right/Big Key Room Right", "@GT-inverted/Ganon's Tower/Big Chest + Ice refight"}, {{ 28, 6 }})
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Pre-Moldorm Chest/Pre-Moldorm Chest", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 4 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Room Left/Mini Helmasaur Room Left", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 5 } })
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Mini Helmasaur Room Right/Mini Helmasaur Room Right", "@GT-inverted/Ganon's Tower/GT Top + Lanmo refight"}, { { 61, 6 } })
   
    UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower Top/Validation Chest/Validation Chest", "@GT-inverted/Ganon's Tower/GT Top Moldorm refight"}, { { 77, 4 }  })
   
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Ice Boss"}, { { 295, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Lanmo Refight"}, { { 295, 10 } })
    -- UpdateSectionChestCountFromRoomSlotList(segment, {"@Ganon's Tower/Boss"}, { { 295, 10 } })


end

function UpdateItemsFromMemorySegment(segment)
    print("UpdateItemsFromMemorySegment")
    if not IsInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        UpdateProgressiveItemFromByte(segment, "sword",  0x7ef359, 0)
        UpdateProgressiveItemFromByte(segment, "shield", 0x7ef35a, 0)
        UpdateProgressiveItemFromByte(segment, "armor",  0x7ef35b, 0)
        UpdateProgressiveItemFromByte(segment, "glove",  0x7ef354, 0)

        UpdateToggleItemFromByte(segment, "hookshot",   0x7ef342)
        UpdateToggleItemFromByte(segment, "bombs",      0x7ef343)
        UpdateToggleItemFromByte(segment, "firerod",    0x7ef345)
        UpdateToggleItemFromByte(segment, "icerod",     0x7ef346)
        UpdateToggleItemFromByte(segment, "bombos",     0x7ef347)
        UpdateToggleItemFromByte(segment, "ether",      0x7ef348)
        UpdateToggleItemFromByte(segment, "quake",      0x7ef349)
        UpdateToggleItemFromByte(segment, "lamp",       0x7ef34a)
        UpdateToggleItemFromByte(segment, "hammer",     0x7ef34b)
        UpdateToggleItemFromByte(segment, "bug_net",    0x7ef34d)
        UpdateToggleItemFromByte(segment, "book",       0x7ef34e)
        UpdateToggleItemFromByte(segment, "somaria",    0x7ef350)
        UpdateToggleItemFromByte(segment, "byrna",      0x7ef351)
        UpdateToggleItemFromByte(segment, "cape",       0x7ef352)
        UpdateToggleItemFromByte(segment, "boots",      0x7ef355)
        UpdateToggleItemFromByte(segment, "flippers",   0x7ef356)
        UpdateToggleItemFromByte(segment, "pearl",      0x7ef357)
        UpdateToggleItemFromByte(segment, "half_magic", 0x7ef37b)

        UpdateToggleItemFromByteAndFlag(segment, "blueboomerang", 0x7ef38c, 0x80) -- blue banana
        UpdateToggleItemFromByteAndFlag(segment, "redboomerang",  0x7ef38c, 0x40) --  red banana
        UpdateToggleItemFromByteAndFlag(segment, "shovel", 0x7ef38c, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "powder", 0x7ef38c, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "mushroom", 0x7ef38c, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "mirror", 0x7ef353, 0x02)

        UpdateProgressiveBow(segment)
        UpdateBottles(segment)
        UpdateFlute(segment)
        UpdateAga1(segment)

        UpdateToggleItemFromByteAndFlag(segment, "gt_bigkey",  0x7ef366, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "tr_bigkey",  0x7ef366, 0x08)
        UpdateToggleItemFromByteAndFlag(segment, "tt_bigkey",  0x7ef366, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "toh_bigkey", 0x7ef366, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "ip_bigkey",  0x7ef366, 0x40)
        UpdateToggleItemFromByteAndFlag(segment, "sw_bigkey",  0x7ef366, 0x80)
        UpdateToggleItemFromByteAndFlag(segment, "mm_bigkey",  0x7ef367, 0x01)
        UpdateToggleItemFromByteAndFlag(segment, "pod_bigkey", 0x7ef367, 0x02)
        UpdateToggleItemFromByteAndFlag(segment, "sp_bigkey",  0x7ef367, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "dp_bigkey",  0x7ef367, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "ep_bigkey",  0x7ef367, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "hc_bigkey",  0x7ef367, 0x40)

        UpdateToggleItemFromByteAndFlag(segment, "gt_map",  0x7ef368, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "tr_map",  0x7ef368, 0x08)
        UpdateToggleItemFromByteAndFlag(segment, "tt_map",  0x7ef368, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "toh_map", 0x7ef368, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "ip_map",  0x7ef368, 0x40)
        UpdateToggleItemFromByteAndFlag(segment, "sw_map",  0x7ef368, 0x80)
        UpdateToggleItemFromByteAndFlag(segment, "mm_map",  0x7ef369, 0x01)
        UpdateToggleItemFromByteAndFlag(segment, "pod_map", 0x7ef369, 0x02)
        UpdateToggleItemFromByteAndFlag(segment, "sp_map",  0x7ef369, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "dp_map",  0x7ef369, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "ep_map",  0x7ef369, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "hc_map",  0x7ef369, 0x40)

        UpdateToggleItemFromByteAndFlag(segment, "gt_compass",  0x7ef364, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "tr_compass",  0x7ef364, 0x08)
        UpdateToggleItemFromByteAndFlag(segment, "tt_compass",  0x7ef364, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "toh_compass", 0x7ef364, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "ip_compass",  0x7ef364, 0x40)
        UpdateToggleItemFromByteAndFlag(segment, "sw_compass",  0x7ef364, 0x80)
        UpdateToggleItemFromByteAndFlag(segment, "mm_compass",  0x7ef365, 0x01)
        UpdateToggleItemFromByteAndFlag(segment, "pod_compass", 0x7ef365, 0x02)
        UpdateToggleItemFromByteAndFlag(segment, "sp_compass",  0x7ef365, 0x04)
        UpdateToggleItemFromByteAndFlag(segment, "dp_compass",  0x7ef365, 0x10)
        UpdateToggleItemFromByteAndFlag(segment, "ep_compass",  0x7ef365, 0x20)
        UpdateToggleItemFromByteAndFlag(segment, "hc_compass",  0x7ef365, 0x40)
        -- UpdateToggleItemFromByteAndFlag(segment, "hc_compass",  0x7ef365, 0x40)
     
    end

    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return true
    end

    --  It may seem unintuitive, but these locations are controlled by flags stored adjacent to the item data,
    --  which makes it more efficient to Update them here.
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Secret Passage/Link's Uncle", 0x7ef3c6, 0x01)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Hobo/Hobo", 0x7ef3c9, 0x01)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Lightworld/Bottle Merchant/Bottle Merchant Item", 0x7ef3c9, 0x02)
    UpdateSectionChestCountFromByteAndFlag(segment, "@Darkworld Bottom/Purple Chest Return/Purple Chest Return", 0x7ef3c9, 0x10)

end

function UpdateChestKeysFromMemorySegment(segment)
    print("UpdateChestKeysFromMemorySegment")
    if not IsInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        --0x7ef37c-0x7ef389 shows only current keys in invetory
        -- if Tracker:FindObjectForCode("key_drop_shuffle").Active == true then
        --     UpdateConsumableItemFromByte(segment, "live_hc_smallkey", 0x7ef37c)
        --     UpdateConsumableItemFromByte(segment, "live_ep_smallkey", 0x7ef37e)
        --     UpdateConsumableItemFromByte(segment, "live_dp_smallkey", 0x7ef37f)
        --     UpdateConsumableItemFromByte(segment, "live_at_smallkey", 0x7ef380)
        --     UpdateConsumableItemFromByte(segment, "live_sp_smallkey", 0x7ef381)
        --     UpdateConsumableItemFromByte(segment, "live_pod_smallkey",0x7ef382)
        --     UpdateConsumableItemFromByte(segment, "live_mm_smallkey", 0x7ef383)
        --     UpdateConsumableItemFromByte(segment, "live_sw_smallkey", 0x7ef384)
        --     UpdateConsumableItemFromByte(segment, "live_ip_smallkey", 0x7ef385)
        --     UpdateConsumableItemFromByte(segment, "live_toh_smallkey",0x7ef386)
        --     UpdateConsumableItemFromByte(segment, "live_tt_smallkey", 0x7ef387)
        --     UpdateConsumableItemFromByte(segment, "live_tr_smallkey", 0x7ef388)
        --     UpdateConsumableItemFromByte(segment, "live_gt_smallkey", 0x7ef389)
        -- else
            -- Pending small key from chests tracking Update
            -- Sewers is unused by the game - this is here for reference sake
            -- UpdateConsumableItemFromByte(segment, "sewers_smallkey",  0x7ef4e0)
            UpdateConsumableItemFromTwoByteSum(segment, "hc_smallkey", 0x7ef4e0, 0x7ef4e1, {  })
            UpdateConsumableItemFromByte(segment, "ep_smallkey",  0x7ef4e2, {  })
            UpdateConsumableItemFromByte(segment, "dp_smallkey",  0x7ef4e3, {  })
            UpdateConsumableItemFromByte(segment, "at_smallkey",  0x7ef4e4, {  })
            UpdateConsumableItemFromByte(segment, "sp_smallkey",  0x7ef4e5, {  })
            UpdateConsumableItemFromByte(segment, "pod_smallkey", 0x7ef4e6, {  })
            UpdateConsumableItemFromByte(segment, "mm_smallkey",  0x7ef4e7, {  })
            UpdateConsumableItemFromByte(segment, "sw_smallkey",  0x7ef4e8, {  })
            UpdateConsumableItemFromByte(segment, "ip_smallkey",  0x7ef4e9, {  })
            UpdateConsumableItemFromByte(segment, "toh_smallkey", 0x7ef4ea, {  })
            UpdateConsumableItemFromByte(segment, "tt_smallkey",  0x7ef4eb, {  })
            UpdateConsumableItemFromByte(segment, "tr_smallkey",  0x7ef4ec, {  })
            UpdateConsumableItemFromByte(segment, "gt_smallkey",  0x7ef4ed, {  })
        -- end
            UpdateConsumableItemFromTwoByteSum(segment, "hc_smallkey_drop", 0x7ef4e0, 0x7ef4e1, { { 113, 10 }, { 114, 10 }, { 33, 10 } })
            UpdateConsumableItemFromByte(segment, "ep_smallkey_drop",  0x7ef4e2, { { 186, 10 }, { 153, 10 } })
            UpdateConsumableItemFromByte(segment, "dp_smallkey_drop",  0x7ef4e3, { { 67, 10 }, { 83, 10 }, { 99, 10 } })
            UpdateConsumableItemFromByte(segment, "at_smallkey_drop",  0x7ef4e4, { { 176, 10 }, { 208, 10 } })
            UpdateConsumableItemFromByte(segment, "sp_smallkey_drop",  0x7ef4e5, { { 53, 10 }, { 54, 10 }, { 55, 10 }, { 56, 10 }, { 22, 10 } })
            UpdateConsumableItemFromByte(segment, "pod_smallkey_drop", 0x7ef4e6, {  })
            UpdateConsumableItemFromByte(segment, "mm_smallkey_drop",  0x7ef4e7, { { 161, 10 }, { 179, 10 }, { 193, 10 } })
            UpdateConsumableItemFromByte(segment, "sw_smallkey_drop",  0x7ef4e8, { { 86, 10 }, { 57, 10 } })
            UpdateConsumableItemFromByte(segment, "ip_smallkey_drop",  0x7ef4e9, { { 14, 10 }, { 62, 10 }, { 63, 10 }, { 159, 10 } })
            UpdateConsumableItemFromByte(segment, "toh_smallkey_drop", 0x7ef4ea, {  })
            UpdateConsumableItemFromByte(segment, "tt_smallkey_drop",  0x7ef4eb, { { 171, 10}, { 188, 10 } })
            UpdateConsumableItemFromByte(segment, "tr_smallkey_drop",  0x7ef4ec, { { 19, 10 }, { 182, 10 } })
            UpdateConsumableItemFromByte(segment, "gt_smallkey_drop",  0x7ef4ed, { { 138, 10 }, { 155, 10 }, { 61, 10 }, { 123, 10 } })
    end
end

function UpdateHeartPiecesFromMemorySegment(segment)
    print("UpdateHeartPiecesFromMemorySegment")
    if not IsInGame() then
        return false
    end
   
    -- containers.AcquiredCount = maxHealth - (pieces.AcquiredCount // 4)
   

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        UpdateConsumableItemFromByte(segment, "heartpieces", 0x7ef448, {})
        local pieces = Tracker:FindObjectForCode("heartpieces") --[[@as JsonItem]]
        pieces.CurrentStage = pieces.AcquiredCount % 4
    end
end

function UpdateHeartContainersFromMemorySegment(segment)
    print("UpdateHeartContainersFromMemorySegment")
    if not IsInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

        local pieces = Tracker:FindObjectForCode("heartpieces")
        local containers = Tracker:FindObjectForCode("heartcontainer")

        if pieces and containers then
           
            local maxHealth = (ReadU8(segment, 0x7ef36c) // 8) - 3
           
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print("Pieces: ", pieces.AcquiredCount)
                print("Max Health: ", maxHealth)
            end

            containers.AcquiredCount = maxHealth - (pieces.AcquiredCount // 4)
            pieces.CurrentStage = pieces.AcquiredCount % 4
        end
    end
end

ScriptHost:AddMemoryWatch("LTTP Overworld Event Data", 0x7ef280, 0x82, UpdateOverworldEventsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP NPC Item Data", 0x7ef410, 2, UpdateNPCItemFlagsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Heart Piece Data", 0x7ef448, 1, UpdateHeartPiecesFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Heart Container Data", 0x7ef36c, 1, UpdateHeartContainersFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, UpdateItemsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Room Data", 0x7ef000, 0x250, UpdateRoomsFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Chest Key Data", 0x7ef4e0, 32, UpdateChestKeysFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Keydrop Data", 0x7ef37c, 32, UpdateChestKeysFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Room Keydrop Data", 0x7ef000, 0x250, UpdateChestKeysFromMemorySegment)
ScriptHost:AddMemoryWatch("LTTP Upgrade Updater", 0x7ef370, 2, UpdateBowAndBombUpgrade)