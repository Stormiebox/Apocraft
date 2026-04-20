-- Constants
local Recipe = Recipe
local SCRAP_METAL = "Base.ScrapMetal"

local accessoryTypes = {
    "Bracelet_BangleLeftGold", "Bracelet_BangleRightGold", "Bracelet_ChainLeftGold", "Bracelet_ChainRightGold",
    "Bracelet_BangleLeftSilver", "Bracelet_BangleRightSilver", "Bracelet_ChainLeftSilver", "Bracelet_ChainRightSilver",
    "BellyButton_DangleGold", "BellyButton_DangleGoldRuby", "BellyButton_DangleSilver", "BellyButton_DangleSilverDiamond",
    "BellyButton_RingGold", "BellyButton_RingGoldDiamond", "BellyButton_RingGoldRuby", "BellyButton_RingSilver",
    "BellyButton_RingSilverAmethyst", "BellyButton_RingSilverDiamond", "BellyButton_RingSilverRuby",
    "BellyButton_StudGold", "BellyButton_StudGoldDiamond", "BellyButton_StudSilver", "BellyButton_StudSilverDiamond",
    "Earring_Dangly_Diamond", "Earring_Dangly_Emerald", "Earring_Dangly_Pearl", "Earring_Dangly_Ruby",
    "Earring_Dangly_Sapphire",
    "Earring_LoopLrg_Gold", "Earring_LoopLrg_Silver", "Earring_LoopMed_Gold", "Earring_LoopMed_Silver",
    "Earring_LoopSml_Gold",
    "Earring_LoopSml_Silver", "Earring_Stud_Diamond", "Earring_Stud_Emerald", "Earring_Stud_Gold", "Earring_Stud_Pearl",
    "Earring_Stud_Ruby", "Earring_Stud_Sapphire", "Earring_Stud_Silver",
    "Necklace_Crucifix", "Necklace_Diamond", "Necklace_Emerald", "Necklace_Gold", "Necklace_GoldDiamond",
    "Necklace_GoldRuby", "Necklace_Pearl", "Necklace_Ruby", "Necklace_Sapphire", "Necklace_Silver",
    "Necklace_SilverDiamond", "Necklace_SilverSapphire", "Necklace_YinYang",
    "Ring_Left_MiddleFinger_Gold", "Ring_Left_MiddleFinger_Silver", "Ring_Left_RingFinger_Gold",
    "Ring_Left_RingFinger_GoldDiamond",
    "Ring_Left_RingFinger_GoldRuby", "Ring_Left_RingFinger_Silver", "Ring_Left_RingFinger_SilverDiamond",
    "Ring_Right_MiddleFinger_Gold", "Ring_Right_MiddleFinger_Silver", "Ring_Right_RingFinger_Gold",
    "Ring_Right_RingFinger_GoldDiamond",
    "Ring_Right_RingFinger_GoldRuby", "Ring_Right_RingFinger_Silver", "Ring_Right_RingFinger_SilverDiamond"
}

local watchTypes = {
    "WristWatch_Left_ClassicBlack", "WristWatch_Left_ClassicBrown", "WristWatch_Left_ClassicGold",
    "WristWatch_Left_ClassicMilitary", "WristWatch_Left_ClassicSilver", "WristWatch_Left_DigitalBlack",
    "WristWatch_Left_DigitalDress", "WristWatch_Left_DigitalRed", "WristWatch_Right_ClassicBlack",
    "WristWatch_Right_ClassicBrown", "WristWatch_Right_ClassicGold", "WristWatch_Right_ClassicSilver",
    "WristWatch_Right_DigitalBlack", "WristWatch_Right_DigitalDress", "WristWatch_Right_DigitalRed",
    "WristWatch_Right_ClassicMilitary",
}

-- Create high-performance lookup sets for OnCanPerform checks
local accessoryTypesSet = {}
for _, t in ipairs(accessoryTypes) do accessoryTypesSet[t] = true end

local watchTypesSet = {}
for _, t in ipairs(watchTypes) do watchTypesSet[t] = true end

-- Helper Functions
local function getCraftableItemsFromTypes(inventory, typesSet, maxCount)
    local result = {}
    local count = 0
    maxCount = maxCount or 0

    local items = inventory:getItems()
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item and typesSet[item:getType()] and not item:isFavorite() and not item:isEquipped() then
            table.insert(result, item)
            count = count + 1
            if maxCount > 0 and count >= maxCount then
                return result
            end
        end
    end
    return result
end

local function removeInventoryItems(items)
    for _, item in ipairs(items) do
        local container = item:getContainer()
        if container then container:Remove(item) end
    end
end

local function convertItemsToScrap(inventory, typesSet)
    local craftableItems = getCraftableItemsFromTypes(inventory, typesSet, 3)
    if #craftableItems == 3 then
        removeInventoryItems(craftableItems)
        inventory:AddItem(SCRAP_METAL)
        return true
    end
    return false
end

-- Recipe Functions
function Recipe.OnCanPerform.AnyAccessory3(recipe, player, selectedItem)
    local craftableItems = getCraftableItemsFromTypes(player:getInventory(), accessoryTypesSet, 3)
    return #craftableItems == 3
end

function Recipe.OnCanPerform.AnyWristWatch3(recipe, player, selectedItem)
    local craftableItems = getCraftableItemsFromTypes(player:getInventory(), watchTypesSet, 3)
    return #craftableItems == 3
end

function Recipe.OnCreate.ScrapMetalFromAnyAccessory3(items, result, player, selectedItem)
    return convertItemsToScrap(player:getInventory(), accessoryTypesSet)
end

function Recipe.OnCreate.ScrapMetalFromAnyWristWatch3(items, result, player, selectedItem)
    return convertItemsToScrap(player:getInventory(), watchTypesSet)
end
