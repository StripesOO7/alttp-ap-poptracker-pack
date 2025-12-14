ENTRANCE_SELECTED = nil
BASE_IMG_PATH = ImageReference:FromPackRelativePath("images/door_closed.png")

HIGHLIGHT_SOURCE = nil
HIGHLIGHT_TARGET = nil
HIGHLIGHT_LAST_ACTIVATED = 0

ROUTE_MODE = false

function _SetLocationOptions(source, target) -- source == inside, target == outside
    if MANUAL_CHECKED then
        local er_storage_item = Tracker:FindObjectForCode("manual_er_storage")
        er_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED][source.Name] = target.Name
    end
    source.ItemState.Target = target.Name
    source.ItemState.TargetCorrespondingLocationSection = target.ItemState.CorrespondingLocationSection
    source.ItemState.TargetBaseName = target.ItemState.BaseName
    source.Icon = target.ItemState.ImgPath
    source.BadgeText = target.ItemState.BadgeTextDirection
end

function _UnsetLocationOptions(source)
    if MANUAL_CHECKED then
        local er_storage_item = Tracker:FindObjectForCode("manual_er_storage").ItemState
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

local function _LeftClickUnmarkHelper(taget, source)
    local target_entrance_from = Tracker:FindObjectForCode("from_" .. taget)
    local target_entrance_to = Tracker:FindObjectForCode("to_" .. taget)
    local source_entrance_from = Tracker:FindObjectForCode("from_" .. source)
    local source_entrance_to = Tracker:FindObjectForCode("to_" .. source)
    if target_entrance_from ~= nil then
        _UnsetLocationOptions(target_entrance_from)
    end
    if target_entrance_to ~= nil then
        _UnsetLocationOptions(target_entrance_to)
    end
    _UnsetLocationOptions(source_entrance_to)
    _UnsetLocationOptions(source_entrance_from)
end

local function _LeftClickMarkHelper(taget, source)
    local target_entrance_from = Tracker:FindObjectForCode("from_" .. taget)
    local target_entrance_to = Tracker:FindObjectForCode("to_" .. taget)
    local source_entrance_from = Tracker:FindObjectForCode("from_" .. source)
    local source_entrance_to = Tracker:FindObjectForCode("to_" .. source)
    if target_entrance_from ~= nil then
        _SetLocationOptions(source_entrance_from, target_entrance_to) -- enter source exit target
        _SetLocationOptions(target_entrance_to, source_entrance_from)
    end
    if target_entrance_to ~= nil then 
        _SetLocationOptions(target_entrance_from, source_entrance_to) -- enter target exit source
        _SetLocationOptions(source_entrance_to, target_entrance_from)
    end
end

function MarkFirstConnectionPart(location, highlight)
    local source_location
    if Tracker:FindObjectForCode("er_tracking").CurrentStage < 3 then
        source_location = "@"..table.concat(location.ItemState.CorrespondingLocationSection, "/")
    else
        source_location = "@"..location.ItemState.CorrespondingLocationSection[1].."/"..location.ItemState.CorrespondingLocationSection[2].."/From".." "..location.ItemState.CorrespondingLocationSection[3]
    end
    Tracker:FindObjectForCode(source_location).Highlight = highlight
end

local function OnLeftClickFunc(self)
    if not ROUTE_MODE then
        if ER_STAGE < 3 then --off, dungeons, full
            if ENTRANCE_SELECTED then -- ENTRANCE_SELECTED ~= nil
                if self.ItemState.Target then -- attempt of new connection to already existing connection (how to handle that?)
                    _LeftClickUnmarkHelper(self.ItemState.TargetBaseName, ENTRANCE_SELECTED)
                end
                -- second step of normal new connection
                _LeftClickMarkHelper(ENTRANCE_SELECTED, self.ItemState.BaseName)
                MarkFirstConnectionPart(Tracker:FindObjectForCode(self.ItemState.Target), Highlight.None)
                ENTRANCE_SELECTED = nil
            else -- ENTRANCE_SELECTED == nil
                MarkFirstConnectionPart(self, Highlight.NoPriority)
                ENTRANCE_SELECTED = self.ItemState.BaseName
                if self.ItemState.Target then -- retarget a connection to new target location
                    _LeftClickUnmarkHelper(self.ItemState.TargetBaseName, ENTRANCE_SELECTED)
                end
            end
        else -- insanity
            local target_entrance
            if ENTRANCE_SELECTED then -- ENTRANCE_SELECTED ~= nil
                if string.find(ENTRANCE_SELECTED, "from_") then
                    self = Tracker:FindObjectForCode("to_" .. self.ItemState.BaseName)
                else
                    self = Tracker:FindObjectForCode("from_" .. self.ItemState.BaseName)
                end
                if self.ItemState.Target then -- attempt of new connection to already existing connection (how to handle that?)
                    target_entrance = Tracker:FindObjectForCode(self.ItemState.Target)
                    if target_entrance ~= nil then
                        _UnsetLocationOptions(target_entrance)
                        _UnsetLocationOptions(self)
                    end
                end

                -- second step of normal new connection
                target_entrance = Tracker:FindObjectForCode(ENTRANCE_SELECTED)
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
                    target_entrance = Tracker:FindObjectForCode(self.ItemState.Target)
                    if target_entrance ~= nil then
                        _UnsetLocationOptions(target_entrance)
                        _UnsetLocationOptions(self)
                    end
                end
            end
        end
    else
        if ENTRANCE_SELECTED then
            GetRoute(NAMED_LOCATIONS[Tracker:FindObjectForCode(ENTRANCE_SELECTED).ItemState.BaseName], NAMED_LOCATIONS[self.ItemState.BaseName])
            Tracker:FindObjectForCode("route_mode").Active = false
            ENTRANCE_SELECTED = nil
        else
            ENTRANCE_SELECTED = self.Name
        end
    end
