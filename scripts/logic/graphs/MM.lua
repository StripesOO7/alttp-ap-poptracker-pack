-- MM_entrance = alttp_location.new("", nil, nil, "MM", true)
local MM_pre_gap = alttp_location.new("MM_pre_gap", "MM Main Room", nil, "MM", true)
local MM_post_gap = alttp_location.new("MM_post_gap", "MM Main Room", nil, "MM", true)
local MM_wizrobe_room = alttp_location.new("MM_wizrobe_room", "MM Main Room", nil, "MM", true)
local MM_main_room = alttp_location.new("MM_main_room", "MM Main Room", nil, "MM", true)
local MM_big_chest_room_top = alttp_location.new("MM_big_chest_room_top", "MM Big Chest Top", nil, "MM", true)
local MM_big_chest_room_bottom = alttp_location.new("MM_big_chest_room_bottom", "MM Big Chest Bottom", nil, "MM", true)
local MM_map_room_top_right = alttp_location.new("MM_map_room_top_right", "MM Map Ledge right", nil, "MM", true)
local MM_map_room_top_middle = alttp_location.new("MM_map_room_top_middle", "MM Map Ledge middle", nil, "MM", true)
local MM_map_room_top_left = alttp_location.new("MM_map_room_top_left", "MM Map Ledge left", nil, "MM", true)
local MM_map_room_bottom = alttp_location.new("MM_map_room_bottom", "MM Map Floor", nil, "MM", true)
local MM_conveyor_crystal_room = alttp_location.new("MM_conveyor_crystal_room", "MM Conveyor", nil, "MM", true)
local MM_four_torches_tile_room = alttp_location.new("MM_four_torches_tile_room", "MM 4 Torches & Tiles", nil, "MM", true)
local MM_compass_room = alttp_location.new("MM_compass_room", "MM Compass", nil, "MM", true)
local MM_cutscene_room = alttp_location.new("MM_cutscene_room", "MM Moving Wall", nil, "MM", true)
local MM_big_key_chest = alttp_location.new("MM_big_key_chest", "MM Big Key Chest", nil, "MM", true)
local MM_above_spike_room = alttp_location.new("MM_above_spike_room", "MM Spike Chest", nil, "MM", true)
local MM_spike_room = alttp_location.new("MM_spike_room", "MM Spike Chest", nil, "MM", true)
local MM_fishbone_room = alttp_location.new("MM_fishbone_room", "MM Fishbone", nil, "MM", true)
local MM_bridge_right = alttp_location.new("MM_bridge_right", "MM Bridge Right", nil, "MM", true)
local MM_bridge_middle = alttp_location.new("MM_bridge_middle", "MM Main Bridge", nil, "MM", true)
local MM_big_key_door_room = alttp_location.new("MM_big_key_door_room", "MM Big Key Door", nil, "MM", true)
local MM_hourglas_room = alttp_location.new("MM_hourglas_room", "MM Hourglas", nil, "MM", true)
local MM_lonely_teleporter_room = alttp_location.new("MM_lonely_teleporter_room", "MM Teleporter", nil, "MM", true)
local MM_boss_room = alttp_location.new("MM_boss_room", "MM Boss Room", nil, "MM", true)

local function CanReachCrystalSwitches()
    return ANY(
        MM_conveyor_crystal_room:accessibility() > 5,
        MM_fishbone_room:accessibility() > 5
    )
end

local MM_lobby = alttp_location.new("MM_lobby", "MM lobby")
local MM_map_room_center_bridge = alttp_location.new("MM_map_room_center_bridge", "MM map room center bridge")
local MM_bomb_slug_room = alttp_location.new("MM_bomb_slug_room", "MM bomb slug room")
local MM_square_rail = alttp_location.new("MM_square_rail", "MM square rail")
local MM_2_torches_hidden_shooter = alttp_location.new("MM_2_torches_hidden_shooter", "MM 2 torches hidden shooter")
local MM_big_key_door_room_bridge_NS = alttp_location.new("MM_big_key_door_room_bridge_NS", "MM Big Key Door Room Bridge NS")
local MM_bridge_EW = alttp_location.new("MM_bridge_EW", "MM bridge EW")
local MM_bent_bridge = alttp_location.new("MM_bent_bridge", "MM bent bridge")
local MM_wizzrobe_bypass = alttp_location.new("MM_wizzrobe_bypass", "MM wizzrobe_ ypass")
local MM_neglected_room = alttp_location.new("MM_neglected_room", "MM neglected room")
local MM_chest_view = alttp_location.new("MM_chest_view", "MM chest view")
local MM_conveyor_bomb_slug_room = alttp_location.new("MM_conveyor_bomb_slug_room", "MM conveyor bomb slug room")
local MM_torches_top = alttp_location.new("MM_torches_top", "MM torches top")
local MM_torches_bottom = alttp_location.new("MM_torches_bottom", "MM torches bottom")
local MM_big_key_chest_teleporter_room = alttp_location.new("MM_big_key_chest_teleporter_room", "MM big key chest teleporter room")
local MM_dark_shooters = alttp_location.new("MM_dark_shooters", "MM dark shooters")
local MM_dark_key_rupees = alttp_location.new("MM_dark_key_rupees", "MM dark key rupees")
local MM_block_X = alttp_location.new("MM_block_X", "MM block_X")
local MM_tall_dark_and_roomy = alttp_location.new("MM_tall_dark_and_roomy", "MM tall dark and roomy")
local MM_crystal_right = alttp_location.new("MM_crystal_right", "MM crystal right")
local MM_crystal_middle = alttp_location.new("MM_crystal_middle", "MM crystal middle")
local MM_crystal_left = alttp_location.new("MM_crystal_left", "MM crystal Left")
local MM_shooter_rupees = alttp_location.new("MM_shooter_rupees", "MM Shooter rupees")
local MM_falling_foes = alttp_location.new("MM_falling_foes", "MM fallin _foes")
local MM_antechamber_left = alttp_location.new("MM_antechamber_left", "MM antechamber left")
local MM_antechamber_right = alttp_location.new("MM_antechamber_right", "MM antechamber right")

