KEY_DROP_SHUFFLE_STATE = false
SMALL_KEY_STAGE = 0


ACCESS_NONE = AccessibilityLevel.None
ACCESS_PARTIAL = AccessibilityLevel.Partial
ACCESS_INSPECT = AccessibilityLevel.Inspect
ACCESS_SEQUENCEBREAK = AccessibilityLevel.SequenceBreak
ACCESS_NORMAL = AccessibilityLevel.Normal
ACCESS_CLEARED = AccessibilityLevel.Cleared

local bool_to_accesslvl = {
    [true] = ACCESS_NORMAL,
    [false] = ACCESS_NONE
}

function A(result)
    if result then
        return ACCESS_NORMAL
    end
    return ACCESS_NONE
end

function ALL(...)
    local args = { ... }
    local min = ACCESS_NORMAL
    for _, v in ipairs(args) do
        if type(v) == "function" then
            v = v()
        elseif type(v) == "string" then
            v = Has(v)
        end
        if type(v) == "boolean" then
            v = bool_to_accesslvl[v]
        end
        if v < min then
            if v == ACCESS_NONE then
                return ACCESS_NONE
            end
            min = v
        end
    end
    return min
end

function ANY(...)
    local args = { ... }
    local max = ACCESS_NONE
    for _, v in ipairs(args) do
        if type(v) == "function" then
            v = v()
        elseif type(v) == "string" then
            v = Has(v)
        end
        if type(v) == "boolean" then
            v = bool_to_accesslvl[v]
            -- v = A(v)
        end
        if v > max then
            if v == ACCESS_NORMAL then
                return ACCESS_NORMAL
            end
            max = v
        end
    end
    return max
end

function SetSmallKeyGlobal()
    SMALL_KEY_STAGE = Tracker:FindObjectForCode("small_keys").CurrentStage
end

function Has(item, noKDS_amount, noKDS_amountInLogic, KDS_amount, KDS_amountInLogic)
    local count
    local amount
    local amountInLogic
    if (SMALL_KEY_STAGE == 2) and item:sub(-8,-1) == "smallkey" then -- universal keys
        return ACCESS_NORMAL
    end
    if KEY_DROP_SHUFFLE_STATE then
        amount = KDS_amount
        amountInLogic = KDS_amountInLogic
        if item:sub(-8,-1) == "smallkey" then
            item = item.."_drop"
        end
    else
        amount = noKDS_amount
        amountInLogic = noKDS_amountInLogic
    end
    count = Tracker:ProviderCountForCode(item)

    -- print(item, count, amount, amountInLogic)
    if amountInLogic then
        if count >= amountInLogic then
            return ACCESS_NORMAL
        elseif count >= amount then
            return ACCESS_SEQUENCEBREAK
        end
        return ACCESS_NONE
    end
    if not amount then
        if count > 0 then
            return ACCESS_NORMAL
        end
        return ACCESS_NONE
    else
        if count >= amount then
            return ACCESS_SEQUENCEBREAK
        end
        return ACCESS_NONE
    end
end

function KDSreturn( noKDS, KDS)
    return KEY_DROP_SHUFFLE_STATE and KDS or noKDS
    -- if KEY_DROP_SHUFFLE_STATE then
    --     return KDS
    -- end
    -- return noKDS
end

function OWDungeonChecks(...)
    local locations = { ... }
    local availale = 0
    local access_check = 0
    local sequence_breakable = 0
    local inspect = 0
   
    for _, location in ipairs(locations) do
        access_check = Tracker:FindObjectForCode(location).AccessibilityLevel
        if access_check == 6 then
            availale = availale + 1        elseif access_check == 3 then
            inspect = inspect + 1
        elseif access_check == 5 then
            sequence_breakable = sequence_breakable + 1
        end
    end
    if availale > 0 then
        return ACCESS_NORMAL
    elseif sequence_breakable > 0 then
        return ACCESS_SEQUENCEBREAK
    elseif inspect > 0 then
        return ACCESS_INSPECT
    end
    return ACCESS_NONE
end


function DealDamage()
    return ANY(
        "sword",
        "bombs",
        "byrna",
        "somaria",
        -- "bombos",
        -- "ether",
        -- "quake",
        "bow",
        "hookshot",
        "firerod",
        "hammer"
    )
end

function hitRanged()
    return ANY(
        "masterword",
        "bombs",
        "somaria",
        "bow",
        "hookshot",
        "firerod",
        "icerod",
        "blueboomerang",
        "redboomerang"
    )
