ENTRANCE_SELECTED = nil
BASE_IMG_PATH = ImageReference:FromPackRelativePath("images/door_closed.png")

HIGHLIGHT_SOURCE = nil
HIGHLIGHT_TARGET = nil
HIGHLIGHT_LAST_ACTIVATED = 0

ROUTE_MODE = false

local unknown = ImageReference:FromPackRelativePath("images/enemies/effects/unknown.png")
local can_hit = ImageReference:FromPackRelativePath("images/enemies/effects/can_hit.png")
local immune = ImageReference:FromPackRelativePath("images/enemies/effects/immune.png")

local stun_overlay = ImageReference:FromPackRelativePath("images/enemies/effects/stun.png")
local freeze_overlay = ImageReference:FromPackRelativePath("images/enemies/effects/freeze.png")
local burn_overlay = ImageReference:FromPackRelativePath("images/enemies/effects/burn.png")
local transform_overlay = ImageReference:FromPackRelativePath("images/enemies/effects/transform.png")
local transform_fairy_overlay = ImageReference:FromPackRelativePath("images/enemies/effects/transform_fairy.png")


local primary_img_list = {
    [0] = unknown,
    [1] = can_hit,
    [2] = immune,
}
local secondary_img_list = {
    [0] = can_hit,
    [1] = stun_overlay,
    [2] = freeze_overlay,
    [3] = burn_overlay,
    [4] = transform_overlay,
    [5] = transform_fairy_overlay,
}
-- local secondary_img_list = {
--     [0] = "overlay|",
--     [1] = "overlay|images/enemies/effects/stun_overlay.png", --..stun_overlay,
--     [2] = "overlay|images/enemies/effects/freeze_overlay.png", --..freeze_overlay,
--     [3] = "overlay|images/enemies/effects/burn_overlay_2.png", --..burn_overlay,
--     [4] = "overlay|images/enemies/effects/transform_overlay.png", --..transform_overlay,
--     [5] = "overlay|images/enemies/effects/transform_fairy_overlay.png", --..transform_fairy_overlay,
-- }


local primary_dmg_list = {
    [0] = 0,
    [1] = 1,
    [2] = 0,
}
local secondary_dmg_list = {
    [0] = 0,
    [1] = 255,
    [2] = 254,
    [3] = 253,
    [4] = 250,
    [5] = 249,
}


local reverse_secondary_dmg_list = {
    [255] = 1,
    [254] = 2,
    [253] = 3, --burn 
    [252] = 1,
    [251] = 1,
    [250] = 4,
    [249] = 5,
}


function _SetDmgClassImageHelper(self)
    -- local dmg_class_storage_item = (Tracker:FindObjectForCode("manual_dmg_class_storage") --[[@as LuaItem]]).ItemState

    local primary_stage = self:Get("PrimaryStage")
    local secondary_stage = self:Get("SecondaryStage")
    local base_classindex =self:Get("BaseClassindex")
    if primary_stage == 1 then
        self.Icon = secondary_img_list[secondary_stage]
        -- self.IconMods = secondary_img_list[itemstate.SecondaryStage]
    else
        self.Icon = primary_img_list[primary_stage]
    end
    -- if dmg_class_storage_item then
        
    --     if dmg_class_storage_item.MANUAL_LOCATIONS[ROOM_SEED][self:Get("Code")] == nil then
    --         dmg_class_storage_item.MANUAL_LOCATIONS[ROOM_SEED][self:Get("Code")] = {
    --             primary_stage = self:Get("PrimaryStage"),
    --             secondary_stage = self:Get("SecondaryStage"),
    --             icon = self.Icon
    --         }
    --     end
    -- end
end

---Sets the connection between the 2 provided lua items to link them in the graph
---@param source LuaItem
---@param target LuaItem
function _SetLocationOptions(source, target) -- source == inside, target == outside
end

---Unsets the connection between the provided LuaItem and its set target if any is set
---@param source LuaItem
function _UnsetLocationOptions(source)
end

