-- Lumberjack_SpecialTrees.lua
-- This script handles special trees logic with the Lumberjack skill.

require "!_TargetSquare_OnLoad.lua" -- Include the external API

local Lumberjack_SpecialTrees = {}

-- Function to check if a given square's cell is special.
function Lumberjack_SpecialTrees.isSpecialCell(square)
    local cell = square:getCell()
    local worldX = cell:getWorldX()
    local worldY = cell:getWorldY()

    for treeType, cellData in pairs(Lumberjack_SpecialTrees.specialCells) do
        if cellData.worldX == worldX and cellData.worldY == worldY then
            return treeType
        end
    end

    return nil
end

-- Function to get the special tree cells
function Lumberjack_SpecialTrees.getSpecialTreeCells()
    return Lumberjack_SpecialTrees.specialCells
end

-- Table that keeps track of special tree cells.
Lumberjack_SpecialTrees.specialCells = {
    SuperOak = { worldX = 12, worldY = 27 },
    MagicPine = { worldX = 31, worldY = 50 },
    GoldenBirch = { worldX = 41, worldY = 60 },
    SilverCedar = { worldX = 53, worldY = 72 },
    -- ... add more cells if needed
}

return Lumberjack_SpecialTrees