end

function GetBossRef(nameRef)
    local bosses = {
        [0] = "@Bosses/Unknown",
        [1] = "@Bosses/Armos Knights",
        [2] = "@Bosses/Lanmolas",
        [3] = "@Bosses/Moldorm",
        [4] = "@Bosses/Helmasaur King",
        [5] = "@Bosses/Arrghus",
        [6] = "@Bosses/Mothula",
        [7] = "@Bosses/Blind",
        [8] = "@Bosses/Kholdstare",
        [9] = "@Bosses/Vitreous",
        [10] = "@Bosses/Trinexx"
    }
    local stage = Tracker:FindObjectForCode(nameRef).CurrentStage
    -- local access_lvl = 0
   
    -- access_lvl = Tracker:FindObjectForCode(bosses[stage]).AccessibilityLevel
    return Tracker:FindObjectForCode(bosses[stage]).AccessibilityLevel
    -- return access_lvl
end

function CanActivateTablets()
    if Tracker:FindObjectForCode("swordless").Active then
        return Tracker:FindObjectForCode("hammer").Active
    end
    return (Tracker:FindObjectForCode("sword").CurrentStage > 1)
end

function GetShuffle(item, type)
    -- print(item, type)
    return (Tracker:ProviderCountForCode(item) > 0 and type == "shuffle") or (Tracker:ProviderCountForCode(item) == 0 and type == "vanilla")
end

function CheckSwordless()
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return true
    end
    return Tracker:FindObjectForCode("sword").Active
end

function CanCheckWithBook()
    if Tracker:FindObjectForCode("Book").Active then
        return ACCESS_INSPECT
    end
    return ACCESS_NONE
end

function CanUseMedallions()
    return CheckSwordless()
end

function CanRemoveCurtains()
    return CheckSwordless()
end

function CanClearAgaTowerBarrier()
    -- With cape, we can always get through
    if Tracker:FindObjectForCode("cape").Active then
        return true
    end
    -- Otherwise we need master sword or a hammer depending on the mode
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return Tracker:FindObjectForCode("hammer").Active
    end
    return Tracker:ProviderCountForCode("mastersword") > 0
end

function GTCrystalCount()
    return CheckRequirements("gt_access", "crystal") > 0
end

function GanonCrystalCount()
    return CheckRequirements("ganon_killable", "crystal") > 0
end

function CanSwim(itemNeeded) --fake flippers
    local glitches_state = Tracker:FindObjectForCode("glitches").CurrentStage
    if glitches_state > 0 then -- and itemNeeded ~= nil then
        return itemNeeded ~= nil and Tracker:FindObjectForCode(itemNeeded).Active
    --     return Tracker:FindObjectForCode(itemNeeded).Active
    -- elseif glitches_state > 0 and itemNeeded == nil then
    --     return true
    end
    return Tracker:FindObjectForCode("flippers").Active
end

function smallKeys(dungeon, count, count_in_logic, keydrop_count, keydrop_count_in_logic)
    -- if Tracker:FindObjectForCode("small_keys").CurrentStage == 1 then
    --     if Tracker:FindObjectForCode("key_drop_shuffle").Active == true then
    --         -- Has(dungeon.."_drop", tonumber(keydrop_count), tonumber(keydrop_count_in_logic))
    --         if Tracker:FindObjectForCode(dungeon.."_drop").AcquiredCount >= tonumber(keydrop_count) then
    --             return true
    --         else
    --             return false
    --         end
    --     elseif Tracker:FindObjectForCode(dungeon).AcquiredCount >= tonumber(count) then
    --         return true
    --     else
    --         return false
    --     end
    --     -- else
    --     --     -- Has(dungeon, tonumber(count), tonumber(count_in_logic))
    --     -- end
    -- else
    --     return true
    -- end
end

function BigKeys(dungeon)
    if Tracker:FindObjectForCode("big_keys").Active then
        return Tracker:FindObjectForCode(dungeon).Active
    -- elseif Tracker:FindObjectForCode("big_keys").Active == false and key == "sw_bigkey" and Tracker:FindObjectForCode("firerod").Active == false then
    --     return false
    end
    return true
end

function CheckRequirements(reference, check_count)
    local reqCount = Tracker:ProviderCountForCode(reference)
    local count = Tracker:ProviderCountForCode(check_count)

    if count >= reqCount then
        return 1 --true
    end
    return 0 --false
