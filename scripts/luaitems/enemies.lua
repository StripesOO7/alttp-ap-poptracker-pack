function Enemies_scope(scope_enemy_index, scope_name, scope_health, scope_dmg_table, scope_counter)
    local scope_name_code = string.gsub(scope_name, " ", "_")
    scope_name_code = string.gsub(scope_name_code, "%(", "")
    scope_name_code = string.gsub(scope_name_code, "%)", "")

    local Counter = "enemy_"..scope_counter
    local Code = "enemy_"..scope_enemy_index
    local Basename = scope_name_code.."_lua"

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        if not MANUAL_TRACKING_ENEMIES then
            local row_counter_horizontal = 1+(self:Get("Index")//21)
            local row_counter_vertical = 1+(2*self:Get("Index")//22)
            Tracker:UiHint("ActivateTab", "Damage Table")
            Tracker:UiHint("ActivateTab", "Row "..row_counter_vertical.."&"..(row_counter_vertical+1))
            Tracker:UiHint("ActivateTab", "Row "..(row_counter_vertical-1).."&"..row_counter_vertical)
            Tracker:UiHint("ActivateTab", "Row "..row_counter_horizontal)
        else
            MANUAL_TRACKING_ENEMIES = false
            SELECTED_ENEMY.Icon = self.Icon
            SELECTED_ENEMY.ItemState.EnemyRef = Code
        end
    end

    ---function that get triggered when right clicking a lua items as hosted item or in an itemgrid
    ---will remove the connection between the selected luaItem and its connected partner
    ---specific to ER LuaItems
    ---@param self LuaItem
    local function OnRightClickFunc(self)
        Tracker:UiHint("ActivateTab", "Damage Table")
        Tracker:UiHint("ActivateTab", "Overview")
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
        -- return CanProvideCodeFunc(self, code) and 1 or 0
        if code == Code or code == Basename then
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
            Name = self.Name,
            Icon = self.Icon,
            Health = self:Get("Health"),
            Default_damage_table = self.ItemState.Default_damage_table,
            Damage_table = self.ItemState.Damage_table,
            Index = self:Get("Index"),
            Code = self:Get("Code"),
            SpecialEffect = self:Get("SpecialEffect"),
            Invulnerable = self:Get("Invulnerable"),
        }
        -- print("SaveFunc")
    end

    ---function triggered on loading the pack to restore the lat saves state. specific to ER LuaItems
    ---@param self LuaItem
    ---@param data table
    local function LoadLocationFunc(self, data)
        if data ~= nil and self.Name == data.Name then
            self.Name = data.Name
            self.Icon = data.Icon
            self:Set("Health", data.Health)
            self.ItemState.Default_damage_table = data.Default_damage_table
            self.ItemState.Damage_table = data.Damage_table
            self:Set("Index", data.Index)
            self:Set("Code", data.Code)
            self:Set("SpecialEffect", data.SpecialEffect)
            self:Set("Invulnerable", data.Invulnerable)
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

    local reverse_dmg_list = {
        [255] = 2, --stun
        [254] = 3, --freeze
        [253] = 4, --burn 
        [252] = 2, --stun
        [251] = 2, --stun
        [250] = 5, --transform slime 
        [249] = 6, --fransform fairy
        [0] = 7, --immune
    }
    -- local reverse_dmg_list = {
    --     [255] = 3, --stun
    --     [254] = 4, --freeze
    --     [253] = 5, --burn 
    --     [252] = 3, --stun
    --     [251] = 3, --stun
    --     [250] = 6, --transform slime 
    --     [249] = 7, --fransform fairy
    --     [0] = 8, --immune
    -- }

    ---function to create ER LuaItems in their default state
    ---@param name string
    ---@param health integer
    ---@param dmg_table integer[]
    ---@param index integer
    ---@return LuaItem
    function CreateLuaEnemeyClass(name, health, dmg_table, index, counter)
        local self = ScriptHost:CreateLuaItem()
        -- self.Type = "custom"
        self.Name = name
        self.Icon = ImageReference:FromPackRelativePath("images/enemies/" .. string.lower(name) .. ".png")
        -- -@type ItemState
        self.ItemState = {
            Health = health,
            RAW_damage_table = {table.unpack(dmg_table)},
            Default_damage_table = {},
            Damage_table = {},
            Index = counter,
            Code = "enemy_"..index,
            Invulnerable = nil,
            SpecialEffect = nil,
            
        } --[[@as table<string, any>]]

        self.PotentialCodes = {Code, Basename}

        local invulnerable = health == 255
        self:Set("Invulnerable", invulnerable)
        -- local stun = {255, 251}
        -- local freeze = {254}
        -- local burn = {253}
        -- local transform_slime = {250}
        -- local transform_fairy = {249}
        self:Set("SpecialEffect", nil)

        NAMED_ENEMIES[scope_name_code] = self
        for i=1,16 do
            local dmg_class_item = Tracker:FindObjectForCode(index.."_"..i-1)
            -- REVERSE_DMG_CLASSES[scope_counter.."_"..i-1] = Basename
            -- if invulnerable then
            --     -- dmg_class_item.CurrentStage = 7
            --     self.ItemState.Default_damage_table[i] = 7
            --     self.ItemState.Damage_table[i] = 7
            -- else
            if reverse_dmg_list[dmg_table[i]] then
                self.ItemState.Default_damage_table[i] = reverse_dmg_list[dmg_table[i]]
                self.ItemState.Damage_table[i] = reverse_dmg_list[dmg_table[i]]
            else
                self.ItemState.Default_damage_table[i] = 1
                self.ItemState.Damage_table[i] = 1
            end
            print(self.ItemState.Default_damage_table[i])
            dmg_class_item.CurrentStage = self.ItemState.Damage_table[i]
        end 
        -- for i=0,15 do
        --     ScriptHost:AddWatchForCode("handler for dmg class: "..scope_counter.."_"..i, scope_counter.."_"..i, ChangeDmgClassProperty)
        -- end

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

    return CreateLuaEnemeyClass(scope_name, scope_health, scope_dmg_table, scope_enemy_index, scope_counter)
end

DEFAULT_WEAPON_CLASSES = {
    [0] = {"blueboomerang", "redboomerang"},
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

---@class enemy_table
---@field [1] boolean NPC/non-enemy flag
---@field [2] integer ROM-index
---@field [3] string Name
---@field [4] integer Health
---@field [5] integer Class 1 Damage
---@field [6] integer Class 2 Damage
---@field [7] integer Class 3 Damage
---@field [8] integer Class 4 Damage
---@field [9] integer Class 5 Damage
---@field [10] integer Class 6 Damage
---@field [11] integer Class 7 Damage
---@field [12] integer Class 8 Damage
---@field [13] integer Class 9 Damage
---@field [14] integer Class 10 Damage
---@field [15] integer Class 11 Damage
---@field [16] integer Class 12 Damage
---@field [17] integer Class 13 Damage
---@field [18] integer Class 14 Damage
---@field [19] integer Class 15 Damage

---@type table<string, enemy_table>
DEFAULT_ENEMY_DAMAGE_TABLE = { --{npc/enemy, index, name, health, dmgclass0-15}
    {false, 0x00, "Raven", 12, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 254, 32},  --# 0x00 Raven
    {false, 0x01, "Vulture", 6, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 254, 32},  --# 0x01 Vulture
    -- {false, 0x02, 255, 1, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x02 
    -- {true, 0x03, "Empty", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x03 Empty
    {true, 0x04, "Pull Switch (good)", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x04 Pull Switch (good)
    -- {false, 0x05, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x05 
    {true, 0x06, "Pull Switch (trap)", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x06 Pull Switch (trap)
    -- {false, 0x07, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x07 
    {false, 0x08, "Octorok (one-way)", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x08 Octorok (one-way)
    {false, 0x0A, "Octorok (four-way)", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x0A Octorok (four-way)
    {false, 0x0B, "Cucco", 255, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0x0B Cucco
    -- {false, 0x0C, 0, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 16, 16, 32},  --0x0C 
    {false, 0x0D, "Buzzblob", 3, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 249, 253, 254, 253, 254, 255},  --# 0x0D Buzzblob
    {false, 0x0E, "Snapdragon", 12, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 64, 250},  --# 0x0E Snapdragon
    {false, 0x0F, "Octoballoon", 2, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 16, 64},  --# 0x0F Octoballoon
    {false, 0x11, "Hinox", 20, 252, 2, 4, 8, 16, 64, 4, 0, 64, 100, 0, 8, 254, 253, 254, 250},  --# 0x11 Hinox
    {false, 0x12, "Moblin", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 253, 254, 253, 254, 250},  --# 0x12 Moblin
    {false, 0x13, "Mini Helmasaur", 4, 0, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 0, 0, 253, 64, 250},  --# 0x13 Mini Helmasaur
    {true, 0x14, "Gargoyle's Domain Gate", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x14 Gargoyle's Domain Gate
    {false, 0x15, "Anti-Fairy", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0},  --# 0x15 Anti-Fairy
    {true, 0x16, "Sahasrahla / Aginah", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x16 Sahasrahla / Aginah
    {false, 0x17, "Bush Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 64, 64, 64, 64, 250},  --# 0x17 Bush Hoarder
    {false, 0x18, "Mini Moldorm", 3, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 8, 253, 16, 250},  --# 0x18 Mini Moldorm
    {false, 0x19, "Poe", 8, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 8, 8, 253, 64, 255},  --# 0x19 Poe
    {true, 0x1A, "Dwarves", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x1A Dwarves
    {true, 0x1B, "Arrow in Wall", 0, 32, 64, 64, 64, 64, 64, 64, 64, 64, 24, 0, 64, 64, 64, 16, 64},  --# 0x1B Arrow in Wall
    {true, 0x1C, "Statue", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x1C Statue
    {true, 0x1D, "Weathervane", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x1D Weathervane
    {true, 0x1E, "Crystal Switch", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x1E Crystal Switch
    {true, 0x1F, "Bug Catching Kid", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x1F Bug Catching Kid
    {false, 0x20, "Sluggula", 8, 255, 2, 4, 8, 16, 16, 4, 255, 0, 100, 250, 253, 254, 253, 254, 250},  --# 0x20 Sluggula
    {true, 0x21, "Push Switch", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x21 Push Switch
    {false, 0x22, "Ropa", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 64, 250},  --# 0x22 Ropa
    {false, 0x23, "Red Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255},  --# 0x23 Red Bari
    {false, 0x24, "Blue Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255},  --# 0x24 Blue Bari
    {true, 0x25, "Talking Tree", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x25 Talking Tree
    {false, 0x26, "Hardhat Beetle", 3, 0, 2, 4, 8, 16, 16, 0, 255, 255, 100, 0, 0, 0, 253, 254, 255},  --# 0x26 Hardhat Beetle
    {false, 0x27, "Deadrock", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, 0, 0, 0, 0, 250},  --# 0x27 Deadrock
    {true, 0x28, "Storytellers", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x28 Storytellers
    {true, 0x29, "Blind Hideout Attendant", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x29 Blind Hideout Attendant
    {true, 0x2A, "Sweeping Lady", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0},  --# 0x2A Sweeping Lady
    {true, 0x2B, "Multipurpose", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x2B Multipurpose
    {true, 0x2C, "Lumberjacks", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x2C Lumberjacks
    {true, 0x2D, "Telepathic Stones", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x2D Telepathic Stones
    {true, 0x2E, "Flute Boy's Notes", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x2E Flute Boy's Notes
    {true, 0x2F, "Race Game NPCs", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x2F Race Game NPCs
    {true, 0x30, "Person", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x30 Person
    {true, 0x31, "Fortune Teller", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x31 Fortune Teller
    {true, 0x32, "Angry Brothers", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x32 Angry Brothers
    {true, 0x33, "Pull for Rupees", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x33 Pull for Rupees
    {true, 0x34, "Scared Girl2", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x34 Scared Girl2
    {true, 0x35, "Innkeeper", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x35 Innkeeper
    {true, 0x36, "Witch", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x36 Witch
    {true, 0x37, "Waterfall", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x37 Waterfall
    {true, 0x38, "Arrow Target", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x38 Arrow Target
    {true, 0x39, "Average Middle Aged Man", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x39 Average Middle Aged Man
    {true, 0x3A, "Half Magic Bat", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x3A Half Magic Bat
    {true, 0x3B, "Dash Item", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x3B Dash Item
    {true, 0x3C, "Village Kid", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x3C Village Kid
    -- {false, 0x3D, "Misc People", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x3D Signs Chicken Lady Also Showed Up Scared Ladies    Houses,
    {false, 0x3E, "Rock Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 64, 64, 64, 250},  --# 0x3E Rock Hoarder
    {true, 0x3F, "Tutorial Soldier", 255, 0, 0, 64, 8, 16, 16, 4, 255, 4, 100, 0, 8, 8, 16, 254, 32},  --# 0x3F Tutorial Soldier
    {true, 0x40, "Lightning Gate", 2, 0, 0, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x40 Lightning Gate
    {false, 0x41, "Blue Sword Soldier", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 250},  --# 0x41 Blue Sword Soldier
    {false, 0x42, "Green Sword Soldier", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x42 Green Sword Soldier
    {false, 0x43, "Red Spear Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250},  --# 0x43 Red Spear Soldier
    {false, 0x44, "Assault Sword Soldier", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250},  --# 0x44 Assault Sword Soldier
    {false, 0x45, "Green Spear Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250},  --# 0x45 Green Spear Soldier
    {false, 0x46, "Blue Archer", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250},  --# 0x46 Blue Archer
    {false, 0x47, "Green Bush Archer", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 250},  --# 0x47 Green Archer
    {false, 0x48, "Red Javelin Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250},  --# 0x48 Red Javelin Soldier
    {false, 0x49, "Red Bush Javelin Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 64, 250},  --# 0x49 Red Javelin Soldier2
    {false, 0x4A, "Red Bomb Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250},  --# 0x4A Red Bomb Soldier
    {false, 0x4B, "Green Soldier Recruit", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x4B Green Soldier Recruit / HM Knight
    {false, 0x4C, "Geldman", 4, 1, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 8, 8, 253, 16, 255},  --# 0x4C Geldman
    {true, 0x4D, "Rabbit", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 64, 253, 64, 255},  --# 0x4D Rabbit
    {false, 0x4E, "Popo", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x4E Popo
    {false, 0x4F, "Popo2", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x4F Popo2
    {false, 0x50, "Cannon Balls", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x50 Cannon Balls
    {false, 0x51, "Armos", 8, 255, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 8, 254, 253, 16, 255},  --# 0x51 Armos
    {true, 0x52, "King Zora", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x52 King Zora
    {false, 0x55, "Fireball Zora", 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32},  --# 0x55 Fireball Zora
    {false, 0x56, "Walking Zora", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32},  --# 0x56 Walking Zora
    {true, 0x57, "Desert Palace Barriers", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x57 Desert Palace Barriers
    {false, 0x58, "Crab", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 254, 253, 254, 250},  --# 0x58 Crab
    {true, 0x59, "Bird", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x59 Bird
    {true, 0x5A, "Squirrel", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x5A Squirrel
    {false, 0x5B, "Spark (clockwise)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 0, 255},  --# 0x5B Spark (clockwise)
    {false, 0x5F, "Roller", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x5F Roller
    {false, 0x61, "Beamos", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x61 Beamos
    {true, 0x62, "Master Sword", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x62 Master Sword
    {false, 0x64, "Devalant (shooter)", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 8, 8, 253, 16, 255},  --# 0x64 Devalant (shooter)
    {true, 0x65, "Shooting Gallery Proprietor", 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x65 Shooting Gallery Proprietor
    {false, 0x67, "Moving Cannon Ball Shooter (left)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x67 Moving Cannon Ball Shooter (left)
    {false, 0x6A, "Ball and Chain Trooper", 16, 251, 2, 2, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250},  --# 0x6A Ball and Chain Trooper
    {false, 0x6B, "Cannon Soldier", 3, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 8, 8, 16, 254, 32},  --# 0x6B Cannon Soldier
    {true, 0x6C, "Mirror Portal", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x6C Mirror Portal
    {false, 0x6D, "Rat", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x6D Rat
    {false, 0x6E, "Rope", 4, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250},  --# 0x6E Rope
    {false, 0x6F, "Keese", 1, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 255},  --# 0x6F Keese
    -- {false, 0x70, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x70 
    {false, 0x71, "Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 255},  --# 0x71 Leever
    {true, 0x72, "Pond Item Trigger", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x72 Pond Item Trigger
    {true, 0x73, "Uncle / Priest", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x73 Uncle / Priest
    {true, 0x74, "Running Man", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x74 Running Man
    {true, 0x75, "Bottle Salesman", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x75 Bottle Salesman
    {true, 0x76, "Princess Zelda", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x76 Princess Zelda
    -- {false, 0x77, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x77 
    {true, 0x78, "Village Elder", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x78 Village Elder
    -- {false, 0x79, 0, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 249, 8, 8, 16, 16, 32},  --0x79 
    {true, 0x7B, "Agahnim Energy Ball", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x7B Agahnim Energy Ball
    {false, 0x7C, "Floating Stalfos Head", 24, 0, 2, 4, 8, 16, 16, 4, 0, 64, 100, 0, 253, 254, 253, 16, 255},  --# 0x7C Floating Stalfos Head
    {true, 0x7D, "Big Spike Trap", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x7D Big Spike Trap
    {false, 0x7E, "Fire Bar (clockwise)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x7E Fire Bar (clockwise)
    {false, 0x80, "Fire Snake", 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x80 Fire Snake
    {false, 0x81, "Water Tektite", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 64, 16, 64},  --# 0x81 Water Tektite
    {false, 0x82, "Anti-Fairy Circle", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x82 Anti-Fairy Circle
    {false, 0x83, "Green Eyegore", 16, 0, 2, 4, 64, 64, 16, 64, 0, 4, 24, 0, 0, 0, 0, 0, 0},  --# 0x83 Green Eyegore
    {false, 0x84, "Red Eyegore", 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 0, 0, 0, 0, 0, 0},  --# 0x84 Red Eyegore
    -- {false, 0x85, 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 8, 64, 253, 64, 255},  --0x85 
    {false, 0x86, "Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 254, 253, 254, 250},  --# 0x86 Kodongo
    -- {false, 0x87, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --0x87 
    {true, 0x89, "Mothula's Beam", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x89 Mothula's Beam
    {false, 0x8A, "Spike Trap", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x8A Spike Trap
    {false, 0x8B, "Gibdo", 32, 255, 2, 4, 8, 16, 16, 0, 0, 4, 100, 0, 253, 254, 253, 64, 255},  --# 0x8B Gibdo
    {false, 0x8E, "Terrorpin", 8, 1, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 8, 254, 64, 64, 255},  --# 0x8E Terrorpin
    {false, 0x8F, "Slime", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64},  --# 0x8F Slime
    {false, 0x90, "Wallmaster", 8, 1, 2, 4, 8, 16, 16, 4, 0, 4, 100, 0, 8, 8, 253, 16, 64},  --# 0x90 Wallmaster
    {false, 0x91, "Stalfos Knight", 64, 1, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x91 Stalfos Knight
    {false, 0x93, "Bumper", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x93 Bumper
    {false, 0x94, "Pirogusu", 2, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255},  --# 0x94 Pirogusu
    {false, 0x97, "Laser Eye (down)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x97 Laser Eye (down)
    {false, 0x99, "Pengator", 16, 1, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 8, 0, 253, 254, 64},  --# 0x99 Pengator
    {false, 0x9A, "Kyameron", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 254, 64, 254, 32},  --# 0x9A Kyameron
    {false, 0x9B, "Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64},  --# 0x9B Wizzrobe
    {false, 0x9C, "Zoro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64},  --# 0x9C Zoro
    {false, 0x9D, "Babasu", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64},  --# 0x9D Babasu
    {true, 0x9E, "Haunted Grove Ostrich", 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x9E Haunted Grove Ostrich
    {true, 0x9F, "Flute", 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x9F Flute
    {true, 0xA0, "Haunted Grove Birds", 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xA0 Haunted Grove Birds
    {false, 0xA1, "Freezor", 16, 0, 0, 0, 0, 16, 16, 0, 0, 0, 0, 0, 64, 0, 64, 0, 0},  --# 0xA1 Freezor
    {true, 0xA4, "Falling Ice", 8, 0, 2, 4, 8, 16, 16, 4, 0, 4, 100, 0, 253, 0, 16, 16, 32},  --# 0xA4 Falling Ice
    {false, 0xA5, "Blue Zazak", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255},  --# 0xA5 Blue Zazak
    {false, 0xA6, "Red Zazak", 8, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255},  --# 0xA6 Red Zazak
    {false, 0xA7, "Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 64, 253, 64, 250},  --# 0xA7 Stalfos
    {false, 0xA8, "Green Zirro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32},  --# 0xA8 Green Zirro
    {false, 0xA9, "Blue Zirro", 8, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32},  --# 0xA9 Blue Zirro
    {false, 0xAA, "Pikit", 12, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 255},  --# 0xAA Pikit
    {true, 0xAB, "Maiden", 16, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0xAB Maiden
    {true, 0xAC, "Apple", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xAC Apple
    {true, 0xAD, "Lost Old Man", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xAD Lost Old Man
    {true, 0xAE, "Down Pipe", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xAE Down Pipe
    {true, 0xAF, "Up Pipe", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xAF Up Pipe
    {true, 0xB0, "Right Pipe", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB0 Right Pipe
    {true, 0xB1, "Left Pipe", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB1 Left Pipe
    {false, 0xB2, "Good Bee", 0, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 16, 16, 32},  --# 0xB2 Good Bee
    {true, 0xB3, "Hylian Inscription", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB3 Hylian Inscription
    {true, 0xB4, "Thief's Chest", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB4 Thief's Chest
    {true, 0xB5, "Bomb Salesman", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB5 Bomb Salesman
    {true, 0xB6, "Kiki", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB6 Kiki
    {true, 0xB7, "Blind's Maiden", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB7 Blind's Maiden
    {false, 0xB8, "Mimic", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB8 Mimic ??????
    {true, 0xB9, "Bully and Pink Ball", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xB9 Bully and Pink Ball
    {true, 0xBA, "Whirlpool", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xBA Whirlpool
    {true, 0xBB, "Shopkeeper / Chest Game NPC", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xBB Shopkeeper / Chest Game NPC
    {true, 0xBC, "Drunkard", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xBC Drunkard
    {true, 0xBF, "Vitreous Lightning", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xBF Vitreous Lightning
    {true, 0xC0, "Catfish", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xC0 Catfish
    {true, 0xC1, "Cutscene Agahnim", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xC1 Cutscene Agahnim
    {true, 0xC2, "Boulders", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xC2 Boulders
    {false, 0xC3, "Gibo", 8, 0, 2, 4, 8, 16, 16, 16, 0, 4, 100, 0, 0, 0, 0, 0, 0},  --# 0xC3 Gibo
    {false, 0xC4, "Thief", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xC4 Thief
    {false, 0xC5, "Medusa", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 16, 32},  --# 0xC5 Medusa
    {false, 0xC6, "Four-Way Fireball Spitter", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 16, 32},  --# 0xC6 Four-Way Fireball Spitter
    {false, 0xC7, "Hokku-Bokku", 32, 0, 2, 4, 8, 16, 16, 4, 0, 4, 24, 0, 253, 8, 253, 254, 255},  --# 0xC7 Hokku-Bokku
    {true, 0xC8, "Great Fairy", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xC8 Great Fairy
    {false, 0xC9, "Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 16, 16, 32},  --# 0xC9 Tektite
    {false, 0xCA, "Chain Chomp", 5, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xCA Chain Chomp
    {false, 0xCF, "Swamola", 16, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 16, 64, 32},  --# 0xCF Swamola
    {false, 0xD0, "Lynel", 24, 0, 0, 0, 8, 16, 16, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0},  --# 0xD0 Lynel
    {false, 0xD1, "Bunny Beam", 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 64, 64, 64},  --# 0xD1 Bunny Beam
    {true, 0xD2, "Flopping Fish", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, 0, 0, 0, 0, 250},  --# 0xD2 Flopping Fish
    {false, 0xD3, "Stal", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 8, 16, 64, 250},  --# 0xD3 Stal
    {true, 0xD4, "Landmine", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xD4 Landmine
    {true, 0xD5, "Digging Game Proprietor", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xD5 Digging Game Proprietor
    {true, 0x10, "Octoballoon Hatchlings", 0, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 8, 8, 16, 16, 32},  --# 0x10 Octoballoon Hatchlings
    ---dupes
    {false, 0x63, "Devalant (non-shooter)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x63 Devalant (non-shooter)
    {false, 0x5C, "Spark (counter-clockwise)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 0, 255},  --# 0x5C Spark (counter-clockwise)
    {false, 0x5D, "Roller (vertical up)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x5D Roller (vertical up)
    {false, 0x5E, "Roller (vertical down)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x5E Roller (vertical down)
    {false, 0x60, "Roller (horizontal)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x60 Roller (horizontal)
    {false, 0x66, "Moving Cannon Ball Shooter (right)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x66 Moving Cannon Ball Shooter (right)
    {false, 0x68, "Moving Cannon Ball Shooter (down)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x68 Moving Cannon Ball Shooter (down)
    {false, 0x69, "Moving Cannon Ball Shooter (up)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x69 Moving Cannon Ball Shooter (up)
    {false, 0x7F, "Fire Bar (counter-clockwise)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x7F Fire Bar (counter-clockwise)
    {false, 0x95, "Laser Eye (right)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x95 Laser Eye (right)
    {false, 0x96, "Laser Eye (left)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x96 Laser Eye (left)
    {false, 0x98, "Laser Eye (up)", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x98 Laser Eye (up)


    ---lw bosses
    {false, 0x53, "Armos Knights", 48, 1, 4, 2, 4, 8, 8, 16, 0, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0x53 Armos Knights
    {false, 0x54, "Lanmolas", 16, 0, 2, 2, 4, 8, 8, 4, 0, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0x54 Lanmolas
    {false, 0x09, "Moldorm", 12, 0, 2, 2, 4, 8, 8, 4, 255, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0x09 Moldorm
    {false, 0x7A, "Agahnim", 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0x7A Agahnim


    ---dw bosses
    {false, 0x92, "Helmasaur King", 48, 0, 0, 4, 8, 16, 16, 4, 0, 4, 100, 0, 0, 0, 0, 0, 0},  --# 0x92 Helmasaur King
    {false, 0x8C, "Arrghus", 32, 0, 0, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 0, 0, 0},  --# 0x8C Arrghus
    {false, 0x8D, "Arrgi", 8, 0, 0, 4, 8, 16, 16, 0, 0, 4, 100, 0, 8, 8, 0, 0, 0},  --# 0x8D Arrghus Spawn
    {false, 0x88, "Mothula", 32, 0, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0},  --# 0x88 Mothula
    {false, 0xCE, "Blind the Thief", 90, 0, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xCE Blind the Thief
    {false, 0xA2, "Kholdstare", 64, 0, 0, 4, 8, 16, 16, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0},  --# 0xA2 Kholdstare
    {false, 0xA3, "Kholdstare Shell", 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 64, 0, 0},  --# 0xA3 Kholdstare's Shell
    {false, 0xBD, "Vitreous", 128, 0, 0, 4, 8, 16, 16, 16, 0, 4, 100, 0, 0, 0, 0, 0, 0},  --# 0xBD Vitreous
    {false, 0xBE, "Vitreous Eyeball", 48, 0, 0, 4, 8, 16, 16, 16, 0, 4, 100, 0, 0, 0, 0, 0, 0},  --# 0xBE Vitreous Eyeball
    {false, 0xCB, "Trinexx Rock Head", 40, 0, 0, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xCB Trinexx Rock Head
    {false, 0xCC, "Trinexx Fire Head", 40, 0, 0, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0},  --# 0xCC Trinexx Fire Head
    {false, 0xCD, "Trinexx Ice Head", 40, 0, 0, 4, 8, 16, 16, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0},  --# 0xCD Trinexx Ice Head
    {false, 0xD6, "Ganon", 254, 0, 0, 0, 4, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  --# 0xD6 Ganon
    {false, 0xD7, "Invincible Ganon", 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0},  --# 0xD7 Invincible Ganon
}

-- ---@type table<string, enemy_table>
-- DEFAULT_ENEMY_DAMAGE_TABLE = {}

-- ---fucntion to create a tbale entry for each enemy
-- ---@param enemy_name any
-- ---@param ... integer
-- function CreateEnemieDmgTable(enemy_name, ...)
--     local dmg_table = {}
--     local dmg_values = {...}
--     for i, value in ipairs(dmg_values) do
--         dmg_table[i] = value
--     end
--     DEFAULT_ENEMY_DAMAGE_TABLE[enemy_name] = dmg_table
-- end

local counter = -1
Tracker.BulkUpdate = true
MANUAL_CHECKED = false
for _, enemy in pairs(DEFAULT_ENEMY_DAMAGE_TABLE) do
    print(Dump_table(enemy))
    
    if not enemy[1] then
        counter = counter+1
        print(counter, enemy[2], enemy[3], enemy[4], table.unpack(enemy, 5))
        Enemies_scope(enemy[2], enemy[3], enemy[4], {table.unpack(enemy, 5)}, counter)
    end
    -- for i=0,15 do
    --     -- CreateLuaDamageClass(counter, i, enemy[1], enemy[i+3])--, enemy[2], {table.unpack(enemy, 3)})
    --     Damage_Classes_scope(counter, i, enemy[1], enemy[i+3])--, enemy[2], {table.unpack(enemy, 3)})
    -- end
end
MANUAL_CHECKED = true
Tracker.BulkUpdate = false

-- local alttpr_enemey_list = {
--     [0] = "Raven" ,-- = 0x00
--     [1] = "Vulture" ,-- = 0x01
--     -- [3] = "CustomSprite" ,-- = 0x03
--     -- [4] = "CorrectPullSwitch" ,-- = 0x04
--     -- [6] = "WrongPullSwitch" ,-- = 0x06
--     [8] = "Octorok" ,-- = 0x08
--     [9] = "Moldorm" ,-- = 0x09
--     [10] = "Octorok4Way" ,-- = 0x0a
--     [11] = "Cucco" ,-- = 0x0b
--     [13] = "Buzzblob" ,-- = 0x0d
--     [14] = "Snapdragon" ,-- = 0x0e

--     [15] = "Octoballoon" ,-- = 0x0f
--     [16] = "OctoballoonBaby" ,-- = 0x10
--     [17] = "Hinox" ,-- = 0x11
--     [18] = "Moblin" ,-- = 0x12
--     [19] = "MiniHelmasaur" ,-- = 0x13
--     -- [20] = "ThievesTownGrate" ,-- = 0x14
--     [21] = "AntiFairy" ,-- = 0x15
--     [22] = "Wiseman" ,-- = 0x16
--     [23] = "Hoarder" ,-- = 0x17
--     [24] = "MiniMoldorm" ,-- = 0x18
--     [25] = "Poe" ,-- = 0x19
--     [26] = "Smithy" ,-- = 0x1a
--     -- [27] = "Arrow" ,-- = 0x1b
--     [28] = "Statue" ,-- = 0x1c
--     [29] = "FluteQuest" ,-- = 0x1d
--     [30] = "CrystalSwitch" ,-- = 0x1e
--     [31] = "SickKid" ,-- = 0x1f
--     [32] = "Sluggula" ,-- = 0x20
--     [33] = "WaterSwitch" ,-- = 0x21
--     [34] = "Ropa" ,-- = 0x22
--     [35] = "RedBari" ,-- = 0x23
--     [36] = "BlueBari" ,-- = 0x24
--     [37] = "TalkingTree" ,-- = 0x25
--     [38] = "HardhatBeetle" ,-- = 0x26
--     [39] = "Deadrock" ,-- = 0x27
--     -- [40] = "DarkWorldHintNpc" ,-- = 0x28
--     -- [41] = "AdultNpc" ,-- = 0x29
--     -- [42] = "SweepingLady" ,-- = 0x2a
--     -- [43] = "Hobo" ,-- = 0x2b
--     -- [44] = "Lumberjacks" ,-- = 0x2c
--     [45] = "TelepathicTile" ,-- = 0x2d
--     -- [46] = "FluteKid" ,-- = 0x2e
--     -- [47] = "RaceGameLady" ,-- = 0x2f
--     -- [48] = "RaceGameGuy" ,-- = 0x30
--     -- [49] = "FortuneTeller" ,-- = 0x31
--     -- [50] = "ArgueBros" ,-- = 0x32
--     [51] = "RupeePull" ,-- = 0x33
--     -- [52] = "YoungSnitch" ,-- = 0x34
--     -- [53] = "Innkeeper" ,-- = 0x35
--     -- [54] = "Witch" ,-- = 0x36
--     [55] = "Waterfall" ,-- = 0x37
--     [56] = "EyeStatue" ,-- = 0x38
--     -- [57] = "Locksmith" ,-- = 0x39
--     -- [58] = "MagicBat" ,-- = 0x3a
--     [59] = "BonkItem" ,-- = 0x3b
--     -- [60] = "KidInKak" ,-- = 0x3c
--     -- [61] = "OldSnitch" ,-- = 0x3d
--     [62] = "Hoarder2" ,-- = 0x3e
--     [63] = "TutorialGuard" ,-- = 0x3f

--     -- [64] = "LightningGate" ,-- = 0x40
--     [65] = "BlueGuard" ,-- = 0x41
--     [66] = "GreenGuard" ,-- = 0x42
--     [67] = "RedSpearGuard" ,-- = 0x43
--     [68] = "BluesainBolt" ,-- = 0x44
--     [69] = "UsainBolt" ,-- = 0x45
--     [70] = "BlueArcher" ,-- = 0x46
--     [71] = "GreenBushGuard" ,-- = 0x47
--     [72] = "RedJavelinGuard" ,-- = 0x48
--     [73] = "RedBushGuard" ,-- = 0x49
--     [74] = "BombGuard" ,-- = 0x4a
--     [75] = "GreenKnifeGuard" ,-- = 0x4b
--     [76] = "Geldman" ,-- = 0x4c
--     [77] = "Toppo" ,-- = 0x4d
--     [78] = "Popo" ,-- = 0x4e
--     [79] = "Popo2" ,-- = 0x4f

--     [80] = "Cannonball" ,-- = 0x50
--     [81] = "ArmosStatue" ,-- = 0x51
--     -- [82] = "KingZora" ,-- = 0x52
--     -- [83] = "ArmosKnight" ,-- = 0x53
--     -- [84] = "Lanmolas" ,-- = 0x54
--     [85] = "FireballZora" ,-- = 0x55
--     [86] = "Zora" ,-- = 0x56
--     [87] = "DesertStatue" ,-- = 0x57
--     [88] = "Crab" ,-- = 0x58
--     -- [89] = "LostWoodsBird" ,-- = 0x59
--     -- [90] = "LostWoodsSquirrel" ,-- = 0x5a
--     [91] = "SparkCW" ,-- = 0x5b
--     [92] = "SparkCCW" ,-- = 0x5c
--     [93] = "RollerVerticalUp" ,-- = 0x5d
--     [94] = "RollerVerticalDown" ,-- = 0x5e
--     [95] = "RollerHorizontalLeft" ,-- = 0x5f
--     [96] = "RollerHorizontalRight" ,-- = 0x60
--     [97] = "Beamos" ,-- = 0x61
--     [98] = "MasterSword" ,-- = 0x62
--     [99] = "DebirandoPit" ,-- = 0x63
--     [100] = "Debirando" ,-- = 0x64
--     -- [101] = "ArcheryNpc" ,-- = 0x65
--     [102] = "WallCannonVertLeft" ,-- = 0x66
--     [103] = "WallCannonVertRight" ,-- = 0x67
--     [104] = "WallCannonHorzTop" ,-- = 0x68
--     [105] = "WallCannonHorzBottom" ,-- = 0x69
--     [106] = "BallNChain" ,-- = 0x6a
--     [107] = "CannonTrooper" ,-- = 0x6b
--     [109] = "CricketRat" ,-- = 0x6d
--     [110] = "Snake" ,-- = 0x6e
--     [111] = "Keese" ,-- = 0x6f

--     [113] = "Leever" ,-- = 0x71
--     [114] = "FairyPondTrigger" ,-- = 0x72
--     -- [115] = "UnclePriest" ,-- = 0x73
--     -- [116] = "RunningNpc" ,-- = 0x74
--     -- [117] = "BottleMerchant" ,-- = 0x75
--     -- [118] = "Zelda" ,-- = 0x76
--     -- [120] = "Grandma" ,-- = 0x78
--     [121] = "Bee" ,-- = 0x79
--     -- [122] = "Agahnim" ,-- = 0x7a
--     [124] = "FloatingSkull" ,-- = 0x7c
--     [125] = "BigSpike" ,-- = 0x7d
--     [126] = "FirebarCW" ,-- = 0x7e
--     [127] = "FirebarCCW" ,-- = 0x7f
--     [128] = "Firesnake" ,-- = 0x80
--     [129] = "Hover" ,-- = 0x81
--     [130] = "AntiFairyCircle" ,-- = 0x82
--     [131] = "GreenEyegoreMimic" ,-- = 0x83
--     [132] = "RedEyegoreMimic" ,-- = 0x84
--     [133] = "YellowStalfos" ,-- = 0x85  # falling stalfos that shoots head
--     [134] = "Kodongo" ,-- = 0x86
--     [135] = "KodongoFire" ,-- = 0x87
--     -- [136] = "Mothula" ,-- = 0x88
--     [138] = "SpikeBlock" ,-- = 0x8a
--     [139] = "Gibdo" ,-- = 0x8b
--     -- [140] = "Arrghus" ,-- = 0x8c
--     [141] = "Arrghi" ,-- = 0x8d
--     [142] = "Terrorpin" ,-- = 0x8e
--     [143] = "Blob" ,-- = 0x8f
--     [144] = "Wallmaster" ,-- = 0x90
--     [145] = "StalfosKnight" ,-- = 0x91
--     -- [146] = "HelmasaurKing" ,-- = 0x92
--     [147] = "Bumper" ,-- = 0x93
--     [148] = "Pirogusu" ,-- = 0x94
--     -- [149] = "LaserEyeLeft" ,-- = 0x95
--     -- [150] = "LaserEyeRight" ,-- = 0x96
--     -- [151] = "LaserEyeTop" ,-- = 0x97
--     -- [152] = "LaserEyeBottom" ,-- = 0x98
--     [153] = "Pengator" ,-- = 0x99
--     [154] = "Kyameron" ,-- = 0x9a
--     [155] = "Wizzrobe" ,-- = 0x9b
--     [156] = "Zoro" ,-- = 0x9c  # babasu horizontal?
--     [157] = "Babasu" ,-- = 0x9d  # babasu vertical?
--     -- [158] = "GroveOstritch" ,-- = 0x9e
--     -- [159] = "GroveRabbit" ,-- = 0x9f
--     -- [160] = "GroveBird" ,-- = 0xa0
--     [161] = "Freezor" ,-- = 0xa1
--     -- [162] = "Kholdstare" ,-- = 0xa2
--     -- [163] = "KholdstareShell" ,-- = 0xa3
--     -- [164] = "FallingIce" ,-- = 0xa4
--     [165] = "BlueZazak" ,-- = 0xa5
--     [166] = "RedZazak" ,-- = 0xa6
--     [167] = "Stalfos" ,-- = 0xa7
--     [168] = "GreenZirro" ,-- = 0xa8
--     [169] = "BlueZirro" ,-- = 0xa9
--     [170] = "Pikit" ,-- = 0xaa
--     -- [171] = "CrystalMaiden" ,-- = 0xab
--     -- [172] = "Apple" ,-- = 0xac
--     -- [173] = "OldMan" ,-- = 0xad
--     -- [174] = "PipeDown" ,-- = 0xae
--     -- [175] = "PipeUp" ,-- = 0xaf
--     -- [176] = "PipeRight" ,-- = 0xb0
--     -- [177] = "PipeLeft" ,-- = 0xb1
--     [178] = "GoodBee" ,-- = 0xb2
--     -- [179] = "PedestalPlaque" ,-- = 0xb3
--     -- [180] = "PurpleChest" ,-- = 0xb4
--     -- [181] = "BombShopGuy" ,-- = 0xb5
--     -- [182] = "Kiki" ,-- = 0xb6
--     -- [183] = "BlindMaiden" ,-- = 0xb7
--     -- [186] = "BullyPinkBall" ,-- = 0xb9

--     -- [187] = "Whirlpool" ,-- = 0xba
--     -- [188] = "Shopkeeper" ,-- = 0xbb
--     -- [189] = "Drunkard" ,-- = 0xbc
--     -- [190] = "Vitreous" ,-- = 0xbd
--     -- # ... (spawnables)
--     [192] = "Catfish" ,-- = 0xc0
--     -- [193] = "CutsceneAgahnim" ,-- = 0xc1
--     [194] = "Boulder" ,-- = 0xc2
--     [195] = "Gibo" ,-- = 0xc3  # patrick!
--     [196] = "Thief" ,-- = 0xc4
--     [197] = "Medusa" ,-- = 0xc5
--     [198] = "FourWayShooter" ,-- = 0xc6
--     [199] = "Pokey" ,-- = 0xc7
--     -- [200] = "BigFairy" ,-- = 0xc8
--     [201] = "Tektite" ,-- = 0xc9  # firebat?
--     [202] = "Chainchomp" ,-- = 0xca
--     -- [203] = "TrinexxRockHead" ,-- = 0xcb
--     -- [204] = "TrinexxFireHead" ,-- = 0xcc
--     -- [205] = "TrinexxIceHead" ,-- = 0xcd
--     -- [206] = "Blind" ,-- = 0xce
--     [207] = "Swamola" ,-- = 0xcf
--     [208] = "Lynel" ,-- = 0xd0
--     [209] = "BunnyBeam" ,-- = 0xd1
--     [210] = "FloppingFish" ,-- = 0xd2
--     [211] = "Stal" ,-- = 0xd3  # alive skull rock?
--     -- [212] = "Landmine" ,-- = 0xd4
--     -- [213] = "DiggingGameNPC" ,-- = 0xd5
--     [214] = "Ganon" ,-- = 0xd6