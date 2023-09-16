-- ApocraftQuests.lua
require 'SFQuest_Database'

-- Quest 1: Gather Wood
local gatherWoodQuest = {
    guid = "Apocraft_GatherWood",
    text = "Gather Wood",
    texture = "Item_WoodenPlank",
    title = "IGUI_QuestTitle_GatherWood",
    lore = { "IGUI_QuestLore_GatherWood" },
    needsitem = "Base.Log;10",          -- Gather 10 logs
    awardsitem = "Base.WoodenPlank;20", -- Receive 20 wooden planks as a reward
}

-- Quest 2: Craft a Weapon
local craftWeaponQuest = {
    guid = "Apocraft_CraftWeapon",
    text = "Craft a Weapon",
    texture = "Item_BaseballBat",
    title = "IGUI_QuestTitle_CraftWeapon",
    lore = { "IGUI_QuestLore_CraftWeapon" },
    needsitem = "Base.WoodenPlank;5;Base.Nails;3", -- Craft with planks and nails
    awardsitem = "Base.BaseballBat;1",             -- Receive a baseball bat as a reward
}

-- Quest 3: Mine for Resources
local mineResourcesQuest = {
    guid = "Apocraft_MineResources",
    text = "Mine for Resources",
    texture = "Item_PickAxe",
    title = "IGUI_QuestTitle_MineResources",
    lore = { "IGUI_QuestLore_MineResources" },
    needsitem = "Base.PickAxe;1",   -- Requires a pickaxe
    awardsitem = "Base.Stone;20",   -- Receive stones as rewards
    rewardsoul = "MiningSkillSoul", -- Reward the player with a MiningSkillSoul
}

-- Quest 4: Build a Shelter
local buildShelterQuest = {
    guid = "Apocraft_BuildShelter",
    text = "Build a Shelter",
    texture = "Item_Hammer",
    title = "IGUI_QuestTitle_BuildShelter",
    lore = { "IGUI_QuestLore_BuildShelter" },
    needsitem = "Base.Hammer;1;Base.Nails;30;Base.WoodenPlank;50", -- Requires hammer, nails, and planks
    awardsitem = "Base.CampfireKit;1",                             -- Receive a campfire kit as a reward
    rewardsoul = "ConstructionSkillSoul",                          -- Reward the player with a ConstructionSkillSoul
}

-- Quest 5: Forage for Food
local forageFoodQuest = {
    guid = "Apocraft_ForageFood",
    text = "Forage for Food",
    texture = "Item_Berry",
    title = "IGUI_QuestTitle_ForageFood",
    lore = { "IGUI_QuestLore_ForageFood" },
    needsitem = "Base.Berry;10",      -- Gather 10 berries
    awardsitem = "Base.Apple;5",      -- Receive apples as rewards
    rewardsoul = "ForagingSkillSoul", -- Reward the player with a ForagingSkillSoul
}

-- Quest 6: Scavenge for Supplies
local scavengeSuppliesQuest = {
    guid = "Apocraft_ScavengeSupplies",
    text = "Scavenge for Supplies",
    texture = "Item_Backpack",
    title = "IGUI_QuestTitle_ScavengeSupplies",
    lore = { "IGUI_QuestLore_ScavengeSupplies" },
    needsitem = "Base.Backpack;1",         -- Find a backpack
    awardsitem = "Base.WaterBottleFull;1", -- Receive a filled water bottle as a reward
    rewardsoul = "ScavengingSkillSoul",    -- Reward the player with a ScavengingSkillSoul
}

-- Quest 7: Hunt for Food
local huntFoodQuest = {
    guid = "Apocraft_HuntFood",
    text = "Hunt for Food",
    texture = "Item_HuntingRifle",
    title = "IGUI_QuestTitle_HuntFood",
    lore = { "IGUI_QuestLore_HuntFood" },
    needsitem = "Base.HuntingRifle;1", -- Requires a hunting rifle
    awardsitem = "Base.RawMeat;5",     -- Receive raw meat as rewards
    rewardsoul = "HuntingSkillSoul",   -- Reward the player with a HuntingSkillSoul
}