end

function DarkRooms(torches_available)
    local dark_mode = Tracker:FindObjectForCode("dark_mode").CurrentStage
    local has_lamp = Tracker:ProviderCountForCode("lamp")
    if dark_mode == 2 then --none
        return ACCESS_NORMAL
    elseif dark_mode == 0 and has_lamp > 0 then -- lamp
        return ACCESS_NORMAL
    elseif dark_mode == 1 then
        if torches_available then
            return (has_lamp > 0 or has_lamp > 0)
        end
        return (has_lamp > 0) -- scornes/firerod
    end
    return ACCESS_NONE
end

function CalcHeartpieces()
    local pieces = Tracker:FindObjectForCode("heartpieces")
    pieces.CurrentStage = (Tracker:FindObjectForCode("heartpieces").AcquiredCount % 4)
end

function EnemizerCheck(item)
    return Tracker:FindObjectForCode("enemizer").Active or Tracker:FindObjectForCode(item).Active
end

CAN_INTERACT = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    ["light"] = {},
    ["dark"] = {}
}

function PrecalcCanInteract()
    for i=1,6 do
        CAN_INTERACT["light"][i] = CAN_INTERACT[i] or OpenOrStandard()
        CAN_INTERACT["dark"][i] = CAN_INTERACT[i] or Inverted()
    end
    
end

function UpdateCanInteract()
    local moonpearl = Tracker:FindObjectForCode("pearl").Active
    local glitch_lvl = Tracker:FindObjectForCode("glitches").CurrentStage
    for i=1,6 do
        CAN_INTERACT[i] = moonpearl or (glitch_lvl >= i)
    end
    PrecalcCanInteract()
end

function Can_interact(worldstate, glitch_lvl)
    return CAN_INTERACT[worldstate][glitch_lvl]
    -- local glitchstage = Tracker:FindObjectForCode("glitches").CurrentStage

    -- if (worldstate == "light" and OpenOrStandard()) or (worldstate == "dark" and Inverted()) then
    --     return true
    -- elseif (worldstate == "light" and Inverted()) or (worldstate == "dark" and OpenOrStandard()) then
    --     if Tracker:FindObjectForCode("pearl").Active then
    --         return true
    --     end
    --     if Tracker:FindObjectForCode("glitches").CurrentStage >= glitch_lvl then
    --         return true
    --     end
    --     return false
    -- end
    -- return false
end

function CanFinish()
    local reqs = {
        [1] = {CheckRequirements("ganon_killable", "crystal")},
        [2] = {Tracker:ProviderCountForCode("aga1")},
        [3] = {Tracker:ProviderCountForCode("aga2")},
        [4] = {Tracker:ProviderCountForCode("green_pendant")},
        [5] = {Tracker:ProviderCountForCode("blue_pendant")},
        [6] = {Tracker:ProviderCountForCode("red_pendant")},
        [7] = {CheckRequirements("triforce_pieces_needed", "triforcepieces")},
        [8] = {Tracker:ProviderCountForCode("icerod")}
    }
    local goals = {
        [0] = {reqs[1][1], reqs[3][1]}, --aga2 + ganon killable
        [1] = {reqs[1][1]}, --ganon killable
        [2] = {reqs[1][1], reqs[2][1], reqs[3][1], reqs[4][1], reqs[5][1], reqs[6][1]}, --7crystal, aga1+aga2, 3pendants
        [3] = {reqs[4][1], reqs[5][1], reqs[6][1]}, --3 pendants
        [4] = {reqs[1][1], reqs[4][1], reqs[5][1], reqs[6][1]}, --pendants+ ganon killable
        [5] = {reqs[7][1]}, --trifoce pieces
        [6] = {reqs[1][1], reqs[7][1]}, --triforce pieces + ganon killabel
        [7] = {reqs[8][1]} --icerod
    }
    local beatable = 0

    for k,h in pairs(goals[Tracker:FindObjectForCode("goal").CurrentStage]) do
        beatable = beatable + h
        table_length = k
    end
    local obj = Tracker:FindObjectForCode("go_mode")
    if beatable >= table_length then
        obj.Active = true
        return true
    end
    obj.Active = false
    return false
end

function CanChangeWorldWithMirror()
    return Tracker:FindObjectForCode("mirror").Active
end

function OpenOrStandard()
    return Tracker:FindObjectForCode("start_option").CurrentStage ~= 2
