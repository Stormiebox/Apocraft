-- On player load, check profession and grant expected free recipes.
local function addRecipesToExistingPlayers(playerIndex, playerObj)
    if not playerObj or not playerObj.getDescriptor then
        return
    end

    local descriptor = playerObj:getDescriptor()
    if not descriptor then
        return
    end

    local profession = descriptor:getProfession()

    -- Adjustments to acquire Spare Engine Parts recipes instantly.
    if profession == "repairman" then
        playerObj:learnRecipe("Create 5 Spare Engine Parts")
        playerObj:learnRecipe("Create 10 Spare Engine Parts")
        playerObj:learnRecipe("Create 15 Spare Engine Parts")
        playerObj:learnRecipe("Create 20 Spare Engine Parts")
        playerObj:learnRecipe("Create 25 Spare Engine Parts")
        playerObj:learnRecipe("Create 30 Spare Engine Parts")
        playerObj:learnRecipe("Create 35 Spare Engine Parts")
        playerObj:learnRecipe("Create 40 Spare Engine Parts")
        playerObj:learnRecipe("Create 45 Spare Engine Parts")
        playerObj:learnRecipe("Create 50 Spare Engine Parts")
    end
end

-- Event for when a character loads into the world.
Events.OnCreatePlayer.Add(addRecipesToExistingPlayers)
