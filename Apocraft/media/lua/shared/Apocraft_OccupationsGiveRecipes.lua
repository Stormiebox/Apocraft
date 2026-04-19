-- On Player Load, check their professions and if it's one we're expecting, add some free recipes to their character.
function AddRecipesToExistingPlayers(id, player)
    local profession = player:getDescriptor():getProfession();

    -- Adjustments to acquire Spare Engine Parts recipes instantly.
    if profession == "repairman" then
        player:learnRecipe("Create 5 Spare Engine Parts");
        player:learnRecipe("Create 10 Spare Engine Parts");
        player:learnRecipe("Create 15 Spare Engine Parts");
        player:learnRecipe("Create 20 Spare Engine Parts");
        player:learnRecipe("Create 25 Spare Engine Parts");
        player:learnRecipe("Create 30 Spare Engine Parts");
        player:learnRecipe("Create 35 Spare Engine Parts");
        player:learnRecipe("Create 40 Spare Engine Parts");
        player:learnRecipe("Create 45 Spare Engine Parts");
        player:learnRecipe("Create 50 Spare Engine Parts");
    end

end

-- Event for when a character loads into the world.
Events.OnCreatePlayer.Add(AddRecipesToExistingPlayers);
