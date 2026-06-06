local frequency = math.random(10, #ALL_LOCATIONS)
local trap_counter = 0
local item_id_index = { [0] = ""}
for item_index,v in pairs(ITEM_MAPPING) do
    table.insert(item_id_index, item_index)
end

-- print(dump_table(item_id_index))
---trap functions to reset the entire pack via whats being called in onClear
function TrapOnClear()
    onClear()
end

---trap function to randomly reset 1 item from the already obtained items
function TrapUndoItem()
    MANUAL_CHECKED = false
    local id = math.random(#item_id_index)
    local item_code = item_id_index[id]
    local item_obj = Tracker:FindObjectForCode(ITEM_MAPPING[item_code][1][1])  --[[@as JsonItem]]
    if item_obj then
        ItemReset(item_obj.Type, item_obj, item_code)
    end
    MANUAL_CHECKED = true
end

---trap function to randomly reset 1 location from the already checked locations
function TrapUndoLocation()
    MANUAL_CHECKED = false
    if #Archipelago.CheckedLocations > 0 then
        local id = math.random(#Archipelago.CheckedLocations)
        for _, location in pairs(LOCATION_MAPPING[Archipelago.CheckedLocations[id]]) do
            if location then
                local location_obj = Tracker:FindObjectForCode(location)  --[[@as LocationSection]]
                if location_obj then
                    LocationReset(location, location_obj, (Tracker:FindObjectForCode("manual_location_storage")  --[[@as LuaItem]]).ItemState)
                end
            end
        end
    end
    MANUAL_CHECKED = true
end

-- function TrapUiHint()
-- end

---trap function to bring most items into an invalid state. Progressive Items will be set to the max stage others will
--disappear from the grid
function TrapInvalidState()
    MANUAL_CHECKED = false
    local itemid = math.random(#item_id_index)
    local item_code = item_id_index[itemid]
    local item_obj = Tracker:FindObjectForCode(ITEM_MAPPING[item_code][1][1])
    item_obj.CurrentStage = 1000
    MANUAL_CHECKED = true
end

---Puts a random highlight on a not already highlighted and not cleared locationSection
function TrapRandomHighlight()
    if #Archipelago.MissingLocations > 0 then
        local locationid = math.random(#Archipelago.MissingLocations)
        for ID, location in pairs(LOCATION_MAPPING[Archipelago.MissingLocations[locationid]]) do
            if location:sub(1, 1) == "@" then
                (Tracker:FindObjectForCode(location)  --[[@as LocationSection]]).Highlight = Highlight.Priority
            end
        end
    end
end

---comment
function TrapSleepStall()
    local start = os.time()
    local stall_time = math.random(5,15)
    print("stall_time", stall_time)
    while os.difftime(os.time(), start) < stall_time do
        -- entry_point:discover(ACCESS_NORMAL, 0, nil)
        -- print(os.difftime(os.time(), start))
        
    end
end

local LAST_TRAP_CALLED = os.time()
---comment
function Frame_counter()
    -- print("call trap frame counter", LAST_TRAP_CALLED)

    if os.time() - LAST_TRAP_CALLED > 600 then --for prod
    -- if os.time() - LAST_TRAP_CALLED > 6 then --for testing
        local roll = math.random(1001)
        -- print("rolled new random value for traps")
        -- print(roll)
        if roll <= 250 then  -- 25.0%
            TrapUndoItem()
        elseif roll <= 599 then  -- 24.9%
            TrapUndoLocation()
        elseif roll == 600 then -- 0.1%
            ScriptHost:RemoveOnFrameHandler("Trap Handler")
            TrapOnClear()
        elseif roll <= 650 then  -- 5.0%
            TrapInvalidState()
        elseif roll <= 800 then  -- 15.0%
            TrapRandomHighlight()
        else                     -- 20.0%
            TrapSleepStall()
        end
        
        if Archipelago.PlayerNumber == -1 then
            ScriptHost:RemoveOnFrameHandler("Trap Handler")
            return
        end
        LAST_TRAP_CALLED = os.time() --comment out for testing
    end
end


ScriptHost:AddOnFrameHandler("Trap Handler", Frame_counter)