-- Quest 8: Study the Occult
local studyOccultQuest = {
    guid = "Apocraft_StudyOccult",
    text = "Study the Occult",
    texture = "Item_BookOccult",
    title = "IGUI_QuestTitle_StudyOccult",
    lore = { "IGUI_QuestLore_StudyOccult" },
    needsitem = "Base.BookOccult;1", -- Requires an occult book
    awardsitem = "Base.Spellbook;1", -- Receive a spellbook as a reward
    rewardsoul = "OccultSkillSoul",  -- Reward the player with an OccultSkillSoul
}

-- Quest 9: Craft Advanced Gear
local craftAdvancedGearQuest = {
    guid = "Apocraft_CraftAdvancedGear",
    text = "Craft Advanced Gear",
    texture = "Item_ForgeAnvil",
    title = "IGUI_QuestTitle_CraftAdvancedGear",
    lore = { "IGUI_QuestLore_CraftAdvancedGear" },
    needsitem = "Base.ForgeAnvil;1",       -- Requires a forge anvil
    awardsitem = "Base.AdvancedToolKit;1", -- Receive an advanced toolkit as a reward
    rewardsoul = "CraftingSkillSoul",      -- Reward the player with a CraftingSkillSoul
}

-- Quest 10: Survive the Apocalypse
local surviveApocalypseQuest = {
    guid = "Apocraft_SurviveApocalypse",
    text = "Survive the Apocalypse",
    texture = "Item_GasMask",
    title = "IGUI_QuestTitle_SurviveApocalypse",
    lore = { "IGUI_QuestLore_SurviveApocalypse" },
    needsitem = "Base.GasMask;1",     -- Requires a gas mask
    awardsitem = "Base.Ammo9mm;50",   -- Receive 50 rounds of 9mm ammo as a reward
    rewardsoul = "SurvivalSkillSoul", -- Reward the player with a SurvivalSkillSoul
}

-- Quest 11: Explore the Unknown
local exploreUnknownQuest = {
    guid = "Apocraft_ExploreUnknown",
    text = "Explore the Unknown",
    texture = "Item_Map",
    title = "IGUI_QuestTitle_ExploreUnknown",
    lore = { "IGUI_QuestLore_ExploreUnknown" },
    needsitem = "Base.Map;1",            -- Requires a map
    awardsitem = "Base.Compass;1",       -- Receive a compass as a reward
    rewardsoul = "ExplorationSkillSoul", -- Reward the player with an ExplorationSkillSoul
}

-- Quest 12: Survive the Hordes
local surviveHordesQuest = {
    guid = "Apocraft_SurviveHordes",
    text = "Survive the Hordes",
    texture = "Item_Zombie",
    title = "IGUI_QuestTitle_SurviveHordes",
    lore = { "IGUI_QuestLore_SurviveHordes" },
    needsitem = "Base.ZombieKills;100", -- Requires killing 100 zombies
    awardsitem = "Base.Molotov;5",      -- Receive 5 Molotov cocktails as a reward
    rewardsoul = "CombatSkillSoul",     -- Reward the player with a CombatSkillSoul
}

-- Insert your new quests into the QuestPool
table.insert(SFQuest_Database.QuestPool, gatherWoodQuest)
table.insert(SFQuest_Database.QuestPool, craftWeaponQuest)
table.insert(SFQuest_Database.QuestPool, mineResourcesQuest)
table.insert(SFQuest_Database.QuestPool, buildShelterQuest)
table.insert(SFQuest_Database.QuestPool, forageFoodQuest)
table.insert(SFQuest_Database.QuestPool, scavengeSuppliesQuest)
table.insert(SFQuest_Database.QuestPool, huntFoodQuest)
table.insert(SFQuest_Database.QuestPool, studyOccultQuest)
table.insert(SFQuest_Database.QuestPool, craftAdvancedGearQuest)
table.insert(SFQuest_Database.QuestPool, surviveApocalypseQuest)
table.insert(SFQuest_Database.QuestPool, exploreUnknownQuest)
table.insert(SFQuest_Database.QuestPool, surviveHordesQuest)
