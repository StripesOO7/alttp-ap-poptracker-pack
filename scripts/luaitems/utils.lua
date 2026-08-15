


function ChangeDmgClassProperty(item_code)
    local enemy_number, dmg_class = item_code:match("([^_]+)_([^_]+)")
    -- print(enemy_number, dmg_class)
    Tracker:FindObjectForCode("enemy_"..enemy_number).ItemState.Damage_table[tonumber(dmg_class)+1] = Tracker:FindObjectForCode(item_code).CurrentStage
    AddManualItemStorage(item_code, "manual_dmg_class_storage")
    CanKillUpdate()
end

---function to reset all ER connections back to their base state for the given ER setting
function Reset_ER_settings()
    ScriptHost:RemoveWatchForCode("StateChanged")
    for name, _ in pairs(NAMED_ER_ENTRANCES) do
        _UnsetLocationOptions(NAMED_ER_CONNECTIONS[name]--[[@as LuaItem]])
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_er").Active = false
end

---function to reset all Doors connections back to their base state for the given ER setting
function Reset_Doors_settings()
    ScriptHost:RemoveWatchForCode("StateChanged")
    for name, _ in pairs(NAMED_DOORS_ENTRANCES) do
        _UnsetDoorsLocationOptions(NAMED_DOORS_CONNECTIONS[name]--[[@as LuaItem]])
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_doors").Active = false
end

---function to reset all Damag Class Shuffle connections back to their base state for the given ER setting
function Reset_Dmg_Class_Shuffle_settings()
    ScriptHost:RemoveWatchForCode("StateChanged")
    for enemy_number=0, #DEFAULT_ENEMY_DAMAGE_TABLE-1 do 
        local enemy_object = Tracker:FindObjectForCode("enemy_"..enemy_number).ItemState
        if enemy_object then
            for dmg_class_index=0, 15 do
                
                enemy_object.Damage_table[dmg_class_index+1] = enemy_object.Default_damage_table[dmg_class_index+1]
                Tracker:FindObjectForCode(enemy_number.."_"..dmg_class_index).CurrentStage = enemy_object.Default_damage_table[dmg_class_index+1]
            end
        end
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_dmg_class_shuffle").Active = false
end
-- ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_settings)

---helper function that gets called to remove the hilight set from ER luaItem-middleclick function
function RemoveTempHighlight()
    local current_time = os.clock()
    if current_time - HIGHLIGHT_LAST_ACTIVATED > 10 then
        ScriptHost:RemoveOnFrameHandler("temporary highlight handler")
        HIGHLIGHT_LAST_ACTIVATED = 0
        HIGHLIGHT_SOURCE.Highlight = Highlight.None
        HIGHLIGHT_SOURCE = nil
        HIGHLIGHT_TARGET.Highlight = Highlight.None
        HIGHLIGHT_TARGET = nil
    end
end

