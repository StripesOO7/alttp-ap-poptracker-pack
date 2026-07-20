function Enemies_scope(scope_name, scope_health, scope_dmg_table, scope_counter)
    
    local Code = "enemy_"..scope_counter
    local Basename = scope_name

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        local row_counter_horizontal = 1+self:Get("Index")//21
        local row_counter_vertical = 1+(2*self:Get("Index")//24)
        Tracker:UiHint("ActivateTab", "Damage Table")
        Tracker:UiHint("ActivateTab", "Row "..row_counter_horizontal)
        Tracker:UiHint("ActivateTab", "Row "..row_counter_vertical.."&"..row_counter_vertical+1)
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


    ---function to create ER LuaItems in their default state
    ---@param name string
    ---@param health integer
    ---@param dmg_table integer[]
    ---@param counter integer
    ---@return LuaItem
    function CreateLuaEnemeyClass(name, health, dmg_table, counter)
        local self = ScriptHost:CreateLuaItem()
        -- self.Type = "custom"
        self.Name = name
        self.Icon = ImageReference:FromPackRelativePath("images/enemies/" .. string.lower(name) .. ".png")
        ---@type ItemState
        self.ItemState = {
            Health = health,
            Default_damage_table = {table.unpack(dmg_table)
            },
            Damage_table = {table.unpack(dmg_table)
            },
            Index = counter,
            Code = "enemy_"..counter,
            Invulnerable = nil,
            SpecialEffect = nil,
            
        } --[[@as table<string, any>]]

        if health == 255 then
            self:Set("Invulnerable", true)
        else
            self:Set("Invulnerable", false)
        end
        -- local stun = {255, 251}
        -- local freeze = {254}
        -- local burn = {253}
        -- local transform_slime = {250}
        -- local transform_fairy = {249}
        self:Set("SpecialEffect", nil)

        NAMED_ENEMIES[name] = self

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

    return CreateLuaEnemeyClass(scope_name, scope_health, scope_dmg_table, scope_counter)
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
---@field [1] string Name
---@field [2] integer Health
---@field [3] integer Class 1 Damage
---@field [4] integer Class 2 Damage
---@field [5] integer Class 3 Damage
---@field [6] integer Class 4 Damage
---@field [7] integer Class 5 Damage
---@field [8] integer Class 6 Damage
---@field [9] integer Class 7 Damage
---@field [10] integer Class 8 Damage
---@field [11] integer Class 9 Damage
---@field [12] integer Class 10 Damage
---@field [13] integer Class 11 Damage
---@field [14] integer Class 12 Damage
---@field [15] integer Class 13 Damage
---@field [16] integer Class 14 Damage
---@field [17] integer Class 15 Damage

---@type table<string, enemy_table>
DEFAULT_ENEMY_DAMAGE_TABLE = {
    {"Anti-Fairy", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0}, --1 --"enemy_0",
    {"Blue Archer", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250}, --"enemy_1",
    {"Green Archer", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 250}, --"enemy_2",
    {"Armos", 8, 255, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 8, 254, 253, 16, 25}, --"enemy_3",
    {"Arrgi", 8, 0, 0, 4, 8, 16, 16, 0, 0, 4, 100, 0, 8, 8, 0, 0, 0}, --"enemy_4",
    {"Babusu", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64}, --"enemy_5",
    {"Ball", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_6",
    {"Ball and Chain Soldier", 16, 251, 2, 2, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_7",
    -- {"Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255},
    {"Blue Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_8",
    {"Red Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_9",
    {"Beamos", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_10",
    {"Bee", 0, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 249, 8, 8, 16, 16, 32}, --"enemy_11",
    {"Biri", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_12",
    {"Blade Trap", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_13",
    {"Blazing Bat", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_14",
    {"Bomb Knight", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250}, --"enemy_15",
    {"Bone Cucco", 255, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 0, 0, 0}, --"enemy_16",
    {"Boulder", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_17",
    {"Bumper", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_18",
    {"Buzz", 8, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_19",
    {"Buzz Blob", 3, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 249, 253, 254, 253, 254, 255}, --"enemy_20"
    {"Chain Chomp", 5, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_21",
    {"Chasupa", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_22",
    {"Crow", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_23",
    {"Cucco", 255, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 0, 0, 0}, --"enemy_24",
    {"Cukeman", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_25",
    {"Deadrock", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_26",
    -- {"Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64},
    {"Blue Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64}, --"enemy_27",
    {"Red Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64}, --"enemy_28",
    {"Green Eyegore", 16, 0, 2, 4, 64, 64, 16, 64, 0, 4, 24, 0, 0, 0, 0, 0, 0}, --"enemy_29",
    {"Red Eyegore", 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 0, 0, 0, 0, 0, 0}, --"enemy_30",
    {"Fireball Cannon", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_31",
    {"Flying Tile", 0, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_32",
    {"Freezor", 16, 0, 0, 0, 0, 16, 16, 0, 0, 0, 0, 0, 253, 0, 253, 0, 0}, --"enemy_33",
    {"Geldman", 4, 1, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 64, 8, 64, 16, 255}, --"enemy_34",
    {"Giant Ball", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_35",
    {"Giant Blade Trap", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_36",
    {"Gibdo", 32, 255, 2, 4, 8, 16, 16, 0, 0, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_37",
    {"Gibo", 8, 0, 2, 4, 8, 16, 16, 16, 0, 4, 100, 0, 0, 0, 0, 0, 0}, --"enemy_38",
    {"Golden Bee", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_39",
    {"Green Goriya", 16, 0, 2, 4, 64, 64, 16, 64, 0, 4, 24, 0, 0, 0, 0, 0, 0}, --"enemy_40",
    {"Red Goriya", 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 0, 0, 0, 0, 0, 0}, --"enemy_41"
    {"Guruguru Bar", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_42",
    {"Blue Hardhat Beetle", 6, 0, 2, 4, 8, 16, 16, 0, 255, 255, 100, 0, 0, 0, 253, 254, 255}, --"enemy_43",
    {"Red Hardhat Beetle", 32, 0, 2, 4, 8, 16, 16, 0, 255, 255, 100, 0, 0, 0, 253, 254, 255}, --"enemy_44",
    {"Helmasaur", 4, 0, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 0, 0, 253, 254, 250}, --"enemy_45",
    {"Hinox", 20, 252, 2, 4, 8, 16, 64, 4, 0, 64, 100, 0, 8, 254, 253, 254, 250}, --"enemy_46",
    {"Bush Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 64, 64, 64, 64, 250}, --"enemy_47",
    {"Stone Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 64, 64, 64, 250}, --"enemy_48",
    {"Hokkubokku", 32, 0, 2, 4, 8, 16, 16, 4, 0, 4, 24, 0, 253, 8, 253, 254, 255}, --"enemy_49",
    {"Hover", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 16, 64}, --"enemy_50",
    {"Hyu", 8, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_51",
    {"Keese", 1, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_52",
    -- {"Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250},
    {"Green Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250}, --"enemy_53",
    {"Red Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250}, --"enemy_54",
    {"Ku", 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_55",
    {"Kyameron", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 254, 64, 254, 32}, --"enemy_56",
    {"Kyune", 8, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_57",
    {"Laser Eye", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_58",
    -- {"Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64},
    {"Green Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64}, --"enemy_59",
    {"Purple Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64}, --"enemy_60",
    {"Like Like", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_61",
    {"Lynel", 24, 0, 0, 0, 8, 16, 16, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0}, --"enemy_62"
    {"Medusa", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_63",
    {"Mini-Moldorm", 3, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 8, 253, 16, 250}, --"enemy_64",
    {"Moblin", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 253, 254, 253, 254, 250}, --"enemy_65",
    {"Octoballoon", 2, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 16, 64}, --"enemy_66",
    {"Octorok", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_67",
    {"Pengator", 16, 1, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 8, 0, 253, 254, 64}, --"enemy_68",
    {"Pikit", 12, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 255}, --"enemy_69",
    {"Pikku", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_70",
    {"Pirogusu", 2, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_71",
    {"Poe", 8, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_72",
    {"Popo", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_73",
    {"Rabbit_Beam", 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 64, 64, 64}, --"enemy_74",
    {"Rat", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_75",
    {"River Zora", 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_76",
    {"River Zora Walking", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_77",
    {"Ropa", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_78",
    {"Rope", 4, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_79",
    {"Sand Crab", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 254, 253, 254, 250}, --"enemy_80",
    {"Slarok", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_81",
    {"Slime", 0, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_82",
    {"Sluggula", 8, 255, 2, 4, 8, 16, 16, 4, 255, 0, 100, 250, 253, 254, 253, 254, 250}, --"enemy_83"
    {"Snap Dragon", 12, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_84",
    {"Green Soldier", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_85",
    {"Spark", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 0, 255}, --"enemy_86",
    {"Spear Knight", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_87",
    {"Green Spear Soldier", 4, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_88",
    {"Red Spear Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_89",
    {"Spear Throwing Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_90",
    {"Spiked Roller", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_91",
    {"Stal", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 8, 16, 64, 250}, --"enemy_92",
    -- {"Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250},
    {"Blue Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_93",
    {"Gray Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_94",
    {"Red Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_95",
    {"Yellow Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_96",
    {"Orange Stalfos Head", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_97",
    {"Green Stalfos Head", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_98",
    {"Stalfos Knight", 64, 1, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_99",
    {"Stalrope", 8, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_100",
    {"Swamola", 16, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 16, 64, 32}, --"enemy_101",
    {"Sword Knight", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_102",
    {"Blue Sword Soldier", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 250}, --"enemy_103",
    {"Green Sword Soldier", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_104"
    {"Blue Taros", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 250}, --"enemy_105",
    {"Red Taros", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_106",
    -- {"Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250},
    {"Blue Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250}, --"enemy_107",
    {"Red Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250}, --"enemy_108",
    {"Terrorpin", 8, 1, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 8, 254, 64, 254, 255}, --"enemy_109",
    {"Thief", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_110",
    {"Toppo", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_111",
    {"Vulture", 6, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_112",
    {"Wall Turret", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_113",
    {"Wallmaster", 8, 1, 2, 4, 8, 16, 16, 4, 0, 4, 100, 0, 253, 8, 253, 16, 64}, --"enemy_114",
    {"Winder", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_115",
    -- {"Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64},
    {"Green Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64}, --"enemy_116",
    {"Purple Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64}, --"enemy_117",
    {"Blue Zazak", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255}, --"enemy_118",
    {"Red Zazak", 8, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255}, --"enemy_119",
    {"Green Zirro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_120",
    {"Blue Zirro", 8, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_121",
    -- {"Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64},
    {"Dark Green Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_122",
    {"Green Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_123",
    {"Red Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_124",
    {"Yellow Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_125"
    {"Zoro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64}, --"enemy_125"
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
for _, enemy in pairs(DEFAULT_ENEMY_DAMAGE_TABLE) do
    counter = counter+1
    -- CreateLuaEnemeyClass(enemy[1], enemy[2], {table.unpack(enemy, 3)}, counter)
    Enemies_scope(enemy[1], enemy[2], {table.unpack(enemy, 3)}, counter)
    -- for i=0,15 do
    --     -- CreateLuaDamageClass(counter, i, enemy[1], enemy[i+3])--, enemy[2], {table.unpack(enemy, 3)})
    --     Damage_Classes_scope(counter, i, enemy[1], enemy[i+3])--, enemy[2], {table.unpack(enemy, 3)})
    -- end
end
Tracker.BulkUpdate = false