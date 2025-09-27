ENTRANCE_SELECTED = nil
BASE_IMG_PATH = ImageReference:FromPackRelativePath("images/door_closed.png")
function _SetLocationOptions(source, target) -- source == inside, target == outside
    source.ItemState.Target = target.Name
    -- source.Icon = ImageReference:FromPackRelativePath("images/entrances/".. target.ItemState.Side .."/".. string.gsub(string.gsub(target.Name, "_"..target.ItemState.Side, ""), target.ItemState.Direction, "") ..".png")
    source.Icon = target.ItemState.ImgPath
    -- source.BadgeText = string.gsub(target.ItemState.Direction, "_", " ") .. target.ItemState.Shortname
    source.BadgeText = target.ItemState.BadgeTextDirection
    -- source.BadgeTextColor = "#abcdef"
    -- source:SetOverlayFontSize(10)
    -- source:SetOverlayAlign("left")
end

function _UnsetLocationOptions(source)
    source.ItemState.Target = nil
    source.Icon = source.ItemState.BaseImg
    source.BadgeText = ""
    -- source.BadgeTextColor = ""
    source.ItemState.Worldstate = source.ItemState.BaseWorldstate
    -- source:SetOverlayFontSize(10)
    -- source:SetOverlayAlign("left")
end

local function OnLeftClickFunc(self)
    local target_entrance

    if ENTRANCE_SELECTED == nil and self.ItemState.Target == nil then -- fully new connection
        ENTRANCE_SELECTED = self.Name
    elseif ENTRANCE_SELECTED ~= nil and self.ItemState.Target == nil then -- second step of normal new connection
        target_entrance = Tracker:FindObjectForCode(ENTRANCE_SELECTED)
        if target_entrance ~= nil then
            target_entrance.ItemState.Target = self.Name
            self.ItemState.Target = target_entrance.Name

            _SetLocationOptions(self, target_entrance)
            _SetLocationOptions(target_entrance, self)
        end
        ENTRANCE_SELECTED = nil
    elseif ENTRANCE_SELECTED == nil and self.ItemState.Target ~= nil then -- retarget a connection to new target location
        ENTRANCE_SELECTED = self.Name
        target_entrance = Tracker:FindObjectForCode(self.ItemState.Target)
        if target_entrance ~= nil then
            _UnsetLocationOptions(target_entrance)
            _UnsetLocationOptions(self)
        end


    elseif ENTRANCE_SELECTED ~= nil and self.ItemState.Target ~= nil then -- attempt of new connection to already existing connection (how to handle that?)
        target_entrance = Tracker:FindObjectForCode(self.ItemState.Target)
        if target_entrance ~= nil then
            _UnsetLocationOptions(target_entrance)
            _UnsetLocationOptions(self)
        end
        target_entrance = Tracker:FindObjectForCode(ENTRANCE_SELECTED)
        if target_entrance ~= nil then
            -- target_entrance.ItemState.Target = self.Name
            -- self.ItemState.Target = target_entrance.Name
            _SetLocationOptions(self, target_entrance)
            _SetLocationOptions(target_entrance, self)
        end
        ENTRANCE_SELECTED = nil

    else
        print("################### SOMETHING IS REEEEEAAAALY FUCKED #########################")
    end
end

local function OnRightClickFunc(self)
    if ENTRANCE_SELECTED ~= nil then
        print("set back to nil")
        ENTRANCE_SELECTED = nil
    else
        if self.ItemState.Target ~= nil then
            local target = Tracker:FindObjectForCode(self.ItemState.Target)
            if target ~= nil then
                _UnsetLocationOptions(target)
                _UnsetLocationOptions(self)
                -- print("diconnected" .. self.Name .. " from " .. target.Name)
                ForceUpdate()
            end
        end
    end

    -- print("from", self.Name, "to", self.ItemState.Target)
end
local function OnMiddleClickFunc(self)
end
local function CanProvideCodeFunc(self, code)
    -- print("inside CanProvideCodeFunc. self:", self.Name, " and Code:", code)
    return code == self.Name
end
local function ProvidesCodeFunc(self, code)
--     return 1
-- end
    if CanProvideCodeFunc(self, code) then
        -- print("ProvidesCodeFunc with", code)
        if self.ItemState.Target ~= nil then  --and Tracker:FindObjectForCode("er_tracking").CurrentStage > 0 then
            return 1
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
        BadgeTextDirection = self.ItemState.BadgeTextDirection --from/to
    }
    -- print("SaveFunc")
end

local function SaveCaptureFunc(self)
    return {
        Active = self.ItemState.Active,
        Target = self.ItemState.Target,
        Name = self.Name,
        Shortname = self.ItemState.Shortname,
        Icon = self.Icon
    }
    -- print("SaveFunc")
end

local function LoadLocationFunc(self, data)
    -- print(self.Name, data.Name)
    -- print("loading data from:", data)
    -- print(dump_table(data))
    if data ~= nil and self.Name == data.Name then
        -- print("assigning saved data for ", data.Name)
        -- print(dump_table(data))
        self.ItemState.Target = data.Target
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

local function LoadCaptureFunc(self, data)
    -- print(self.Name, data.Name)
    -- print("loading data from:", data)
    -- print(dump_table(data))
    if data ~= nil and self.Name == data.Name then
        -- print("assigning saved data for ", data.Name)
        -- print(dump_table(data))
        self.ItemState.Target = data.Target
        self.ItemState.Shortname = data.Shortname
        self.Icon = ImageReference:FromPackRelativePath(data.Icon)
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
    self.Name = direction .. location_obj.name --code --
    self.Icon = ImageReference:FromPackRelativePath("images/door_closed.png")
    self.ItemState = {
        ImgPath = ImageReference:FromPackRelativePath("images/entrances/".. side .."/" .. string.gsub(location_obj.name, "_"..side, "") .. ".png"),
        BaseImg = BASE_IMG_PATH,
        Stage = 0,
        Active = true,
        Side = side,
        Target = nil,
        Shortname = location_obj.shortname,
        Direction = direction,
        Room = location_obj.room,
        Worldstate = location_obj.worldstate,
        BaseWorldstate = location_obj.worldstate,
        BadgeTextDirection = direction .. location_obj.shortname
    }
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

function CreateLuaCaptureItems(name, shortname)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = name --code --
    self.Icon = ImageReference:FromPackRelativePath("images/AP-item.png")
    self.ItemState = {
        Active = true,
        Target = nil,
        Shortname = shortname
    }
   
    self.CanProvideCodeFunc = CanProvideCodeFunc
    self.OnLeftClickFunc = OnLeftClickFunc
    self.OnRightClickFunc = OnRightClickFunc
    self.OnMiddleClickFunc = OnMiddleClickFunc
    self.ProvidesCodeFunc = ProvidesCodeFunc
    -- self.AdvanceToCodeFunc = AdvanceToCodeFunc
    self.SaveFunc = SaveCaptureFunc
    self.LoadFunc = LoadCaptureFunc
    self.PropertyChangedFunc = PropertyChangedFunc
    -- self.ItemState = ItemState
    return self
end

function Reset_ER_setings()
    ScriptHost:RemoveMemoryWatch("StateChanged")
    for name, _ in pairs(NAMED_ENTRANCES) do
        -- print(name)
        -- print(Tracker:FindObjectForCode(name).ItemState.Target)
        _UnsetLocationOptions(Tracker:FindObjectForCode(name))
    end
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    Tracker:FindObjectForCode("reset_er").Active = false
end
ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_setings)