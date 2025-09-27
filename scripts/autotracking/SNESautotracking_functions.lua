-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = false
-- AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

function autotracker_started()
    -- Invoked when the auto-tracker is activated/connected
end

AUTOTRACKER_IS_IN_TRIFORCE_ROOM = false
AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY = false

U8_READ_CACHE = 0
U8_READ_CACHE_ADDRESS = 0

U16_READ_CACHE = 0
U16_READ_CACHE_ADDRESS = 0

room_lookuptable = {
    [1] = {"Lightworld Dungeons", "Hyrule Castle",},
    [2] = {"Lightworld Dungeons", "Castle Escape",},
    [4] = {"Darkworld Dungeons", "Turtle Rock",},
    [6] = {"Darkworld Dungeons", "Swamp Palace",},
    [7] = {"Lightworld Dungeons", "Tower of Hera",},
    [9] = {"Darkworld Dungeons", "Palace of Darkness",},
    [10] = {"Darkworld Dungeons", "Palace of Darkness",},
    [11] = {"Darkworld Dungeons", "Palace of Darkness",},
    [12] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [13] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [14] = {"Darkworld Dungeons", "Ice Palace",},
    [17] = {"Lightworld Dungeons", "Castle Escape",},
    [18] = {"Lightworld Dungeons", "Castle Escape",},
    [19] = {"Darkworld Dungeons", "Turtle Rock",},
    [20] = {"Darkworld Dungeons", "Turtle Rock",},
    [21] = {"Darkworld Dungeons", "Turtle Rock",},
    [22] = {"Darkworld Dungeons", "Swamp Palace",},
    [23] = {"Lightworld Dungeons", "Tower of Hera",},
    [25] = {"Darkworld Dungeons", "Palace of Darkness",},
    [26] = {"Darkworld Dungeons", "Palace of Darkness",},
    [27] = {"Darkworld Dungeons", "Palace of Darkness",},
    [28] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [29] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [30] = {"Darkworld Dungeons", "Ice Palace",},
    [31] = {"Darkworld Dungeons", "Ice Palace",},
    [32] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [33] = {"Lightworld Dungeons", "Castle Escape",},
    [34] = {"Lightworld Dungeons", "Castle Escape",},
    [35] = {"Darkworld Dungeons", "Turtle Rock",},
    [36] = {"Darkworld Dungeons", "Turtle Rock",},
    [38] = {"Darkworld Dungeons", "Swamp Palace",},
    [39] = {"Lightworld Dungeons", "Tower of Hera",},
    [40] = {"Darkworld Dungeons", "Swamp Palace",},
    [41] = {"Darkworld Dungeons", "Skull Woods",},
    [42] = {"Darkworld Dungeons", "Palace of Darkness",},
    [43] = {"Darkworld Dungeons", "Palace of Darkness",},
    [46] = {"Darkworld Dungeons", "Ice Palace",},
    [48] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [49] = {"Lightworld Dungeons", "Tower of Hera",},
    [50] = {"Lightworld Dungeons", "Castle Escape",},
    [51] = {"Lightworld Dungeons", "Desert Palace",},
    [52] = {"Darkworld Dungeons", "Swamp Palace",},
    [53] = {"Darkworld Dungeons", "Swamp Palace",},
    [54] = {"Darkworld Dungeons", "Swamp Palace",},
    [55] = {"Darkworld Dungeons", "Swamp Palace",},
    [56] = {"Darkworld Dungeons", "Swamp Palace",},
    [57] = {"Darkworld Dungeons", "Skull Woods",},
    [58] = {"Darkworld Dungeons", "Palace of Darkness",},
    [59] = {"Darkworld Dungeons", "Palace of Darkness",},
    [61] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [62] = {"Darkworld Dungeons", "Ice Palace",},
    [63] = {"Darkworld Dungeons", "Ice Palace",},
    [64] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [65] = {"Lightworld Dungeons", "Castle Escape",},
    [66] = {"Lightworld Dungeons", "Castle Escape",},
    [67] = {"Lightworld Dungeons", "Desert Palace",},
    [68] = {"Darkworld Dungeons", "Thieves Town",},
    [69] = {"Darkworld Dungeons", "Thieves Town",},
    [70] = {"Darkworld Dungeons", "Swamp Palace",},
    [73] = {"Darkworld Dungeons", "Skull Woods",},
    [74] = {"Darkworld Dungeons", "Palace of Darkness",},
    [75] = {"Darkworld Dungeons", "Palace of Darkness",},
    [76] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [77] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [78] = {"Darkworld Dungeons", "Ice Palace",},
    [79] = {"Darkworld Dungeons", "Ice Palace",},
    [80] = {"Lightworld Dungeons", "Hyrule Castle",},
    [81] = {"Lightworld Dungeons", "Hyrule Castle",},
    [82] = {"Lightworld Dungeons", "Hyrule Castle",},
    [83] = {"Lightworld Dungeons", "Desert Palace",},
    [84] = {"Darkworld Dungeons", "Swamp Palace",},
    [86] = {"Darkworld Dungeons", "Skull Woods",},
    [87] = {"Darkworld Dungeons", "Skull Woods",},
    [88] = {"Darkworld Dungeons", "Skull Woods",},
    [89] = {"Darkworld Dungeons", "Skull Woods",},
    [90] = {"Darkworld Dungeons", "Palace of Darkness",},
    [91] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [92] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [93] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [94] = {"Darkworld Dungeons", "Ice Palace",},
    [95] = {"Darkworld Dungeons", "Ice Palace",},
    [96] = {"Lightworld Dungeons", "Hyrule Castle",},
    [97] = {"Lightworld Dungeons", "Hyrule Castle",},
    [98] = {"Lightworld Dungeons", "Hyrule Castle",},
    [99] = {"Lightworld Dungeons", "Desert Palace",},
    [100] = {"Darkworld Dungeons", "Thieves Town",},
    [101] = {"Darkworld Dungeons", "Thieves Town",},
    [102] = {"Darkworld Dungeons", "Swamp Palace",},
    [103] = {"Darkworld Dungeons", "Skull Woods",},
    [104] = {"Darkworld Dungeons", "Skull Woods",},
    [106] = {"Darkworld Dungeons", "Palace of Darkness",},
    [107] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [108] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [109] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [110] = {"Darkworld Dungeons", "Ice Palace",},
    [112] = {"Lightworld Dungeons", "Hyrule Castle",},
    [113] = {"Lightworld Dungeons", "Hyrule Castle",},
    [114] = {"Lightworld Dungeons", "Hyrule Castle",},
    [115] = {"Lightworld Dungeons", "Desert Palace",},
    [116] = {"Lightworld Dungeons", "Desert Palace",},
    [117] = {"Lightworld Dungeons", "Desert Palace",},
    [118] = {"Darkworld Dungeons", "Swamp Palace",},
    [119] = {"Lightworld Dungeons", "Tower of Hera",},
    [123] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [124] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [125] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [126] = {"Darkworld Dungeons", "Ice Palace",},
    [127] = {"Darkworld Dungeons", "Ice Palace",},
    [128] = {"Lightworld Dungeons", "Hyrule Castle",},
    [129] = {"Lightworld Dungeons", "Hyrule Castle",},
    [130] = {"Lightworld Dungeons", "Hyrule Castle",},
    [131] = {"Lightworld Dungeons", "Desert Palace",},
    [132] = {"Lightworld Dungeons", "Desert Palace",},
    [133] = {"Lightworld Dungeons", "Desert Palace",},
    [135] = {"Lightworld Dungeons", "Tower of Hera",},
    [137] = {"Lightworld Dungeons", "Eastern Palace",},
    [139] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [140] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [141] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [142] = {"Darkworld Dungeons", "Ice Palace",},
    [144] = {"Darkworld Dungeons", "Misery Mire",},
    [145] = {"Darkworld Dungeons", "Misery Mire",},
    [146] = {"Darkworld Dungeons", "Misery Mire",},
    [147] = {"Darkworld Dungeons", "Misery Mire",},
    [149] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [150] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [151] = {"Darkworld Dungeons", "Misery Mire",},
    [152] = {"Darkworld Dungeons", "Misery Mire",},
    [153] = {"Darkworld Dungeons", "Eastern Palace",},
    [155] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [156] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [157] = {"Darkworld Dungeons", "Ganon's Tower - Bottom",},
    [158] = {"Darkworld Dungeons", "Ice Palace",},
    [159] = {"Darkworld Dungeons", "Ice Palace",},
    [160] = {"Darkworld Dungeons", "Misery Mire",},
    [161] = {"Darkworld Dungeons", "Misery Mire",},
    [162] = {"Darkworld Dungeons", "Misery Mire",},
    [163] = {"Darkworld Dungeons", "Misery Mire",},
    [164] = {"Darkworld Dungeons", "Turtle Rock",},
    [165] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [166] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [167] = {"Darkworld Dungeons", "Ganon's Tower - Top",},
    [168] = {"Lightworld Dungeons", "Eastern Palace",},
    [169] = {"Lightworld Dungeons", "Eastern Palace",},
    [170] = {"Lightworld Dungeons", "Eastern Palace",},
    [171] = {"Darkworld Dungeons", "Thieves Town",},
    [172] = {"Darkworld Dungeons", "Thieves Town",},
    [174] = {"Darkworld Dungeons", "Ice Palace",},
    [175] = {"Darkworld Dungeons", "Ice Palace",},
    [176] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [177] = {"Darkworld Dungeons", "Misery Mire",},
    [178] = {"Darkworld Dungeons", "Misery Mire",},
    [179] = {"Darkworld Dungeons", "Misery Mire",},
    [180] = {"Darkworld Dungeons", "Turtle Rock",},
    [181] = {"Darkworld Dungeons", "Turtle Rock",},
    [182] = {"Darkworld Dungeons", "Turtle Rock",},
    [183] = {"Darkworld Dungeons", "Turtle Rock",},
    [184] = {"Lightworld Dungeons", "Eastern Palace",},
    [185] = {"Lightworld Dungeons", "Eastern Palace",},
    [186] = {"Lightworld Dungeons", "Eastern Palace",},
    [187] = {"Darkworld Dungeons", "Thieves Town",},
    [188] = {"Darkworld Dungeons", "Thieves Town",},
    [190] = {"Darkworld Dungeons", "Ice Palace",},
    [191] = {"Darkworld Dungeons", "Ice Palace",},
    [192] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [193] = {"Darkworld Dungeons", "Misery Mire",},
    [194] = {"Darkworld Dungeons", "Misery Mire",},
    [195] = {"Darkworld Dungeons", "Misery Mire",},
    [196] = {"Darkworld Dungeons", "Turtle Rock",},
    [197] = {"Darkworld Dungeons", "Turtle Rock",},
    [198] = {"Darkworld Dungeons", "Turtle Rock",},
    [199] = {"Darkworld Dungeons", "Turtle Rock",},
    [200] = {"Lightworld Dungeons", "Eastern Palace",},
    [201] = {"Lightworld Dungeons", "Eastern Palace",},
    [203] = {"Darkworld Dungeons", "Thieves Town",},
    [204] = {"Darkworld Dungeons", "Thieves Town",},
    [206] = {"Darkworld Dungeons", "Ice Palace",},
    [208] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [209] = {"Darkworld Dungeons", "Misery Mire",},
    [210] = {"Darkworld Dungeons", "Misery Mire",},
    [213] = {"Darkworld Dungeons", "Turtle Rock",},
    [214] = {"Darkworld Dungeons", "Turtle Rock",},
    [216] = {"Lightworld Dungeons", "Eastern Palace",},
    [217] = {"Lightworld Dungeons", "Eastern Palace",},
    [218] = {"Lightworld Dungeons", "Eastern Palace",},
    [219] = {"Darkworld Dungeons", "Thieves Town",},
    [220] = {"Darkworld Dungeons", "Thieves Town",},
    [222] = {"Darkworld Dungeons", "Ice Palace",},
    [224] = {"Lightworld Dungeons", "Agahnim's Tower",},
    [250] = {"Overworld", "Lightworld",},
    [251] = {"Overworld", "Lightworld",},
    [252] = {"Overworld", "Lightworld",},
    [253] = {"Overworld", "Lightworld",},
    [254] = {"Overworld", "Lightworld",},
    [255] = {"Overworld", "Lightworld",},
    [256] = {"Overworld", "Lightworld",},
    [257] = {"Overworld", "Lightworld",},
    [258] = {"Overworld", "Lightworld",},
    [259] = {"Overworld", "Lightworld",},
    [260] = {"Overworld", "Lightworld",},
}

