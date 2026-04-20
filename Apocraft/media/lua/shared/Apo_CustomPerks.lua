-- Apo_CustomPerks.lua
-- Registers custom Apocraft skills into the game engine.

-- Dynamically generate the Java Enum for the new perk and assign it to the global Perks table
Perks.Lumberjack = Perks.FromString("Lumberjack")

-- Register it into the game's Perk UI under the "Survivalist" category
PerkFactory.AddPerk(Perks.Lumberjack, "Lumberjack", "UI_Perk_Lumberjack", Perks.Survivalist)