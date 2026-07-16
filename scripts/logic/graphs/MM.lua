-- MM_entrance = alttp_location.new("", nil, nil, "MM", true)
local MM_pre_gap = alttp_location.new("MM_pre_gap", "MM Main Room", nil, "MM", true)
local MM_post_gap = alttp_location.new("MM_post_gap", "MM Main Room", nil, "MM", true)
local MM_wizrobe_room = alttp_location.new("MM_wizrobe_room", "MM Main Room", nil, "MM", true)
local MM_main_room = alttp_location.new("MM_main_room", "MM Main Room", nil, "MM", true)
local MM_big_chest_room = alttp_location.new("MM_big_chest_room", "MM Big Chest", nil, "MM", true)
local MM_map_room_top_right = alttp_location.new("MM_map_room_top_right", "MM Map Ledge right", nil, "MM", true)
local MM_map_room_top_middle = alttp_location.new("MM_map_room_top_middle", "MM Map Ledge middle", nil, "MM", true)
local MM_map_room_top_left = alttp_location.new("MM_map_room_top_left", "MM Map Ledge left", nil, "MM", true)
local MM_map_room_bottom = alttp_location.new("MM_map_room_bottom", "MM Map Floor", nil, "MM", true)
local MM_conveyor_crystal_room = alttp_location.new("MM_conveyor_crystal_room", "MM Conveyor", nil, "MM", true)
local MM_four_torches_tile_room = alttp_location.new("MM_four_torches_tile_room", "MM 4 Torches & Tiles", nil, "MM", true)
local MM_compass_room = alttp_location.new("MM_compass_room", "MM Compass", nil, "MM", true)
local MM_block_push = alttp_location.new("MM_block_push", "MM Block Push & Torches", nil, "MM", true)
local MM_cutscene_room = alttp_location.new("MM_cutscene_room", "MM Moving Wall", nil, "MM", true)
local MM_big_key_chest = alttp_location.new("MM_big_key_chest", "MM Big Key Chest", nil, "MM", true)
local MM_above_spike_room = alttp_location.new("MM_above_spike_room", "MM Spike Chest", nil, "MM", true)
local MM_spike_room = alttp_location.new("MM_spike_room", "MM Spike Chest", nil, "MM", true)
local MM_fishbone_room = alttp_location.new("MM_fishbone_room", "MM Fishbone", nil, "MM", true)
local MM_bridge_right = alttp_location.new("MM_bridge_right", "MM Bridge Right", nil, "MM", true)
local MM_bridge_middle = alttp_location.new("MM_bridge_middle", "MM Main Bridge", nil, "MM", true)
local MM_big_key_door_room = alttp_location.new("MM_big_key_door_room", "MM Big Key Door", nil, "MM", true)
local MM_hourglas_room = alttp_location.new("MM_hourglas_room", "MM Hourglas", nil, "MM", true)
local MM_teleporter_room = alttp_location.new("MM_teleporter_room", "MM Teleporter", nil, "MM", true)
local MM_boss_room = alttp_location.new("MM_boss_room", "MM Boss Room", nil, "MM", true)

local function CanReachCrystalSwitches()
    return ANY(
        MM_conveyor_crystal_room:accessibility() > 5,
        MM_fishbone_room:accessibility() > 5
    )
end