---functions to make clear that a normally useless deadend connections still has an uncollected item and thus has some
---significance to the player
---@param locationname string
---@return integer
function ChangeLocationColor(locationname)
    if not Tracker.BulkUpdate then
        local location_obj = nil
        if NAMED_ER_CONNECTIONS[locationname] then
            location_obj = (NAMED_ER_CONNECTIONS[locationname]--[[@as LuaItem]]).ItemState --[[@as table]]
        elseif NAMED_DOORS_CONNECTIONS[locationname] then
            location_obj = (NAMED_DOORS_CONNECTIONS[locationname]--[[@as LuaItem]]).ItemState --[[@as table]]
        else
            error("Location: "..locationname.." is neither an ER nor a DOORS connection.")
        end
        -- location_obj = (NAMED_ER_CONNECTIONS[locationname]--[[@as LuaItem]]).ItemState --[[@as table]]
        if location_obj then
            if location_obj.Target then
                local target_obj = nil
                if NAMED_ER_CONNECTIONS[location_obj.Target] then
                    target_obj = (NAMED_ER_CONNECTIONS[location_obj.Target]--[[@as LuaItem]]).ItemState
                elseif NAMED_DOORS_CONNECTIONS[location_obj.Target] then
                    target_obj = (NAMED_DOORS_CONNECTIONS[location_obj.Target]--[[@as LuaItem]]).ItemState
                else
                    error("Location-Target: "..location_obj.Target.." is neither an ER nor a DOORS connection.")
                end
                -- local target_obj = (NAMED_ER_CONNECTIONS[location_obj.Target]--[[@as LuaItem]]).ItemState
                -- print(Dump_table(target_obj.ItemState))
                -- local from_target_obj = Tracker:FindObjectForCode("from_"..location_obj.ItemState.target)
                if target_obj then
                    if location_obj.IsDeadEnd or target_obj.IsDeadEnd then
                        -- print(location_obj.DeadendColorBackup)
                        -- print(target_obj.DeadendColorBackup)
                        local deadendBackup = location_obj.DeadendColorBackup or target_obj.DeadendColorBackup
                        if deadendBackup ~= nil then
                            local sum = 0
                            for _, lookup_location in pairs(deadendBackup) do
                                sum = sum + Tracker:FindObjectForCode(lookup_location).AvailableChestCount
                            end
                            if sum > 0 then
                                -- print("return ACCESS_INSPECT")
                                return ACCESS_INSPECT
                            end
                        else
                            return ACCESS_CLEARED
                        end
                        -- print("target ACCESS_CLEARED")
                        -- return ACCESS_NONE
                        -- return ACCESS_NONE
                    end
                    if location_obj.IsConnector or target_obj.IsConnector then
                        -- print("target ACCESS_INSPECT")
                        return ACCESS_INSPECT
                    end
                    if location_obj.IsDungeon or target_obj.IsDungeon then
                        -- print("target ACCESS_SEQUENCEBREAK")
                        return ACCESS_SEQUENCEBREAK
                    end
                    -- return ACCESS_NORMAL
                end
            end
        end
        -- print(location_obj.ItemState.BaseName)
        return CanReach(location_obj.BaseName)
    end
    -- print("afer bulkupdate check")
    -- local base_locationname = string.gsub(string.gsub(locationname, "from_", "", 1), "to_", "", 1)
    -- print("return CanReach", locationname, base_locationname, CanReach(base_locationname))
    return ACCESS_NONE
end

-- ---functions to make clear that a normally useless deadend connections still has an uncollected item and thus has some
-- ---significance to the player
-- ---@param locationname string
-- ---@return integer
-- function ChangeLocationColor(locationname)
--     if not Tracker.BulkUpdate then
--         local location_obj = (NAMED_DOORS_CONNECTIONS[locationname]--[[@as LuaItem]]).ItemState --[[@as table]]
--         if location_obj then
--             if location_obj.Target then
--                 local target_obj = (NAMED_DOORS_CONNECTIONS[location_obj.Target]--[[@as LuaItem]]).ItemState
--                 -- print(Dump_table(target_obj.ItemState))
--                 -- local from_target_obj = Tracker:FindObjectForCode("from_"..location_obj.ItemState.target)
--                 if target_obj then
--                     if location_obj.IsDeadEnd or target_obj.IsDeadEnd then
--                         -- print(location_obj.DeadendColorBackup)
--                         -- print(target_obj.DeadendColorBackup)
--                         local deadendBackup = location_obj.DeadendColorBackup or target_obj.DeadendColorBackup
--                         if deadendBackup ~= nil then
--                             local sum = 0
--                             for _, lookup_location in pairs(deadendBackup) do
--                                 sum = sum + Tracker:FindObjectForCode(lookup_location).AvailableChestCount
--                             end
--                             if sum > 0 then
--                                 -- print("return ACCESS_INSPECT")
--                                 return ACCESS_INSPECT
--                             end
--                         else
--                             return ACCESS_CLEARED
--                         end
--                         -- print("target ACCESS_CLEARED")
--                         -- return ACCESS_NONE
--                         -- return ACCESS_NONE
--                     end
--                     if location_obj.IsConnector or target_obj.IsConnector then
--                         -- print("target ACCESS_INSPECT")
--                         return ACCESS_INSPECT
--                     end
--                     if location_obj.IsDungeon or target_obj.IsDungeon then
--                         -- print("target ACCESS_SEQUENCEBREAK")
--                         return ACCESS_SEQUENCEBREAK
--                     end
--                     -- return ACCESS_NORMAL
--                 end
--             end
--         end
--         -- print(location_obj.ItemState.BaseName)
--         return CanReach(location_obj.BaseName)
--     end
--     -- print("afer bulkupdate check")
--     -- local base_locationname = string.gsub(string.gsub(locationname, "from_", "", 1), "to_", "", 1)
--     -- print("return CanReach", locationname, base_locationname, CanReach(base_locationname))
--     return ACCESS_NONE
-- end