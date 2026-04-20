-- LumberjackTrait.lua
-- This script defines a trait that matches the Lumberjack skill perk.

-- Function to create the Lumberjack trait
local function createLumberjackTrait()
    local LumberjackTrait = TraitFactory.addTrait(
        "LumberjackTrait",                   -- Unique identifier
        getText("UI_trait_Lumberjack"),      -- Display name
        5,                                   -- Point cost (adjust as needed)
        getText("UI_trait_Lumberjack_desc"), -- Description
        false                                -- Positive trait
    )

    -- Re-use the vanilla "Axe Man" trait icon to avoid a missing texture
    local axeIcon = Texture.getSharedTexture("media/ui/Traits/trait_axeman.png")
    if axeIcon then
        LumberjackTrait:setTexture(axeIcon)
    end

    -- Safely add relevant tags to the Lumberjack trait if TTF is installed
    if getActivatedMods():contains("TraitTagFramework") then
        local TTF = require("TraitTagFramework")
        TTF.Add("LumberjackTrait", "Strong,Outdoorsman,Woodworker")
    end

    -- Configure any other trait-related properties or effects here
    -- Add XP boost for the Lumberjack skill:
    LumberjackTrait:addXPBoost(Perks.Lumberjack, 2)

    -- Give related vanilla perk boosts (fits the "Strong" and "Woodworker" TTF tags)
    LumberjackTrait:addXPBoost(Perks.Axe, 2)
    LumberjackTrait:addXPBoost(Perks.Strength, 1)

    -- Grant free custom recipes so the Lumberjack doesn't need to read the basic magazines
    LumberjackTrait:getFreeRecipes():add("Saw Logs (x5 Planks)")
    LumberjackTrait:getFreeRecipes():add("Saw Logs (x7 Planks)")

    -- Balance the trait by making it mutually exclusive with physically weak traits
    TraitFactory.setMutuallyExclusive("LumberjackTrait", "Feeble")
    TraitFactory.setMutuallyExclusive("LumberjackTrait", "Weak")
    TraitFactory.setMutuallyExclusive("LumberjackTrait", "Unfit")
    TraitFactory.setMutuallyExclusive("LumberjackTrait", "Out of Shape")
end

Events.OnGameBoot.Add(createLumberjackTrait)
