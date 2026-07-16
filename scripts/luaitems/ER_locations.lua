ENTRANCE_SELECTED = nil
BASE_IMG_PATH = ImageReference:FromPackRelativePath("images/door_closed.png")

HIGHLIGHT_SOURCE = nil
HIGHLIGHT_TARGET = nil
HIGHLIGHT_LAST_ACTIVATED = 0

ROUTE_MODE = false

local er_storage_item = (Tracker:FindObjectForCode("manual_er_storage") --[[@as LuaItem]]).ItemState
function ER_locations_scope(scope_direction, scope_location_obj, scope_side)

    local Code = string.lower(scope_direction) .. "_" .. scope_location_obj.name
    local Basename  = scope_location_obj.name

    ---Sets the connection between the 2 provided lua items to link them in the graph
    ---@param source LuaItem
    ---@param target LuaItem
    function _SetLocationOptions(source, target) -- source == inside, target == outside
        if MANUAL_CHECKED and er_storage_item then
            -- local er_storage_item = Tracker:FindObjectForCode("manual_er_storage") --[[@as LuaItem]]
            er_storage_item.MANUAL_LOCATIONS[ROOM_SEED][source.Name] = target.Name
        end
        source.ItemState.Target = target.Name
        source.ItemState.TargetCorrespondingLocationSection = target.ItemState.CorrespondingLocationSection
        source.ItemState.TargetBaseName = target.ItemState.BaseName
        source.Icon = target.ItemState.ImgPath
        source.BadgeText = target.ItemState.BadgeTextDirection
    end

    ---Unsets the connection between the provided LuaItem and its set target if any is set
    ---@param source LuaItem
    function _UnsetLocationOptions(source)
        if MANUAL_CHECKED and er_storage_item then
            -- local er_storage_item = (Tracker:FindObjectForCode("manual_er_storage") --[[@as LuaItem]]).ItemState
            if er_storage_item.MANUAL_LOCATIONS[ROOM_SEED][source.Name] then
                er_storage_item.MANUAL_LOCATIONS[ROOM_SEED][source.Name] = nil
            end
        end
        source.ItemState.Target = nil
        source.ItemState.TargetCorrespondingLocationSection = nil
        source.ItemState.TargetBaseName = nil
        source.Icon = source.ItemState.BaseImg
        source.BadgeText = ""
        source.ItemState.Worldstate = source.ItemState.BaseWorldstate
    end

    ---helper function for disconnecting the 2 provided LuaItems
    ---@param target string
    ---@param source string
    local function _LeftClickUnmarkHelper(target, source)
        local target_entrance_from = NAMED_ER_CONNECTIONS["from_" .. target] --[[@as LuaItem]]
        local target_entrance_to = NAMED_ER_CONNECTIONS["to_" .. target] --[[@as LuaItem]]
        local source_entrance_from = NAMED_ER_CONNECTIONS["from_" .. source] --[[@as LuaItem]]
        local source_entrance_to = NAMED_ER_CONNECTIONS["to_" .. source] --[[@as LuaItem]]
        if target_entrance_from ~= nil then
            _UnsetLocationOptions(target_entrance_from)
        end
        if target_entrance_to ~= nil then
            _UnsetLocationOptions(target_entrance_to)
        end
        _UnsetLocationOptions(source_entrance_to)
        _UnsetLocationOptions(source_entrance_from)
    end

    ---helperfunction to connect the provided LuaItems 
    ---@param target string
    ---@param source string
    local function _LeftClickMarkHelper(target, source)
        local target_entrance_from = NAMED_ER_CONNECTIONS["from_" .. target] --[[@as LuaItem]]
        local target_entrance_to = NAMED_ER_CONNECTIONS["to_" .. target] --[[@as LuaItem]]
        local source_entrance_from = NAMED_ER_CONNECTIONS["from_" .. source] --[[@as LuaItem]]
        local source_entrance_to = NAMED_ER_CONNECTIONS["to_" .. source] --[[@as LuaItem]]
        if target_entrance_from ~= nil then
            _SetLocationOptions(source_entrance_from, target_entrance_to) -- enter source exit target
            _SetLocationOptions(target_entrance_to, source_entrance_from)
        end 
        if target_entrance_from and target_entrance_to ~= nil then
            _SetLocationOptions(target_entrance_from, source_entrance_to) -- enter target exit source
            _SetLocationOptions(source_entrance_to, target_entrance_from)
        end
    end

    ---helper function to highlight the first location of a pair that gets selected to signal that something happened
    ---@param location LuaItem
    ---@param highlight integer
    function MarkFirstConnectionPart(location, highlight)
        local source_location
        local location_itemstate = location.ItemState  --[[@as ERItemState]]
        if ER_STAGE < 3 then
            source_location = "@"..table.concat(location_itemstate.CorrespondingLocationSection, "/")
        else
            source_location = "@"..location_itemstate.CorrespondingLocationSection[1].."/"..location_itemstate.CorrespondingLocationSection[2].."/From".." "..location_itemstate.CorrespondingLocationSection[3]
        end
        Tracker:FindObjectForCode(source_location).Highlight = highlight
    end

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        local self_itemstate =  self.ItemState --[[@as ERItemState]]
        if not ROUTE_MODE then
            if ER_STAGE < 3 then --off, dungeons, full
                if ENTRANCE_SELECTED then -- ENTRANCE_SELECTED ~= nil
                    if self_itemstate.Target then -- attempt of new connection to already existing connection (how to handle that?)
                        _LeftClickUnmarkHelper(self_itemstate.TargetBaseName, ENTRANCE_SELECTED)
                    end
                    -- second step of normal new connection
                    _LeftClickMarkHelper(ENTRANCE_SELECTED, self_itemstate.BaseName)
                    MarkFirstConnectionPart(NAMED_ER_CONNECTIONS[self_itemstate.Target]--[[@as LuaItem]], Highlight.None)
                    ENTRANCE_SELECTED = nil
                else -- ENTRANCE_SELECTED == nil
                    MarkFirstConnectionPart(self, Highlight.NoPriority)
                    ENTRANCE_SELECTED = self_itemstate.BaseName
                    if self_itemstate.Target then -- retarget a connection to new target location
                        _LeftClickUnmarkHelper(self_itemstate.TargetBaseName, ENTRANCE_SELECTED)
                    end
                end
            else -- insanity
                local target_entrance
                if ENTRANCE_SELECTED then -- ENTRANCE_SELECTED ~= nil
                    if string.find(ENTRANCE_SELECTED, "from_") then
                        self = NAMED_ER_CONNECTIONS["to_" .. self_itemstate.BaseName] --[[@as LuaItem]]
                    else
                        self = NAMED_ER_CONNECTIONS["from_" .. self_itemstate.BaseName] --[[@as LuaItem]]
                    end
                    if self_itemstate.Target then -- attempt of new connection to already existing connection (how to handle that?)
                        target_entrance = NAMED_ER_CONNECTIONS[self_itemstate.Target] --[[@as LuaItem]]
                        if target_entrance ~= nil then
                            _UnsetLocationOptions(target_entrance)
                            _UnsetLocationOptions(self)
                        end
                    end

                    -- second step of normal new connection
                    target_entrance = NAMED_ER_CONNECTIONS[ENTRANCE_SELECTED] --[[@as LuaItem]]
                    MarkFirstConnectionPart(target_entrance, Highlight.None)
                    if target_entrance ~= nil then
                        _SetLocationOptions(self, target_entrance)
                        _SetLocationOptions(target_entrance, self)
                    end
                    ENTRANCE_SELECTED = nil
                else -- ENTRANCE_SELECTED == nil
                    MarkFirstConnectionPart(self, Highlight.Priority)
                    ENTRANCE_SELECTED = self.Name
                    if self.ItemState.Target then -- retarget a connection to new target location
                        target_entrance = NAMED_ER_CONNECTIONS[self_itemstate.Target] --[[@as LuaItem]]
                        if target_entrance ~= nil then
                            _UnsetLocationOptions(target_entrance)
                            _UnsetLocationOptions(self)
                        end
                    end
                end
            end
        else
            if ENTRANCE_SELECTED then
                GetRoute(NAMED_LOCATIONS[NAMED_ER_CONNECTIONS[ENTRANCE_SELECTED].ItemState.BaseName], NAMED_LOCATIONS[self_itemstate.BaseName])
                Tracker:FindObjectForCode("route_mode").Active = false
                ENTRANCE_SELECTED = nil
            else
                ENTRANCE_SELECTED = self.Name
            end
        end
    end

    ---function that get triggered when right clicking a lua items as hosted item or in an itemgrid
    ---will remove the connection between the selected luaItem and its connected partner
    ---specific to ER LuaItems
    ---@param self LuaItem
    local function OnRightClickFunc(self)
        local self_itemstate = self.ItemState --[[@as ERItemState]]
        if ENTRANCE_SELECTED ~= nil then
            print("set back to nil")
            ENTRANCE_SELECTED = nil
        end
        if not ROUTE_MODE then
            if ER_STAGE < 3 then -- off, dungeons, full
                if self_itemstate.Target ~= nil then
                    local target_from = NAMED_ER_CONNECTIONS{"from_" .. self_itemstate.TargetBaseName} --[[@as LuaItem]]
                    local target_to = NAMED_ER_CONNECTIONS{"to_" .. self_itemstate.TargetBaseName} --[[@as LuaItem]]
                    local source_from = NAMED_ER_CONNECTIONS{"from_" .. self_itemstate.BaseName} --[[@as LuaItem]]
                    local source_to = NAMED_ER_CONNECTIONS{"to_" .. self_itemstate.BaseName} --[[@as LuaItem]]
                    if target_from ~= nil then
                        _UnsetLocationOptions(target_from)
                        _UnsetLocationOptions(source_to)
                    end
                    if target_to ~= nil then
                        _UnsetLocationOptions(target_to)
                        _UnsetLocationOptions(source_from)
                    end
                    ForceUpdate()
                end
            else -- insanity
                if self_itemstate.Target ~= nil then
                    local target = NAMED_ER_CONNECTIONS(self_itemstate.Target) --[[@as LuaItem]]
                    if target ~= nil then
                        _UnsetLocationOptions(target)
                        _UnsetLocationOptions(self)
                    end
                    ForceUpdate()
                end
            end
        end
    end

    ---function that get triggered when middle clicking a lua items as hosted item or in an itemgrid
    ---will highlight itself and the connected LuaItem on the map to make sptting connected entrances easier
    ---specific to ER LuaItems
    ---@param self LuaItem
    local function OnMiddleClickFunc(self)
        HIGHLIGHT_LAST_ACTIVATED = os.clock()
        ScriptHost:AddOnFrameHandler("temporary highlight handler", RemoveTempHighlight)
        if HIGHLIGHT_SOURCE then
            HIGHLIGHT_SOURCE.Highlight = Highlight.None
        end
        if HIGHLIGHT_TARGET then
            HIGHLIGHT_TARGET.Highlight = Highlight.None
        end
        -- print(Dump_table(self.ItemState))
        
        local source_ItemState = self.ItemState --[[@as ERItemState]]

        local source_location = nil
        local target_location = nil
        local target = NAMED_ER_CONNECTIONS[source_ItemState.Target] --[[@as LuaItem]]

        local target_ItemState = target.ItemState --[[@as ERItemState]]
        if ER_STAGE == 3 then
            source_location = "@"..source_ItemState.CorrespondingLocationSection[1].."/"..source_ItemState.CorrespondingLocationSection[2].."/"..target_ItemState.Direction.." "..source_ItemState.CorrespondingLocationSection[3]
            target_location = "@"..target_ItemState.CorrespondingLocationSection[1].."/"..target_ItemState.CorrespondingLocationSection[2].."/"..source_ItemState.Direction.." "..target_ItemState.CorrespondingLocationSection[3]
        else
            source_location = "@"..table.concat(source_ItemState.CorrespondingLocationSection, "/")
            target_location = "@"..table.concat(target_ItemState.CorrespondingLocationSection, "/")
        end
        HIGHLIGHT_SOURCE = Tracker:FindObjectForCode(source_location) --[[@as LocationSection]] --location/section
        HIGHLIGHT_SOURCE.Highlight = Highlight.Avoid
        HIGHLIGHT_TARGET = Tracker:FindObjectForCode(target_location) --[[@as LocationSection]] --location/section
        HIGHLIGHT_TARGET.Highlight = Highlight.Avoid
        Tracker:UiHint("ActivateTab", "Entrances")
        if source_ItemState.Map ~= nil then --outside
            Tracker:UiHint("ActivateTab", source_ItemState.Map)
        end
        -- local target = NAMED_ER_CONNECTIONS(source_ItemState.Target) --[[@as LuaItem]]
        if target_ItemState.Map  ~= nil then --outside
            Tracker:UiHint("ActivateTab", target_ItemState.Map)
        end
    end

    ---comment
    ---@param self LuaItem
    ---@param code string
    ---@return boolean
    local function CanProvideCodeFunc(self, code)
        return code == Code
    end

    ---comment
    ---@param self LuaItem
    ---@param code string
    ---@return integer
    local function ProvidesCodeFunc(self, code)
        local self_itemstate = self.ItemState  --[[@as ERItemState]]
    --     return 1
    -- end
        if code == Code then
            -- print(self.Name)
            if self_itemstate.Target ~= nil then  --and Tracker:FindObjectForCode("er_tracking").CurrentStage > 0 then
                local target_obj = (NAMED_ER_CONNECTIONS[self_itemstate.Target] --[[@as LuaItem]]).ItemState --[[@as ERItemState]]
                if self_itemstate.IsDeadEnd or target_obj.IsDeadEnd then
                    -- local location_obj = self.ItemState --[[@as table]]
                    -- local target_obj = Tracker:FindObjectForCode(self.ItemState.Target).ItemState --[[@as table]]
                    local deadendBackup = (self_itemstate.DeadendColorBackup or target_obj.DeadendColorBackup) --[[@as table]]
                    if deadendBackup ~= nil then
                        local sum = 0
                        for _, lookup_location in pairs(deadendBackup) do
                            sum = sum + Tracker:FindObjectForCode(lookup_location).AvailableChestCount
                        end
                        if sum > 0 then
                            -- print("return ACCESS_INSPECT")
                            return 0
                        end
                    end
                    return 1
                end
            end
        end
        return 0
    end


    ---comment
    local function AdvanceToCodeFunc()
        print("AdvanceToCodeFunc")
    end

    ---save function triggered on closing popotracker to have a state to restore later on. specific to ER LuaItems
    ---@param self LuaItem
    ---@return table
    local function SaveLocationFunc(self)
        return {
            Stage = self.ItemState.Stage, --unused
            Active = self.ItemState.Active, --true/false
            Side = self.ItemState.Side, --
            Target = self.ItemState.Target, --location.Name
            TargetBaseName = self.ItemState.TargetBaseName, --location.Name
            BaseName = self.ItemState.BaseName, --location.Name
            Name = self.Name, --str
            Shortname = self.ItemState.Shortname, --str
            Icon = self.Icon, --icurretn set img path
            BadgeText = self.BadgeText, --curretn badge text
            Direction = self.ItemState.Direction, --from/to
            Room = self.ItemState.Room, --room number
            Worldstate = self.ItemState.Worldstate,
            BaseWorldstate = self.ItemState.BaseWorldstate,
            ImgPath = self.ItemState.ImgPath,
            BaseImg = self.ItemState.BaseImg,
            BadgeTextDirection = self.ItemState.BadgeTextDirection, --from/to
            CorrespondingLocationSection = self.ItemState.CorrespondingLocationSection,
            TargetCorrespondingLocationSection = self.ItemState.TargetCorrespondingLocationSection,
            IsDeadEnd = self.ItemState.IsDeadEnd,
            IsDungeon = self.ItemState.IsDungeon,
            IsConnector = self.ItemState.IsConnector,
            DeadendColorBackup = self.ItemState.DeadendColorBackup,
            Map = self.ItemState.Map
        }
        -- print("SaveFunc")
    end

    ---function triggered on loading the pack to restore the lat saves state. specific to ER LuaItems
    ---@param self LuaItem
    ---@param data table
    local function LoadLocationFunc(self, data)
        if data ~= nil and self.Name == data.Name then
            self.ItemState.Target = data.Target
            self.ItemState.TargetBaseName = data.TargetBaseName
            self.ItemState.BaseName = data.BaseName
            self.ItemState.Side = data.Side
            self.ItemState.Shortname = data.Shortname
            self.ItemState.Direction = data.Direction
            self.ItemState.Room = data.Room
            self.ItemState.Worldstate = data.Worldstate
            self.ItemState.BaseWorldstate = data.BaseWorldstate
            self.Icon = ImageReference:FromPackRelativePath(data.Icon)
            self.ItemState.ImgPath = data.ImgPath
            self.ItemState.BaseImg = data.BaseImg
            self.ItemState.BadgeTextDirection = data.BadgeTextDirection
            self.ItemState.CorrespondingLocationSection = data.CorrespondingLocationSection
            self.ItemState.TargetCorrespondingLocationSection = data.TargetCorrespondingLocationSection
            self.ItemState.IsDeadEnd = data.IsDeadEnd
            self.ItemState.IsDungeon = data.IsDungeon
            self.ItemState.IsConnector = data.IsConnector
            self.ItemState.DeadendColorBackup = data.DeadendColorBackup
            self.ItemState.Map = data.Map
            if data.BadgeText ~= nil then
                self.BadgeText = data.BadgeText
                self.BadgeTextColor = "#abcdef"
                self:SetOverlayFontSize(10)
                self:SetOverlayAlign("left")
            end
        else
            -- print("skipped laoding")
        end

        -- print("LoadFunc")
    end


    local function PropertyChangedFunc()
        -- print("PropertyChangedFunc")
    end
    local function ItemState()
    end
    local function Name()
    end
    local function Icon ()--> ImageReference:FromPackRelativePath()
    end
    local function Type()
    end


    ---@class ERItemState
    ---@field BaseName string
    ---@field ImgPath ImageReference
    ---@field BaseImg string
    ---@field Stage integer
    ---@field Active boolean
    ---@field Side string
    ---@field Target? string
    ---@field TargetBaseName? string
    ---@field Shortname string
    ---@field Direction string
    ---@field Room integer
    ---@field Worldstate string
    ---@field BaseWorldstate string
    ---@field Map string
    ---@field BadgeTextDirection string
    ---@field CorrespondingLocationSection string[]
    ---@field TargetCorrespondingLocationSection? string[]
    ---@field IsDeadEnd boolean
    ---@field IsDungeon boolean
    ---@field IsConnector boolean
    ---@field DeadendColorBackup any

    -- LuaLocationItems = {}
    -- LuaLocationItems.__index = LuaLocationItems

    ---function to create ER LuaItems in their default state
    ---@param direction string
    ---@param location_obj alttp_location_new_return
    ---@param side string
    ---@return LuaItem
    function CreateLuaLocationItems(direction, location_obj, side)
        local self = ScriptHost:CreateLuaItem()
        -- self.Type = "custom"
        self.Name = string.lower(direction) .. "_" .. location_obj.name --code --
        self.Icon = ImageReference:FromPackRelativePath("images/door_closed.png")
        ---@type ERItemState
        self.ItemState = {
            BaseName = location_obj.name,
            ImgPath = ImageReference:FromPackRelativePath("images/entrances/" .. side .. "/" .. string.gsub(location_obj.name, "_" .. side, "") .. ".png"),
            BaseImg = BASE_IMG_PATH,
            Stage = 0,
            Active = true,
            Side = side,
            Target = nil,
            TargetBaseName = nil,
            Shortname = location_obj.shortname,
            Direction = direction,
            Room = location_obj.room,
            Worldstate = location_obj.worldstate,
            BaseWorldstate = location_obj.worldstate,
            Map= location_obj.map, 
            BadgeTextDirection = direction .. " " .. location_obj.shortname,
            CorrespondingLocationSection = location_obj.locationsection,
            TargetCorrespondingLocationSection = nil,
            IsDeadEnd = false,
            IsDungeon = false,
            IsConnector = false,
            DeadendColorBackup = location_obj.deadendColorBackup,
        } --[[@as table<string, any>]]

        local Code = string.lower(direction) .. "_" .. location_obj.name

        if location_obj.deadEndOrDungeonOrConnector == "deadend" then
            self.ItemState.IsDeadEnd = true
        elseif location_obj.deadEndOrDungeonOrConnector == "dungeon" then
            self.ItemState.IsDungeon = true
        elseif location_obj.deadEndOrDungeonOrConnector == "connector" then
            self.ItemState.IsConnector = true
        end
        self.BadgeTextColor = "#abcdef"
        self:SetOverlayFontSize(10)
        self:SetOverlayAlign("left")

        
        self.ItemState.Side = side
    
        self.CanProvideCodeFunc = CanProvideCodeFunc
        self.OnLeftClickFunc = OnLeftClickFunc
        self.OnRightClickFunc = OnRightClickFunc
        
        self.OnMiddleClickFunc = OnMiddleClickFunc
        self.ProvidesCodeFunc = ProvidesCodeFunc
        -- self.AdvanceToCodeFunc = AdvanceToCodeFunc
        self.SaveFunc = SaveLocationFunc
        self.LoadFunc = LoadLocationFunc
        self.PropertyChangedFunc = PropertyChangedFunc
        -- self.ItemState = ItemState
        return self
    end


    return CreateLuaLocationItems(scope_direction, scope_location_obj, scope_side)

end

---function to reset all ER connections back to their base state for the given ER setting
function Reset_ER_setings()
    ScriptHost:RemoveMemoryWatch("StateChanged")
    for name, _ in pairs(NAMED_ENTRANCES) do
        _UnsetLocationOptions(NAMED_ER_CONNECTIONS[name]--[[@as LuaItem]])
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_er").Active = false
end
-- ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_setings)

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
        local location_obj = (NAMED_ER_CONNECTIONS[locationname]--[[@as LuaItem]]).ItemState --[[@as table]]
        if location_obj then
            if location_obj.Target then
                local target_obj = (NAMED_ER_CONNECTIONS[location_obj.Target]--[[@as LuaItem]]).ItemState
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