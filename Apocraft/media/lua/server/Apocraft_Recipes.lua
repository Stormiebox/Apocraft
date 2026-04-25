-- Initialization
-- Get thread (sometimes, depending on tailoring level) and add XP
local function GetThreadAndXP(player)
    if not player then
        return
    end

    if ZombRand(7) < player:getPerkLevel(Perks.Tailoring) + 1 then
        local max = ZombRand(2, 7) -- Generates 2 through 6
        local thread = InventoryItemFactory.CreateItem("Base.Thread")
        if not thread then
            return
        end

        -- Safely adjust the amount of thread remaining based on the random max value
        thread:setUsedDelta(thread:getUseDelta() * max)

        local inventory = player:getInventory()
        if inventory then
            inventory:AddItem(thread)
        end

        local xp = player:getXp()
        if xp then
            xp:AddXP(Perks.Tailoring, 1)
        end
    end
end

-- Gives thread depending on tailoring level
function Recipe.OnCreate.ApoRipClothing(items, result, player)
    GetThreadAndXP(player)
end

-- Rip Bra's and Clothing Items
function Recipe.OnCreate.ApoRipBra(items, result, player)
    if player and player:getInventory() then
        player:getInventory():AddItem("Base.RippedSheets")
    end
    GetThreadAndXP(player)
end

-- Produce Sacks
function Recipe.OnTest.WholeProduce(item)
    if not instanceof(item, "Food") then return true end
    local baseHunger = math.abs(item:getBaseHunger())
    local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() then return not (baseHunger > hungerChange) end
    return not ((baseHunger * 0.75) > hungerChange)
end

-- Safely load TraitTagFramework only if it is activated
local TTF = nil
if getActivatedMods and getActivatedMods():contains("TraitTagFramework") then
    TTF = require("TraitTagFramework")
end

-- Gives an extra plank to anyone with the "Woodworker" tag when sawing logs
function Recipe.OnCreate.SawLogsWoodworkerBonus(items, result, player, selectedItem)
    if not player then
        return
    end

    if TTF and TTF.PlayerHasTag and TTF.PlayerHasTag(player, "Woodworker") then
        -- Add an extra plank directly to their inventory
        if player:getInventory() then
            player:getInventory():AddItem("Base.Plank")
        end

        -- Pop up a little green text over their head so they know the trait worked!
        if player:isLocalPlayer() then
            player:setHaloNote(getText("IGUI_Woodworker_Bonus"), 0, 255, 0, 300)
        end
    end
end
