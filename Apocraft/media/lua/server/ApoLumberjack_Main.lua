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

--- Calculate bonus planks based on the Lumberjack skill and player strength.
function Apocraft.calculateBonusPlanks(player)
    -- Everyone "has" the perk, they just have different levels. No need for HasTrait assert here.
    local loggingSkill = player:getPerkLevel(Perks.Lumberjack) or 0
    local strengthSkill = player:getPerkLevel(Perks.Strength) or 0

    local bonus = math.floor(loggingSkill / 2) + math.floor(strengthSkill / 4)
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

        local square = nil
        local tree = nil

        local wepLength = loggingOnWeapon.grabLengthOf(weapon) + 0.5
        local ownerForwardDir = owner:getForwardDirection()
        local ownerX, ownerY = owner:getX(), owner:getY()
        local attackX, attackY = ownerForwardDir:getX(), ownerForwardDir:getY()

        -- Raycast to find the exact tree the player is hitting
        for i = 1, 10 do
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
                    break -- We found the tree, no need to keep raycasting
                end
            end
        end

        -- We only want to drop logs if we ACTUALLY hit a tree!
        if tree then
            local loggingLevel = owner:getPerkLevel(Perks.Lumberjack)
            local strengthLevel = owner:getPerkLevel(Perks.Strength)

            -- 1. Calculate the standard base logs (Includes the Lumberjack/Strength bonuses)
            local baseLogs = math.min(loggingLevel + math.floor(strengthLevel / 2), 10)
            if baseLogs < 1 then baseLogs = 1 end

            -- 2. Check for Procedural Special Trees and determine their flat bonus
            local specialTreeType = Lumberjack_SpecialTrees.getTreeType(square)
            local specialBonus = 0

            if specialTreeType == "SuperOak" then
                specialBonus = 12 -- Massive jackpot
                if owner:isLocalPlayer() then
                    owner:setHaloNote(getText("IGUI_Found_SuperOak"), 0, 255, 0, 300)
                end
            elseif specialTreeType == "MagicPine" then
                specialBonus = 8
                if owner:isLocalPlayer() then
                    owner:setHaloNote(getText("IGUI_Found_MagicPine"), 0, 255, 255, 300)
                end
            elseif specialTreeType == "GoldenBirch" then
                specialBonus = 5
                if owner:isLocalPlayer() then
                    owner:setHaloNote(getText("IGUI_Found_GoldenBirch"), 255, 215, 0, 300)
                end
            elseif specialTreeType == "SilverCedar" then
                specialBonus = 3
                if owner:isLocalPlayer() then
                    owner:setHaloNote(getText("IGUI_Found_SilverCedar"), 200, 200, 200, 300)
                end
            end

            -- 3. Combine them and spawn only vanilla Base.Logs
            local totalLogs = baseLogs + specialBonus

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