MM_post_gap_4N_door = alttp_location.new("MM_post_gap_4N_door", "MM post gap 4N door", nil, "", true, 152, 4488, 4488, 4900, 4915, {"Misery Mire Doors", "MM post gap 4N door", "MM post gap 4N door"})
MM_wizrobe_room_4N_door = alttp_location.new("MM_wizrobe_room_4N_door", "MM wizrobe room 4N door", nil, "", true, 210, 1410, 1420, 6960, 6970, {"Misery Mire Doors", "MM wizrobe room 4N door", "MM wizrobe room 4N door"})
MM_wizrobe_room_2N_door = alttp_location.new("MM_wizrobe_room_2N_door", "MM wizrobe room 2N door", nil, "", true, 210, 1400, 1400, 6640, 6690, {"Misery Mire Doors", "MM wizrobe room 2N door", "MM wizrobe room 2N door"})
MM_main_room_1N_door = alttp_location.new("MM_main_room_1N_door", "MM main room 1N door", nil, "", true, 194, 1144, 1144, 6125, 6170, {"Misery Mire Doors", "MM main room 1N door", "MM main room 1N door"})
MM_main_room_1W_door = alttp_location.new("MM_main_room_1W_door", "MM main room 1W door", nil, "", true, 194, 1005, 1055, 6264, 6264, {"Misery Mire Doors", "MM main room 1W door", "MM main room 1W door"})
MM_main_room_2N_door = alttp_location.new("MM_main_room_2N_door", "MM main room 2N door", nil, "", true, 194, 1400, 1400, 6125, 6170, {"Misery Mire Doors", "MM main room 2N door", "MM main room 2N door"})
MM_main_room_2E_door = alttp_location.new("MM_main_room_2E_door", "MM main room 2E door", nil, "", true, 194, 1500, 1540, 6264, 6264, {"Misery Mire Doors", "MM main room 2E door", "MM main room 2E door"})
MM_main_room_E_door = alttp_location.new("MM_main_room_E_door", "MM main room E door", nil, "", true, 194, 1500, 1540, 6392, 6392, {"Misery Mire Doors", "MM main room E door", "MM main room E door"})
MM_main_room_3W_door = alttp_location.new("MM_main_room_3W_door", "MM main room 3W door", nil, "", true, 194, 1005, 1055, 6520, 6520, {"Misery Mire Doors", "MM main room 3W door", "MM main room 3W door"})
MM_main_room_4E_door = alttp_location.new("MM_main_room_4E_door", "MM main room 4E door", nil, "", true, 194, 1500, 1540, 6520, 6520, {"Misery Mire Doors", "MM main room 4E door", "MM main room 4E door"})
MM_main_room_4S_door = alttp_location.new("MM_main_room_4S_door", "MM main room 4S door", nil, "", true, 194, 1400, 1400, 6610, 6680, {"Misery Mire Doors", "MM main room 4S door", "MM main room 4S door"})
MM_map_room_top_middle_1N_door = alttp_location.new("MM_map_room_top_middle_1N_door", "MM map room top middle 1N door", nil, "", true, 195, 1656, 1656, 6125, 6190, {"Misery Mire Doors", "MM map room top middle 1N door", "MM map room top middle 1N door"})
MM_map_room_top_left_1W_door = alttp_location.new("MM_map_room_top_left_1W_door", "MM map room top_left 1W door", nil, "", true, 195, 1515, 1560, 6264, 6264, {"Misery Mire Doors", "MM map room top_left 1W door", "MM map room top_left 1W door"})
MM_map_room_bottom_3W_door = alttp_location.new("MM_map_room_bottom_3W_door", "MM map room bottom 3W door", nil, "", true, 195, 1515, 1560, 6520, 6520, {"Misery Mire Doors", "MM map room bottom 3W door", "MM map room bottom 3W door"})
MM_map_room_center_bridge_W_door = alttp_location.new("MM_map_room_center_bridge_W_door", "MM map room center bridge W door", nil, "", true, 195, 1515, 1560, 6392, 6392, {"Misery Mire Doors", "MM map room center bridge W door", "MM map room center bridge W door"})
MM_conveyor_crystal_room_4E_door = alttp_location.new("MM_conveyor_crystal_room_4E_door", "MM conveyor crystal room 4E door", nil, "", true, 193, 995, 1030, 6520, 6520, {"Misery Mire Doors", "MM conveyor crystal room 4E door", "MM conveyor crystal room 4E door"})
MM_conveyor_crystal_room_4S_door = alttp_location.new("MM_conveyor_crystal_room_4S_door", "MM conveyor crystal room 4S door", nil, "", true, 193, 888, 888, 6605, 6680, {"Misery Mire Doors", "MM conveyor crystal room 4S door", "MM conveyor crystal room 4S door"})
MM_neglected_room_2N_door = alttp_location.new("MM_neglected_room_2N_door", "MM neglected room 2N door", nil, "", true, 209, 888, 888, 6640, 6700, {"Misery Mire Doors", "MM neglected room 2N door", "MM neglected room 2N door"})
MM_four_torches_tile_room_3S_door = alttp_location.new("MM_four_torches_tile_room_3S_door", "MM four torches tile room 3S door", nil, "", true, 193, 632, 632, 6610, 6680, {"Misery Mire Doors", "MM four torches tile room 3S door", "MM four torches tile room 3S door"})
MM_bomb_slug_room_3S_door = alttp_location.new("MM_bomb_slug_room_3S_door", "MM bomb slug room 3S door", nil, "", true, 178, 1144, 1144, 6090, 6170, {"Misery Mire Doors", "MM bomb slug room 3S door", "MM bomb slug room 3S door"})
MM_spike_room_3W_door = alttp_location.new("MM_spike_room_3W_door", "MM spike room 3W door", nil, "", true, 179, 1520, 1555, 6008, 6008, {"Misery Mire Doors", "MM spike room 3W door", "MM spike room 3W door"})
MM_spike_room_3S_door = alttp_location.new("MM_spike_room_3S_door", "MM spike room 3S door", nil, "", true, 179, 1656, 1656, 6105, 6170, {"Misery Mire Doors", "MM spike room 3S door", "MM spike room 3S door"})
MM_2_torches_hidden_shooter_4E_door = alttp_location.new("MM_2_torches_hidden_shooter_4E_door", "MM 2 torches hidden shooter 4E door", nil, "", true, 178, 1510, 1540, 6008, 6008, {"Misery Mire Doors", "MM 2 torches hidden shooter 4E door", "MM 2 torches hidden shooter 4E door"})
MM_2_torches_hidden_shooter_4S_door = alttp_location.new("MM_2_torches_hidden_shooter_4S_door", "MM 2 torches hidden shooter 4S door", nil, "", true, 178, 1400, 1400, 6090, 6170, {"Misery Mire Doors", "MM 2 torches hidden shooter 4S door", "MM 2 torches hidden shooter 4S door"})
MM_big_keydoor_room_bridge_NS_2N_door = alttp_location.new("MM_big_keydoor_room_bridge_NS_2N_door", "MM Big Key Door Room Bridge NS 2N door", nil, "", true, 178, 1400, 1400, 5615, 5675, {"Misery Mire Doors", "MM Big Key Door Room Bridge NS 2N door", "MM Big Key Door Room Bridge NS 2N door"})
MM_above_spike_room_1N_door = alttp_location.new("MM_above_spike_room_1N_door", "MM above spike room 1N door", nil, "", true, 179, 1656, 1656, 5610, 5670, {"Misery Mire Doors", "MM above spike room 1N door", "MM above spike room 1N door"})
MM_above_spike_room_1W_door = alttp_location.new("MM_above_spike_room_1W_door", "MM above spike room 1W door", nil, "", true, 179, 1520, 1570, 5752, 5752, {"Misery Mire Doors", "MM above spike room 1W door", "MM above spike room 1W door"})
MM_big_keydoor_room_N_door = alttp_location.new("MM_big_keydoor_room_N_door", "MM big key door room N door", nil, "", true, 178, 1272, 1272, 5610, 5665, {"Misery Mire Doors", "MM big key door room N door", "MM big key door room N door"})
MM_big_keydoor_room_2E_door = alttp_location.new("MM_big_keydoor_room_2E_door", "MM big key door room 2E door", nil, "", true, 178, 1490, 1545, 5752, 5752, {"Misery Mire Doors", "MM big key door room 2E door", "MM big key door room 2E door"})
MM_bridge_right_4S_door = alttp_location.new("MM_bridge_right_4S_door", "MM bridge right 4S door", nil, "", true, 162, 1400, 1400, 5575, 5655, {"Misery Mire Doors", "MM bridge right 4S door", "MM bridge right 4S door"})
MM_bridge_middle_N_door = alttp_location.new("MM_bridge_middle_N_door", "MM bridge_middle N door", nil, "", true, 162, 1272, 1272, 5170, 5195, {"Misery Mire Doors", "MM bridge_middle N door", "MM bridge_middle N door"})
MM_bridge_middle_S_door = alttp_location.new("MM_bridge_middle_S_door", "MM bridge middle S door", nil, "", true, 162, 1272, 1272, 5590, 5655, {"Misery Mire Doors", "MM bridge middle S door", "MM bridge middle S door"})
MM_bridge_EW_E_door = alttp_location.new("MM_bridge_EW_E_door", "MM bridge EW E door", nil, "", true, 162, 1495, 1545, 5368, 5368, {"Misery Mire Doors", "MM bridge EW E door", "MM bridge EW E door"})
MM_bridge_EW_W_door = alttp_location.new("MM_bridge_EW_W_door", "MM bridge EW W door", nil, "", true, 162, 1005, 1050, 5368, 5368, {"Misery Mire Doors", "MM bridge EW W door", "MM bridge EW W door"})
MM_bent_bridge_W_door = alttp_location.new("MM_bent_bridge_W_door", "MM bent bridge W door", nil, "", true, 163, 1515, 1565, 5368, 5368, {"Misery Mire Doors", "MM bent bridge W door", "MM bent bridge W door"})
MM_bent_bridge_3S_door = alttp_location.new("MM_bent_bridge_3S_door", "MM bent bridge 3S door", nil, "", true, 163, 1656, 1656, 5580, 5655, {"Misery Mire Doors", "MM bent bridge 3S door", "MM bent bridge 3S door"})
MM_fishbone_room_E_door = alttp_location.new("MM_fishbone_room_E_door", "MM fishbone room E door", nil, "", true, 161, 990, 1030, 5368, 5368, {"Misery Mire Doors", "MM fishbone room E door", "MM fishbone room E door"})
MM_fishbone_room_4S_door = alttp_location.new("MM_fishbone_room_4S_door", "MM fishbone room 4S door", nil, "", true, 161, 888, 888, 5585, 5650, {"Misery Mire Doors", "MM fishbone room 4S door", "MM fishbone room 4S door"})
MM_hourglas_room_2N_door = alttp_location.new("MM_hourglas_room_2N_door", "MM hourglas room 2N door", nil, "", true, 177, 888, 888, 5610, 5680, {"Misery Mire Doors", "MM hourglas room 2N door", "MM hourglas room 2N door"})
MM_hourglas_room_4S_door = alttp_location.new("MM_hourglas_room_4S_door", "MM hourglas room 4S door", nil, "", true, 177, 888, 888, 6090, 6170, {"Misery Mire Doors", "MM hourglas room 4S door", "MM hourglas room 4S door"})
MM_wizzrobe_bypass_2E_door = alttp_location.new("MM_wizzrobe_bypass_2E_door", "MM wizzrobe bypass 2E door", nil, "", true, 193, 985, 1030, 6264, 6264, {"Misery Mire Doors", "MM wizzrobe bypass 2E door", "MM wizzrobe bypass 2E door"})
MM_wizzrobe_bypass_2N_door = alttp_location.new("MM_wizzrobe_bypass_2N_door", "MM wizzrobe bypass 2N door", nil, "", true, 193, 888, 888, 6125, 6175, {"Misery Mire Doors", "MM wizzrobe bypass 2N door", "MM wizzrobe bypass 2N door"})
MM_conveyor_bomb_slug_room_N_door = alttp_location.new("MM_conveyor_bomb_slug_room_N_door", "MM conveyor bomb slug room N door", nil, "", true, 209, 632, 632, 6640, 6695, {"Misery Mire Doors", "MM conveyor bomb slug room N door", "MM conveyor bomb slug room N door"})
MM_conveyor_bomb_slug_room_1N_door = alttp_location.new("MM_conveyor_bomb_slug_room_1N_door", "MM conveyor bomb slug room 1N door", nil, "", true, 209, 680, 681, 6685, 6710, {"Misery Mire Doors", "MM conveyor bomb slug room 1N door", "MM conveyor bomb slug room 1N door"})
MM_torches_top_N_door = alttp_location.new("MM_torches_top_N_door", "MM torches top N door", nil, "", true, 151, 3745, 3765, 4645, 4665, {"Misery Mire Doors", "MM torches top N door", "MM torches top N door"})
MM_dark_shooters_N_door = alttp_location.new("MM_dark_shooters_N_door", "MM dark_ hooters N door", nil, "", true, 147, 1784, 1785, 4640, 4675, {"Misery Mire Doors", "MM dark_ hooters N door", "MM dark_ hooters N door"})
MM_block_X_3W_door = alttp_location.new("MM_block_X_3W_door", "MM block X 3W door", nil, "", true, 147, 1515, 1555, 4984, 4984, {"Misery Mire Doors", "MM block X 3W door", "MM block X 3W door"})
MM_tall_dark_and_roomy_4E_door = alttp_location.new("MM_tall_dark_and_roomy_4E_door", "MM tall dark and roomy 4E door", nil, "", true, 146, 1485, 1545, 4984, 4984, {"Misery Mire Doors", "MM tall dark and roomy 4E door", "MM tall dark and roomy 4E door"})
MM_crystal_left_3W_door = alttp_location.new("MM_crystal_left_3W_door", "MM crystal left 3W door", nil, "", true, 146, 995, 1030, 4984, 4984, {"Misery Mire Doors", "MM crystal left 3W door", "MM crystal left 3W door"})
MM_falling_foes_4E_door = alttp_location.new("MM_falling_foes_4E_door", "MM falling foes 4E door", nil, "", true, 145, 1005, 1065, 4984, 4984, {"Misery Mire Doors", "MM falling foes 4E door", "MM falling foes 4E door"})
MM_falling_foes_2N_door = alttp_location.new("MM_falling_foes_2N_door", "MM falling foes 2N door", nil, "", true, 145, 888, 888, 4770, 4790, {"Misery Mire Doors", "MM falling foes 2N door", "MM falling foes 2N door"})
MM_antechamber_left_1N_door = alttp_location.new("MM_antechamber_left_1N_door", "MM antechamber left 1N door", nil, "", true, 160, 376, 376, 5215, 5295, {"Misery Mire Doors", "MM antechamber left 1N door", "MM antechamber left 1N door"})
MM_antechamber_right_2N_door = alttp_location.new("MM_antechamber_right_2N_door", "MM antechamber right 2N door", nil, "", true, 160, 120, 120, 5150, 5210, {"Misery Mire Doors", "MM antechamber right 2N door", "MM antechamber right 2N door"})
MM_boss_room_3S_door = alttp_location.new("MM_boss_room_3S_door", "MM boss room 3S door", nil, "", true, 144, 120, 120, 5130, 5190, {"Misery Mire Doors", "MM boss room 3S door", "MM boss room 3S door"})





