require("scripts.luaitems.manual_storage_cache")

Manual_Storage_Cache_scope("manual_location_storage")
Manual_Storage_Cache_scope("manual_er_storage")
Manual_Storage_Cache_scope("manual_misc_items_storage")
-- Manual_Storage_Cache_scope("manual_dmg_class_storage")

require("scripts.luaitems.ER_locations")
require("scripts.luaitems.Doors_locations")
require("scripts.luaitems.doors")
-- require("scripts.luaitems.damage_classes")
-- require("scripts.luaitems.enemies")

Dungeon_key_mapping = {
    ["AT_entrance_outside"] = "at",
    ["AT_entrance_inside"] = "at",
    ["CE_dropdown_entrance_outside"] = "hc",
    ["CE_dropdown_entrance_inside"] = "hc",
    ["CE_stairs_outside"] = "hc",
    ["CE_stairs_inside"] = "hc",
    ["DP_back_entrance_outside"] = "dp",
    ["DP_back_entrance_inside"] = "dp",
    ["DP_left_entrance_outside"] = "dp",
    ["DP_left_entrance_inside"] = "dp",
    ["DP_main_entrance_outside"] = "dp",
    ["DP_main_entrance_inside"] = "dp",
    ["DP_right_entrance_outside"] = "dp",
    ["DP_right_entrance_inside"] = "dp",
    ["EP_entrance_outside"] = "ep",
    ["EP_entrance_inside"] = "ep",
    ["HC_left_entrance_outside"] = "hc",
    ["HC_left_entrance_inside"] = "hc",
    ["HC_main_entrance_outside"] = "hc",
    ["HC_main_entrance_inside"] = "hc",
    ["HC_right_entrance_outside"] = "hc",
    ["HC_right_entrance_inside"] = "hc",
    ["ToH_entrance_outside"] = "toh",
    ["ToH_entrance_outside_weird_state"] = "toh",
    ["ToH_entrance_inside"] = "toh",
    ["GT_entrance_outside"] = "gt",
    ["GT_entrance_inside"] = "gt",
    ["IP_entrance_outside"] = "ip",
    ["IP_entrance_inside"] = "ip",
    ["MM_entrance_outside"] = "mm",
    ["MM_entrance_inside"] = "mm",
    ["PoD_entrance_outside"] = "pod",
    ["PoD_entrance_inside"] = "pod",
    ["SP_entrance_outside"] = "sp",
    ["SP_entrance_inside"] = "sp",
    ["SW_back_entrance_outside"] = "sw",
    ["SW_back_entrance_inside"] = "sw",
    ["SW_big_chest_entrance_outside"] = "sw",
    ["SW_big_chest_entrance_inside"] = "sw",
    ["SW_bottom_left_drop_outside"] = "sw",
    ["SW_bottom_left_drop_inside"] = "sw",
    ["SW_gibdo_entrance_outside"] = "sw",
    ["SW_gibdo_entrance_inside"] = "sw",
    ["SW_north_drop_outside"] = "sw",
    ["SW_north_drop_inside"] = "sw",
    ["SW_pinball_drop_outside"] = "sw",
    ["SW_pinball_drop_inside"] = "sw",
    ["SW_pot_circle_drop_outside"] = "sw",
    ["SW_pot_circle_drop_inside"] = "sw",
    ["SW_west_lobby_entrance_outside"] = "sw",
    ["SW_west_lobby_entrance_inside"] = "sw",
    ["TR_big_chest_entrance_outside"] = "tr",
    ["TR_big_chest_entrance_inside"] = "tr",
    ["TR_eye_bridge_entrance_outside"] = "tr",
    ["TR_eye_bridge_entrance_inside"] = "tr",
    ["TR_laser_entrance_outside"] = "tr",
    ["TR_laser_entrance_inside"] = "tr",
    ["TR_main_entrance_outside"] = "tr",
    ["TR_main_entrance_inside"] = "tr",
    ["TT_entrance_outside"] = "tr",
    ["TT_entrance_inside"] = "tr",
}