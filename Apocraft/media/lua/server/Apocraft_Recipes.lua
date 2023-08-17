-- Initialization
Apocraft = {}
Apocraft.OnCreate = {}

-- Destroys ingredients on create
function Apocraft.OnCreate.DestroyIngredients(items, result, player)
    for i = 0, items:size() - 1 do
        player:getInventory():Remove(items:get(i))
    end
end

-- Get thread (sometimes, depending on tailoring level) and add XP
function Apocraft.OnCreate.GetThreadAndXP(items, result, player)
    if ZombRand(7) < player:getPerkLevel(Perks.Tailoring) + 1 then
        local max = ZombRand(2, 6) -- Maximum value is set to 6
        local thread = InventoryItemFactory.CreateItem("Base.Thread")

        -- Adjust the amount of thread based on the random max value
        for i = 1, 10 - max do
            thread:Use()
        end

        player:getInventory():AddItem(thread)
        player:getXp():AddXP(Perks.Tailoring, 1)
    end
end

-- Destroy ingredients and give thread depending on tailoring level
function Apocraft.OnCreate.RipTowel(items, result, player)
    Apocraft.OnCreate.DestroyIngredients(items, result, player)
    Apocraft.OnCreate.GetThreadAndXP(items, result, player)
end

-- Rip Bra's and Clothing Items
function Apocraft.OnCreate.RipBra(items, result, player)
    player:getInventory():AddItem("Base.RippedSheets")
    Apocraft.OnCreate.GetThreadAndXP(items, result, player)
end

-- Produce Sacks
function Recipe.OnTest.WholeProduce(item)
    if not instanceof(item, "Food") then return true end
    local baseHunger = math.abs(item:getBaseHunger())
    local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() then return not (baseHunger > hungerChange) end
    return not ((baseHunger * 0.75) > hungerChange)
end
