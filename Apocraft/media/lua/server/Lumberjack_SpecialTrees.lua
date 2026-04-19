-- Lumberjack_SpecialTrees.lua
-- Uses Procedural Coordinate Hashing for perfectly synced, random special trees.

local Lumberjack_SpecialTrees = {}

-- A procedural hash function to turn X/Y coordinates into a random 0-9999 roll
local function getProceduralHash(x, y)
    -- Using large prime numbers to scatter the results randomly
    local hash = (x * 374761393) + (y * 668265263)
    return math.abs(hash) % 10000
end

-- Checks a square to see if the tree on it is genetically special
function Lumberjack_SpecialTrees.getTreeType(square)
    -- Ensure the square actually has a tree on it before doing math
    if not square or not square:getTree() then return nil end
    local x = square:getX()
    local y = square:getY()
    -- Get our roll from 0 to 9999 (10000 total outcomes, meaning 100 = 1%)
    local roll = getProceduralHash(x, y)
    -- THE SPAWN CHANCES (Out of 10,000. 100 = 1%)
    -- SuperOak:    1.00% chance (Rolls 0 to 99)
    -- MagicPine:   0.50% chance (Rolls 100 to 149)
    -- GoldenBirch: 0.25% chance (Rolls 150 to 174)
    -- SilverCedar: 0.10% chance (Rolls 175 to 184)
    if roll < 100 then
        return "SuperOak"
    elseif roll < 150 then
        return "MagicPine"
    elseif roll < 175 then
        return "GoldenBirch"
    elseif roll < 185 then
        return "SilverCedar"
    end
    -- If the roll is 185 or higher (98.15% of the time), it's a normal tree.
    return nil
end

return Lumberjack_SpecialTrees
