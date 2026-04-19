require 'SFQuest_Database'

-- Define a function to create a skill milestone quest
local function createSkillMilestoneQuest(skillName, requiredLevel, questText, experienceReward, itemReward)
    local quest = {}

    -- Generate a unique GUID for the quest (you can use a proper GUID generation function)
    quest.guid = "SkillMilestoneQuest_" .. skillName .. "_" .. requiredLevel
    quest.text = questText

    -- Define the quest objective
    quest.objectives = {
        {
            type = "skilllevel",
            skill = skillName,
            level = requiredLevel,
            description = "Reach " .. skillName .. " Level " .. requiredLevel
        }
    }

    -- Define the quest rewards
    quest.rewards = {
        experience = experienceReward,
        items = { itemReward } -- You can add more items to the list if needed
    }

    -- Insert the quest into the quest pool
    table.insert(SFQuest_Database.QuestPool, quest)
end

-- Create skill milestone quests
createSkillMilestoneQuest("Carpentry", 4, "Master Carpenter Quest", 500, "CarpentryBlueprint")
createSkillMilestoneQuest("Metalworking", 3, "Master Blacksmith Quest", 600, "BlacksmithHammer")
createSkillMilestoneQuest("Lumberjack", 5, "Legendary Lumberjack Quest", 700, "LumberjackAxe")
