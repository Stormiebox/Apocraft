-- ApoLumberJack_Main.lua
-- This script contains the main logic for the Lumberjack skill in the Apocraft mod.

-- Import the Lumberjack_SpecialTrees module for special tree handling.
local Lumberjack_SpecialTrees = require "Lumberjack_SpecialTrees"

-- Initialize the loggingOnWeapon table to store weapon-related functions.
local loggingOnWeapon = {}

-- Initialize or use the existing Apocraft table to store main mod logic.
local Apocraft = Apocraft or {}

-- This table stores weapon lengths, as there's no getter function for this in the game API.
loggingOnWeapon.lengths = {}

-- Store the locations of special trees in cells.
local specialTreeCells = Lumberjack_SpecialTrees.getSpecialTreeCells()

--- Calculate bonus planks based on the Lumberjack skill and player strength.
--- @param player -Player object to calculate the bonus for.
--- @return number -The calculated bonus planks.
function Apocraft.calculateBonusPlanks(player)
    -- Validate the player object and the possession of required perks
    assert(player, "Player object cannot be null")
    assert(player:HasTrait(Perks.Lumberjack) and player:HasTrait(Perks.Strength),
        "Player must have perks: Lumberjack and Strength")
    local loggingSkill = player:getPerkLevel(Perks.Lumberjack)
    local strengthSkill = player:getPerkLevel(Perks.Strength)
    local bonus = math.floor(loggingSkill / 2) + math.floor(strengthSkill / 3)
    return bonus
end

--- Display a halo message to the player to notify them of the special tree.
local function displaySpecialTreeMessage(player, treeType)
    player:setHaloNote("You've hit a " .. treeType .. " tree!")
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
        local cellX, cellY = square:getCellX(), square:getCellY()

        if specialTreeCells[cellX] and specialTreeCells[cellX][cellY] then
            displaySpecialTreeMessage(owner, specialTreeCells[cellX][cellY].treeType)
        end

        local wepLength = loggingOnWeapon.grabLengthOf(weapon) + 0.5
        local ownerForwardDir = owner:getForwardDirection()
        local ownerX, ownerY = owner:getX(), owner:getY()
        local attackX, attackY = ownerForwardDir:getX(), ownerForwardDir:getY()

        for i = 1, 10 do -- Removed the unnecessary third argument for incrementing by 1.
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

-- Return the loggingOnWeapon module.
return loggingOnWeapon
