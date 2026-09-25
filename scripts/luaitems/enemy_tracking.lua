function Enemy_tracking_scope(scope_room_id, scope_counter, scope_code, scope_enemy_id) --code = room_id..counter
    local Code = scope_code.."_enemy"
    local Basename = scope_code.."_lua"

    local default_unkown_img = ImageReference:FromPackRelativePath("images/items/unknown.png")
    local defaultReferenceEnemy = Tracker:FindObjectForCode("enemy_"..scope_enemy_id) --[[@as LuaItem]]
    
    local defaultReferenceEnemy_code = string.gsub(defaultReferenceEnemy.Name, " ", "_")
    defaultReferenceEnemy_code = string.gsub(defaultReferenceEnemy_code, "%(", "")
    defaultReferenceEnemy_code = string.gsub(defaultReferenceEnemy_code, "%)", "")

    ENEMY_ROOM_MAPPING[Code] = defaultReferenceEnemy_code

    ---function that get triggered when left clicking a lua items as hosted item or in an itemgrid
    ---will select 2 LuaItems and connect them to be traversable in the graph
    ---@param self LuaItem
    local function OnLeftClickFunc(self)
        if not MANUAL_TRACKING_ENEMIES then
            MANUAL_TRACKING_ENEMIES = true
            SELECTED_ENEMY = self
            Tracker:UiHint("ActivateTab", "Damage Table")
            Tracker:UiHint("ActivateTab", "Overview")
        end
    end

    ---function that get triggered when right clicking a lua items as hosted item or in an itemgrid
    ---will remove the connection between the selected luaItem and its connected partner
    ---specific to ER LuaItems
    ---@param self LuaItem
    local function OnRightClickFunc(self)
        if ENEMIZER then
            self.Icon = default_unkown_img
            self.Name = "unknown"
            self.ItemState.EnemyRefCode = nil
            self.ItemState.EnemyRefItem = nil
            ENEMY_ROOM_MAPPING[Code] = "unkown"
        else
            
            self.Icon = defaultReferenceEnemy.Icon
            self.Name = defaultReferenceEnemy.Name
            self.ItemState.EnemyRefCode = self.ItemState.EnemyRefDefaultCode
            self.ItemState.EnemyRefItem = self.ItemState.EnemyRefDefaultItem
            ENEMY_ROOM_MAPPING[Code] = defaultReferenceEnemy_code
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
            Code = self.ItemState.Code,
            EnemyRefItem = self.ItemState.EnemyRefItem,
            EnemyRefCode = self.ItemState.EnemyRefCode,
            EnemyRefItemDefault = self.ItemState.EnemyRefItemDefault,
            EnemyRefCodeDefault = self.ItemState.EnemyRefCodeDefault,
            Originpath = self.ItemState.Originpath,
            last_enemy_mapping = ENEMY_ROOM_MAPPING[Code],
        }
        -- print("SaveFunc")
    end

    ---function triggered on loading the pack to restore the lat saves state. specific to ER LuaItems
    ---@param self LuaItem
    ---@param data table
    local function LoadLocationFunc(self, data)
        if data ~= nil and scope_code == data.Code then
            self.Name = data.Name
            self.Icon = data.Icon
            self.ItemState.Code = data.Code
            self.ItemState.EnemyRefItem = data.EnemyRefItem
            self.ItemState.EnemyRefCode = data.EnemyRefCode
            self.ItemState.EnemyRefItemDefault = data.EnemyRefItemDefault
            self.ItemState.EnemyRefCodeDefault = data.EnemyRefCodeDefault
            self.ItemState.Originpath = data.Originpath
            ENEMY_ROOM_MAPPING[Code] = data.last_enemy_mapping
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
    ---@param room_id integer
    ---@param counter integer
    ---@param code string
    ---@param enemy_id integer
    ---@return LuaItem
    function CreateLuaEnemeyTracking(room_id, counter, code, enemy_id)
        local self = ScriptHost:CreateLuaItem()
        -- self.Type = "custom"
        self.Name = defaultReferenceEnemy.Name
        self.Icon = defaultReferenceEnemy.Icon
        -- -@type ItemState
        self.ItemState = {
            EnemyRefItem = nil,
            EnemyRefCode = nil,
            EnemyRefItemDefault = defaultReferenceEnemy,
            EnemyRefCodeDefault = "enemy_"..enemy_id,
            Code = code,
            Originpath = ROOM_LOOKUPTABLE[room_id]
        } --[[@as table<string, any>]]

        self.PotentialCodes = {Code, Basename}
        ENEMY_ROOM_MAPPING[Code] = defaultReferenceEnemy_code

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

    return CreateLuaEnemeyTracking(scope_room_id, scope_counter, scope_code, scope_enemy_id)
