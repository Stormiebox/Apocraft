--Using own function for this
Apocraft = {}
Apocraft.OnCreate = {}

--Destroys ingredients on create
function Apocraft.OnCreate.DestroyIngredients(items, result, player)
    for i = 0, items:size() - 1 do
        player:getInventory():Remove(items:get(i))
    end
end

--Get thread sometimes, depending on tailoring level
function Apocraft.OnCreate.GetThread(items, result, player)
    if ZombRand(7) < player:getPerkLevel(Perks.Tailoring) + 1 then
        local max = 2;
        if nbrOfCoveredParts then
            max = nbrOfCoveredParts;
            if max > 6 then
                max = 6;
            end
        end
        max = ZombRand(2, max);
        local thread = InventoryItemFactory.CreateItem("Base.Thread");
        for i = 1, 10 - max do
            thread:Use();
        end
        player:getInventory():AddItem(thread);
    end
end

--Code copied from TimedActions/ISRipClothing.lua
function ApocraftRipClothing(items, result, player, selectedItem)
    --Either we come from clothingrecipesdefinitions or we simply check number of covered parts by the clothing and add
    local nbrOfCoveredParts = nil

    --Add thread sometimes, depending on tailoring level
    if ZombRand(7) < player:getPerkLevel(Perks.Tailoring) + 1 then
        local max = 2;
        if nbrOfCoveredParts then
            max = nbrOfCoveredParts;
            if max > 6 then
                max = 6;
            end
        end
        max = ZombRand(2, max);
        local thread = InventoryItemFactory.CreateItem("Base.Thread");
        for i = 1, 9 do
            thread:Use();
        end
        player:getInventory():AddItem(thread);
        player:getXp():AddXP(Perks.Tailoring, 1);
    end
end

--Destroy ingredients and give thread depending on tailoring level
function Apocraft.OnCreate.RipTowel(items, result, player)
    Apocraft.OnCreate.DestroyIngredients(items, result, player)
    Apocraft.OnCreate.GetThread(items, result, player)
end

--Rip Bra's and Clothing Items
function ApocraftRipBra(items, result, player)
    --local wire = InventoryItemFactory.CreateItem("Base.Wire");
    -- for i=1, 9 do
    -- wire:Use();
    -- end
    --wire:Use();

    player:getInventory():AddItem("Base.RippedSheets");

    --Add thread based on tailoring level
    ApocraftRipClothing(items, result, player, nil);
end

--Produce Sacks
function Recipe.OnTest.WholeProduce(item)
    if not instanceof(item, "Food") then return true end
    local baseHunger = math.abs(item:getBaseHunger())
    local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() then return not (baseHunger > hungerChange) end
    return not ((baseHunger * 0.75) > hungerChange)
end