MM_entrance_inside:connect_two_ways(MM_pre_gap)
MM_pre_gap:connect_two_ways(MM_post_gap, function()
    return ALL(
        ANY(
            "hookshot",
            "boots"
        ),
        CanInteract(MM_pre_gap)
    )
end)
MM_post_gap:connect_two_ways(MM_wizrobe_room)
MM_wizrobe_room:connect_two_ways(MM_main_room, function()
    if Tracker:FindObjectForCode("enemizer").Active and CanInteract(MM_wizrobe_room) then
        return DealDamage()
    else
        return ANY(
            "sword",
            "somaria",
            "bow",
            "hookshot",
            "firerod",
            -- "icerod",
            "hammer"
        )
    end
end)
MM_main_room:connect_two_ways(MM_conveyor_crystal_room,function(keys)
    if Tracker:FindObjectForCode("mm_bigkey").Active then
        return Has("mm_smallkey", keys + 0, 2, keys + CountDoneDeadends(1, "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Boss/Boss Item"), 4), KDSreturn(keys, keys + 1)
    else
        return Has("mm_smallkey", keys + 0, 2, keys + CountDoneDeadends(1, "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 3), KDSreturn(keys, keys + 1)
    end
end)
MM_main_room:connect_two_ways(MM_block_push)

MM_main_room:connect_two_ways(MM_map_room_bottom)
MM_main_room:connect_two_ways(MM_map_room_top_left, function(keys)
    if CanReachCrystalSwitches() >= 5 then
        return Has("mm_smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 2), keys
    else
        return Has("mm_smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 4), keys + 1
    end
end)
MM_main_room:connect_one_way("MM - Main Lobby Chest", function()
    return CanReachCrystalSwitches() >= 5
end)
    -- return MM_conveyor_crystal_room:accessibility() > 5 or Tracker:FindObjectForCode("@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop").AvailableChestCount == 0 end)

MM_map_room_bottom:connect_two_ways(MM_big_chest_room)

MM_big_chest_room:connect_one_way(MM_map_room_top_right)
MM_big_chest_room:connect_one_way("MM - Big Chest", function() return Has("mm_bigkey") end)

MM_map_room_top_right:connect_one_way(MM_map_room_bottom)
MM_map_room_top_middle:connect_two_ways(MM_map_room_top_right, function() 
    return ALL(
        CanReachCrystalSwitches() >= 5,
        CanInteract(MM_conveyor_crystal_room)
    )
end)
MM_map_room_top_middle:connect_two_ways(MM_map_room_top_left, function() 
return ALL(
        CanReachCrystalSwitches() >= 5,
        CanInteract(MM_conveyor_crystal_room)
    )
end)
MM_map_room_top_middle:connect_two_ways(MM_spike_room)
MM_map_room_top_left:connect_one_way("MM - Map Chest")

MM_block_push:connect_two_ways(MM_bridge_right)
MM_block_push:connect_two_ways(MM_spike_room)

MM_bridge_right:connect_one_way("MM - Bridge Chest")

MM_spike_room:connect_two_ways(MM_above_spike_room, function(keys)
    return Has("mm_smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 5), KDSreturn(keys, keys + 1)
end)

MM_spike_room:connect_one_way("MM - Spike Chest", function()
    return ANY(
        CalcHealth() > 3,
        Has("invincibility")
    )
end)
MM_spike_room:connect_one_way("MM - Spike Key Drop")

MM_fishbone_room:connect_one_way(MM_hourglas_room, function(keys)
    if Tracker:FindObjectForCode("mm_bigkey").Active then
        return Has("mm_smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Boss/Boss Item"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Boss/Boss Item", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 5), KDSreturn(keys, keys + 1)
    else
        return Has("mm_smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 4), KDSreturn(keys, keys + 1)
    end
end)
MM_fishbone_room:connect_one_way("MM - Fishbone Key Drop")

MM_hourglas_room:connect_two_ways(MM_main_room)
MM_hourglas_room:connect_two_ways(MM_teleporter_room)
MM_conveyor_crystal_room:connect_two_ways(MM_four_torches_tile_room, function(keys)
    if Tracker:FindObjectForCode("mm_bigkey").Active then
        return Has("mm_smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Boss/Boss Item"), 3, keys + CountDoneDeadends(1, "@Misery Mire/Boss/Boss Item"), 6), KDSreturn(keys, keys + 1)
    else
        return Has("mm_smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Boss/Boss Item"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Boss/Boss Item"), 5), KDSreturn(keys, keys + 1)
    end
end)

MM_four_torches_tile_room:connect_two_ways(MM_compass_room, function() return Has("firesource") end)
MM_four_torches_tile_room:connect_two_ways(MM_cutscene_room)

-- UWG
MM_cutscene_room:connect_one_way(ToH_fairy_drop, function()
    return ALL(
        CheckGlitches(3),
        CanBombClip(MM_cutscene_room),
        "firesource",
        "mm_bigkey"
    )
end) -- mire to hera
MM_cutscene_room:connect_one_way(SP_first_room, function()
    return ALL(
        CheckGlitches(3),
        CanBombClip(MM_cutscene_room),
        "firesource"
    )
end) -- mire to swamp
MM_cutscene_room:connect_one_way(SP_main_room, function()
    return ALL(
        CheckGlitches(3),
        CanBombClip(MM_cutscene_room),
        "firesource"
    )
end) -- mire to swamp center
-- UWG end

MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Key Drop")

MM_compass_room:connect_one_way(MM_main_room)
MM_compass_room:connect_one_way("MM - Comapss Chest")

MM_cutscene_room:connect_one_way(MM_big_key_chest, function() return Has("firesource")end)

MM_big_key_chest:connect_one_way(MM_hourglas_room)
MM_big_key_chest:connect_one_way("MM - Big Key Chest")

MM_teleporter_room:connect_one_way(MM_big_key_door_room, function() return Has("mm_bigkey") end)

MM_above_spike_room:connect_two_ways(MM_fishbone_room)
MM_above_spike_room:connect_two_ways(MM_big_key_door_room)

MM_big_key_door_room:connect_two_ways(MM_bridge_middle, function() return Has("mm_bigkey") end)
MM_bridge_middle:connect_two_ways(MM_boss_room, function(keys)
    return ALL(
        "somaria",
        "bombs",
        DarkRooms,
        Has("mm_smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 3, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 6),
        "mm_bigkey"
    ), keys + 1 -- + 1)
end)

MM_boss_room:connect_one_way("MM - Boss", function() return GetBossRef("mm_boss") end)