dungeon_entrance_IDS = {
    [0] = {Pyramid_Drop},
    [16] = {Pyramid_Exit},
    [12] = {gt_entrance_inside},
    [14] = {ip_entrance_inside},
    [18] = {sanctuary_entrance_inside},
    [35] = {tr_laser_entrance_inside},
    [36] = {tr_big_chest_entrance_inside},
    [40] = {sp_entrance_inside},
    [74] = {pod_entrance_inside},
    [85] = {secret_passage_hole_inside, secret_passage_stairs_inside},
    [86] = {sw_west_lobby_entrance_inside, sw_north_drop_inside},
    [87] = {sw_gibdo_entrance_inside},
    [88] = {sw_big_chest_entrance_inside, sw_pot_circle_drop_inside},
    [89] = {sw_back_entrance_inside},
    [96] = {hc_left_entrance_inside},
    [97] = {hc_main_entrance_inside},
    [98] = {hc_right_entrance_inside},
    [99] = {dp_back_entrance_inside},
    [103] = {sw_bottom_left_drop_inside},
    [104] = {sw_pinball_drop_inside},
    [119] = {toh_entrance_inside},
    [131] = {dp_left_entrance_inside},
    [132] = {dp_main_entrance_inside},
    [133] = {dp_right_entrance_inside},
    [152] = {mm_entrance_inside},
    [201] = {ep_entrance_inside},
    [213] = {tr_eye_bridge_entrance_inside},
    [214] = {tr_main_entrance_inside},
    [219] = {tt_entrance_inside},
    [224] = {at_entrance_inside},
}

