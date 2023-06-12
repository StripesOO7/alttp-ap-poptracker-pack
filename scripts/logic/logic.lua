function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function getBossRef(nameRef)
    local boss = Tracker:FindObjectForCode(nameRef)
    -- name = boss.Name
    stage = boss.CurrentStage
    -- print(name, stage) --Eastern palace boss 0.0
    stage_int = math.floor(stage)
    access_lvl = 0
    -- print("if")
    if stage_int == 0 then
       access_lvl = 1
    elseif stage_int == 1 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Armos Knights").AccessibilityLevel
    elseif stage_int == 2 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Lanmolas").AccessibilityLevel
    elseif stage_int == 3 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Moldorm").AccessibilityLevel
    elseif stage_int == 4 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Helmasaur King").AccessibilityLevel
    elseif stage_int == 5 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Arrghus").AccessibilityLevel
    elseif stage_int == 6 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Mothula").AccessibilityLevel
    elseif stage_int == 7 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Blind").AccessibilityLevel
    elseif stage_int == 8 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Kholdstare").AccessibilityLevel
    elseif stage_int == 9 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Vitreous").AccessibilityLevel
    elseif stage_int == 10 then
       access_lvl = Tracker:FindObjectForCode("@Bosses/Trinexx").AccessibilityLevel
    end
    if access_lvl > 0 then
        return true
    end
    -- print("Failed Boss_check with ".. name .. "and" .. stage)
    return 0
end

function canActivateTablets()
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return Tracker:ProviderCountForCode("hammer")
    else
        return Tracker:ProviderCountForCode("mastersword")
    end
end

function canUseMedallions()
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return 1
    else
        return Tracker:ProviderCountForCode("sword")
    end
end

function canRemoveCurtains()
    if Tracker:ProviderCountForCode("swordless") > 0 then
        return 1
    else
        return Tracker:ProviderCountForCode("sword")
    end
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
    local reqCount = Tracker:ProviderCountForCode("gt_access")
    local count = Tracker:ProviderCountForCode("crystal")

    if count >= reqCount then
        return 1
    else
        return 0
    end
end

function ganonCrystalCount()
    local reqCount = Tracker:ProviderCountForCode("ganon_killable")
    local count = Tracker:ProviderCountForCode("crystal")

    if count >= reqCount then
        return 1
    else
        return 0
    end
end