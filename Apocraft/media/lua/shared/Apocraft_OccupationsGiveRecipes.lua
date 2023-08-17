-- On Player Load, check their professions and if it's one we're expecting, add some free recipes to their character.
function AddRecipesToExistingPlayers(id, player)
    local profession = player:getDescriptor():getProfession();

    -- Adjustments to acquire PaintItAll recipes instantly.
    if profession == "repairman" then
        player:learnRecipe("BLANK");
        player:learnRecipe("BLANK");
        player:learnRecipe("BLANK");
        player:learnRecipe("BLANK");
    end

end

-- Event for when a character loads into the world.
Events.OnCreatePlayer.Add(AddRecipesToExistingPlayers);
