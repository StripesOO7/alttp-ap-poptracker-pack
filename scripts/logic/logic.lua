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
    name = boss.Name
    stage = boss.CurrentStage
    -- print(name, stage) --Eastern palace boss 0.0
    stage_int = math.floor(stage)
    -- print("if")
    if stage_int == 0 then
        return 1, 0
    elseif stage_int == 1 then
        return 1, Tracker:FindObjectForCode("@Bosses/Armos Knights").AccessibilityLevel
    elseif stage_int == 2 then
        return 1, Tracker:FindObjectForCode("@Bosses/Lanmolas").AccessibilityLevel
    elseif stage_int == 3 then
        return 1, Tracker:FindObjectForCode("@Bosses/Moldorm").AccessibilityLevel
    elseif stage_int == 4 then
        return 1, Tracker:FindObjectForCode("@Bosses/Helmasaur King").AccessibilityLevel
    elseif stage_int == 5 then
        return 1, Tracker:FindObjectForCode("@Bosses/Arrghus").AccessibilityLevel
    elseif stage_int == 6 then
        return 1, Tracker:FindObjectForCode("@Bosses/Mothula").AccessibilityLevel
    elseif stage_int == 7 then
        return 1, Tracker:FindObjectForCode("@Bosses/Blind").AccessibilityLevel
    elseif stage_int == 8 then
        return 1, Tracker:FindObjectForCode("@Bosses/Kholdstare").AccessibilityLevel
    elseif stage_int == 9 then
        return 1, Tracker:FindObjectForCode("@Bosses/Vitreous").AccessibilityLevel
    elseif stage_int == 10 then
        return 1, Tracker:FindObjectForCode("@Bosses/Trinexx").AccessibilityLevel
    end
    
    print("Failed Boss_check with ".. name .. "and" .. stage)
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
        return Tracker:ProviderCountForCode("sword2")
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

-- function badges()
--     return Tracker:ProviderCountForCode("stonebadge") + Tracker:ProviderCountForCode("knucklebadge") + Tracker:ProviderCountForCode("dynamobadge") + Tracker:ProviderCountForCode("heatbadge") + Tracker:ProviderCountForCode("balancebadge") + Tracker:ProviderCountForCode("featherbadge") + Tracker:ProviderCountForCode("rainbadge") + Tracker:ProviderCountForCode("mindbadge")
-- end

-- function norman_open()
--     if (has("op_norm_bdg")) then
--         return badges() >= Tracker:ProviderCountForCode('normanreq')
--     end
--     return  Tracker:ProviderCountForCode('gyms') >= Tracker:ProviderCountForCode('normanreq')
-- end

-- function e4_open()
--     if (has("op_e4_bdg")) then
--         return badges() >= Tracker:ProviderCountForCode('e4req')
--     end
--     return Tracker:ProviderCountForCode('gyms') >= Tracker:ProviderCountForCode('e4req')
-- end

-- function hid()
--     return has("itemfinder") or has("op_if_off")
-- end

-- function can_cut()
--     return (has("hm01") and has("stonebadge"))
-- end

-- function can_flash()
--     return (has("op_hm5_off") or (has("hm05") and has("knucklebadge")))
-- end

-- function can_rocksmash()
--     return (has("hm06") and has("dynamobadge"))
-- end

-- function can_strength()
--     return (has("hm04") and has("heatbadge"))
-- end

-- function can_surf()
--     return (has("hm03") and has("balancebadge"))
-- end

-- function can_fly()
--     return (has("hm02") and has("featherbadge"))
-- end

-- function can_dive()
--     return (has("hm08") and has("mindbadge") and can_surf())
-- end

-- function can_waterfall()
--     return (has("hm07") and has("rainbadge") and can_surf())
-- end

-- function can_bike()
--     return (has("machbike") or has("acrobike"))
-- end

-- function dewford_access()
--     return (has("recovergoods") or can_surf())
-- end

-- function slateport_access()
--     return (has("stevenletter") or can_surf() or (can_rocksmash() and can_bike()))
-- end

-- function mauville_access()
--     return (can_rocksmash() or can_surf() or has("sterngoods") or (slateport_access() and can_bike()))
-- end

-- function meteorfalls_access()
--     return ((can_surf()) or (mauville_access() and can_rocksmash()))
-- end

-- function fallarbor_access()
--     return ((can_surf() and has("stealmeteor")) or (mauville_access() and can_rocksmash()))
-- end

-- function lavaridge_access()
--     return (has("stealmeteor") and fallarbor_access())
-- end

-- function lilycove_access()
--     return (mauville_access() and can_surf() and has("weatherins")) or (slateport_access() and has("op_fer_on") and has("ssticket"))
-- end

-- function rt121_access()
--     return (mauville_access() and can_surf() and has("weatherins")) or (slateport_access() and has("op_fer_on") and has("ssticket") and (can_surf() or can_cut()))
-- end

-- function elite_four()
--     return e4_open() and lilycove_access() and can_waterfall() and can_flash() and can_strength() and can_rocksmash()
-- end