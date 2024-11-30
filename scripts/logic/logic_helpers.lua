function A(result)
    if result then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function all(...)
    local args = { ... }
    local min = AccessibilityLevel.Normal
    for _, v in ipairs(args) do
        if type(v) == "boolean" then
            v = A(v)
        end
        if v < min then
            if v == AccessibilityLevel.None then
                return AccessibilityLevel.None
            else
                min = v
            end
        end
    end
    return min
end

function any(...)
    local args = { ... }
    local max = AccessibilityLevel.None
    for _, v in ipairs(args) do
        if type(v) == "boolean" then
            v = A(v)
        end
        if tonumber(v) > tonumber(max) then
            if tonumber(v) == AccessibilityLevel.Normal then
                return AccessibilityLevel.Normal
            else
                max = tonumber(v)
            end
        end
    end
    return max
end

function has(item, noKDS_amount, noKDS_amountInLogic, KDS_amount, KDS_amountInLogic)
    local count
    local amount
    local amountInLogic
    if (Tracker:FindObjectForCode("small_keys").CurrentStage == 2) and item:sub(-8,-1) == "smallkey" then -- universal keys
        return true
    end
    if Tracker:FindObjectForCode("key_drop_shuffle").Active then
        -- print(KDS_amount, KDS_amountInLogic)
        amount = KDS_amount
        amountInLogic = KDS_amountInLogic
        if item:sub(-8,-1) == "smallkey" then
            count = Tracker:ProviderCountForCode(item.."_drop")
        else
            count = Tracker:ProviderCountForCode(item)
        end
    else
        count = Tracker:ProviderCountForCode(item)
        amount = noKDS_amount
        amountInLogic = noKDS_amountInLogic
    end

    -- print(item, count, amount, amountInLogic)
    if amountInLogic then
        if count >= amountInLogic then
            return AccessibilityLevel.Normal
        elseif count >= amount then
            return AccessibilityLevel.SequenceBreak
        else
            return AccessibilityLevel.None
        end
    end
    if not amount then
        if count > 0 then
            return AccessibilityLevel.Normal
        else
            return AccessibilityLevel.None
        end
    else
        amount = tonumber(amount)
        if count >= amount then
            return AccessibilityLevel.SequenceBreak
        else
            return AccessibilityLevel.None
        end
    end
end

function KDSreturn( noKDS, KDS)
    -- print(noKDS, KDS)
    if Tracker:FindObjectForCode("key_drop_shuffle").Active then
        return KDS
    else
        return noKDS
    end
end

function owDungeonChecks(...)
    local locations = { ... }
    local availale 
    local access_check
    availale = 0
    local sequence_breakable 
    sequence_breakable= 0
    for _, location in ipairs(locations) do
       
        -- access_check =  CanReach(location) 
        access_check = Tracker:FindObjectForCode(location).AccessibilityLevel
        -- print(location, access_check)
        if access_check == 5 then
            sequence_breakable = sequence_breakable+1
        elseif access_check == 6 then
            availale = availale + 1
        end
    end
    if availale > 0 then
        return AccessibilityLevel.Normal
    elseif sequence_breakable > 0 then
        return AccessibilityLevel.SequenceBreak
    else
        return AccessibilityLevel.None
    end
end


function dealDamage()
    return any(
        has("sword"),
        has("bombs"),
        has("byrna"),
        has("somaria"),
        -- has("bombos"),
        -- has("ether"),
        -- has("quake"),
        has("bow"),
        has("hookshot"),
        has("firerod"),
        has("hammer")
    )
end

function getBossRef(nameRef)
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
    local access_lvl = 0
    
    access_lvl = Tracker:FindObjectForCode(bosses[stage]).AccessibilityLevel
    return access_lvl
end

function canActivateTablets()
    if Tracker:FindObjectForCode("swordless").Active then
        return Tracker:FindObjectForCode("hammer").Active
    else
        return (Tracker:FindObjectForCode("sword").CurrentStage > 1)
    end
end

function getShuffle(item, type)
    -- print(item, type)
    if Tracker:ProviderCountForCode(item) > 0 and type == "shuffle" then
        return true
    elseif Tracker:ProviderCountForCode(item) == 0 and type == "vanilla" then
        return true
    else 
        return false
    end
end

function checkSwordless()
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return 1
    else
        return Tracker:ProviderCountForCode("sword")
    end
end

function canCheckWithBook()
    if Tracker:FindObjectForCode("Book") then
        return AccessibilityLevel.Inspect
    else
        return AccessibilityLevel.None
    end
end

function canUseMedallions()
    return checkSwordless()
end

function canRemoveCurtains()
    return checkSwordless()
end

function canClearAgaTowerBarrier()
    -- With cape, we can always get through
    if Tracker:ProviderCountForCode("cape") > 0 then
        return 1
    end
    -- Otherwise we need master sword or a hammer depending on the mode
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return Tracker:ProviderCountForCode("hammer")
    else
        return Tracker:ProviderCountForCode("mastersword")
    end    
end

