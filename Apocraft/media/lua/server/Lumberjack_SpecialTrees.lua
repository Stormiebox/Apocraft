-- Lumberjack_SpecialTrees.lua
-- This script handles special trees logic with the Lumberjack skill.

local Lumberjack_SpecialTrees = {}

-- Table that keeps track of special tree cells.
Lumberjack_SpecialTrees.specialCells = {
    SuperOak = { worldX = 12, worldY = 27 },
    MagicPine = { worldX = 31, worldY = 50 },
    GoldenBirch = { worldX = 41, worldY = 60 },
    SilverCedar = { worldX = 53, worldY = 72 },
    -- ... add more cells if needed
}

-- Checks if a given square's cell is special.
function Lumberjack_SpecialTrees.isSpecialCell(square)
    for treeType, cell in pairs(Lumberjack_SpecialTrees.specialCells) do
        if square:getCell():getWorldX() == cell.worldX and square:getCell():getWorldY() == cell.worldY then
            return treeType
        end
    end
    return nil
end

-- Function to get the special tree cells
function Lumberjack_SpecialTrees.getSpecialTreeCells()
    return Lumberjack_SpecialTrees.specialCells
end

return Lumberjack_SpecialTrees
