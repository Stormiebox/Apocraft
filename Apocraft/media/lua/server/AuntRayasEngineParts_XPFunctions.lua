--------Created By: Hazy Lunar
--------Deathscape Community

-- Give XP Functions
function Recipe.OnGiveXP.MetalWelding10(recipe, ingredients, result, player)
   player:getXp():AddXP(Perks.MetalWelding, 10);
end

function Recipe.OnGiveXP.MetalWelding20(recipe, ingredients, result, player)
   player:getXp():AddXP(Perks.MetalWelding, 20);
end

-- These functions are defined to avoid breaking Project Zomboid mods.
Get10MetalWeldingXP = Recipe.OnGiveXP.MetalWelding10
Get20MetalWeldingXP = Recipe.OnGiveXP.MetalWelding20