end

local function OnRightClickFunc(self)
    if ENTRANCE_SELECTED ~= nil then
        print("set back to nil")
        ENTRANCE_SELECTED = nil
    end
    if not ROUTE_MODE then
        if ER_STAGE < 3 then -- off, dungeons, full
            if self.ItemState.Target ~= nil then
                local target_from = Tracker:FindObjectForCode("from_" .. self.ItemState.TargetBaseName)
                local target_to = Tracker:FindObjectForCode("to_" .. self.ItemState.TargetBaseName)
                local source_from = Tracker:FindObjectForCode("from_" .. self.ItemState.BaseName)
                local source_to = Tracker:FindObjectForCode("to_" .. self.ItemState.BaseName)
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
            if self.ItemState.Target ~= nil then
                local target = Tracker:FindObjectForCode(self.ItemState.Target)
                if target ~= nil then
                    _UnsetLocationOptions(target)
                    _UnsetLocationOptions(self)
                end
                ForceUpdate()
            end
        end
    end
end

local function OnMiddleClickFunc(self)
    HIGHLIGHT_LAST_ACTIVATED = os.clock()
    ScriptHost:AddOnFrameHandler("temporary highlight handler", RemoveTempHighlight)
    if HIGHLIGHT_SOURCE then
        HIGHLIGHT_SOURCE.Highlight = Highlight.None
    end
    if HIGHLIGHT_TARGET then
        HIGHLIGHT_TARGET.Highlight = Highlight.None
    end
    -- print(dump_table(self.ItemState))
    local source_location = nil
    local target_location = nil
    local target = Tracker:FindObjectForCode(self.ItemState.Target)
    if Tracker:FindObjectForCode("er_tracking").CurrentStage == 3 then
        source_location = "@"..self.ItemState.CorrespondingLocationSection[1].."/"..self.ItemState.CorrespondingLocationSection[2].."/"..target.ItemState.Direction.." "..self.ItemState.CorrespondingLocationSection[3]
        target_location = "@"..target.ItemState.CorrespondingLocationSection[1].."/"..target.ItemState.CorrespondingLocationSection[2].."/"..self.ItemState.Direction.." "..target.ItemState.CorrespondingLocationSection[3]
    else
        source_location = "@"..table.concat(self.ItemState.CorrespondingLocationSection, "/")
        target_location = "@"..table.concat(target.ItemState.CorrespondingLocationSection, "/")
    end
    HIGHLIGHT_SOURCE = Tracker:FindObjectForCode(source_location) --location/section
    HIGHLIGHT_SOURCE.Highlight = Highlight.Avoid
    HIGHLIGHT_TARGET = Tracker:FindObjectForCode(target_location) --location/section
    HIGHLIGHT_TARGET.Highlight = Highlight.Avoid
    Tracker:UiHint("ActivateTab", "Entrances")
    if self.ItemState.BaseWorldstate ~= nil then --outside
        if self.ItemState.BaseWorldstate == "light" then
            Tracker:UiHint("ActivateTab", "Lightworld OW")
        else
            Tracker:UiHint("ActivateTab", "Darkworld OW")
        end
    -- else
    --     if self.ItemState.BaseWorldstate == "light" then --inside
    --         Tracker:UiHint("ActivateTab", "Lightworld Caves")
    --     else
    --         Tracker:UiHint("ActivateTab", "Darkworld Caves")
    --     end
    end
    local target = Tracker:FindObjectForCode(self.ItemState.Target)
    if target.ItemState.BaseWorldstate  ~= nil then --outside
        if target.ItemState.BaseWorldstate == "light" then
            Tracker:UiHint("ActivateTab", "Lightworld OW")
        else
            Tracker:UiHint("ActivateTab", "Darkworld OW")
        end
    -- else
    --     if target.ItemState.BaseWorldstate == "light" then --inside
    --         Tracker:UiHint("ActivateTab", "Lightworld Caves")
    --     else
    --         Tracker:UiHint("ActivateTab", "Darkworld Caves")
    --     end
    end
end

local function CanProvideCodeFunc(self, code)
    return code == self.Name
end

