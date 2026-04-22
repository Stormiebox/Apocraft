-- Item Constants
local ITEMS = {
    WELDING_MASK = "WeldingMask",
    BLOW_TORCH = "BlowTorch",
    SCRAP_METAL = "Base.ScrapMetal",
    GLASS_PANE = "GlassPane",
    SHARDS_OF_GLASS = "ShardsOfGlass",
    LIGHTER = "Base.Lighter",
    EMPTY_LIGHTER = "EmptyLighter"
}

-- Forbidden Items Set
local FORBIDDEN_ITEMS = {
    [ITEMS.WELDING_MASK] = true,
    [ITEMS.BLOW_TORCH] = true
}

-- Helper Functions
local function isItemForbiddenForRecycling(itemType)
    return FORBIDDEN_ITEMS[itemType]
end

-- Item Parameter Modifications
local function modifyItemParameters()
    local item = ScriptManager.instance:getItem(ITEMS.LIGHTER)
    if item then
        item:DoParam("ticksPerEquipUse = 250")
        item:DoParam("ReplaceOnDeplete = " .. ITEMS.EMPTY_LIGHTER)
    end
end
Events.OnGameBoot.Add(modifyItemParameters)

-- Dismantling Functions
function Recipe.OnTest.DismantleFavs(item)
    if not item then return end

    local itemType = item:getType()
    if isItemForbiddenForRecycling(itemType) or item:isBroken() then
        return true
    end

    return not (item:isFavorite() or item:isEquipped())
end

-- Recycling Functions
local function calculateWeight(items)
    local weight = 0
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item and not isItemForbiddenForRecycling(item:getType()) then
            weight = weight + item:getWeight()
        end
    end
    return weight
end

local function calculateScrapMetal(items, player, weightMultiplier, strengthXpMultiplier, minScrapRewardXP)
    local weight = calculateWeight(items)
    local scrapQuantity = math.floor(weight * 10 * weightMultiplier)

    if scrapQuantity < 1 then
        player:getXp():AddXP(Perks.Strength, minScrapRewardXP)
        return
    end

    player:getInventory():AddItems(ITEMS.SCRAP_METAL, scrapQuantity)
    player:getXp():AddXP(Perks.MetalWelding, scrapQuantity * 4)
    player:getXp():AddXP(Perks.Mechanics, scrapQuantity * 2)
    player:getXp():AddXP(Perks.Strength, scrapQuantity * strengthXpMultiplier)
end

function Recipe.OnCreate.RecycleToScrapMetal(items, result, player)
    calculateScrapMetal(items, player, 0.25, 8, 4)
end

function Recipe.OnCreate.ApocraftRecycleToScrapMetal(items, result, player)
    calculateScrapMetal(items, player, 0.5, 4, 4)
end

-- Glass Forging Functions
function Recipe.OnCreate.TryMakeGlass(items, result, player)
    local skillChance = player:getPerkLevel(Perks.MetalWelding)
    local finalChance = 1 + skillChance
    local inventory = player:getInventory()

    local addItem = ZombRand(0, 9) < finalChance and ITEMS.GLASS_PANE or ITEMS.SHARDS_OF_GLASS
    inventory:AddItems(addItem, addItem == ITEMS.GLASS_PANE and 1 or 4)
    player:getXp():AddXP(Perks.Strength, 4)
end