function gtCrystalCount()
    return checkRequirements("gt_access", "crystal")
end

function ganonCrystalCount()
    return checkRequirements("ganon_killable", "crystal")
end

function canSwim(itemNeeded) --fake flippers
    if Tracker:FindObjectForCode("glitches").CurrentStage > 0 and itemNeeded ~= nil then
        return Tracker:FindObjectForCode(itemNeeded).Active
    elseif Tracker:FindObjectForCode("glitches").CurrentStage > 0 and itemNeeded == nil then 
        return true
    else
        return Tracker:ProviderCountForCode("flippers")
    end
end

function smallKeys(dungeon, count, count_in_logic, keydrop_count, keydrop_count_in_logic)
    -- if Tracker:FindObjectForCode("small_keys").CurrentStage == 1 then
    --     if Tracker:FindObjectForCode("key_drop_shuffle").Active == true then
    --         -- has(dungeon.."_drop", tonumber(keydrop_count), tonumber(keydrop_count_in_logic))
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
    --     --     -- has(dungeon, tonumber(count), tonumber(count_in_logic))
    --     -- end
    -- else
    --     return true
    -- end
end

function bigKeys(dungeon)
    if Tracker:FindObjectForCode("big_keys").Active == true then
        return Tracker:FindObjectForCode(dungeon).Active
    -- elseif Tracker:FindObjectForCode("big_keys").Active == false and key == "sw_bigkey" and Tracker:FindObjectForCode("firerod").Active == false then
    --     return false
    else
        return true
    end
end

function checkRequirements(reference, check_count)
    local reqCount = Tracker:ProviderCountForCode(reference)
    local count = Tracker:ProviderCountForCode(check_count)

    if count >= reqCount then
        return 1
    else
        return 0
    end
end

function darkRooms()
    local dark_mode = Tracker:FindObjectForCode("dark_mode").CurrentStage
    if dark_mode == 2 then --none
        return true
    elseif  dark_mode == 0 and Tracker:ProviderCountForCode("lamp") > 0 then -- lamp
        return true
    elseif  dark_mode == 1 and (Tracker:ProviderCountForCode("firerod") > 0 or Tracker:ProviderCountForCode("lamp") > 0) then -- scornes/firerod
        return true
    else
        return false
    end
end

function calcHeartpieces()
    local pieces = Tracker:FindObjectForCode("heartpieces")
    pieces.CurrentStage = (Tracker:FindObjectForCode("heartpieces").AcquiredCount % 4)
end

function enemizerCheck(item)
    if Tracker:FindObjectForCode("enemizer").Active == true then
        return true
    end
    if Tracker:FindObjectForCode(item).Active == true then
        return true
    else
        return false
    end
end

function can_interact(world, glitch_lvl)
    if (world == "light" and openOrStandard()) or (world == "dark" and inverted()) then
        return true
    elseif (world == "light" and inverted()) or (world == "dark" and openOrStandard()) then
        if Tracker:FindObjectForCode("pearl").Active then
            return true
        end
        if Tracker:FindObjectForCode("glitches").CurrentStage >= glitch_lvl then
            return true
        end
        return false
    end
    return false
end

function canFinish() 
    local reqs = {
        [1] = {checkRequirements("ganon_killable", "crystal")},
        [2] = {Tracker:ProviderCountForCode("aga1")},
        [3] = {Tracker:ProviderCountForCode("aga2")},
        [4] = {Tracker:ProviderCountForCode("green_pendant")},
        [5] = {Tracker:ProviderCountForCode("blue_pendant")},
        [6] = {Tracker:ProviderCountForCode("red_pendant")},
        [7] = {checkRequirements("triforce_pieces_needed", "triforcepieces")},
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
    else
        obj.Active = false
        return false
    end
end

function canChangeWorldWithMirror()
    if Tracker:FindObjectForCode("mirror").Active then
        return true
    end
    return false
end

function openOrStandard(item)
    if Tracker:FindObjectForCode("start_option").CurrentStage ~= 2 then
        if item then
            return Tracker:FindObjectForCode(item).Active
        end
        return true
    end
    return false
end

function inverted(item)
    if Tracker:FindObjectForCode("start_option").CurrentStage == 2 then
        if item then
            return Tracker:FindObjectForCode(item).Active
        end
        return true
    end
    return false
end

function checkGlitches(stage)
    if Tracker:FindObjectForCode("glitches").CurrentStage >= tonumber(stage) then
        return true
    end
    return false
end

function keyDropLayoutChange()
    local key_drop = Tracker:FindObjectForCode("key_drop_shuffle")
    if key_drop.Active then
        Tracker:AddLayouts("layouts/dungeon_items_keydrop.json")
    else
        Tracker:AddLayouts("layouts/dungeon_items.json")
    end
end

function tt_boss_check()
    if Tracker:FindObjectForCode("tt_boss").CurrentStage == 7 then 
        return all(
            CanReach("tt_attic"),
            CanReach("TT - Blind's Cell"),
            has("bombs")
        )
    else
        return true
    end
end

function bossShuffle()
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