local function ProvidesCodeFunc(self, code)
--     return 1
-- end
    if CanProvideCodeFunc(self, code) then
        -- print(self.Name)
        if self.ItemState.Target ~= nil then  --and Tracker:FindObjectForCode("er_tracking").CurrentStage > 0 then
            if self.ItemState.IsDeadEnd or Tracker:FindObjectForCode(self.ItemState.Target).ItemState.IsDeadEnd then
                return 1
            end
        end
    end
    return 0
end

local function AdvanceToCodeFunc()
    print("AdvanceToCodeFunc")
end

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
        IsConnector = self.ItemState.IsConnector
    }
    -- print("SaveFunc")
end

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

-- LuaLocationItems = {}
-- LuaLocationItems.__index = LuaLocationItems

function CreateLuaLocationItems(direction, location_obj, side)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = string.lower(direction) .. "_" .. location_obj.name --code --
    self.Icon = ImageReference:FromPackRelativePath("images/door_closed.png")
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
        BadgeTextDirection = direction .. " " .. location_obj.shortname,
        CorrespondingLocationSection = location_obj.locationsection,
        TargetCorrespondingLocationSection = nil,
        IsDeadEnd = false,
        IsDungeon = false,
        IsConnector = false
    }
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
    -- self.OnRightClickFunc = OnMiddleClickFunc
    self.OnMiddleClickFunc = OnMiddleClickFunc
    self.ProvidesCodeFunc = ProvidesCodeFunc
    -- self.AdvanceToCodeFunc = AdvanceToCodeFunc
    self.SaveFunc = SaveLocationFunc
    self.LoadFunc = LoadLocationFunc
    self.PropertyChangedFunc = PropertyChangedFunc
    -- self.ItemState = ItemState
    return self
end

local function SaveManualLocationStorageFunc(self)
    return {
        MANUAL_LOCATIONS = self.ItemState.MANUAL_LOCATIONS,
        MANUAL_LOCATIONS_ORDER = self.ItemState.MANUAL_LOCATIONS_ORDER,
        Name = self.Name,
        Icon = self.Icon
    }
    -- print("SaveFunc")
end

local function LoadManualLocationStorageFunc(self, data)
    -- print(self.Name, data.Name)
    -- print("loading data from:", data)
    -- print(dump_table(data))
    if data ~= nil and self.Name == data.Name then
        -- print("assigning saved data for ", data.Name)
        -- print(dump_table(data))
        self.ItemState.MANUAL_LOCATIONS = data.MANUAL_LOCATIONS
        self.ItemState.MANUAL_LOCATIONS_ORDER = data.MANUAL_LOCATIONS_ORDER
        self.Icon = ImageReference:FromPackRelativePath(data.Icon)
    else
        -- print("skipped laoding")
    end

    -- print("LoadFunc")
end

function CreateLuaManualStorageItem(name)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = name --code --
    self.Icon = ImageReference:FromPackRelativePath("images/AP-item.png")
    self.ItemState = {
        MANUAL_LOCATIONS = {
            ["default"] = {}
        },
        MANUAL_LOCATIONS_ORDER = {}
    }
   
    self.CanProvideCodeFunc = CanProvideCodeFunc
    self.OnLeftClickFunc = OnLeftClickFunc
    self.OnRightClickFunc = OnRightClickFunc
    self.OnMiddleClickFunc = OnMiddleClickFunc
    self.ProvidesCodeFunc = ProvidesCodeFunc
    -- self.AdvanceToCodeFunc = AdvanceToCodeFunc
    self.SaveFunc = SaveManualLocationStorageFunc
    self.LoadFunc = LoadManualLocationStorageFunc
    self.PropertyChangedFunc = PropertyChangedFunc
    -- self.ItemState = ItemState
    return self
end

function Reset_ER_setings()
    ScriptHost:RemoveMemoryWatch("StateChanged")
    for name, _ in pairs(NAMED_ENTRANCES) do
        _UnsetLocationOptions(Tracker:FindObjectForCode(name))
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_er").Active = false
end
-- ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_setings)

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

function ChangeLocationColor(locationname)
    if not Tracker.BulkUpdate then
    -- print(locationname)
    local location_obj = Tracker:FindObjectForCode(locationname).ItemState
    -- if location_obj == nil then
    --     return 0
    -- end
        if location_obj then
            if location_obj.Target then
                local target_obj = Tracker:FindObjectForCode(location_obj.Target).ItemState
                -- print(dump_table(target_obj.ItemState))
                -- local from_target_obj = Tracker:FindObjectForCode("from_"..location_obj.ItemState.target)
                if target_obj then
                    if location_obj.IsDeadEnd or target_obj.IsDeadEnd then
                        -- print("target ACCESS_CLEARED")
                        -- return ACCESS_NONE
                        -- return ACCESS_NONE
                    elseif location_obj.IsConnector or target_obj.IsConnector then
                        -- print("target ACCESS_INSPECT")
                        return ACCESS_INSPECT
                    elseif location_obj.IsDungeon or target_obj.IsDungeon then
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