---helper function for disconnecting the 2 provided LuaItems
---@param target string
---@param source string
local function _LeftClickUnmarkHelper(target, source)
    local target_entrance_from = Tracker:FindObjectForCode("from_" .. target) --[[@as LuaItem]]
    local target_entrance_to = Tracker:FindObjectForCode("to_" .. target) --[[@as LuaItem]]
    local source_entrance_from = Tracker:FindObjectForCode("from_" .. source) --[[@as LuaItem]]
    local source_entrance_to = Tracker:FindObjectForCode("to_" .. source) --[[@as LuaItem]]
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
    local target_entrance_from = Tracker:FindObjectForCode("from_" .. target) --[[@as LuaItem]]
    local target_entrance_to = Tracker:FindObjectForCode("to_" .. target) --[[@as LuaItem]]
    local source_entrance_from = Tracker:FindObjectForCode("from_" .. source) --[[@as LuaItem]]
    local source_entrance_to = Tracker:FindObjectForCode("to_" .. source) --[[@as LuaItem]]
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
    if Tracker:FindObjectForCode("er_tracking").CurrentStage < 3 then
        source_location = "@"..table.concat(location.ItemState.CorrespondingLocationSection, "/")
    else
        source_location = "@"..location.ItemState.CorrespondingLocationSection[1].."/"..location.ItemState.CorrespondingLocationSection[2].."/From".." "..location.ItemState.CorrespondingLocationSection[3]
    end
    Tracker:FindObjectForCode(source_location).Highlight = highlight
end

---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
---will select 2 LuaItems and connect them to be traversable in the graph
---@param self LuaItem
local function OnLeftClickFunc(self)
    
    local primary_stage =self:Get("PrimaryStage")
    local base_classindex =self:Get("BaseClassindex")

    local enemy_item = Tracker:FindObjectForCode(self:Get("Basename")) --[[@as LuaItem]]
    
    if primary_stage == self:Get("PrimaryStageMax") then
        self:Set("PrimaryStage", 0)
    else
        self:Set("PrimaryStage", primary_stage + 1)
    end

    enemy_item.ItemState.Damage_table[base_classindex] = primary_dmg_list[base_classindex]
    _SetDmgClassImageHelper(self)
    -- self.Icon = primary_img_list[itemstate.PrimaryStage]
end

---function that get triggered when right clicking a lua items as hosted item or in an itemgrid
---will remove the connection between the selected luaItem and its connected partner
---specific to ER LuaItems
---@param self LuaItem
local function OnRightClickFunc(self)
    
    local primary_stage =self:Get("PrimaryStage")
    local secondary_stage =self:Get("SecondaryStage")
    local base_classindex =self:Get("BaseClassindex")
    
    local enemy_item = Tracker:FindObjectForCode(self:Get("Basename")) --[[@as LuaItem]]
    if primary_stage == 1 then
        if secondary_stage == self:Get("SecondaryStageMax") then
            self:Set("SecondaryStage", 0)
            enemy_item.ItemState.Damage_table[base_classindex] = primary_dmg_list[primary_stage]
        else
            self:Set("SecondaryStage", secondary_stage + 1)
            enemy_item.ItemState.Damage_table[base_classindex] = secondary_dmg_list[secondary_stage]
        end
        _SetDmgClassImageHelper(self)
        -- self.Icon = secondary_img_list[itemstate.SecondaryStage]
        -- self.IconMods = secondary_img_list[itemstate.SecondaryStage]
    end
end

---function that get triggered when middle clicking a lua items as hosted item or in an itemgrid
---will highlight itself and the connected LuaItem on the map to make sptting connected entrances easier
---specific to ER LuaItems
---@param self LuaItem
local function OnMiddleClickFunc(self)
end

---comment
---@param self LuaItem
---@param code string
---@return boolean
local function CanProvideCodeFunc(self, code)
    return code == self:Get("Basename") or code == self:Get("Code")
end