end

function Inverted()
    return Tracker:FindObjectForCode("start_option").CurrentStage == 2
end

function CheckGlitches(stage)
    return Tracker:FindObjectForCode("glitches").CurrentStage >= tonumber(stage)
end

function KeyDropLayoutChange()
    KEY_DROP_SHUFFLE_STATE = Tracker:FindObjectForCode("key_drop_shuffle").Active
    if KEY_DROP_SHUFFLE_STATE then
        Tracker:AddLayouts("layouts/dungeon_items_keydrop.json")
    else
        Tracker:AddLayouts("layouts/dungeon_items.json")
    end
end

function TT_boss_check()
    if Tracker:FindObjectForCode("tt_boss").CurrentStage == 7 then
        return ALL(
            CanReach("tt_attic"),
            CanReach("TT - Blind's Cell"),
            "bombs"
        )
    end
    return true
end

function BossShuffle()
    local dungeon_list = {"ep","dp","toh","pod","sp","sw","tt","ip","mm","tr"}
    if Tracker:FindObjectForCode("boss_shuffle").CurrentStage == 0 then
        for index, dungeon in pairs(dungeon_list) do
            Tracker:FindObjectForCode(dungeon.."_boss").CurrentStage = index
            Tracker:FindObjectForCode("gt_ice").CurrentStage = 1
            Tracker:FindObjectForCode("gt_lanmo").CurrentStage = 2
            Tracker:FindObjectForCode("gt_boss").CurrentStage = 3
        end
    else
        for index, dungeon in pairs(dungeon_list) do
            Tracker:FindObjectForCode(dungeon.."_boss").CurrentStage = 0
            Tracker:FindObjectForCode("gt_ice").CurrentStage = 0
            Tracker:FindObjectForCode("gt_lanmo").CurrentStage = 0
            Tracker:FindObjectForCode("gt_boss").CurrentStage = 0
        end
    end
end

function CountDoneDeadends(inital_keys_needed, ...)
    local locations = { ... }
    local keys_needed = inital_keys_needed
    for _, location in pairs(locations) do
        keys_needed = keys_needed + (Tracker:FindObjectForCode(location).AccessibilityLevel//7)
    end
    return keys_needed
end

function CheckPyramidState()
    local pyramid_open = Tracker:FindObjectForCode("pyramid_state").Active
    if not pyramid_open then
        return Tracker:FindObjectForCode("aga2").Active
    end
    return true
end

function ShopSlotHelper(shop_slot, number)
    
    if Archipelago.PlayerNumber > 0 then
        for index, value in pairs(ALL_LOCATIONS) do
            if type(value) == "number" then
                if tonumber(shop_slot) == value then
                    return true
                end
            end
        end
        return false
    else
        local mod = 9
        local ghost = 8
        if Tracker:FindObjectForCode("shop_include_witchhut").Active then
            mod = 10
            ghost = 9
        end
        if tonumber(number) > ((Tracker:FindObjectForCode("shuffle_item_slots").AcquiredCount + ghost) // mod) then
            return false
        end
        return true
    end
end

local dungeons_prefixes = {
        "hc",
        "ep",
        "dp",
        "toh",
        "at",
        "pod",
        "sp",
        "sw",
        "tt",
        "ip",
        "mm",
        "tr",
        "gt"
    }
-- not sure howto handle reset. i should probably keep a record of some sort of all already gotten items.
function GiveAll(setting)
    local setting_stage = Tracker:FindObjectForCode(setting).CurrentStage
    local mapping = {
        ["maps_setting"] = "_map",
        ["compass_setting"] = "_compass",
        ["bigkeys_setting"] = "_bigkey",
        ["smallkeys_setting"] = "_smallkey"
    }
    -- if Archipelago.PlayerNumber < 0 then
        for _, dungeon_prefix in ipairs(dungeons_prefixes) do
            local item = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting])
            local copy = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting] .. "_copy")
            if setting_stage == 5 or setting_stage == 6 then
               
                if setting == "smallkeys_setting" then
                    item.AcquiredCount = item.MaxCount
                    item = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting].. "_drop")
                    copy = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting] .. "_drop_copy")
                    item.AcquiredCount = item.MaxCount
                else
                    item.Active = true
                end
            else
                if setting == "smallkeys_setting" then
                    item.AcquiredCount = copy.AcquiredCount
                    item = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting].. "_drop")
                    copy = Tracker:FindObjectForCode(dungeon_prefix .. mapping[setting] .. "_drop_copy")
                    item.AcquiredCount = copy.AcquiredCount
                else
                    item.Active = copy.Active
                end
            end
        end
    -- end