local multi_purpose_room = {
    ["kakariko_shop"] = function()
                            LIGHT_SHOPS_FOUND = LIGHT_SHOPS_FOUND + 1
                            return LIGHT_SHOPS_FOUND
                            end,
    ["kakariko_fortune"] = function()
                            FORTUNE_FOUND = FORTUNE_FOUND + 1
                            return FORTUNE_FOUND
                            end,
    ["dam_desert_fairy_"] = function()
                            FAIRYS_FOUND = FAIRYS_FOUND + 1
                            return FAIRYS_FOUND
                            end
}
Selected_entrance = nil
Selected_exit = nil
Selected_entrance_origin = nil
Selected_exit_origin = nil
local er_target_counter = 0
LIGHT_SHOPS_FOUND = 0
FORTUNE_FOUND = 0
FAIRYS_FOUND = 0

function UpdateEntrances(segment, mainModuleIdx)
    -- print(AutoTracker:ReadU8(0x7e0010, 0))
    local current_room
    local new_ow_room
    local new_dungeon_room
    local current_coords_y
    local current_coords_x
    current_coords_y = segment:ReadUInt16(0x7e0020)
    current_coords_x = segment:ReadUInt16(0x7e0022)

    if mainModuleIdx > 0x05 then
        -- print("-------------------------------------------------")
        new_ow_room = segment:ReadUInt16(0x7e008a)
        new_dungeon_room = segment:ReadUInt16(0x7e00a0)
        -- print("Room Memory for Address: 0x7e00a2")
        -- print(last_seen_room1)
        -- last_seen_room2 = segment:ReadUInt8(0x7e00a9)
        -- print("Room Memory for Address: 0x7e00a9")
        -- print(last_seen_room2)
        -- last_seen_room3 = segment:ReadUInt8(0x7e00aA)
        -- print("Room Memory for Address: 0x7e00aA")
        -- print(last_seen_room3)
        -- print("left/right qudrant:", segment:ReadUInt8(0x7e00a9))
        -- print("upper/lower qudrant:", segment:ReadUInt8(0x7e00aa))
        -- print("x cord :", segment:ReadUInt16(0x7e0022))
        current_coords_x = segment:ReadUInt16(0x7e0022)
        -- print("y cord :", segment:ReadUInt16(0x7e0020))
        current_coords_y = segment:ReadUInt16(0x7e0020)
        -- print("-------------------------------------------------")
        -- print("Current Room Index: ", new_dungeon_room)
        -- print("Current OW   Index: ", new_ow_room)



        -- print("------------------------------------------")
        -- print(dump_table(OVERWORLD_MAPPING[current_coords_x][current_coords_y][new_ow_room]))
        -- print(dump_table(CAVES_MAPPING[current_coords_x][current_coords_y][new_dungeon_room]))
        -- print("------------------------------------------")
       

        if new_ow_room == 0 then
            if current_coords_x > 740 and current_coords_x < 780 and current_coords_y > 0 and current_coords_y < 610 then
                current_room = new_ow_room
            else
                current_room = new_dungeon_room
            end
        else
            if current_room ~= new_ow_room then
                current_room = new_ow_room
            end
        end
        if mainModuleIdx == 0x0F or mainModuleIdx == 0x08 or mainModuleIdx == 0x06 or mainModuleIdx == 0x11 then

            local temp_room = ENTRANCE_MAPPING[current_room]
            local temp_room_x
            local temp_room_y
            local entrance_name
            local entrance_origin
            if temp_room then
                temp_room_x = temp_room[current_coords_x]
                if temp_room_x then
                    temp_room_y = temp_room_x[current_coords_y]
                    if temp_room_y then
                        entrance_name = temp_room_y[1]
                        entrance_origin = temp_room_y[2]
                    end
                end
            end

            if temp_room_y ~= nil then
                -- local current_door = ENTRANCE_MAPPING[current_room][current_coords_x][current_coords_y]
                local current_door = temp_room_y
                local door_name = entrance_name
                -- print(door_name)
                if current_door ~= nil and type(current_door) == "table" then
                    if Selected_entrance == nil then
                        Selected_entrance = Tracker:FindObjectForCode("from_"..door_name)
                        Selected_entrance_origin = entrance_origin
                        -- print("Selected_entrance", Selected_entrance.Name)
                    else
                        if string.gsub(Selected_entrance.Name, "from_", "") ~= door_name then
                            -- if multi_purpose_room[door_name] then
                            local multi_purpose_room_call = multi_purpose_room[door_name]
                            if multi_purpose_room_call == nil then
                                multi_purpose_room_call = function() return 1 end
                            end
                            Selected_exit = Tracker:FindObjectForCode("to_"..current_door[multi_purpose_room_call()])
                            Selected_exit_origin = entrance_origin
                            -- if string.match(current_door[1], "kakariko_shop") then
                            --     LIGHT_SHOPS_FOUND = LIGHT_SHOPS_FOUND + 1
                            --     Selected_exit = Tracker:FindObjectForCode("to_"..current_door[LIGHT_SHOPS_FOUND])
                            -- elseif string.match(current_door[1], "kakariko_fortune") then
                            --     FORTUNE_FOUND = FORTUNE_FOUND + 1
                            --     Selected_exit = Tracker:FindObjectForCode("to_"..current_door[FORTUNE_FOUND])
                            -- elseif string.match(current_door[1], "dam_desert_fairy_") then
                            --     FAIRYS_FOUND = FAIRYS_FOUND + 1
                            --     Selected_exit = Tracker:FindObjectForCode("to_"..current_door[FAIRYS_FOUND])
                            -- else
                            --     Selected_exit = Tracker:FindObjectForCode("to_"..current_door[1])
                            -- end
                            -- print("Selected_exit", Selected_exit.Name)
                        end

                    end
                
                    local er_stage = Tracker:FindObjectForCode("er_tracking").CurrentStage
                    if Selected_entrance ~= nil and Selected_exit ~= nil and Selected_entrance_origin ~= Selected_exit_origin then
                        -- print("inside entrance connection part")
                        -- print("selected_entrance", selected_entrance.Name)
                        -- print("selected_exit", selected_exit.Name)
                        -- print(Tracker:FindObjectForCode("er_tracking").CurrentStage)
                        if er_stage == 3 then -- separated doors
                    
                            _SetLocationOptions(Selected_entrance, Selected_exit)
                            _SetLocationOptions(Selected_exit, Selected_entrance)
                        else --trackes both sides simlutaniously
                            _SetLocationOptions(Selected_entrance, Selected_exit)
                            _SetLocationOptions(Selected_exit, Selected_entrance)
                            Selected_entrance = Tracker:FindObjectForCode(string.gsub(Selected_entrance.Name, "from_", "to_"))
                            Selected_exit = Tracker:FindObjectForCode(string.gsub(Selected_exit.Name, "to_", "from_"))
                            _SetLocationOptions(Selected_entrance, Selected_exit)
                            _SetLocationOptions(Selected_exit, Selected_entrance)
                        end
                        Selected_entrance = nil
                        Selected_exit = nil
                        Selected_entrance_origin = nil
                        Selected_exit_origin = nil
                    end
                else
                    Selected_entrance = nil
                end
            else
                if (current_room ~= 149 and current_room ~= 150) then
                    print("No entrance found for room:", current_room, "x:", current_coords_x, "y:", current_coords_y)
                    print("If this is a dropdown it's probably fine. If not, the mapping needs to be expanded.")
                end
            end
        else
            Selected_entrance = nil
            Selected_exit = nil
            Selected_entrance_origin = nil
            Selected_exit_origin = nil
        end
    end
    if LIGHT_SHOPS_FOUND == 5 then
        LIGHT_SHOPS_FOUND = 0
    end
    if FAIRYS_FOUND == 7 then
        FAIRYS_FOUND = 0
    end
    if FORTUNE_FOUND == 2 then
        FORTUNE_FOUND = 0
    end