end

DEFAULT_DUNGEON_ROOM_ENEMIES = {
    [0] = {
        214,
    },
    [1] = {

    },
    [10] = {
        142,
        142,
        261,
        261,
        279,
        261,
        261,
    },
    [100] = {
        111,
        6,
        111,
        209,
        109,
        109,
        109,
        262,
        262,
        262,
        262,
        262,
        262,
    },
    [101] = {
        109,
        109,
        109,
        109,
        109,
    },
    [102] = {
        129,
        272,
        36,
        36,
        55,
        272,
        154,
        129,
        129,
        129,
        273,
        129,
    },
    [103] = {
        147,
        36,
        36,
        38,
        38,
        38,
        38,
        126,
        127,
        38,
    },
    [104] = {
        147,
        147,
        147,
        147,
        139,
        265,
        139,
        139,
    },
    [105] = {

    },
    [106] = {
        142,
        142,
        21,
        21,
        142,
        142,
    },
    [107] = {
        30,
        30,
        131,
        132,
        21,
        28,
        132,
        138,
        138,
        132,
        132,
        97,
        97,
        132,
    },
    [108] = {
        84,
        84,
        84,
        209,
        197,
    },
    [109] = {
        166,
        97,
        97,
        166,
        197,
        97,
        167,
        166,
        92,
    },
    [11] = {
        30,
        142,
        142,
        142,
        142,
        142,
        142,
        142,
        142,
        142,
    },
    [110] = {
        153,
        153,
        153,
        153,
        153,
    },
    [111] = {

    },
    [112] = {

    },
    [113] = {
        66,
        65,
        228,
    },
    [114] = {
        65,
        228,
        65,
    },
    [115] = {
        100,
        97,
        113,
        113,
        97,
        113,
        59,
    },
    [116] = {
        100,
        100,
        131,
        131,
        113,
        113,
        113,
        113,
    },
    [117] = {
        100,
        100,
        113,
        113,
        113,
        113,
        102,
        103,
        113,
        113,
    },
    [118] = {
        33,
        129,
        154,
        129,
        143,
        275,
        36,
    },
    [119] = {
        24,
        30,
        30,
        30,
        134,
        134,
    },
    [12] = {

    },
    [120] = {

    },
    [121] = {

    },
    [122] = {

    },
    [123] = {
        36,
        36,
        198,
        167,
        167,
        198,
        28,
        38,
        167,
        198,
        198,
    },
    [124] = {
        24,
        127,
        138,
        126,
        38,
        36,
        267,
    },
    [125] = {
        128,
        128,
        128,
        128,
        167,
        198,
        128,
        19,
        35,
        128,
        38,
    },
    [126] = {
        147,
        127,
        153,
        161,
        161,
        153,
        127,
    },
    [127] = {
        35,
        35,
        35,
        35,
        125,
        125,
        125,
        125,
    },
    [128] = {
        118,
        66,
        106,
        228,
    },
    [129] = {
        66,
        66,
    },
    [13] = {
        122,
    },
    [130] = {
        65,
        65,
        65,
    },
    [131] = {
        99,
        99,
        113,
        227,
        227,
        113,
        113,
        97,
        113,
        113,
    },
    [132] = {
        113,
        113,
        97,
        113,
        113,
        113,
        113,
    },
    [133] = {
        99,
        100,
        79,
        79,
        79,
        97,
        113,
        113,
        97,
        113,
    },
    [134] = {

    },
    [135] = {
        24,
        24,
        24,
        24,
        276,
        30,
        30,
        30,
        167,
        167,
        167,
        228,
        167,
    },
    [136] = {

    },
    [137] = {
        227,
        227,
    },
    [138] = {

    },
    [139] = {
        147,
        30,
        30,
        36,
        138,
        167,
        126,
        127,
    },
    [14] = {
        161,
        36,
        36,
        36,
        228,
    },
    [140] = {
        6,
        282,
        282,
        282,
        282,
        282,
        91,
        138,
        167,
        167,
        128,
        91,
        21,
        128,
        21,
        59,
    },
    [141] = {
        276,
        198,
        21,
        209,
        198,
        139,
        265,
        138,
        167,
        126,
        36,
        197,
        36,
    },
    [142] = {
        161,
        143,
        209,
        143,
        143,
        143,
        143,
        143,
    },
    [143] = {

    },
    [144] = {
        189,
    },
    [145] = {
        30,
        138,
        264,
        197,
        209,
        21,
        21,
    },
    [146] = {
        30,
        30,
        21,
        197,
        21,
        197,
        198,
        278,
        138,
        21,
        167,
        21,
    },
    [147] = {
        197,
        197,
        197,
        197,
        143,
        167,
        167,
        21,
    },
    [148] = {

    },
    [149] = {
        67,
        67,
        67,
        67,
        267,
    },
    [15] = {

    },
    [150] = {
        126,
        150,
        150,
        150,
        150,
    },
    [151] = {
        277,
    },
    [152] = {
        143,
        143,
        143,
        143,
        143,
    },
    [153] = {
        21,
        21,
        131,
        131,
        228,
        78,
        78,
        79,
        79,
        79,
        79,
    },
    [154] = {

    },
    [155] = {
        30,
        30,
        30,
        138,
        138,
        138,
        198,
        138,
        138,
        138,
        138,
        38,
        38,
    },
    [156] = {
        38,
        19,
        38,
        38,
        38,
        38,
        128,
    },
    [157] = {
        30,
        38,
        139,
        139,
        38,
        139,
        36,
        36,
        36,
    },
    [158] = {
        35,
        35,
        145,
        35,
        161,
    },
    [159] = {
        157,
        157,
        157,
        157,
        21,
        126,
    },
    [16] = {

    },
    [160] = {
        197,
        21,
        128,
    },
    [161] = {
        30,
        91,
        91,
        155,
        197,
        197,
        167,
        209,
        167,
    },
    [162] = {

    },
    [163] = {

    },
    [164] = {
        203,
        204,
        205,
    },
    [165] = {
        155,
        155,
        155,
        155,
        138,
        155,
        155,
        155,
        151,
        151,
        67,
        65,
    },
    [166] = {
        277,
        21,
    },
    [167] = {
        227,
        227,
    },
    [168] = {
        167,
        167,
        167,
        167,
        280,
    },
    [169] = {
        131,
        131,
        261,
        261,
        261,
        261,
        167,
        167,
    },
    [17] = {
        109,
        109,
        111,
        111,
        109,
        109,
        109,
        109,
    },
    [170] = {
        21,
        79,
        167,
        167,
        167,
        79,
    },
    [171] = {
        30,
        138,
        138,
        138,
        143,
        138,
        138,
        138,
    },
    [172] = {
        206,
    },
    [173] = {

    },
    [174] = {
        36,
        36,
    },
    [175] = {
        126,
    },
    [176] = {
        67,
        111,
        111,
        72,
        72,
        67,
        106,
        111,
        111,
        67,
        67,
        228,
        68,
        72,
    },
    [177] = {
        197,
        197,
        138,
        138,
        155,
        125,
        198,
        155,
        21,
        155,
    },
    [178] = {
        155,
        209,
        21,
        209,
        21,
        32,
        32,
        21,
        197,
        197,
        32,
        32,
        78,
        78,
    },
    [179] = {
        167,
        167,
        97,
        198,
        167,
    },
    [18] = {
        115,
        118,
    },
    [180] = {

    },
    [181] = {
        126,
        126,
        126,
    },
    [182] = {
        202,
        202,
        30,
        30,
        227,
        199,
        228,
        276,
        143,
        143,
    },
    [183] = {
        95,
        93,
    },
    [184] = {
        78,
        78,
        130,
        131,
        167,
        167,
    },
    [185] = {
        259,
    },
    [186] = {
        167,
        21,
        167,
        21,
        79,
        167,
        79,
    },
    [187] = {
        166,
        195,
        166,
        195,
        21,
        195,
        128,
        195,
        195,
        21,
        195,
    },
    [188] = {
        165,
        167,
        138,
        166,
        138,
        165,
        167,
        167,
        167,
        165,
        128,
        166,
    },
    [189] = {

    },
    [19] = {
        30,
        21,
        21,
        21,
        21,
        124,
        199,
        228,
        150,
        124,
        209,
    },
    [190] = {
        21,
        161,
        36,
        36,
        145,
        36,
        36,
    },
    [191] = {
        30,
        209,
    },
    [192] = {
        65,
        70,
        65,
        70,
        228,
        65,
        65,
        70,
        65,
    },
    [193] = {
        30,
        197,
        197,
        167,
        167,
        124,
        197,
        276,
        21,
        198,
        36,
        228,
        124,
    },
    [194] = {
        128,
        128,
        197,
        91,
        91,
        209,
        128,
        91,
    },
    [195] = {
        197,
        150,
        149,
        150,
        149,
        267,
        21,
        197,
    },
    [196] = {
        30,
        30,
        30,
        30,
        199,
        21,
        19,
        19,
        21,
        21,
    },
    [197] = {
        150,
        149,
        150,
        149,
        150,
        149,
        19,
        150,
    },
    [198] = {
        167,
        167,
        36,
        36,
        124,
        36,
        36,
    },
    [199] = {

    },
    [2] = {
        109,
        109,
        109,
        109,
        109,
        262,
        262,
        262,
        262,
        262,
        262,
        262,
        6,
        4,
        109,
        109,
    },
    [20] = {
        176,
        175,
        174,
        174,
        174,
        174,
        176,
        177,
        176,
        177,
    },
    [200] = {
        83,
        83,
        83,
        83,
        83,
        83,
        281,
    },
    [201] = {
        79,
        79,
        79,
    },
    [202] = {

    },
    [203] = {
        209,
        128,
        165,
        143,
        91,
        143,
        167,
        166,
        166,
        143,
        143,
        209,
    },
    [204] = {
        128,
        209,
        165,
        91,
        143,
        166,
        165,
        128,
        143,
        91,
        91,
        166,
        143,
        209,
    },
    [205] = {

    },
    [206] = {
        35,
        35,
        4,
        28,
        36,
        36,
        36,
        36,
    },
    [207] = {

    },
    [208] = {
        111,
        65,
        111,
        68,
        111,
        111,
        65,
        65,
        68,
        111,
        68,
    },
    [209] = {
        97,
        97,
        155,
        35,
        198,
        32,
        32,
        32,
    },
    [21] = {
        174,
        174,
        175,
        177,
        143,
        143,
        21,
        199,
        21,
        21,
    },
    [210] = {
        155,
        78,
        155,
        155,
        97,
        78,
        78,
        155,
        78,
        78,
    },
    [211] = {

    },
    [212] = {

    },
    [213] = {
        150,
        149,
        150,
        149,
        38,
    },
    [214] = {
        151,
        197,
        197,
    },
    [215] = {

    },
    [216] = {
        132,
        132,
        79,
        79,
        79,
        79,
        78,
        78,
        132,
        167,
        167,
    },
    [217] = {
        258,
        131,
        131,
        131,
    },
    [218] = {
        21,
        21,
    },
    [219] = {
        209,
        91,
        166,
        165,
        143,
        128,
        165,
    },
    [22] = {
        143,
        143,
        36,
        143,
        129,
        129,
        129,
    },
    [220] = {
        165,
        92,
        166,
        143,
        143,
        209,
        166,
        165,
        128,
        128,
        143,
    },
    [221] = {

    },
    [222] = {
        163,
        164,
        162,
    },
    [223] = {
        24,
        24,
    },
    [224] = {
        106,
        106,
        68,
        68,
    },
    [225] = {
        235,
        41,
    },
    [226] = {
        227,
        227,
        227,
        227,
        235,
    },
    [227] = {
        58,
    },
    [228] = {
        111,
        111,
        111,
        173,
    },
    [229] = {
        111,
        111,
        111,
        111,
        111,
        111,
    },
    [23] = {
        147,
        147,
        147,
        38,
        38,
        126,
        38,
        38,
        38,
    },
    [230] = {
        111,
        111,
        111,
        111,
        111,
    },
    [231] = {
        111,
        111,
        111,
        111,
        111,
        111,
        111,
    },
    [232] = {
        38,
        38,
        38,
        38,
    },
    [233] = {

    },
    [234] = {
        235,
    },
    [235] = {
        147,
    },
    [236] = {

    },
    [237] = {

    },
    [238] = {
        24,
        24,
        24,
        36,
        36,
    },
    [239] = {
        24,
        24,
        24,
        30,
    },
    [24] = {

    },
    [240] = {
        111,
        111,
        111,
        111,
        111,
        111,
        111,
        111,
        173,
        111,
    },
    [241] = {
        111,
        111,
        111,
        111,
        111,
        111,
        111,
        111,
        111,
        111,
    },
    [242] = {

    },
    [243] = {
        120,
    },
    [244] = {
        50,
    },
    [245] = {
        50,
    },
    [246] = {

    },
    [247] = {

    },
    [248] = {

    },
    [249] = {
        24,
        24,
        24,
        24,
    },
    [25] = {
        134,
        134,
        134,
        134,
    },
    [250] = {
        227,
        227,
        227,
    },
    [251] = {
        147,
        38,
        38,
    },
    [252] = {

    },
    [253] = {
        24,
        36,
        227,
        227,
        36,
    },
    [254] = {
        24,
        24,
        24,
        36,
        36,
    },
    [255] = {
        187,
    },
    [256] = {
        187,
    },
    [257] = {
        51,
    },
    [258] = {
        31,
    },
    [259] = {
        188,
        41,
        53,
    },
    [26] = {
        19,
        142,
        142,
        142,
        142,
        19,
        138,
        138,
        28,
        138,
        267,
    },
    [260] = {
        115,
    },
    [261] = {
        22,
    },
    [262] = {
        187,
    },
    [263] = {
        59,
        109,
        109,
    },
    [264] = {
        11,
        11,
        11,
        11,
    },
    [265] = {
        233,
    },
    [266] = {
        22,
    },
    [267] = {
        6,
        282,
        282,
        282,
        282,
        4,
        21,
    },
    [268] = {
        227,
        227,
        227,
        227,
        131,
        131,
        131,
        131,
    },
    [269] = {
        91,
        92,
    },
    [27] = {
        30,
        56,
        138,
        132,
        131,
        131,
    },
    [270] = {
        40,
        40,
    },
    [271] = {
        187,
    },
    [272] = {
        187,
    },
    [273] = {
        101,
    },
    [274] = {
        40,
        187,
    },
    [275] = {

    },
    [276] = {
        114,
        40,
    },
    [277] = {
        200,
        227,
        227,
        227,
        227,
        114,
    },
    [278] = {
        114,
    },
    [279] = {

    },
    [28] = {
        83,
        83,
        83,
        83,
        83,
        83,
        281,
        227,
        227,
        227,
        227,
    },
    [280] = {
        187,
    },
    [281] = {
        41,
    },
    [282] = {
        40,
    },
    [283] = {
        235,
        235,
    },
    [284] = {
        181,
    },
    [285] = {

    },
    [286] = {
        227,
        227,
        227,
        227,
        187,
    },
    [287] = {
        187,
    },
    [288] = {
        178,
        227,
        227,
    },
    [289] = {
        26,
    },
    [29] = {

    },
    [290] = {
        49,
        49,
    },
    [291] = {
        24,
        24,
        24,
        24,
        187,
    },
    [292] = {
        187,
    },
    [293] = {
        187,
    },
    [294] = {
        227,
        227,
        227,
        227,
        235,
    },
    [295] = {
        235,
    },
    [3] = {

    },
    [30] = {
        30,
        35,
        35,
        35,
        35,
        143,
        143,
    },
    [31] = {
        153,
        153,
        21,
        209,
        153,
        153,
        153,
        153,
    },
    [32] = {
        122,
    },
    [33] = {
        109,
        228,
        111,
        111,
        109,
        109,
        109,
        111,
        111,
        109,
        109,
        109,
    },
    [34] = {
        109,
        109,
        109,
        109,
        109,
        109,
        109,
    },
    [35] = {
        151,
        151,
        151,
        151,
        151,
    },
    [36] = {
        197,
        197,
        96,
        199,
        197,
        199,
        209,
    },
    [37] = {

    },
    [38] = {
        197,
        35,
        35,
        167,
        167,
        197,
        28,
        198,
        35,
        154,
        36,
        128,
    },
    [39] = {
        24,
        24,
        24,
        24,
        91,
        134,
        134,
    },
    [4] = {
        30,
        93,
        96,
        95,
        95,
        278,
        4,
        6,
        282,
        143,
        282,
        282,
        282,
        143,
        143,
        199,
    },
    [40] = {
        154,
        129,
        129,
        129,
        138,
    },
    [41] = {
        136,
    },
    [42] = {
        30,
        147,
        38,
        38,
        38,
        38,
        38,
        38,
    },
    [43] = {
        30,
        28,
        35,
        227,
        227,
        35,
        35,
        227,
    },
    [44] = {
        200,
        227,
        227,
        227,
    },
    [45] = {

    },
    [46] = {
        153,
        153,
        153,
        153,
        153,
        153,
    },
    [47] = {

    },
    [48] = {
        193,
    },
    [49] = {
        30,
        30,
        38,
        38,
        38,
        38,
        38,
        38,
        38,
        38,
        38,
        38,
    },
    [5] = {

    },
    [50] = {
        111,
        110,
        111,
        110,
        110,
    },
    [51] = {
        84,
        84,
        84,
    },
    [52] = {
        129,
        129,
        154,
        128,
        143,
        36,
        167,
    },
    [53] = {
        30,
        33,
        35,
        138,
        167,
        143,
        167,
        128,
        198,
        36,
        167,
    },
    [54] = {
        274,
        129,
        129,
        197,
        272,
        154,
        273,
        129,
        129,
        275,
        275,
    },
    [55] = {
        33,
        167,
        143,
        143,
        167,
        128,
        167,
        36,
        198,
        35,
    },
    [56] = {
        129,
        129,
        154,
        197,
        154,
        154,
        129,
    },
    [57] = {
        24,
        265,
        139,
        228,
        19,
        138,
        38,
        138,
    },
    [58] = {
        142,
        142,
        197,
        36,
        36,
        197,
    },
    [59] = {
        138,
        35,
        138,
        36,
        138,
        36,
        138,
    },
    [6] = {
        140,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
        141,
    },
    [60] = {
        38,
        36,
        36,
    },
    [61] = {
        30,
        30,
        19,
        228,
        19,
        197,
        197,
        138,
        125,
        266,
        92,
        91,
        91,
        209,
        21,
    },
    [62] = {
        30,
        145,
        145,
        157,
        157,
        263,
        157,
        157,
        36,
        36,
        228,
        36,
        36,
    },
    [63] = {
        4,
        145,
        4,
        145,
        209,
    },
    [64] = {
        65,
        65,
        28,
        67,
        70,
        70,
    },
    [65] = {
        109,
        109,
        109,
        109,
    },
    [66] = {
        110,
        110,
        110,
        110,
        110,
        110,
    },
    [67] = {
        132,
        276,
    },
    [68] = {
        147,
        147,
        36,
        36,
        143,
        36,
        35,
        266,
        36,
    },
    [69] = {
        183,
        166,
        165,
        167,
        209,
        165,
        165,
        165,
        143,
        166,
        166,
    },
    [7] = {
        9,
    },
    [70] = {
        129,
        273,
        129,
        273,
        129,
    },
    [71] = {

    },
    [72] = {

    },
    [73] = {
        24,
        24,
        24,
        209,
        139,
        139,
        265,
        139,
        139,
        36,
        35,
        36,
        139,
    },
    [74] = {
        28,
        19,
        19,
    },
    [75] = {
        132,
        21,
        21,
        131,
        131,
        36,
        36,
        36,
    },
    [76] = {
        147,
        147,
        19,
        19,
        19,
        19,
        19,
        138,
    },
    [77] = {
        9,
    },
    [78] = {
        143,
        143,
        143,
        126,
    },
    [79] = {
        227,
        227,
        227,
    },
    [8] = {
        200,
    },
    [80] = {
        66,
        75,
        75,
    },
    [81] = {
        238,
        65,
        65,
    },
    [82] = {
        66,
        75,
        75,
    },
    [83] = {
        78,
        97,
        79,
        79,
        97,
        78,
        78,
        78,
        97,
        78,
        78,
        97,
        78,
    },
    [84] = {
        154,
        129,
        197,
        126,
        129,
        154,
        129,
        154,
    },
    [85] = {
        115,
        75,
        75,
    },
    [86] = {
        266,
        147,
        147,
        19,
        38,
        19,
        19,
        265,
        38,
        138,
        38,
        128,
        38,
    },
    [87] = {
        209,
        35,
        138,
        167,
        167,
        139,
        265,
        139,
        139,
        139,
        139,
        167,
        139,
        36,
        36,
        28,
    },
    [88] = {
        24,
        24,
        147,
        19,
        91,
        4,
        38,
        38,
        35,
    },
    [89] = {
        24,
        24,
        147,
        147,
        138,
        128,
        138,
        91,
        209,
        139,
        139,
        139,
    },
    [9] = {
        197,
        197,
        21,
    },
    [90] = {
        146,
    },
    [91] = {
        30,
        30,
        138,
        131,
        132,
        138,
        138,
        138,
        138,
    },
    [92] = {
        104,
        105,
        105,
        227,
        227,
    },
    [93] = {
        167,
        97,
        167,
        166,
        167,
        165,
        167,
        167,
        97,
        165,
        165,
        165,
        97,
    },
    [94] = {
        266,
        197,
        197,
        125,
        126,
    },
    [95] = {
        36,
        36,
        36,
    },
    [96] = {
        65,
    },
    [97] = {
        66,
        75,
        75,
    },
    [98] = {
        65,
        66,
        66,
    },
    [99] = {
        276,
        97,
    }
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

local counter = 0
Tracker.BulkUpdate = true
MANUAL_CHECKED = false
for room_id, enemy_table in pairs(DEFAULT_DUNGEON_ROOM_ENEMIES) do
    counter = 0
    for _, enemy_id in pairs(enemy_table) do
        if NAMED_INDICES[enemy_id] then
            counter = counter+1
            local code = room_id.."_"..counter
            Enemy_tracking_scope(room_id, counter, code, enemy_id)
        else
            print("skipped enemy: "..enemy_id.." in room: "..room_id)
        end
    end
end
MANUAL_CHECKED = true
Tracker.BulkUpdate = false