---comment
---@param self LuaItem
---@param code string
---@return integer
local function ProvidesCodeFunc(self, code)
--     return 1
-- end
    if code == self:Get("Basename") or code == self:Get("Code") then
        return 1
    else
        return 0
    end
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
        Invulnerable = self:Get("Invulnerable"),
        Basename = self:Get("Basename"),
        BaseEnemyindex = self:Get("BaseEnemyindex"),
        BaseClassindex = self:Get("BaseClassindex"),
        Code = self:Get("Code"),
        PrimaryStage = self:Get("PrimaryStage"),
        PrimaryStageMax = self:Get("PrimaryStageMax"),
        SecondaryStage = self:Get("SecondaryStage"),
        SecondaryStageMax = self:Get("SecondaryStageMax"),
        Name = self.Name, --str
        Icon = self.Icon, --curretn set img path
    }
    -- print("SaveFunc")
end

---function triggered on loading the pack to restore the lat saves state. specific to ER LuaItems
---@param self LuaItem
---@param data table
local function LoadLocationFunc(self, data)
    if data ~= nil and self.Name == data.Name then
        self:Set("Invulnerable", data.Invulnerable)
        self:Set("Basename", data.Basename)
        self:Set("BaseEnemyindex", data.BaseEnemyindex)
        self:Set("BaseClassindex", data.BaseClassindex)
        self:Set("Code", data.Code)
        self:Set("PrimaryStage", data.PrimaryStage)
        self:Set("PrimaryStageMax", data.PrimaryStageMax)
        self:Set("SecondaryStage", data.SecondaryStage)
        self:Set("SecondaryStageMax", data.SecondaryStageMax)
        self.Name = data.Name
        self.Icon = data.Icon
        
        
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

---function to create ER LuaItems in their default state
---@param code string
---@param name string
---@return LuaItem
function CreateLuaDamageClass(enemy_index, class_index, name, default_dmg_value)
    local self = ScriptHost:CreateLuaItem()
    -- self.Type = "custom"
    self.Name = name.." - Class "..class_index
    -- self.Icon = ImageReference:FromPackRelativePath("images/items/unknown.png")
    ---@type ItemState
    self.ItemState = {
    } --[[@as table<string, any>]]

    self:Set("Invulnerable", false)
    self:Set("Basename", name)
    self:Set("BaseEnemyindex", enemy_index)
    self:Set("BaseClassindex", class_index)
    self:Set("Code", enemy_index.."_"..class_index)
    self:Set("PrimaryStage", 0)
    self:Set("PrimaryStageMax", 2)
    self:Set("SecondaryStage", 0)
    self:Set("SecondaryStageMax", 5)

    if default_dmg_value > 0 then
        self:Set("PrimaryStage",1)
        if reverse_secondary_dmg_list[default_dmg_value] ~= nil then 
            self:Set("SecondaryStage",reverse_secondary_dmg_list[default_dmg_value])
        else
            self:Set("SecondaryStage",0)
        end
    else
        self:Set("PrimaryStage",2)
        self:Set("SecondaryStage",0)
    end
    _SetDmgClassImageHelper(self)
    local stun = {255, 252, 251}
    local freeze = {254}
    local burn = {253}
    local transform_slime = {250}
    local transform_fairy = {249}

    self.ItemState.SpecialEffect = nil

    self.BadgeTextColor = "#abcdef"
    self:SetOverlayFontSize(10)
    self:SetOverlayAlign("left")

    
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


DEFAULT_WEAPON_CLASSES = {
    [0] = {"Boomerangs"},
    [1] = {"fightersword", "mastersword", "byrna", "somaria", "bee"},
    [2] = {"fightersword", "mastersword", "temperedsword"},
    [3] = {"mastersword", "temperedsword", "goldensword", "hammer"},
    [4] = {"temperedsword", "goldensword"},
    [5] = {"goldensword"},
    [6] = {"bow"},
    [7] = {"hookshot"},
    [8] = {"bombs"},
    [9] = {"silverarrow"},
    [10] = {"powder"},
    [11] = {"firerod"},
    [12] = {"icerod"},
    [13] = {"bombos"},
    [14] = {"ether"},
    [15] = {"quake"},
}