end

function UpdateUI(segment, mainModuleIdx)
    local ow_room_reset
    local dungeon_room_reset
   
   
    ow_room_reset = false
    dungeon_room_reset = false
    if mainModuleIdx > 0x05 then
        -- print("-------------------------------------------------")
        new_ow_room = segment:ReadUInt16(0x7e008a)
        new_dungeon_room = segment:ReadUInt16(0x7e00a0)
        last_seen_room1 = segment:ReadUInt16(0x7e00a2)
        -- print("Room Memory for Address: 0x7e00a2")
        -- print(last_seen_room1)
        -- last_seen_room2 = segment:ReadUInt8(0x7e00a9)
        -- print("Room Memory for Address: 0x7e00a9")
        -- print(last_seen_room2)
        -- last_seen_room3 = segment:ReadUInt8(0x7e00aA)
        -- print("Room Memory for Address: 0x7e00aA")
        -- print(last_seen_room3)
        -- print("left/right qudrant:", segment:ReadUInt8(0x7e00a9))
        -- print("upper/lower qudrant:", segment:ReadUInt8(0x7e00aa))
        -- print("x cord :", segment:ReadUInt16(0x7e0022))
        -- current_coords_x = segment:ReadUInt16(0x7e0022)
        -- print("y cord :", segment:ReadUInt16(0x7e0020))
        -- current_coords_y = segment:ReadUInt16(0x7e0020)
        -- print("-------------------------------------------------")
        -- print("Current Room Index: ", new_dungeon_room)
        -- print("Current OW   Index: ", new_ow_room)
        if new_ow_room == 0 then
            new_dungeon_room = segment:ReadUInt16(0x7e00a0)
            ow_room_reset = true
            --dungeon_room_quadrant_lr = segment:ReadUInt8(0x7e00a9) -- 0 or 1 / left or rigth
            --dungeon_room_quadrant_ud = segment:ReadUInt8(0x7e00aa) -- 0 or 2 / upper or lower
        else
            transition_to_dungeon = true
            dungeon_room_reset = true
            new_dungeon_room = 0
        end
        if new_ow_room > 0 then -- and ow_room ~= new_ow_room then
            if  ow_room ~= new_ow_room then
                ow_room = new_ow_room
                ChangeTab("Overworld")
            end
        elseif new_dungeon_room > 0 and dungeon_room ~= new_dungeon_room then
            if (segment:ReadUInt16(0x7e0020) < 1050 and segment:ReadUInt16(0x7e0022) < 1050) then
                ChangeTab("Overworld")
            else
                dungeon_room = new_dungeon_room
                -- print(room_lookuptable[dungeon_room][1])
                -- print(dump_table(room_lookuptable[dungeon_room]))
                if room_lookuptable[dungeon_room] ~= nil then
                    for _, ui_name in pairs(room_lookuptable[dungeon_room]) do
                        -- print(_, ui_name)
                        ChangeTab(ui_name)
                    end
                else
                    print("room_lookuptable[dungeon_room] returned nil for dungeon room:".. dungeon_room)
                end
            end
        end
       
        -- print(room_lookuptable[dungeon_room])
    end
    if ow_room_reset then
        ow_room = 0
    end
    if dungeon_room_reset then
        dungeon_room = 0
    end
