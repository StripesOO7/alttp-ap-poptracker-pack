ENTRANCE_SELECTED = nil

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
    if ENTRANCE_SELECTED == nil then
        ENTRANCE_SELECTED = self.Name
        print("outside selected", ENTRANCE_SELECTED, self.Name)
        
    else
        print("connect to inside")
        local location = named_locations[self.Name]
        for _, exit in pairs(location.exits) do
            print(exit[1].name)
        end
        INDOORS_INDEX[self.Name] = ENTRANCE_SELECTED
        OUTDOORS_INDEX[ENTRANCE_SELECTED] = self.Name
        print("INDOORS_INDEX[self.Name]",  INDOORS_INDEX[self.Name])
        print("OUTDOORS_INDEX[ENTRANCE_SELECTED]", OUTDOORS_INDEX[ENTRANCE_SELECTED])
        ENTRANCE_SELECTED = nil
    end
    print("ENTRANCE_SELECTED", ENTRANCE_SELECTED)
end

local function OnRightClickFunc(self)
    if ENTRANCE_SELECTED ~= nil then
        print("set back to nil")
        ENTRANCE_SELECTED = nil
    end
    -- if self.ItemState.Stage ~= nil then
    --     if self.ItemState.Stage == 0 then
    --         print("OnRightClickFunc at 0")
    --         self:SetOverlayBackground("")
    --         self.BadgeTextColor = ""
    --         self.BadgeText = ""
    --     else
    --         self.ItemState.Stage = self.ItemState.Stage - 1
    --         print("OnRightClickFunc to stage"..tostring(self.ItemState.Stage))
    --         self:SetOverlayBackground("#333333")
    --         self.BadgeTextColor = "#AAAAAA"
    --         self.BadgeText = self.Name..tostring(self.ItemState.Stage)
    --     end
    -- else
    --     self.ItemState.Stage = 0
    -- end
    -- if self.ItemState.Stage == 0 then
    --     print("OnRightClickFunc at 0")
    --     self:SetOverlayBackground("")
    --     self.BadgeTextColor = ""
    --     self.BadgeText = ""
    -- end
    print("INDOORS_INDEX")
    print(dump_table(INDOORS_INDEX))
    print("OUTDOORS_INDEX")
    print(dump_table(OUTDOORS_INDEX))
end
local function OnMiddleClickFunc(self)
    print("INDOORS_INDEX")
    print(dump_table(INDOORS_INDEX))
    print("OUTDOORS_INDEX")
    print(dump_table(OUTDOORS_INDEX))
    print("OnMiddleClickFunc")
end
local function CanProvideCodeFunc(self, code)
    -- print("inside CanProvideCodeFunc. self:", self.Name, " and Code:", code)
    return code == self.Name
end
local function ProvidesCodeFunc(self, code)
    if self.Name == code then
        return 1
    else
        return 0
    end
end
-- local function AdvanceToCodeFunc()
--     print("AdvanceToCodeFunc")
-- end
local function SaveFunc(self)
    print("SaveFunc")
end
local function LoadFunc(self, data)
    print("LoadFunc")
end
local function PropertyChangedFunc()
    print("PropertyChangedFunc")
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

function CreateLuaLocationItems(code, side)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = code
    self.Icon = ImageReference:FromPackRelativePath("images/entrances/" .. code .. ".png")
    self.ItemState = {
        Stage = 0
    }
    self.ItemState.side = side
    
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

-- CreateLuaLocationItems("hc_main_entrance_inside", "inside")
-- CreateLuaLocationItems("hc_left_entrance_inside", "inside")
-- CreateLuaLocationItems("hc_right_entrance_inside", "inside")
-- CreateLuaLocationItems("sanctuary_entrance_inside", "inside")
-- CreateLuaLocationItems("ce_dropdown_entrance_inside", "inside")
-- CreateLuaLocationItems("at_entrance_inside", "inside")
-- CreateLuaLocationItems("ep_entrance_inside", "inside")
-- CreateLuaLocationItems("dp_main_entrance_inside", "inside")
-- CreateLuaLocationItems("dp_left_entrance_inside", "inside")
-- CreateLuaLocationItems("dp_right_entrance_inside", "inside")
-- CreateLuaLocationItems("dp_back_entrance_inside", "inside")
-- CreateLuaLocationItems("lost_woods_hideout_cave_inside", "inside")

-- print(Test.Name)
-- print(Test.Type)
-- print(Test.Icon)
-- print(Test.ItemState)
-- print(Test.CanProvideCodeFunc)
-- print(Tracker:FindObjectForCode("lost_woods_hideout_cave_inside").Name)
-- print(Tracker:FindObjectForCode("lost_woods_hideout_cave_inside").Type)
-- print(Tracker:FindObjectForCode("lost_woods_hideout_cave_inside").Icon)
-- print(Tracker:FindObjectForCode("lost_woods_hideout_cave_inside").ItemState)
-- print(Test)