end

local shop_default_mapping = {
    [1] = 6,
    [2] = 11,
    [3] = 2,
    [4] = 11,
    [5] = 12,
    [6] = 1,
    [7] = 6,
    [8] = 11,
    [9] = 2,
    [10] = 6,
    [11] = 11,
    [12] = 2,
    [13] = 6,
    [14] = 11,
    [15] = 2,
    [16] = 6,
    [17] = 3,
    [18] = 2,
    [19] = 6,
    [20] = 3,
    [21] = 2,
    [22] = 6,
    [23] = 3,
    [24] = 2,
    [25] = 6,
    [26] = 3,
    [27] = 2,
    [28] = 6,
    [29] = 3,
    [30] = 2,
    [31] = 6,
    [32] = 7,
    [33] = 8
}

function SetCostType()
    local active = Tracker:FindObjectForCode("shuffle_cost_type").Active
    for i,_ in pairs(shop_default_mapping) do
        local item = Tracker:FindObjectForCode("default_shop_price_"..i)
        if active then
            item.CurrentStage = 0
        else
            item.CurrentStage = 1
        end
    end
end
function SetShopInventory()
    local active = Tracker:FindObjectForCode("shop_sanity").Active
    local witch = Tracker:FindObjectForCode("shop_include_witchhut").Active
    for i,v in pairs(shop_default_mapping) do
        local item = Tracker:FindObjectForCode("default_shop_item_"..i)
        if active then
            if i>30 and not witch then
                item.CurrentStage = v
            else
                item.CurrentStage = 0
            end
        else
            item.CurrentStage = v
        end
    end
end


local prize_table = {
    ["crab_pull_1"] = 2,
    ["crab_pull_2"] = 3,
    ["stunprice"] = 6,
    ["tree_pull_1"] = 1,
    ["tree_pull_2"] = 2,
    ["tree_pull_3"] = 3
}
function SetPrizeShuffle()
    if Tracker:FindObjectForCode("prize_shuffle").Active then
        for code, stage in pairs(prize_table) do
            Tracker:FindObjectForCode(code).CurrentStage = 0
        end
    else
        for code, stage in pairs(prize_table) do
            Tracker:FindObjectForCode(code).CurrentStage = stage
        end
    end
end

function setAllAutofill()
    local set_all = Tracker:FindObjectForCode("autofill_all_settings").Active
    Tracker:FindObjectForCode("autofill_dungeon_settings").Active = set_all
    Tracker:FindObjectForCode("autofill_goal_reqs").Active = set_all
    Tracker:FindObjectForCode("autofill_medallions").Active = set_all
    Tracker:FindObjectForCode("autofill_modes").Active = set_all
    Tracker:FindObjectForCode("autofill_misc").Active = set_all
    Tracker:FindObjectForCode("autofill_sanities").Active = set_all
end


ScriptHost:AddWatchForCode("settings maps_setting", "maps_setting", GiveAll)
ScriptHost:AddWatchForCode("settings compass_shuffle", "compass_setting", GiveAll)
ScriptHost:AddWatchForCode("settings smallkeys_setting", "smallkeys_setting", GiveAll)
ScriptHost:AddWatchForCode("settings bigkeys_setting", "bigkeys_setting", GiveAll)


ScriptHost:AddWatchForCode("set shop cost-type", "shuffle_cost_type", SetCostType)
ScriptHost:AddWatchForCode("set shop default inventory", "shop_sanity", SetShopInventory)
ScriptHost:AddWatchForCode("set prize shuffles", "prize_shuffle", SetPrizeShuffle)


ScriptHost:AddWatchForCode("set all autofill", "autofill_all_settings", setAllAutofill)
-- function owDungeonDetails()
--     local dungeon_details = Tracker:FindObjectForCode("ow_dungeon_details")
--     if dungeon_details.Active then
--         Tracker:AddLocations("locations/darkworld_dungeons_detailed.json")
--         Tracker:AddLocations("locations/lightworld_dungeons_detailed.json")
--     else
--         Tracker:AddLocations("locations/darkworld_dungeons.json")
--         Tracker:AddLocations("locations/lightworld_dungeons.json")
--     end
-- end
