function Manual_Storage_Cache_scope(scope_name)
    
    local Code = scope_name

    ---save function triggered on closing popotracker to have a state to restore later on. specific to custom preudo-cache LuaItems
    ---@param self LuaItem
    ---@return table
    local function SaveManualLocationStorageFunc(self)
        return {
            MANUAL_LOCATIONS = self.ItemState.MANUAL_LOCATIONS,
            MANUAL_LOCATIONS_ORDER = self.ItemState.MANUAL_LOCATIONS_ORDER,
            Name = self.Name,
            Icon = self.Icon
        }
        -- print("SaveFunc")
    end

    ---function triggered on loading the pack to restore the lat saves state. specific to custom preudo-cache LuaItems
    ---@param self LuaItem
    ---@param data table
    local function LoadManualLocationStorageFunc(self, data)
        -- print(self.Name, data.Name)
        -- print("loading data from:", data)
        -- print(Dump_table(data))
        if data ~= nil and self.Name == data.Name then
            -- print("assigning saved data for ", data.Name)
            -- print(Dump_table(data))
            self.ItemState.MANUAL_LOCATIONS = data.MANUAL_LOCATIONS
            self.ItemState.MANUAL_LOCATIONS_ORDER = data.MANUAL_LOCATIONS_ORDER
            self.Icon = ImageReference:FromPackRelativePath(data.Icon)
        else
            -- print("skipped laoding")
        end

        -- print("LoadFunc")
    end


    ---comment
    ---@param code string
    ---@return boolean
    local function CanProvideCodeFunc(self, code)
        return code == Code
    end

    ---comment
    ---@param code string
    ---@return integer
    local function ProvidesCodeFunc(self, code)
        if code == Code then
            return 1
        else
            return 0
        end
    end

    ---creates an empty pseudo cache item to store various states for up to 10 seeds to restroe when reconncing to those.
    ---mainly intended for manually marked off locations like shops or inspected locations OR for item states that have been
    ---manually set because they are hard to infer from game/server state
    ---@param name string
    ---@return LuaItem
    function CreateLuaManualStorageItem(name)
        local self = ScriptHost:CreateLuaItem()
        -- self.Type = "custom"
        self.Name = name --code --
        self.Icon = ImageReference:FromPackRelativePath("images/AP-item.png")
        self.ItemState = {
            MANUAL_LOCATIONS = {
                ["default"] = {}
            }, --[[@as table<string, string[]>]]
            MANUAL_LOCATIONS_ORDER = {}
        } --[[@as table<string, any>]]
        local Code = name
        

        local function OnLeftClickFunc() return true end
        local function OnRightClickFunc() return true end
        local function OnMiddleClickFunc() return true end
        local function PropertyChangedFunc() return true end
    
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

    return CreateLuaManualStorageItem(scope_name)
end