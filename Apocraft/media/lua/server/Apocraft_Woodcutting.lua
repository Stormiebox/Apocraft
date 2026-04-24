-- ApoLumberJack_Main.lua
-- Apocraft_Woodcutting.lua
-- This script contains the main logic for woodcutting in the Apocraft mod.

-- Import the SpecialTrees module for special tree handling.
local Apocraft_SpecialTrees = require "Apocraft_SpecialTrees"

-- Initialize the loggingOnWeapon table to store weapon-related functions.
local loggingOnWeapon = {}

-- Initialize or use the existing Apocraft table to store main mod logic.
local Apocraft = Apocraft or {}

-- This table stores weapon lengths, as there's no getter function for this in the game API.
loggingOnWeapon.lengths = {}

--- Handle the conversion of logs in the player's inventory to planks.
function Apocraft.handleLogs(player)
    local logItem = player:getInventory():FindAndReturn("Base.Log")
    if logItem then
        local totalPlanks = 5
        player:getInventory():AddItems("Base.Plank", totalPlanks)
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
            local strengthLevel = owner:getPerkLevel(Perks.Strength) or 0

            local totalLogs = 0
            
            -- 1. Strength-based chance to drop an extra log per hit
            -- Strength 10 gives a 15% chance per hit to yield 1 extra log
            local dropChance = strengthLevel * 1.5
            if ZombRandFloat(0, 100) < dropChance then
                totalLogs = totalLogs + 1
            end

            -- 2. Check for Procedural Special Trees and gradually extract their jackpot
            local modData = tree:getModData()
            if modData.apoSpecialBonus == nil then
                local specialTreeType = Apocraft_SpecialTrees.getTreeType(square)
                if specialTreeType == "SuperOak" then
                    modData.apoSpecialBonus = 8; modData.apoTreeType = "SuperOak"
                elseif specialTreeType == "MagicPine" then
                    modData.apoSpecialBonus = 5; modData.apoTreeType = "MagicPine"
                elseif specialTreeType == "GoldenBirch" then
                    modData.apoSpecialBonus = 3; modData.apoTreeType = "GoldenBirch"
                elseif specialTreeType == "SilverCedar" then
                    modData.apoSpecialBonus = 2; modData.apoTreeType = "SilverCedar"
                else
                    modData.apoSpecialBonus = 0
                end
            end

            if modData.apoSpecialBonus > 0 then
                -- 30% chance per hit to dislodge one of the tree's special bonus logs
                if ZombRand(100) < 30 then
                    modData.apoSpecialBonus = modData.apoSpecialBonus - 1
                    totalLogs = totalLogs + 1
                    
                    -- Notify player on the first bonus log dropped
                    if not modData.apoNotified and owner:isLocalPlayer() then
                        modData.apoNotified = true
                        local tType = modData.apoTreeType
                        if tType == "SuperOak" then
                            owner:setHaloNote(getText("IGUI_Found_SuperOak"), 0, 255, 0, 300)
                        elseif tType == "MagicPine" then
                            owner:setHaloNote(getText("IGUI_Found_MagicPine"), 0, 255, 255, 300)
                        elseif tType == "GoldenBirch" then
                            owner:setHaloNote(getText("IGUI_Found_GoldenBirch"), 255, 215, 0, 300)
                        elseif tType == "SilverCedar" then
                            owner:setHaloNote(getText("IGUI_Found_SilverCedar"), 200, 200, 200, 300)
                        end
                    end
                end
            end

            -- 3. Spawn the logs
            if totalLogs > 0 then
                for i = 1, totalLogs do
                    square:AddWorldInventoryItem("Base.Log", ZombRandFloat(0.1, 0.9), ZombRandFloat(0.1, 0.9), 0)
                end
            end
        end
    end
end

--- This function can be used in a recipe's OnCreate callback to convert logs to planks.
function OnCreateChopLogs(items, result, player)
    Apocraft.handleLogs(player)
end

-- Return the loggingOnWeapon module.
return loggingOnWeapon
