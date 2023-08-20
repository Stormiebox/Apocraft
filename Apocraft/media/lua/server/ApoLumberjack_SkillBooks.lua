-- ApoLumberJack_SkillBooks.lua
-- This script is part of the Apocraft mod, which introduces a new Lumberjack skill.
-- This specific script is responsible for defining the experience multipliers for the Lumberjack skill
-- when players read related skill books in the game.

-- Required libraries for the XP system's skill books.
-- This library helps in associating books with specific perks to grant experience bonuses.
require 'XpSystem/XPSystem_SkillBook'

-- Ensure the Lumberjack entry exists in the SkillBook table.
-- This step is crucial to avoid null reference errors when accessing or modifying the Lumberjack entry.
SkillBook["Lumberjack"] = SkillBook["Lumberjack"] or {}

-- Utility function to safely assign a default value to a table's key.
-- The purpose of this function is to avoid potential crashes or undefined behaviors
-- in case the expected fields in the SkillBook table are not set.
-- @param table: The table where the assignment should take place.
-- @param key: The specific key in the table that we want to check and/or set.
-- @param defaultValue: The default value that will be assigned to the key if it is not already set.
local function safeAssign(table, key, defaultValue)
    if table[key] == nil then
        table[key] = defaultValue
    end
end

-- Assign default values to the Lumberjack entry in the SkillBook table.
-- Here we define the specific multipliers for the Lumberjack skill based on different skill books.
-- If for any reason these values are missing, the safeAssign function will set them to default values.
safeAssign(SkillBook["Lumberjack"], "perk", Perks.Lumberjack)
safeAssign(SkillBook["Lumberjack"], "maxMultiplier1", 3)
safeAssign(SkillBook["Lumberjack"], "maxMultiplier2", 5)
safeAssign(SkillBook["Lumberjack"], "maxMultiplier3", 8)
safeAssign(SkillBook["Lumberjack"], "maxMultiplier4", 12)
safeAssign(SkillBook["Lumberjack"], "maxMultiplier5", 16)