MM_entrance_inside:connect_two_ways(MM_lobby)

MM_lobby:connect_one_way("MM - Lobby Enemy #1", function() return DealDamage end)
-- MM_lobby:connect_one_way("MM - Lobby Enemy #2", function() return DealDamage end)
-- MM_lobby:connect_one_way("MM - Lobby Enemy #3", function() return DealDamage end)
-- MM_lobby:connect_one_way("MM - Lobby Enemy #4", function() return DealDamage end)
-- MM_lobby:connect_one_way("MM - Lobby Enemy #5", function() return DealDamage end)

MM_lobby:connect_two_ways(MM_pre_gap)
MM_pre_gap:connect_two_ways(MM_post_gap)
MM_post_gap:connect_two_ways(MM_post_gap_4N_door)

MM_post_gap_4N_door:connect_two_ways_entrance("", MM_wizrobe_room_4N_door)
MM_wizrobe_room_4N_door:connect_two_ways(MM_wizrobe_room)

MM_wizrobe_room:connect_one_way("MM - 2 Enemy #1", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #2", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #3", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #4", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #5", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #6", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #7", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #8", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #9", function() return DealDamage end)
-- MM_wizrobe_room:connect_one_way("MM - 2 Enemy #10", function() return DealDamage end)

MM_wizrobe_room:connect_two_ways(MM_wizrobe_room_2N_door)

MM_wizrobe_room_2N_door:connect_two_ways_entrance("", MM_main_room_4S_door)
MM_main_room_4S_door:connect_two_ways(MM_main_room)

MM_main_room:connect_one_way("MM - Hub Switch Pot #1") --needs switch
MM_main_room:connect_one_way("MM - Hub Right Pot #2")
MM_main_room:connect_one_way("MM - Hub Pot #3")
-- MM_main_room:connect_one_way("MM - Hub Pot #4")
MM_main_room:connect_one_way("MM - Hub Enemy #1", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #2", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #3", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #4", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #5", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #6", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #7", function() return DealDamage end)
-- MM_main_room:connect_one_way("MM - Hub Enemy #8", function() return DealDamage end)

MM_main_room:connect_two_ways(MM_main_room_1N_door)
MM_main_room_1N_door:connect_two_ways_entrance("", MM_bomb_slug_room_3S_door)
MM_bomb_slug_room_3S_door:connect_two_ways(MM_bomb_slug_room)

MM_bomb_slug_room:connect_one_way("MM - Cross Enemy #6", function() return DealDamage end)
-- MM_bomb_slug_room:connect_one_way("MM - Cross Enemy #7", function() return DealDamage end)
-- MM_bomb_slug_room:connect_one_way("MM - Cross Enemy #8", function() return DealDamage end)
-- MM_bomb_slug_room:connect_one_way("MM - Cross Enemy #11", function() return DealDamage end)

MM_main_room:connect_two_ways(MM_main_room_1W_door)
MM_main_room_1W_door:connect_two_ways_entrance("", MM_wizzrobe_bypass_2E_door)
MM_wizzrobe_bypass_2E_door:connect_two_ways(MM_wizzrobe_bypass)

MM_wizzrobe_bypass:connect_one_way("MM - Wizzrobe Bypass Enemy #5", function() return DealDamage end)

MM_wizzrobe_bypass:connect_two_ways(MM_wizzrobe_bypass_2N_door)

MM_wizzrobe_bypass_2N_door:connect_two_ways_entrance("", MM_hourglas_room_4S_door)

MM_main_room:connect_two_ways(MM_main_room_2E_door)
MM_main_room_2E_door:connect_two_ways_entrance("", MM_map_room_top_left_1W_door)
MM_map_room_top_left_1W_door:connect_two_ways(MM_map_room_top_left)

MM_main_room:connect_two_ways(MM_main_room_2N_door)
MM_main_room_2N_door:connect_two_ways_entrance("", MM_2_torches_hidden_shooter_4S_door)
MM_2_torches_hidden_shooter_4S_door:connect_two_ways(MM_2_torches_hidden_shooter)

MM_2_torches_hidden_shooter:connect_one_way("MM - Hidden Shooters Enemy #9", function() return DealDamage end)
-- MM_2_torches_hidden_shooter:connect_one_way("MM - Hidden Shooters Enemy #10", function() return DealDamage end)
-- MM_2_torches_hidden_shooter:connect_one_way("MM - Hidden Shooters Enemy #13", function() return DealDamage end)
-- MM_2_torches_hidden_shooter:connect_one_way("MM - Hidden Shooters Enemy #14", function() return DealDamage end)

MM_2_torches_hidden_shooter:connect_two_ways_stuck(MM_bomb_slug_room, nil, function() return false end)
MM_2_torches_hidden_shooter:connect_two_ways(MM_2_torches_hidden_shooter_4E_door)
MM_2_torches_hidden_shooter_4E_door:connect_two_ways_entrance("", MM_spike_room_3W_door)

MM_spike_room_3W_door:connect_two_ways(MM_spike_room)


MM_spike_room:connect_one_way("MM - Spike Chest", function()
    return ANY(
        CalcHealth() > 3,
        Has("invincibility")
    )
end)

MM_spike_room:connect_one_way("MM - Spike Key Drop")
MM_spike_room:connect_one_way("MM - Spikes Pot #2")
-- MM_spike_room:connect_one_way("MM - Spikes Pot #3")
MM_spike_room:connect_one_way("MM - Spikes Enemy #1", function() return DealDamage end)
-- MM_spike_room:connect_one_way("MM - Spikes Enemy #2", function() return DealDamage end)
-- MM_spike_room:connect_one_way("MM - Spikes Enemy #3", function() return DealDamage end)
-- MM_spike_room:connect_one_way("MM - Spikes Enemy #4", function() return DealDamage end)
-- MM_spike_room:connect_one_way("MM - Spikes Enemy #5", function() return DealDamage end)

MM_spike_room:connect_two_ways(MM_above_spike_room)

MM_above_spike_room:connect_two_ways(MM_big_key_door_room_bridge_NS)

MM_big_key_door_room_bridge_NS:connect_two_ways(MM_big_keydoor_room_bridge_NS_2N_door)
MM_big_keydoor_room_bridge_NS_2N_door:connect_two_ways_entrance("", MM_bridge_right_4S_door)
MM_bridge_right_4S_door:connect_two_ways(MM_bridge_right)

MM_spike_room:connect_two_ways(MM_spike_room_3S_door)
MM_spike_room_3S_door:connect_two_ways_entrance(MM_map_room_top_middle_1N_door)
MM_map_room_top_middle_1N_door:connect_two_ways(MM_map_room_top_middle)


MM_main_room:connect_two_ways(MM_main_room_3W_door)
MM_main_room_3W_door:connect_two_ways_entrance("", MM_conveyor_crystal_room_4E_door)
MM_conveyor_crystal_room_4E_door:connect_two_ways(MM_conveyor_crystal_room)

MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Enemy #6", function() return DealDamage end)
-- MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Enemy #9", function() return DealDamage end)
-- MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Enemy #10", function() return DealDamage end)
-- MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Enemy #12", function() return DealDamage end)

MM_conveyor_crystal_room:connect_two_ways(MM_conveyor_crystal_room_4S_door)
MM_conveyor_crystal_room_4S_door:connect_two_ways_entrance("", MM_neglected_room_2N_door)

MM_neglected_room_2N_door:connect_two_ways(MM_neglected_room)

MM_neglected_room:connect_one_way("MM - Neglected Room Pot #3")
-- MM_neglected_room:connect_one_way("MM - Neglected Room Pot #4")
-- MM_neglected_room:connect_one_way("MM - Neglected Room Pot #5")
-- MM_neglected_room:connect_one_way("MM - Neglected Room Pot #6")
MM_neglected_room:connect_one_way("MM - Neglected Room Enemy #1", function() return DealDamage end)
-- MM_neglected_room:connect_one_way("MM - Neglected Room Enemy #2", function() return DealDamage end)

MM_neglected_room:connect_two_ways(MM_chest_view)

MM_conveyor_crystal_room:connect_two_ways(MM_four_torches_tile_room)
MM_four_torches_tile_room:connect_two_ways(MM_compass_room)

MM_compass_room:connect_one_way("MM - Compass Room Enemy #4", function() return DealDamage end)

MM_compass_room:connect_two_ways(MM_wizzrobe_bypass)

MM_four_torches_tile_room:connect_two_ways(MM_four_torches_tile_room_3S_door)

MM_four_torches_tile_room_3S_door:connect_two_ways_entrance("", MM_conveyor_bomb_slug_room_1N_door)
MM_conveyor_bomb_slug_room_1N_door:connect_two_ways(MM_conveyor_bomb_slug_room)

MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Pot #1")
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Pot #2")
MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #3", function() return DealDamage end)
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #4", function() return DealDamage end)
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #5", function() return DealDamage end)
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #6", function() return DealDamage end)
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #7", function() return DealDamage end)
-- MM_conveyor_bomb_slug_room:connect_one_way("MM - Conveyor Barrier Enemy #8", function() return DealDamage end)

MM_conveyor_bomb_slug_room:connect_two_ways(MM_conveyor_bomb_slug_room_N_door)

MM_conveyor_bomb_slug_room_N_door:connect_two_ways_entrance("", MM_torches_top_N_door)
MM_torches_top_N_door:connect_two_ways(MM_torches_top)

MM_torches_top:connect_one_way(MM_conveyor_bomb_slug_room) --drop down
MM_torches_top:connect_two_ways(MM_torches_bottom)

MM_torches_bottom:connect_one_way(MM_big_key_chest_teleporter_room) --drop down
MM_torches_bottom:connect_two_ways(MM_cutscene_room)

MM_cutscene_room:connect_one_way("MM - Hint Pot #1")
-- MM_cutscene_room:connect_one_way("MM - Hint Pot #2")
-- MM_cutscene_room:connect_one_way("MM - Hint Pot #3")
-- MM_cutscene_room:connect_one_way("MM - Hint Pot #4")
-- MM_cutscene_room:connect_one_way("MM - Hint Pot #5")
-- MM_cutscene_room:connect_one_way("MM - Hint Pot #6")

MM_cutscene_room:connect_one_way(MM_big_key_chest)
MM_big_key_chest:connect_one_way(MM_big_key_chest_teleporter_room)

MM_big_key_chest_teleporter_room:connect_one_way(MM_square_rail)

MM_square_rail:connect_one_way("MM - Square Rail Enemy #5", function() return DealDamage end)
-- MM_square_rail:connect_one_way("MM - Square Rail Enemy #7", function() return DealDamage end)
-- MM_square_rail:connect_one_way("MM - Square Rail Enemy #8", function() return DealDamage end)
-- MM_square_rail:connect_one_way("MM - Square Rail Enemy #10", function() return DealDamage end)

MM_square_rail:connect_two_ways(MM_hourglas_room)
MM_square_rail:connect_two_ways(MM_lonely_teleporter_room)

MM_lonely_teleporter_room:connect_one_way(MM_big_key_door_room)


MM_main_room:connect_two_ways(MM_main_room_4E_door)
MM_main_room_4E_door:connect_two_ways_entrance("", MM_map_room_bottom_3W_door)
MM_map_room_bottom_3W_door:connect_two_ways(MM_map_room_bottom)
MM_map_room_bottom:connect_two_ways(MM_big_chest_room_bottom)
MM_big_chest_room_bottom:connect_one_way(MM_big_chest_room_top)

MM_big_chest_room_top:connect_two_ways_stuck(MM_map_room_top_right)

MM_map_room_top_right:connect_two_ways(MM_map_room_top_middle)

MM_map_room_top_middle:connect_two_ways(MM_map_room_top_left)


MM_main_room:connect_two_ways(MM_main_room_E_door)
MM_main_room_E_door:connect_two_ways_entrance("", MM_map_room_center_bridge_W_door)
MM_map_room_center_bridge_W_door:connect_two_ways(MM_map_room_center_bridge)
MM_map_room_center_bridge:connect_two_ways(MM_big_chest_room_bottom)

MM_above_spike_room:connect_two_ways(MM_above_spike_room_1N_door)
MM_above_spike_room_1N_door:connect_two_ways_entrance("", MM_bent_bridge_3S_door)

MM_bent_bridge_3S_door:connect_two_ways(MM_bent_bridge)
MM_bent_bridge:connect_two_ways(MM_bent_bridge_W_door)
MM_bent_bridge_W_door:connect_two_ways_entrance("", MM_bridge_EW_E_door)

MM_bridge_EW_E_door:connect_two_ways(MM_bridge_EW)
MM_bridge_EW:connect_two_ways(MM_bridge_EW_W_door)
MM_bridge_EW_W_door:connect_two_ways_entrance("", MM_fishbone_room_E_door)

MM_fishbone_room_E_door:connect_two_ways(MM_fishbone_room)

MM_fishbone_room:connect_one_way("MM - Fishbone Key Drop")
MM_fishbone_room:connect_one_way("MM - Fishbone Pot #2")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #3")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #4")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #5")
MM_fishbone_room:connect_one_way("MM - South Fish Pot #6")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #7")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #8")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #9")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #10")
-- MM_fishbone_room:connect_one_way("MM - Fishbone Pot #11")
MM_fishbone_room:connect_one_way("MM - Fishbone Enemy #2", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - Fishbone Enemy #3", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - Fishbone Enemy #4", function() return DealDamage end)
MM_fishbone_room:connect_one_way("MM - South Fish Enemy #5", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - South Fish Enemy #6", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - South Fish Enemy #7", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - South Fish Enemy #8", function() return DealDamage end)
-- MM_fishbone_room:connect_one_way("MM - South Fish Enemy #9", function() return DealDamage end)

MM_fishbone_room:connect_two_ways(MM_fishbone_room_4S_door)
MM_fishbone_room_4S_door:connect_two_ways_entrance("", MM_hourglas_room_2N_door)

MM_hourglas_room_2N_door:connect_two_ways(MM_hourglas_room)

MM_above_spike_room:connect_two_ways(MM_above_spike_room_1W_door)
MM_above_spike_room_1W_door:connect_two_ways_entrance("", MM_big_keydoor_room_2E_door)
MM_big_keydoor_room_2E_door:connect_two_ways(MM_big_key_door_room)

MM_hourglas_room:connect_one_way("MM - Spike Barrier Pot #1")
MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #1", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #2", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #3", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #4", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #5", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #6", function() return DealDamage end)
-- MM_hourglas_room:connect_one_way("MM - Spike Barrier Enemy #9", function() return DealDamage end)

MM_hourglas_room:connect_two_ways(MM_hourglas_room_4S_door)

MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #1")
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #2")
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #3")
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #4")
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #5")
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Pot #6")
MM_big_key_door_room:connect_one_way("MM - BK Door Room Enemy #1", function() return DealDamage end)
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Enemy #2", function() return DealDamage end)
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Enemy #3", function() return DealDamage end)
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Enemy #4", function() return DealDamage end)
-- MM_big_key_door_room:connect_one_way("MM - BK Door Room Enemy #5", function() return DealDamage end)

MM_big_key_door_room:connect_two_ways(MM_big_keydoor_room_N_door)
MM_big_keydoor_room_N_door:connect_two_ways_entrance("", MM_bridge_middle_S_door)
MM_bridge_middle_S_door:connect_two_ways(MM_bridge_middle)

MM_bridge_middle:connect_one_way("MM - Left Bridge Pot #1")

MM_bridge_middle:connect_two_ways(MM_bridge_middle_N_door)

MM_bridge_middle_N_door:connect_two_ways_entrance("", MM_dark_shooters_N_door)
MM_dark_shooters_N_door:connect_two_ways(MM_dark_shooters)

MM_dark_shooters:connect_one_way("MM - Dark Shooters Pot #1")
-- MM_dark_shooters:connect_one_way("MM - Dark Shooters Pot #3")
MM_dark_shooters:connect_one_way("MM - Dark Shooters Enemy #5", function() return DealDamage end)

MM_dark_shooters:connect_two_ways(MM_dark_key_rupees)
MM_dark_shooters:connect_two_ways(MM_block_X)

MM_block_X:connect_one_way("MM - Block X Enemy #6", function() return DealDamage end)
-- MM_block_X:connect_one_way("MM - Block X Enemy #7", function() return DealDamage end)
-- MM_block_X:connect_one_way("MM - Block X Enemy #8", function() return DealDamage end)

MM_block_X:connect_two_ways(MM_block_X_3W_door)



MM_block_X_3W_door:connect_two_ways_entrance("", MM_tall_dark_and_roomy_4E_door)
MM_tall_dark_and_roomy_4E_door:connect_two_ways(MM_tall_dark_and_roomy)

MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Pot #1")
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Pot #2")
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Pot #3")
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Pot #4")
MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Enemy #1", function() return DealDamage end)
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Enemy #3", function() return DealDamage end)
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Enemy #6", function() return DealDamage end)
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Enemy #7", function() return DealDamage end)
-- MM_tall_dark_and_roomy:connect_one_way("MM - Tall Dark and Roomy Enemy #9", function() return DealDamage end)


MM_tall_dark_and_roomy:connect_two_ways(MM_shooter_rupees)

MM_shooter_rupees:connect_one_way("MM - Shooter Rupees Enemy #4", function() return DealDamage end)
-- MM_shooter_rupees:connect_one_way("MM - Shooter Rupees Enemy #5", function() return DealDamage end)

MM_tall_dark_and_roomy:connect_two_ways(MM_crystal_right)

MM_crystal_right:connect_one_way("MM - Crystal Right Enemy #10", function() return DealDamage end)
-- MM_crystal_right:connect_one_way("MM - Crystal Right Enemy #12", function() return DealDamage end)

MM_crystal_right:connect_two_ways(MM_crystal_middle)
-- MM_crystal_middle:connect_two_ways(MM_crystal_middle)
MM_crystal_middle:connect_one_way("MM - Crystal Mid Enemy #11", function() return DealDamage end)

MM_crystal_middle:connect_two_ways(MM_crystal_left)

MM_crystal_left:connect_two_ways(MM_crystal_left_3W_door)
MM_crystal_left_3W_door:connect_two_ways_entrance("", MM_falling_foes_4E_door)
MM_falling_foes_4E_door:connect_two_ways(MM_falling_foes)

MM_falling_foes:connect_one_way("MM - Falling Foes Pot #1")
-- MM_falling_foes:connect_one_way("MM - Falling Foes Pot #2")
MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #1", function() return DealDamage end)
-- MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #2", function() return DealDamage end)
-- MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #4", function() return DealDamage end)
-- MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #5", function() return DealDamage end)
-- MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #6", function() return DealDamage end)
-- MM_falling_foes:connect_one_way("MM - Falling Foes Enemy #7", function() return DealDamage end)

MM_falling_foes:connect_two_ways(MM_falling_foes_2N_door)

MM_falling_foes_2N_door:connect_two_ways_entrance("", MM_antechamber_right_2N_door)
MM_antechamber_right_2N_door:connect_two_ways(MM_antechamber_right)

MM_antechamber_right:connect_one_way("MM - Antechamber Enemy #1", function() return DealDamage end)
-- MM_antechamber_right:connect_one_way("MM - Antechamber Enemy #2", function() return DealDamage end)
MM_antechamber_right:connect_one_way("MM - Firesnake Skip Enemy #3", function() return DealDamage end)

MM_antechamber_right:connect_two_ways(MM_antechamber_left)

-- MM_antechamber_left:connect_one_way("MM - Antechamber Enemy #2", function() return DealDamage end)

MM_antechamber_left:connect_two_ways(MM_antechamber_left_1N_door)

MM_antechamber_left_1N_door:connect_two_ways_entrance("", MM_boss_room_3S_door)
MM_boss_room_3S_door:connect_two_ways(MM_boss_room)


MM_main_room:connect_one_way("MM - Main Lobby Chest", function()
    return CanReachCrystalSwitches() >= 5
end)
MM_big_chest_room_top:connect_one_way("MM - Big Chest", function() return Has("bigkey") end)

MM_map_room_top_left:connect_one_way("MM - Map Chest")

MM_bridge_right:connect_one_way("MM - Bridge Chest")


MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Key Drop")

MM_compass_room:connect_one_way("MM - Comapss Chest")

MM_big_key_chest:connect_one_way("MM - Big Key Chest")

MM_boss_room:connect_one_way("MM - Boss", function() return GetBossRef("mm_boss") end)

---

-- MM_entrance_inside:connect_two_ways(MM_pre_gap)
-- MM_pre_gap:connect_two_ways(MM_post_gap, function()
--     return ALL(
--         ANY(
--             "hookshot",
--             "boots"
--         ),
--         CanInteract(MM_pre_gap)
--     )
-- end)
-- MM_post_gap:connect_two_ways(MM_wizrobe_room)
-- MM_wizrobe_room:connect_two_ways(MM_main_room, function()
--     if Tracker:FindObjectForCode("enemizer").Active and CanInteract(MM_wizrobe_room) then
--         return DealDamage()
--     else
--         return ANY(
--             "sword",
--             "somaria",
--             "bow",
--             "hookshot",
--             "firerod",
--             -- "icerod",
--             "hammer"
--         )
--     end
-- end)
-- MM_main_room:connect_two_ways(MM_conveyor_crystal_room,function(keys, Current_Dungeon)
--     if Tracker:FindObjectForCode("bigkey").Active then
--         return Has("smallkey", keys + 0, 2, keys + CountDoneDeadends(1, "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Boss/Boss Item"), 4), KDSreturn(keys, keys + 1)
--     else
--         return Has("smallkey", keys + 0, 2, keys + CountDoneDeadends(1, "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 3), KDSreturn(keys, keys + 1)
--     end
-- end)
-- MM_main_room:connect_two_ways(MM_block_push)

-- MM_main_room:connect_two_ways(MM_map_room_bottom)
-- MM_main_room:connect_two_ways(MM_map_room_top_left, function(keys, Current_Dungeon)
--     if CanReachCrystalSwitches() >= 5 then
--         return Has("smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 2), keys
--     else
--         return Has("smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 4), keys + 1
--     end
-- end)
-- MM_main_room:connect_one_way("MM - Main Lobby Chest", function()
--     return CanReachCrystalSwitches() >= 5
-- end)
--     -- return MM_conveyor_crystal_room:accessibility() > 5 or Tracker:FindObjectForCode("@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop").AvailableChestCount == 0 end)

-- MM_map_room_bottom:connect_two_ways(MM_big_chest_room)

-- MM_big_chest_room:connect_one_way(MM_map_room_top_right)
-- MM_big_chest_room:connect_one_way("MM - Big Chest", function() return Has("bigkey") end)

-- MM_map_room_top_right:connect_one_way(MM_map_room_bottom)
-- MM_map_room_top_middle:connect_two_ways(MM_map_room_top_right, function() 
--     return ALL(
--         CanReachCrystalSwitches() >= 5,
--         CanInteract(MM_conveyor_crystal_room)
--     )
-- end)
-- MM_map_room_top_middle:connect_two_ways(MM_map_room_top_left, function() 
-- return ALL(
--         CanReachCrystalSwitches() >= 5,
--         CanInteract(MM_conveyor_crystal_room)
--     )
-- end)
-- MM_map_room_top_middle:connect_two_ways(MM_spike_room)
-- MM_map_room_top_left:connect_one_way("MM - Map Chest")

-- MM_block_push:connect_two_ways(MM_bridge_right)
-- MM_block_push:connect_two_ways(MM_spike_room)

-- MM_bridge_right:connect_one_way("MM - Bridge Chest")

-- MM_spike_room:connect_two_ways(MM_above_spike_room, function(keys, Current_Dungeon)
--     return Has("smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 5), KDSreturn(keys, keys + 1)
-- end)

-- MM_spike_room:connect_one_way("MM - Spike Chest", function()
--     return ANY(
--         CalcHealth() > 3,
--         Has("invincibility")
--     )
-- end)
-- MM_spike_room:connect_one_way("MM - Spike Key Drop")

-- MM_fishbone_room:connect_one_way(MM_hourglas_room, function(keys, Current_Dungeon)
--     if Tracker:FindObjectForCode("bigkey").Active then
--         return Has("smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Boss/Boss Item"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Boss/Boss Item", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 5), KDSreturn(keys, keys + 1)
--     else
--         return Has("smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Compass Chest/Compass Chest"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 4), KDSreturn(keys, keys + 1)
--     end
-- end)
-- MM_fishbone_room:connect_one_way("MM - Fishbone Key Drop")

-- MM_hourglas_room:connect_two_ways(MM_main_room)
-- MM_hourglas_room:connect_two_ways(MM_lonely_teleporter_room)
-- MM_conveyor_crystal_room:connect_two_ways(MM_four_torches_tile_room, function(keys, Current_Dungeon)
--     if Tracker:FindObjectForCode("bigkey").Active then
--         return Has("smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Boss/Boss Item"), 3, keys + CountDoneDeadends(1, "@Misery Mire/Boss/Boss Item"), 6), KDSreturn(keys, keys + 1)
--     else
--         return Has("smallkey", keys + CountDoneDeadends(0, "@Misery Mire/Boss/Boss Item"), 2, keys + CountDoneDeadends(1, "@Misery Mire/Boss/Boss Item"), 5), KDSreturn(keys, keys + 1)
--     end
-- end)

-- MM_four_torches_tile_room:connect_two_ways(MM_compass_room, function() return Has("firesource") end)
-- MM_four_torches_tile_room:connect_two_ways(MM_cutscene_room)

-- -- UWG
-- MM_cutscene_room:connect_one_way(ToH_fairy_drop, function()
--     return ALL(
--         CheckGlitches(3),
--         CanBombClip(MM_cutscene_room),
--         "firesource",
--         "bigkey"
--     )
-- end) -- mire to hera
-- MM_cutscene_room:connect_one_way(SP_first_room, function()
--     return ALL(
--         CheckGlitches(3),
--         CanBombClip(MM_cutscene_room),
--         "firesource"
--     )
-- end) -- mire to swamp
-- MM_cutscene_room:connect_one_way(SP_main_room, function()
--     return ALL(
--         CheckGlitches(3),
--         CanBombClip(MM_cutscene_room),
--         "firesource"
--     )
-- end) -- mire to swamp center
-- -- UWG end

-- MM_conveyor_crystal_room:connect_one_way("MM - Conveyor Crystal Key Drop")

-- MM_compass_room:connect_one_way(MM_main_room)
-- MM_compass_room:connect_one_way("MM - Comapss Chest")

-- MM_cutscene_room:connect_one_way(MM_big_key_chest, function() return Has("firesource")end)

-- MM_big_key_chest:connect_one_way(MM_hourglas_room)
-- MM_big_key_chest:connect_one_way("MM - Big Key Chest")

-- MM_lonely_teleporter_room:connect_one_way(MM_big_key_door_room, function() return Has("bigkey") end)

-- MM_above_spike_room:connect_two_ways(MM_fishbone_room)
-- MM_above_spike_room:connect_two_ways(MM_big_key_door_room)

-- MM_big_key_door_room:connect_two_ways(MM_bridge_middle, function() return Has("bigkey") end)
-- MM_bridge_middle:connect_two_ways(MM_boss_room, function(keys, Current_Dungeon)
--     return ALL(
--         "somaria",
--         "bombs",
--         DarkRooms,
--         Has("smallkey", keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest"), 3, keys + CountDoneDeadends(1, "@Misery Mire/Compass Chest/Compass Chest", "@Misery Mire/Conveyor Crystal Key Drop/Conveyor Crystal Key Drop", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key", "@Misery Mire/Fishbone Pot Key/Fishbone Pot Key"), 6),
--         "bigkey"
--     ), keys + 1 -- + 1)
-- end)

-- MM_boss_room:connect_one_way("MM - Boss", function() return GetBossRef("mm_boss") end)