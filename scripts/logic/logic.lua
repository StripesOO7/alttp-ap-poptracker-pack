function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function badges()
    return Tracker:ProviderCountForCode("stonebadge") + Tracker:ProviderCountForCode("knucklebadge") + Tracker:ProviderCountForCode("dynamobadge") + Tracker:ProviderCountForCode("heatbadge") + Tracker:ProviderCountForCode("balancebadge") + Tracker:ProviderCountForCode("featherbadge") + Tracker:ProviderCountForCode("rainbadge") + Tracker:ProviderCountForCode("mindbadge")
end

function norman_open()
    if (has("op_norm_bdg")) then
        return badges() >= Tracker:ProviderCountForCode('normanreq')
    end
    return  Tracker:ProviderCountForCode('gyms') >= Tracker:ProviderCountForCode('normanreq')
end

function e4_open()
    if (has("op_e4_bdg")) then
        return badges() >= Tracker:ProviderCountForCode('e4req')
    end
    return Tracker:ProviderCountForCode('gyms') >= Tracker:ProviderCountForCode('e4req')
end

function hid()
    return has("itemfinder") or has("op_if_off")
end

function can_cut()
    return (has("hm01") and has("stonebadge"))
end

function can_flash()
    return (has("op_hm5_off") or (has("hm05") and has("knucklebadge")))
end

function can_rocksmash()
    return (has("hm06") and has("dynamobadge"))
end

function can_strength()
    return (has("hm04") and has("heatbadge"))
end

function can_surf()
    return (has("hm03") and has("balancebadge"))
end

function can_fly()
    return (has("hm02") and has("featherbadge"))
end

function can_dive()
    return (has("hm08") and has("mindbadge") and can_surf())
end

function can_waterfall()
    return (has("hm07") and has("rainbadge") and can_surf())
end

function can_bike()
    return (has("machbike") or has("acrobike"))
end

function dewford_access()
    return (has("recovergoods") or can_surf())
end

function slateport_access()
    return (has("stevenletter") or can_surf() or (can_rocksmash() and can_bike()))
end

function mauville_access()
    return (can_rocksmash() or can_surf() or has("sterngoods") or (slateport_access() and can_bike()))
end

function meteorfalls_access()
    return ((can_surf()) or (mauville_access() and can_rocksmash()))
end

function fallarbor_access()
    return ((can_surf() and has("stealmeteor")) or (mauville_access() and can_rocksmash()))
end

function lavaridge_access()
    return (has("stealmeteor") and fallarbor_access())
end

function lilycove_access()
    return (mauville_access() and can_surf() and has("weatherins")) or (slateport_access() and has("op_fer_on") and has("ssticket"))
end

function rt121_access()
    return (mauville_access() and can_surf() and has("weatherins")) or (slateport_access() and has("op_fer_on") and has("ssticket") and (can_surf() or can_cut()))
end

function elite_four()
    return e4_open() and lilycove_access() and can_waterfall() and can_flash() and can_strength() and can_rocksmash()
end