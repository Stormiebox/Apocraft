-- ApoLumberJack_Main.lua
-- This script contains the main logic for the Lumberjack skill in the Apocraft mod.

-- Initialize the loggingOnWeapon table.
local loggingOnWeapon = {}

-- Initialize or use the existing Apocraft table.
Apocraft = Apocraft or {}

-- This table stores weapon lengths, as there's no getter function for this in the game API.
loggingOnWeapon.lengths = {}

--- Calculate bonus planks based on the Lumberjack skill and player strength.
function Apocraft.calculateBonusPlanks(player)
    local loggingSkill = player:getPerkLevel(Perks.Lumberjack)
    local strengthSkill = player:getPerkLevel(Perks.Strength)
    local bonus = math.floor(loggingSkill / 2) + math.floor(strengthSkill / 3)
    return bonus
end

--- Handle the conversion of logs in the player's inventory to planks.
function Apocraft.handleLogs(player)
    local logItem = player:getInventory():FindAndReturn("Base.Log")
    if logItem then
        local totalPlanks = 5 + Apocraft.calculateBonusPlanks(player)
        for i = 1, totalPlanks do
            player:getInventory():AddItem("Base.Plank")
        end
    end
end

--- Get the length of the weapon. If it's not stored, compute and store it.
function loggingOnWeapon.grabLengthOf(weapon)
    local moduleDotType = weapon:getFullType()
    local storedLength = loggingOnWeapon.lengths[moduleDotType]
    if storedLength then return storedLength end

    local numClassFields = getNumClassFields(weapon)
    for i = 0, numClassFields - 1 do
        local javaField = getClassField(weapon, i)
        if javaField then
            if tostring(javaField) == "public float zombie.inventory.types.HandWeapon.WeaponLength" then
                local value = getClassFieldVal(weapon, javaField)
                loggingOnWeapon.lengths[moduleDotType] = value
                return value
            end
        end
    end
end

--- Handle the weapon hit action, checking if the weapon is an axe and applying Lumberjack logic.
function loggingOnWeapon.hit(owner, weapon)
    if weapon:getScriptItem():getCategories():contains("Axe") then
        owner:getXp():AddXP(Perks.Lumberjack, 2.5)
        local square, tree = owner:getSquare()
        local wepLength = loggingOnWeapon.grabLengthOf(weapon) + 0.5
        local ownerForwardDir = owner:getForwardDirection()
        local ownerX, ownerY = owner:getX(), owner:getY()
        local attackX, attackY = ownerForwardDir:getX(), ownerForwardDir:getY()

        for i = 1, 10, 1 do
            local iDiv = i / 10
            local attackSquare = getSquare(ownerX + attackX * wepLength * iDiv, ownerY + attackY * wepLength * iDiv,
                owner:getZ())
            if attackSquare then
                square = attackSquare
                tree = square:getTree()
                if tree then
                    local treeSquare = tree:getSquare()
                    if treeSquare then
                        square = treeSquare
                    end
                end
            end
        end

        if not tree then
            local loggingLevel = owner:getPerkLevel(Perks.Lumberjack)
            local strengthLevel = owner:getPerkLevel(Perks.Strength)
            local totalLogs = math.min(loggingLevel + strengthLevel, 10)
            for i = 1, totalLogs do
                square:AddWorldInventoryItem("Base.Log", 0, 0, 0)
            end

            Apocraft.handleLogs(owner)
        end
    end
end

--- This function can be used in a recipe's OnCreate callback to convert logs to planks.
function OnCreateChopLogs(items, result, player)
    Apocraft.handleLogs(player)
end

return loggingOnWeapon
