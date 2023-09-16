-- LumberjackTrait.lua
-- This script defines a trait that matches the Lumberjack skill perk.

local TTF = require("TraitTagFramework")

-- Function to create the Lumberjack trait
local function createLumberjackTrait()
    local LumberjackTrait = TraitFactory.addTrait(
        "LumberjackTrait",                   -- Unique identifier
        getText("UI_trait_Lumberjack"),      -- Display name
        4,                                   -- Point cost (adjust as needed)
        getText("UI_trait_Lumberjack_desc"), -- Description
        false                                -- Positive trait
    )

    -- Add relevant tags to the Lumberjack trait
    TTF.Add("LumberjackTrait", "Strong,Outdoorsman,Woodworker")

    -- Configure any other trait-related properties or effects here
    -- Add XP boost for the Lumberjack skill:
    LumberjackTrait:addXPBoost(Perks.Lumberjack, 2) -- Adjust the XP boost value as needed

    return LumberjackTrait
end

return createLumberjackTrait
