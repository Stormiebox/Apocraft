Recipe = Recipe or {}
Recipe.OnGiveXP = Recipe.OnGiveXP or {}

-- Helper to dynamically generate repetitive single-perk XP functions
local function generateXP(perk, prefix, amounts)
    for _, amount in ipairs(amounts) do
        local funcName = prefix .. amount

        -- Create the standard Recipe.OnGiveXP function
        Recipe.OnGiveXP[funcName] = function(recipe, ingredients, result, player)
            player:getXp():AddXP(perk, amount)
        end

        -- Auto-generate the legacy global backwards compatibility (e.g. Get1TailoringXP)
        _G["Get" .. amount .. prefix .. "XP"] = Recipe.OnGiveXP[funcName]
    end
end

-- ============================================================================
-- 1. Programmatically Generate All Standard Numbered Functions
-- ============================================================================
generateXP(Perks.Tailoring, "Tailoring", { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 })
generateXP(Perks.Doctor, "Doctor", { 1, 2, 4, 6, 8, 11 })
generateXP(Perks.Farming, "Farming", { 1, 2, 4, 6, 8, 11 })
generateXP(Perks.MetalWelding, "MetalWelding", { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 20 })
generateXP(Perks.Mechanics, "Mechanics", { 1, 2, 4, 5, 6, 8, 10, 11 })
generateXP(Perks.Electricity, "Electricity", { 1, 2, 3, 5, 10 })
generateXP(Perks.Woodwork, "WoodWork", { 1, 2, 5, 10 })
generateXP(Perks.Cooking, "Cooking", { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 })

-- ============================================================================
-- 2. Preserve Backwards Compatibility for Old Typos & Unnumbered Aliases
-- ============================================================================
-- "Machanics" was misspelled in the old file and passed a nil perk. We map it correctly here!
local brokenMachanics = { 1, 2, 4, 6, 8, 11 }
for _, v in ipairs(brokenMachanics) do
    Recipe.OnGiveXP["Machanics" .. v] = Recipe.OnGiveXP["Mechanics" .. v]
    _G["Get" .. v .. "MachanicsXP"] = Recipe.OnGiveXP["Mechanics" .. v]
end

-- Fix older typos and mapping variations so recipe files don't break
Recipe.OnGiveXP.WoodWorkg5          = Recipe.OnGiveXP.WoodWork5
Recipe.OnGiveXP.Give5WoodworkXP     = Recipe.OnGiveXP.WoodWork5
Recipe.OnGiveXP.Tailoring           = Recipe.OnGiveXP.Tailoring1
Recipe.OnGiveXP.Mechanics           = Recipe.OnGiveXP.Mechanics1
Recipe.OnGiveXP.Electricity         = Recipe.OnGiveXP.Electricity1
Recipe.OnGiveXP.MetalWelding        = Recipe.OnGiveXP.MetalWelding1
Recipe.OnGiveXP.WoodWork            = Recipe.OnGiveXP.WoodWork1
Recipe.OnGiveXP.Tailoring01         = Recipe.OnGiveXP.Tailoring1
Recipe.OnGiveXP.Electricity03       = Recipe.OnGiveXP.Electricity3
Recipe.OnGiveXP.Get1FarmingXP       = Recipe.OnGiveXP.Farming1
Recipe.OnGiveXP.Get10MetalWeldingXP = Recipe.OnGiveXP.MetalWelding10
Recipe.OnGiveXP.Get20MetalWeldingXP = Recipe.OnGiveXP.MetalWelding20

-- ============================================================================
-- 3. Complex specific functions (Multiple Perks at Once)
-- ============================================================================
function Recipe.OnGiveXP.MetalWelding01(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 1)
    player:getXp():AddXP(Perks.Strength, 4)
end

function Recipe.OnGiveXP.MetalWelding03(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 3)
    player:getXp():AddXP(Perks.Strength, 8)
end

function Recipe.OnGiveXP.MetalWelding05(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 5)
    player:getXp():AddXP(Perks.Strength, 12)
end

function Recipe.OnGiveXP.MechWeld05(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, 3)
    player:getXp():AddXP(Perks.MetalWelding, 5)
end
