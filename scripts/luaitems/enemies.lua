function Enemies_scope(scope_enemy_index, scope_name, scope_health, scope_dmg_table, scope_counter)
    
    local Code = "enemy_"..scope_counter
    local Basename = scope_name.."_lua"

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        if not MANUAL_TRACKING_ENEMIES then
            local row_counter_horizontal = 1+self:Get("Index")//21
            local row_counter_vertical = 1+(2*self:Get("Index")//24)
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
        -- -@type ItemState
        self.ItemState = {
            Health = health,
            RAW_damage_table = {table.unpack(dmg_table)},
            Default_damage_table = {},
            Damage_table = {},
            Index = counter,
            Code = "enemy_"..counter,
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

        NAMED_ENEMIES[name] = self
        for i=1,16 do
            local dmg_class_item = Tracker:FindObjectForCode(scope_counter.."_"..i-1)
            -- REVERSE_DMG_CLASSES[scope_counter.."_"..i-1] = Basename
            if invulnerable then
                -- dmg_class_item.CurrentStage = 7
                self.ItemState.Default_damage_table[i] = 7
                self.ItemState.Damage_table[i] = 7
            elseif reverse_dmg_list[dmg_table[i]] then
                self.ItemState.Default_damage_table[i] = reverse_dmg_list[dmg_table[i]]
                self.ItemState.Damage_table[i] = reverse_dmg_list[dmg_table[i]]
            else
                self.ItemState.Default_damage_table[i] = 1
                self.ItemState.Damage_table[i] = 1
            end
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
    {{21}, "Anti-Fairy", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0}, --1 --"enemy_0",
    {{70}, "Blue Archer", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250}, --"enemy_1",
    {{71}, "Green Archer", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 250}, --"enemy_2",
    {{81}, "Armos", 8, 255, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 8, 254, 253, 16, 25}, --"enemy_3",
    {{141}, "Arrgi", 8, 0, 0, 4, 8, 16, 16, 0, 0, 4, 100, 0, 8, 8, 0, 0, 0}, --"enemy_4",
    {{157}, "Babusu", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64}, --"enemy_5",
    -- {{80}, "Ball", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"",
    {{106}, "Ball and Chain Soldier", 16, 251, 2, 2, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_6",
    -- {{}, "Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255},
    {{36}, "Blue Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_7",
    {{35}, "Red Bari", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_8",
    {{97}, "Beamos", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_9",
    {{121}, "Bee", 0, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 249, 8, 8, 16, 16, 32}, --"enemy_10",
    {{}, "Biri", 2, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_11",
    {{138}, "Blade Trap", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_12",
    -- {{}, "Blazing Bat", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"",
    {{74}, "Bomb Knight", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 250}, --"enemy_13",
    -- {{}, "Bone Cucco", 255, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 0, 0, 0}, --"",
    {{244}, "Boulder", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_14",
    {{147}, "Bumper", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_15",
    {{109}, "Buzz", 8, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_16",
    {{13}, "Buzz Blob", 3, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 249, 253, 254, 253, 254, 255}, --"enemy_17"
    {{202}, "Chain Chomp", 5, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_18",
    {{111}, "Chasupa", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_19",
    {{0}, "Crow", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_20",
    {{11}, "Cucco", 255, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 0, 0, 0}, --"enemy_21",
    -- {{}, "Cukeman", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"",
    {{39}, "Deadrock", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_22",
    {{100}, "Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64}, --"enemy_23",
    -- {{100}, "Blue Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64}, --"",
    -- {{100}, "Red Devalant", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 8, 64, 16, 64}, --"",
    {{131}, "Green Eyegore", 16, 0, 2, 4, 64, 64, 16, 64, 0, 4, 24, 0, 0, 0, 0, 0, 0}, --"enemy_24",
    {{132}, "Red Eyegore", 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 0, 0, 0, 0, 0, 0}, --"enemy_25",
    {{198}, "Fireball Cannon", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_26",
    -- {{}, "Flying Tile", 0, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"",
    {{161}, "Freezor", 16, 0, 0, 0, 0, 16, 16, 0, 0, 0, 0, 0, 253, 0, 253, 0, 0}, --"enemy_27",
    {{76}, "Geldman", 4, 1, 2, 4, 8, 16, 16, 64, 255, 4, 100, 0, 64, 8, 64, 16, 255}, --"enemy_28",
    {{80}, "Giant Ball", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_29",
    {{138}, "Giant Blade Trap", 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_30",
    {{139}, "Gibdo", 32, 255, 2, 4, 8, 16, 16, 0, 0, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_31",
    {{195}, "Gibo", 8, 0, 2, 4, 8, 16, 16, 16, 0, 4, 100, 0, 0, 0, 0, 0, 0}, --"enemy_32",
    {{178}, "Golden Bee", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_33",
    {{239}, "Green Goriya", 16, 0, 2, 4, 64, 64, 16, 64, 0, 4, 24, 0, 0, 0, 0, 0, 0}, --"enemy_34",
    {{240}, "Red Goriya", 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 0, 0, 0, 0, 0, 0}, --"enemy_35"
    {{126, 127}, "Guruguru Bar", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_36",
    {{38}, "Blue Hardhat Beetle", 6, 0, 2, 4, 8, 16, 16, 0, 255, 255, 100, 0, 0, 0, 253, 254, 255}, --"enemy_37",
    {{38}, "Red Hardhat Beetle", 32, 0, 2, 4, 8, 16, 16, 0, 255, 255, 100, 0, 0, 0, 253, 254, 255}, --"enemy_38",
    {{24}, "Mini Helmasaur", 4, 0, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 0, 0, 253, 254, 250}, --"enemy_39",
    {{17}, "Hinox", 20, 252, 2, 4, 8, 16, 64, 4, 0, 64, 100, 0, 8, 254, 253, 254, 250}, --"enemy_40",
    {{23}, "Bush Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 64, 64, 64, 64, 250}, --"enemy_41",
    {{62}, "Stone Hoarder", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 64, 64, 64, 250}, --"enemy_42",
    {{199}, "Hokkubokku", 32, 0, 2, 4, 8, 16, 16, 4, 0, 4, 24, 0, 253, 8, 253, 254, 255}, --"enemy_43",
    {{129}, "Hover", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 16, 64}, --"enemy_44",
    {{25}, "Hyu", 8, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_45",
    {{111}, "Keese", 1, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 255}, --"enemy_46",
    {{134}, "Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250}, --"enemy_47",
    -- {{134}, "Green Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250}, --"",
    -- {{}, "Red Kodongo", 0, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 253, 254, 253, 254, 250}, --"",
    {{85}, "Ku", 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_48",
    {{154}, "Kyameron", 4, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 64, 254, 64, 254, 32}, --"enemy_49",
    {{0}, "Kyune", 8, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_50",
    {{149,150,151,152}, "Laser Eye", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_51",
    {{113}, "Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64}, --"enemy_52",
    -- {{113}, "Green Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64}, --"",
    -- {{113}, "Purple Leever", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 254, 253, 254, 64}, --"",
    -- {{}, "Like Like", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"",
    {{208}, "Lynel", 24, 0, 0, 0, 8, 16, 16, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0}, --"enemy_53"
    {{197}, "Medusa", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_54",
    {{24}, "Mini-Moldorm", 3, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 8, 253, 16, 250}, --"enemy_55",
    {{66}, "Moblin", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 250, 253, 254, 253, 254, 250}, --"enemy_56",
    {{15}, "Octoballoon", 2, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 16, 64}, --"enemy_57",
    {{8}, "Octorok", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_58",
    {{153}, "Pengator", 16, 1, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 8, 0, 253, 254, 64}, --"enemy_59",
    {{170}, "Pikit", 12, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 255}, --"enemy_60",
    {{196}, "Pikku", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_61",
    {{148}, "Pirogusu", 2, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_62",
    {{25}, "Poe", 8, 1, 2, 4, 64, 16, 16, 4, 64, 4, 100, 0, 253, 8, 253, 64, 255}, --"enemy_63",
    {{78, 79}, "Popo", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_64",
    {{209}, "Rabbit_Beam", 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 249, 0, 0, 64, 64, 64}, --"enemy_65",
    {{109}, "Rat", 2, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_66",
    {{85}, "River Zora", 8, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_67",
    {{86}, "River Zora Walking", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 64, 32}, --"enemy_68",
    {{34}, "Ropa", 8, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_69",
    {{110}, "Rope", 4, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_70",
    {{88}, "Sand Crab", 2, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 254, 253, 254, 250}, --"enemy_71",
    {{8}, "Slarok", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_72",
    -- {{}, "Slime", 0, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"",
    {{32}, "Sluggula", 8, 255, 2, 4, 8, 16, 16, 4, 255, 0, 100, 250, 253, 254, 253, 254, 250}, --"enemy_73"
    {{14}, "Snap Dragon", 12, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_74",
    {{75}, "Green Soldier", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_75",
    {{91,92}, "Spark", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 0, 255}, --"enemy_76",
    {{72}, "Spear Knight", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_77",
    {{67}, "Green Spear Soldier", 4, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_78",
    {{69}, "Red Spear Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_79",
    {{73}, "Red Bush Soldier", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_80",
    {{93,94,95,96}, "Spiked Roller", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_81",
    {{110}, "Stal", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 8, 8, 16, 64, 250}, --"enemy_82",
    {{167}, "Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_83",
    -- {{167}, "Blue Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"",
    -- {{167}, "Gray Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"",
    -- {{167}, "Red Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"",
    {{133}, "Yellow Stalfos", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"enemy_84",
    {{124}, "Orange Stalfos Head", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_85",
    -- {{167}, "Green Stalfos Head", 4, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 64, 253, 64, 250}, --"",
    {{145}, "Stalfos Knight", 64, 1, 2, 4, 8, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_86",
    {{110}, "Stalrope", 8, 255, 2, 4, 8, 16, 16, 4, 64, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_87",
    {{207}, "Swamola", 16, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 8, 8, 16, 64, 32}, --"enemy_88",
    {{68}, "Sword Knight", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_89",
    {{65}, "Blue Sword Soldier", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 250}, --"enemy_90",
    {{66}, "Green Sword Soldier", 4, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 250, 253, 254, 253, 254, 250}, --"enemy_91"
    {{65}, "Blue Taros", 6, 255, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 8, 253, 254, 250}, --"enemy_92",
    {{69}, "Red Taros", 8, 255, 2, 3, 4, 16, 16, 4, 255, 4, 100, 0, 253, 0, 253, 254, 250}, --"enemy_93",
    {{201}, "Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250}, --"enemy_94",
    -- {{201}, "Blue Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250}, --"",
    -- {{201}, "Red Tektite", 8, 251, 2, 4, 8, 16, 16, 16, 0, 64, 100, 0, 253, 254, 253, 254, 250}, --"",
    {{142}, "Terrorpin", 8, 1, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 8, 254, 64, 254, 255}, --"enemy_95",
    {{196}, "Thief", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_96",
    {{77}, "Toppo", 2, 1, 2, 4, 8, 16, 16, 4, 255, 4, 100, 0, 253, 64, 253, 64, 255}, --"enemy_97",
    {{1}, "Vulture", 6, 1, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_98",
    {{102,103,104,105}, "Wall Turret", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_99",
    {{144}, "Wallmaster", 8, 1, 2, 4, 8, 16, 16, 4, 0, 4, 100, 0, 253, 8, 253, 16, 64}, --"enemy_100",
    {{128}, "Winder", 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --"enemy_101",
    {{155}, "Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64}, --"enemy_102",
    -- {{155}, "Green Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64}, --"",
    -- {{155}, "Purple Wizzrobe", 2, 0, 2, 4, 8, 16, 16, 4, 0, 0, 100, 0, 8, 8, 64, 16, 64}, --"",
    {{165}, "Blue Zazak", 4, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255}, --"enemy_103",
    {{166}, "Red Zazak", 8, 255, 2, 4, 8, 16, 16, 4, 255, 64, 100, 0, 253, 254, 253, 254, 255}, --"enemy_104",
    {{168}, "Green Zirro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_105",
    {{169}, "Blue Zirro", 8, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 254, 253, 254, 32}, --"enemy_106",
    {{143}, "Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"enemy_107",
    -- {{143}, "Dark Green Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"",
    -- {{143}, "Green Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"",
    -- {{143}, "Red Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --"",
    -- {{143}, "Yellow Zol", 4, 255, 2, 4, 8, 16, 16, 4, 64, 64, 100, 0, 253, 254, 253, 254, 64}, --""
    {{156}, "Zoro", 4, 0, 2, 4, 8, 16, 16, 4, 64, 4, 100, 0, 253, 64, 253, 64, 64}, --"enemy_108"
    --- maybe add bosses here later
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
    counter = counter+1
    -- CreateLuaEnemeyClass(enemy[1], enemy[2], {table.unpack(enemy, 3)}, counter)
    -- print(enemy[1], enemy[2], {table.unpack(enemy, 3)}, counter)
    Enemies_scope(enemy[1], enemy[2], enemy[3], {table.unpack(enemy, 4)}, counter)
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

--     -- [216] = "SmallHeart" ,-- = 0xd8
--     -- [217] = "GreenRupee" ,-- = 0xd9
--     -- [218] = "BlueRupee" ,-- = 0xda
--     -- [219] = "RedRupee" ,-- = 0xdb
--     -- [220] = "BombRefill1" ,-- = 0xdc
--     -- [221] = "BombRefill4" ,-- = 0xdd
--     -- [222] = "BombRefill8" ,-- = 0xde

--     -- [224] = "LargeMagic" ,-- = 0xe0
--     [227] = "Faerie" ,-- = 0xe3
--     -- [228] = "SmallKey" ,-- = 0xe4
--     -- [231] = "Mushroom" ,-- = 0xe7
--     -- [232] = "FakeMasterSword" ,-- = 0xe8
--     -- [233] = "MagicShopAssistant" ,-- = 0xe9
--     -- [235] = "HeartPiece" ,-- = 0xeb
--     -- [237] = "SomariaPlatform" ,-- = 0xed
--     [238] = "CastleMantle" ,-- = 0xee
--     [239] = "GreenMimic" ,-- = 0xef
--     [240] = "RedMimic" ,-- = 0xf0
--     -- [242] = "MedallionTablet" ,-- = 0xf2
--     -- [243] = "PositionTarget" ,-- = 0xf3
--     [244] = "Boulders" ,-- = 0xf4
-- }