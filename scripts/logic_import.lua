require("scripts.logic.location_definition_light")
require("scripts.logic.location_definition_dark")
require("scripts.logic.location_definition_dungeons")
require("scripts.logic.location_definition_teleporters")
require("scripts/logic/graphs/HC")
require("scripts/logic/graphs/AT")
require("scripts/logic/graphs/EP")
require("scripts/logic/graphs/DP")
require("scripts/logic/graphs/ToH")
require("scripts/logic/graphs/PoD")
require("scripts/logic/graphs/SP")
require("scripts/logic/graphs/SW")
require("scripts/logic/graphs/TT")
require("scripts/logic/graphs/MM")
require("scripts/logic/graphs/IP")
require("scripts/logic/graphs/TR")
require("scripts/logic/graphs/GT")
require("scripts/logic/graphs/darkworld")
require("scripts/logic/graphs/lightworld")


for _, location in pairs(NAMED_LOCATIONS) do
    if location.baseWorldstate == "light" then
        location:connect_one_way(Light_flute_map, function()
            return ALL(
                "flute",
                Light_activate_flute:accessibility() > 5,
                OpenOrStandard
            )
        end)
    elseif location.baseWorldstate == "dark" then
        location:connect_one_way(Light_flute_map, function()
            return ALL(
                "flute",
                Inverted_activate_flute:accessibility() > 5,
                Inverted
            )
        end)
    end
end