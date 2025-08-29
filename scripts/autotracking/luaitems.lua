ENTRANCE_SELECTED = nil

function _SetLocationOptions(source, target) -- source == inside, target == outside
    source.ItemState.Target = target.Name
    source.Icon = ImageReference:FromPackRelativePath("images/entrances/".. target.ItemState.Side .."/".. string.gsub(string.gsub(target.Name, "_"..target.ItemState.Side, ""), target.ItemState.Direction, "") ..".png")
    -- source.BadgeText = "to " .. target.ItemState.Shortname
    source.BadgeText = string.gsub(target.ItemState.Direction, "_", " ") .. target.ItemState.Shortname
    source.BadgeTextColor = "#abcdef"
    source:SetOverlayFontSize(10)
    source:SetOverlayAlign("left")

    -- target.Icon = ImageReference:FromPackRelativePath("images/entrances/inside/".. string.gsub(source.Name, "_inside", "") ..".png")
    -- target.BadgeText = "from".. source.ItemState.Shortname
    -- target.BadgeTextColor = "#abcdef"
    -- target:SetOverlayFontSize(10)
    -- target:SetOverlayAlign("left")

end

function _UnsetLocationOptions(source)
    source.ItemState.Target = nil
    source.Icon = ImageReference:FromPackRelativePath("images/door_closed.png")
    source.BadgeText = ""
    source.BadgeTextColor = ""
    source:SetOverlayFontSize(10)
    source:SetOverlayAlign("left")
end

local function OnLeftClickFunc(self)
    -- if self.ItemState.Stage ~= nil then
    --     self.ItemState.Stage = self.ItemState.Stage + 1
    --     print("OnLeftClickFunc to stage" .. tostring(self.ItemState.Stage))
    --     self:SetOverlayBackground("#333333")
    --     self.BadgeTextColor = "#AAAAAA"
    --     self.BadgeText = self.Name..tostring(self.ItemState.Stage)
    -- else
    --     self.ItemState.Stage = 0
    -- end
    -- if self.ItemState.Stage == 0 then
    --     print("OnLeftClickFunc at 0")
    --     self:SetOverlayBackground("")
    --     self.BadgeTextColor = ""
    --     self.BadgeText = ""
    -- end
    local target_entrance

-- target + ENTRANCE_SELECTED == nil
-- taget == nil + ENTRANCE_SELECTED == value
-- target == value + ENTRANCE_SELECTED == nil
-- target == value + ENTRANCE_SELECTED == value

    if ENTRANCE_SELECTED == nil and self.ItemState.Target == nil then -- fully new connection
        ENTRANCE_SELECTED = self.Name
    elseif ENTRANCE_SELECTED ~= nil and self.ItemState.Target == nil then -- second step of normal new connection
        target_entrance = Tracker:FindObjectForCode(ENTRANCE_SELECTED)
        if target_entrance ~= nil then
            target_entrance.ItemState.Target = self.Name
            self.ItemState.Target = target_entrance.Name

            _SetLocationOptions(self, target_entrance)
                -- self.Icon = ImageReference:FromPackRelativePath("images/inside/" .. INDOORS_INDEX[self.Name] .. ".png")
            _SetLocationOptions(target_entrance, self)
                --  self.Icon = ImageReference:FromPackRelativePath("images/outside/" .. OUTDOORS_INDEX[self.Name] .. ".png")
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
                -- self.Icon = ImageReference:FromPackRelativePath("images/inside/" .. INDOORS_INDEX[self.Name] .. ".png")
            _SetLocationOptions(target_entrance, self)
                -- self.Icon = ImageReference:FromPackRelativePath("images/outside/" .. OUTDOORS_INDEX[self.Name] .. ".png")
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
                forceUpdate()
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
local function SaveFunc(self)
    return { 
        Stage = self.ItemState.Stage,
        Active = self.ItemState.Active,
        Side = self.ItemState.Side,
        Target = self.ItemState.Target,
        Name = self.Name,
        Shortname = self.ItemState.Shortname,
        Icon = self.Icon,
        BadgeText = self.BadgeText,
        Direction = self.ItemState.Direction,
        Room = self.ItemState.Room,
    }
    -- print("SaveFunc")
end
local function LoadFunc(self, data)
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
        self.Icon = ImageReference:FromPackRelativePath(data.Icon)
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

function CreateLuaLocationItems(direction, code, shortname, side, room)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = direction .. location_obj.name --code -- 
    self.Icon = ImageReference:FromPackRelativePath("images/door_closed.png")
    self.ItemState = {
        Stage = 0,
        Active = true,
        Side = nil,
        Target = nil,
        Shortname = location_obj.shortname,
        Direction = direction,
        Room = room,
    }
    -- self.Active = false
    self.ItemState.Side = side
    -- self.Active = false

    -- if self.ItemState.Side == "inside" then
    --     self.ItemState.Target = string.gsub(self.Name, "_inside", "_outside")
    -- else
    --     self.ItemState.Target = string.gsub(self.Name, "_outside", "_inside")
    -- end
    
    self.CanProvideCodeFunc = CanProvideCodeFunc
    self.OnLeftClickFunc = OnLeftClickFunc
    self.OnRightClickFunc = OnRightClickFunc
    self.OnMiddleClickFunc = OnMiddleClickFunc
    self.ProvidesCodeFunc = ProvidesCodeFunc
    -- self.AdvanceToCodeFunc = AdvanceToCodeFunc
    self.SaveFunc = SaveFunc
    self.LoadFunc = LoadFunc
    self.PropertyChangedFunc = PropertyChangedFunc
    -- self.ItemState = ItemState
    return self
end

function Reset_ER_setings() 
    for name, _ in pairs(NAMED_ENTRANCES) do
        -- print(name)
        -- print(Tracker:FindObjectForCode(name).ItemState.Target)
        _UnsetLocationOptions(Tracker:FindObjectForCode(name))
    end
    Tracker:FindObjectForCode("reset_er").Active = false
end
ScriptHost:AddWatchForCode("ER_reset_triggered", "reset_er", Reset_ER_setings)