end

-- function UpdateUI(segment, mainModuleIdx)
--     if mainModuleIdx > 0x05 then
--         new_ow_room = segment:ReadUInt16(0x7e008a)
--         if new_ow_room == 0 then
--             new_dungeon_room = segment:ReadUInt16(0x7e00a0)
--         else
--             dungeon_room = 0
--             new_dungeon_room = 0
--         end

--         if new_ow_room > 0 then -- and ow_room ~= new_ow_room then
--             ow_room = new_ow_room
--             ChangeTab("Overworld")
--         elseif new_dungeon_room > 0 and dungeon_room ~= new_dungeon_room then
--             dungeon_room = new_dungeon_room
--             ChangeTab(room_lookuptable[dungeon_room])
--         end
--         -- print("Current Room Index: ", new_dungeon_room)
--         -- print("Current OW   Index: ", new_ow_room)
--         -- print(room_lookuptable[dungeon_room])
--     end
-- end

function ChangeTab(target_tab)
    if Tracker:FindObjectForCode("ui_hint").Active and target_tab ~= nil then
        -- print(ow_room, dungeon_room, Tracker:FindObjectForCode("ui_hint").Active, target_tab)
        Tracker:UiHint("ActivateTab", target_tab)
    end
end

function InvalidateReadCaches()
    U8_READ_CACHE_ADDRESS = 0
    U16_READ_CACHE_ADDRESS = 0
