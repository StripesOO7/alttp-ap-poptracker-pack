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

local dmg_class_storage_item = (Tracker:FindObjectForCode("manual_dmg_class_storage") --[[@as LuaItem]])
function _SetDmgClassImageHelper(self, itemcode)

    local primary_stage = self:Get("PrimaryStage")
    local secondary_stage = self:Get("SecondaryStage")
    if primary_stage == 1 then
        self.Icon = secondary_img_list[secondary_stage]
        -- self.IconMods = secondary_img_list[itemstate.SecondaryStage]
    else
        self.Icon = primary_img_list[primary_stage]
    end
    if MANUAL_CHECKED then
        if dmg_class_storage_item and 
        dmg_class_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED] then
            dmg_class_storage_item.ItemState.MANUAL_LOCATIONS[ROOM_SEED][itemcode] = {
                primary_stage = primary_stage,
                secondary_stage = secondary_stage,
            }
        end
    end
end

function Damage_Classes_scope(scope_enemy_index, scope_class_index, scope_name, scope_default_dmg_value)

    local Code = scope_enemy_index.."_"..scope_class_index
    local Basename = scope_name
    local BaseEnemyindex = scope_enemy_index
    local BaseClassindex = scope_class_index
    local PrimaryStage = 0
    local PrimaryStageMax = 2
    local SecondaryStage = 0
    local SecondaryStageMax = 5

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        MANUAL_CHECKED = true
        
        local primary_stage = self:Get("PrimaryStage")
        local base_classindex = self:Get("BaseClassindex")

        local enemy_item = NAMED_ENEMIES[Basename] --[[@as LuaItem]]
        
        if primary_stage == PrimaryStageMax then
            self:Set("PrimaryStage", 0)
        else
            self:Set("PrimaryStage", primary_stage + 1)
        end

        enemy_item.ItemState.Damage_table[BaseClassindex] = primary_dmg_list[BaseClassindex]
        _SetDmgClassImageHelper(self, Code)
        MANUAL_CHECKED = false
        -- self.Icon = primary_img_list[itemstate.PrimaryStage]
    end

    ---function that get triggered when right clicking a lua items as hosted item or in an itemgrid
    ---will remove the connection between the selected luaItem and its connected partner
    ---specific to ER LuaItems
    ---@param self LuaItem
    local function OnRightClickFunc(self)
        
        local primary_stage = self:Get("PrimaryStage")
        local secondary_stage = self:Get("SecondaryStage")
        
        local enemy_item = NAMED_ENEMIES[Basename] --[[@as LuaItem]]
        if primary_stage == 1 then
            MANUAL_CHECKED = true
            local stage_max = (secondary_stage == SecondaryStageMax)

            self:Set("SecondaryStage", stage_max and 0 or (secondary_stage + 1))
            enemy_item.ItemState.Damage_table[BaseClassindex] = stage_max and primary_dmg_list[primary_stage] or secondary_dmg_list[secondary_stage]

            _SetDmgClassImageHelper(self, Code)
            MANUAL_CHECKED = false
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
        return code == Code or code == Basename
    end

    ---comment
    ---@param self LuaItem
    ---@param code string
    ---@return integer
    local function ProvidesCodeFunc(self, code)
    --     return 1
    -- end
        return CanProvideCodeFunc(self, code) and 1 or 0
        -- if CanProvideCodeFunc(self, code) then
        --     return 1
        -- else
        --     return 0
        -- end
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
        _SetDmgClassImageHelper(self, Code)
        -- local stun = {255, 252, 251}
        -- local freeze = {254}
        -- local burn = {253}
        -- local transform_slime = {250}
        -- local transform_fairy = {249}

        self.ItemState.SpecialEffect = nil
        
        ---@type table<string, LuaItem>
        NAMED_DMG_CLASSES[Code] = self
        NAMED_DMG_CLASSES[Basename] = self

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

    return CreateLuaDamageClass(scope_enemy_index, scope_class_index, scope_name, scope_default_dmg_value)
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
