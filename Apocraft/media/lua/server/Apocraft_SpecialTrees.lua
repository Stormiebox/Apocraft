-- Lumberjack_SpecialTrees.lua
-- Apocraft_SpecialTrees.lua
-- Uses Procedural Coordinate Hashing for perfectly synced, random special trees.

local Apocraft_SpecialTrees = {}

-- A procedural hash function to turn X/Y coordinates into a random 0-9999 roll
local function getProceduralHash(x, y)
    -- Using large prime numbers to scatter the results randomly
    local hash = (x * 374761393) + (y * 668265263)
    return math.abs(hash) % 10000
end

-- Checks a square to see if the tree on it is genetically special
function Apocraft_SpecialTrees.getTreeType(square)
    -- Ensure the square actually has a tree on it before doing math
    if not square or not square:getTree() then return nil end
    local x = square:getX()
    local y = square:getY()
    -- Get our roll from 0 to 9999 (10000 total outcomes, meaning 100 = 1%)
    local roll = getProceduralHash(x, y)

    -- Optional: Allow server admins to scale the chance of special trees
    local multiplier = 1.0
    if SandboxVars and SandboxVars.Apocraft and SandboxVars.Apocraft.SpecialTreeChanceMultiplier then
        multiplier = tonumber(SandboxVars.Apocraft.SpecialTreeChanceMultiplier) or 1.0
    end

    -- THE SPAWN CHANCES (Out of 10,000. 100 = 1%)
    -- SuperOak:    1.00% chance (Rolls 0 to 99)
    -- MagicPine:   0.50% chance (Rolls 100 to 149)
    -- GoldenBirch: 0.25% chance (Rolls 150 to 174)
    -- SilverCedar: 0.10% chance (Rolls 175 to 184)
    if roll < (100 * multiplier) then
        return "SuperOak"
    elseif roll < (150 * multiplier) then
        return "MagicPine"
    elseif roll < (175 * multiplier) then
        return "GoldenBirch"
    elseif roll < (185 * multiplier) then
        return "SilverCedar"
    end
    -- If the roll is 185 or higher (98.15% of the time), it's a normal tree.
    return nil
end

return Apocraft_SpecialTrees