end

function ReadU8(segment, address)
    if U8_READ_CACHE_ADDRESS ~= address then
        U8_READ_CACHE = segment:ReadUInt8(address)
        U8_READ_CACHE_ADDRESS = nil
    end

    return U8_READ_CACHE
end

function ReadU16(segment, address)
    if U16_READ_CACHE_ADDRESS ~= address then
        U16_READ_CACHE = segment:ReadUInt16(address)
        U16_READ_CACHE_ADDRESS = address
    end

    return U16_READ_CACHE
end

function isInGame()
    return AutoTracker:ReadU8(0x7e0010, 0) > 0x05
end

function updateInGameStatusFromMemorySegment(segment)

    local mainModuleIdx = segment:ReadUInt8(0x7e0010)

    local wasInTriforceRoom = AUTOTRACKER_IS_IN_TRIFORCE_ROOM
    AUTOTRACKER_IS_IN_TRIFORCE_ROOM = (mainModuleIdx == 0x19 or mainModuleIdx == 0x1a)

    if AUTOTRACKER_IS_IN_TRIFORCE_ROOM and not wasInTriforceRoom then
        ScriptHost:AddMemoryWatch("LTTP Statistics", 0x7ef420, 0x46, updateStatisticsFromMemorySegment)
    end

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        if mainModuleIdx > 0x05 then
            print("Current Room Index: ", segment:ReadUInt16(0x7e00a0))
            print("Last Room Index: ", segment:ReadUInt16(0x7e00a2)) --Last Loaded OW/Dungeon Room Index
            print("Dungeon Layer Index: ", segment:ReadUInt8(0x7e00EE)) --dungeon layer
            print("Current OW   Index: ", segment:ReadUInt16(0x7e008a))
            -- print("detailed Current OW   Index: ", segment:ReadUInt16(0x7e040a))
            print("left/right qudrant:", segment:ReadUInt8(0x7e00a9))
            print("upper/lower qudrant:", segment:ReadUInt8(0x7e00aa))
            print("transtion direction:", segment:ReadUInt8(0x7e0418)) -- 0 - 4 / transition up, downn, left, right
            print("y cord :", segment:ReadUInt16(0x7e0020))
            print("x cord :", segment:ReadUInt16(0x7e0022))
        end
        return false
    end
    if Tracker:FindObjectForCode("ui_hint").Active then
        UpdateUI(segment, mainModuleIdx)
    end
    if Tracker:FindObjectForCode("er_tracking_method").Active then
        UpdateEntrances(segment, mainModuleIdx)
    end

    return true
