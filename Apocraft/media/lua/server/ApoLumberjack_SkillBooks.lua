-- ApoLumberJack_SkillBooks.lua
-- This script defines the experience multipliers for the Lumberjack skill when reading related skill books.

-- Required libraries for the XP system's skill books.
require 'XpSystem/XPSystem_SkillBook'

-- Defining the Lumberjack skill and its XP multipliers when reading skill books.
SkillBook["Lumberjack"] = {}
SkillBook["Lumberjack"].perk = Perks.Lumberjack
SkillBook["Lumberjack"].maxMultiplier1 = 3
SkillBook["Lumberjack"].maxMultiplier2 = 5
SkillBook["Lumberjack"].maxMultiplier3 = 8
SkillBook["Lumberjack"].maxMultiplier4 = 12
SkillBook["Lumberjack"].maxMultiplier5 = 16
