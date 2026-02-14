local frequency = math.random(10, #ALL_LOCATIONS)
local trap_counter = 0
local item_id_index = {}
for item_index,v in pairs(ITEM_MAPPING) do
    Table_insert_at(item_id_index, #item_id_index, item_index)
end


function TrapOnClear()
    onClear()
end

function TrapUndoItem()
    MANUAL_CHECKED = false
    local id = math.random(#item_id_index)
    local item_code = item_id_index[id]
    local item_obj = Tracker:FindObjectForCode(item_code)
    if item_obj then
        ItemReset(item_obj.Type, item_obj, item_code)
    end
    MANUAL_CHECKED = true
end

function TrapUndoLocation()
    MANUAL_CHECKED = false
    local id = math.random(#Archipelago.CheckedLocations)
    for _, location in pairs(LOCATION_MAPPING[id]) do
        if location then
            local location_obj = Tracker:FindObjectForCode(location)
            if location_obj then
                LocationReset(location, location_obj, Tracker:FindObjectForCode("manual_location_storage").ItemState)
            end
        end
    end
    MANUAL_CHECKED = true
end

-- function TrapUiHint()
-- end

function TrapInvalidState()
    MANUAL_CHECKED = false
    local itemid = math.random(#item_id_index)
    Tracker:FindObjectForCode(item_id_index[itemid]).CurrentStage = 1000
    MANUAL_CHECKED = true
end

function TrapRandomHighlight()
    if #Archipelago.MissingLocations > 0 then
        local locationid = math.random(Archipelago.MissingLocations[1], Archipelago.MissingLocations[#Archipelago.MissingLocations])
        for ID, location in pairs(LOCATION_MAPPING[locationid]) do
            if location:sub(1, 1) == "@" then
                Tracker:FindObjectForCode(location).Highlight = Highlight.Priority
            end
        end
    end
end

function TrapSleepStall()
    local start = os.time()
    while os.difftime(os.time(), start) < math.random(5,15) do
        -- print("trololo")
    end
end