end

function updateProgressiveItemFromByte(segment, code, address, offset)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        item.CurrentStage = value + (offset or 0)
    end
end

function updateAga1(segment)
    local item = Tracker:FindObjectForCode("aga1")
    local value = ReadU8(segment, 0x7ef3c5)
    if value >= 3 then
        item.Active = true
    else
        item.Active = false
    end
end

function testFlag(segment, address, flag)
    local value = ReadU8(segment, address)
    local flagTest = value & flag

    if flagTest ~= 0 then
        return true
    else
        return false
    end
end

function updateProgressiveBow(segment)
    local item = Tracker:FindObjectForCode("bow")

    if testFlag(segment, 0x7ef38e, 0x80) and ReadU8(segment, 0x7ef340) > 0 then
        item.Active = true
    else
        item.Active = false
    end

    if testFlag(segment, 0x7ef38e, 0x40) then
        item.CurrentStage = 1
    else
        item.CurrentStage = 0
    end
end

function updateBottles(segment)
    local item = Tracker:FindObjectForCode("bottle")
    local count = 0
    for i = 0, 3, 1 do
        if ReadU8(segment, 0x7ef35c + i) > 0 then
            count = count + 1
        end
    end
    item.CurrentStage = count
end

function updateBowAndBombUpgrade(segment)
    local value = segment:ReadU8(0x7ef370)
    Tracker:FindObjectForCode("bombs").AcquiredCount = 10 + value
    local value = segment:ReadU8(0x7ef371)
    Tracker:FindObjectForCode("bow").AcquiredCount = 30 + value
end

function updateToggleItemFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value > 0 then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateToggleItemFromByteAndFlag(segment, code, address, flag)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(item.Name, code, flag)
        end

        local flagTest = value & flag

        if flagTest ~= 0 then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateToggleFromRoomSlot(segment, code, slot)
    local item = Tracker:FindObjectForCode(code)
    local item_boss
    if code == "gt_ice" or code == "gt_lanmo" then
        item_boss = Tracker:FindObjectForCode(code)
    else
        item_boss = Tracker:FindObjectForCode(code .. "_boss")
    end
    if item then
        local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))
       
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(roomData)
        end

        item.Active = (roomData & (1 << slot[2])) ~= 0
        item_boss.Active = (roomData & (1 << slot[2])) ~= 0
    end
end

function updateFlute(segment)
    local item = Tracker:FindObjectForCode("flute")
    local value = ReadU8(segment, 0x7ef38c)

    local fakeFlute = value & 0x02
    local realFlute = value & 0x01

    if realFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 2
    elseif fakeFlute ~= 0 then
        item.Active = true
        item.CurrentStage = 1
    else
        item.Active = false
    end
end

function updateConsumableItemFromByte(segment, code, address, roomSlots)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local keyDropCount = 0

        if Tracker:FindObjectForCode("key_drop_shuffle").Active then
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(roomData, 1 << slot[2], roomData & (1 << slot[2]), item.AcquiredCount)
                end
                   
                if (roomData & (1 << slot[2])) ~= 0 then
                    keyDropCount = keyDropCount + 1
                end
            end
        end

        item.AcquiredCount = value + keyDropCount
    else
        print("Couldn't find item: ", code)
    end
end

function updateConsumableItemFromTwoByteSum(segment, code, address, address2, roomSlots)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local value2 = ReadU8(segment, address2)
        local keyDropCount = 0

        if  Tracker:FindObjectForCode("key_drop_shuffle").Active then
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(roomData, 1 << slot[2], roomData & (1 << slot[2]), item.AcquiredCount)
                end
                   
                if (roomData & (1 << slot[2])) ~= 0 then
                    keyDropCount = keyDropCount + 1
                end
            end
        end
        item.AcquiredCount = value + value2 + keyDropCount
    else
        print("Couldn't find item: ", code)
    end
end

function updatePseudoProgressiveItemFromByteAndFlag(segment, code, address, flag, locationCode)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local flagTest = value & flag

        local isCleared = false
        if locationCode then
            local location = Tracker:FindObjectForCode(locationCode)
            if location then
                if location.AvailableChestCount == 0 then
                    isCleared = true
                end
            end
        end

        if isCleared then
            item.CurrentStage = math.max(2, item.CurrentStage)
        elseif flagTest ~= 0 then
            item.CurrentStage = math.max(1, item.CurrentStage)
        else
            item.CurrentStage = 0
        end
    end
end

function updateSectionChestCountFromByteAndFlag(segment, locationRef, address, flag, callback)
    local location = Tracker:FindObjectForCode(locationRef)
    if location then
        -- Do not auto-track this the user has manually modified it
        if location.Owner.ModifiedByUser then
            return
        end

        local value = ReadU8(segment, address)
       
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(locationRef, value)
        end

        if (value & flag) ~= 0 then
            location.AvailableChestCount = 0
            if callback then
                callback(true)
            end
        else
            location.AvailableChestCount = location.ChestCount
            if callback then
                callback(false)
            end
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Couldn't find location", locationRef)
    end
end

function updateSectionChestCountFromOverworldIndexAndFlag(segment, locationRef, index, callback)
    updateSectionChestCountFromByteAndFlag(segment, locationRef, 0x7ef280 + index, 0x40, callback)
end

-- local clock = os.clock
-- function sleep(n)-- seconds
-- local t0 = clock()
-- while clock() - t0 <= n do end
-- end

function updateSectionChestCountFromRoomSlotList(segment, locationRefList, roomSlots, callback)
    for h,locationRef in pairs(locationRefList) do
        local location = Tracker:FindObjectForCode(locationRef)
        if location then
            -- Do not auto-track this the user has manually modified it
            if location.Owner.ModifiedByUser then
                return
            end

            local clearedCount = 0
            for i,slot in ipairs(roomSlots) do
                local roomData = ReadU16(segment, 0x7ef000 + (slot[1] * 2))

                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(locationRef, roomData, 1 << slot[2], roomData & (1 << slot[2]), location.AvailableChestCount)
                end
                   
                if (roomData & (1 << slot[2])) ~= 0 then
                    clearedCount = clearedCount + 1
                end
            end

            location.AvailableChestCount = location.ChestCount - clearedCount

            if callback then
                callback(clearedCount > 0)
            end
        end
    end
end

function updateBombIndicatorStatus(status)
    local item = Tracker:FindObjectForCode("big_bomb")
    if item then
        if status then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateBatIndicatorStatus(status)
    local item = Tracker:FindObjectForCode("powder")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end

function updateShovelIndicatorStatus(status)
    local item = Tracker:FindObjectForCode("shovel")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end

function updateMushroomStatus(status)
    local item = Tracker:FindObjectForCode("mushroom")
    if item then
        if status then
            item.CurrentStage = 2
        else
            item.CurrentStage = item.CurrentStage
        end
    end
end



AUTOTRACKER_STATS_MARKDOWN_FORMAT = [===[
### Post-Game Summary

Stat | Value
--|-
**Collection Rate** | %d/216
**Deaths** | %d
**Bonks** | %d
**Total Time** | %02d:%02d:%02d.%02d
]===]

function read32BitTimer(segment, baseAddress)
    local timer = 0;
    timer = timer | (ReadU8(segment, baseAddress + 3) << 24)
    timer = timer | (ReadU8(segment, baseAddress + 2) << 16)
    timer = timer | (ReadU8(segment, baseAddress + 1) << 8)
    timer = timer | (ReadU8(segment, baseAddress + 0) << 0)

    local hours = timer // (60 * 60 * 60)
    local minutes = (timer % (60 * 60 * 60)) // (60 * 60)
    local seconds = (timer % (60 * 60)) // (60)
    local frames = timer % 60

    return hours, minutes, seconds, frames
end

function updateStatisticsFromMemorySegment(segment)
    -- print(AutoTracker:ReadU8(0x7e0010, 0))

    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if not AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY then
        -- Read completion timer
        local hours, minutes, seconds, frames = read32BitTimer(segment, 0x7ef43e)

        local collection_rate = ReadU8(segment, 0x7ef423)
        local deaths = ReadU8(segment, 0x7ef449)
        local bonks = ReadU8(segment, 0x7ef420)

        local markdown = string.format(AUTOTRACKER_STATS_MARKDOWN_FORMAT, collection_rate, deaths, bonks, hours, minutes, seconds, frames)
        ScriptHost:PushMarkdownNotification(NotificationType.Celebration, markdown)
    end

    AUTOTRACKER_HAS_DONE_POST_GAME_SUMMARY = true

    return true
end

function test(segment)
    --print("detailed Current OW   Index: ", segment:ReadUInt16(0x7e040a))
end
-- Run the in-game status check more frequently (every 250ms) to catch save/quit scenarios more effectively


-- ScriptHost:AddMemoryWatch("LTTP In-Game Rooms", 0x7e0010, 0x90,  updateInGameRoomsFromMemorySegment, 250)
ScriptHost:AddMemoryWatch("LTTP In-Game status", 0x7e0010, 0x250, updateInGameStatusFromMemorySegment, 250)
-- ScriptHost:AddMemoryWatch("LTTP In-Game status 2", 0x7e0400, 0x250, test, 250)
if Tracker.ActiveVariantUID == "Map Tracker - AP" then
    ScriptHost:AddMemoryWatch("LTTP Item Data", 0x7ef340, 0x90, updateAga1)
end
-- ScriptHost:AddMemoryWatch("LTTP Settings", 0x180000, 250, autofillSettings)
