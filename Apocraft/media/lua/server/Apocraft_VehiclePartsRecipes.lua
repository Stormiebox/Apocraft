--This is used for tires/batteries
function Recipe.OnCreate.RepairItem(items, result, player, selectedItem)
    local mechanics = player:getPerkLevel(Perks.Mechanics)
    local conditionBase = math.min(mechanics * 10, 80)
    local conditionMax = math.min(80, (conditionBase + ZombRand(0, 15)))

    result:setCondition(conditionMax)
    player:getXp():AddXP(Perks.Mechanics, conditionMax / 5)
end

--This is used for other parts
function Recipe.OnCreate.PartQuality(items, result, player, selectedItem)
    local mechanics = player:getPerkLevel(Perks.Mechanics)
    local welding = player:getPerkLevel(Perks.MetalWelding)
    local conditionBase = (mechanics * 6) + (welding * 6)
    local conditionMax = math.min(100, (conditionBase + ZombRand(-15, 10)))

    result:setCondition(conditionMax)
    player:getXp():AddXP(Perks.MetalWelding, conditionMax / 5)
    player:getXp():AddXP(Perks.Mechanics, conditionMax / 5)
    player:getXp():AddXP(Perks.Strength, 8)
end

-- Helper for Tire creation
local function createTire(player, suffix)
    local comboSkill = (player:getPerkLevel(Perks.Mechanics) + player:getPerkLevel(Perks.MetalWelding)) / 2
    local prefix = comboSkill >= 9 and "ModernTire" or (comboSkill >= 6 and "NormalTire" or (comboSkill >= 3 and "OldTire" or nil))

    if prefix then
        player:getInventory():AddItem(prefix .. suffix)
        player:getXp():AddXP(Perks.MetalWelding, 4)
        player:getXp():AddXP(Perks.Mechanics, 4)
        player:getXp():AddXP(Perks.Strength, 8)
    end
end

-- Tires
function Recipe.OnCreate.TireStandard(items, result, player) createTire(player, "1") end
function Recipe.OnCreate.TireHeavy(items, result, player) createTire(player, "2") end
function Recipe.OnCreate.TireSport(items, result, player) createTire(player, "3") end

-- Helper for other vehicle parts
local function createVehiclePart(player, high, med, low)
    local mechSkill = player:getPerkLevel(Perks.Mechanics)
    local weldSkill = player:getPerkLevel(Perks.MetalWelding)
    local partType = mechSkill >= 9 and high or (mechSkill >= 6 and med or (mechSkill >= 3 and low or nil))

    if partType then
        local conditionMax = math.min(100, weldSkill * 15 + ZombRand(-5, 5))
        local newItem = player:getInventory():AddItem(partType)
        if newItem then 
            newItem:setCondition(conditionMax) 
        end
        player:getXp():AddXP(Perks.MetalWelding, weldSkill)
        player:getXp():AddXP(Perks.Mechanics, mechSkill)
        player:getXp():AddXP(Perks.Strength, 8)
    end
end

-- Mufflers
function Recipe.OnCreate.MufflerStandard(items, result, player) createVehiclePart(player, "ModernCarMuffler1", "NormalCarMuffler1", "OldCarMuffler1") end
function Recipe.OnCreate.MufflerHeavy(items, result, player) createVehiclePart(player, "ModernCarMuffler2", "NormalCarMuffler2", "OldCarMuffler2") end
function Recipe.OnCreate.MufflerSport(items, result, player) createVehiclePart(player, "ModernCarMuffler3", "NormalCarMuffler3", "OldCarMuffler3") end

-- Suspensions
function Recipe.OnCreate.SuspensionStandard(items, result, player) createVehiclePart(player, "ModernSuspension1", "NormalSuspension1", nil) end
function Recipe.OnCreate.SuspensionHeavy(items, result, player) createVehiclePart(player, "ModernSuspension2", "NormalSuspension2", nil) end
function Recipe.OnCreate.SuspensionSport(items, result, player) createVehiclePart(player, "ModernSuspension3", "NormalSuspension3", nil) end

-- Gas Tanks
function Recipe.OnCreate.GasTankStandard(items, result, player) createVehiclePart(player, "BigGasTank1", "NormalGasTank1", "SmallGasTank1") end
function Recipe.OnCreate.GasTankHeavy(items, result, player) createVehiclePart(player, "BigGasTank2", "NormalGasTank2", "SmallGasTank2") end
function Recipe.OnCreate.GasTankSport(items, result, player) createVehiclePart(player, "BigGasTank3", "NormalGasTank3", "SmallGasTank3") end

-- Brakes
function Recipe.OnCreate.BrakeStandard(items, result, player) createVehiclePart(player, "ModernBrake1", "NormalBrake1", "OldBrake1") end
function Recipe.OnCreate.BrakeHeavy(items, result, player) createVehiclePart(player, "ModernBrake2", "NormalBrake2", "OldBrake2") end
function Recipe.OnCreate.BrakeSport(items, result, player) createVehiclePart(player, "ModernBrake3", "NormalBrake3", "OldBrake3") end

-- Engine Parts
function Recipe.OnCreate.EngineParts(items, result, player, selectedItem)
    local comboSkill = player:getPerkLevel(Perks.Mechanics) + player:getPerkLevel(Perks.MetalWelding) + player:getPerkLevel(Perks.Electricity)
    local partsNum = math.floor(comboSkill / 1.5)

    if partsNum > 0 then
        player:getInventory():AddItems("EngineParts", partsNum)
        player:getXp():AddXP(Perks.MetalWelding, partsNum)
        player:getXp():AddXP(Perks.Mechanics, partsNum)
        player:getXp():AddXP(Perks.Electricity, partsNum)
    end
end

-- XP Scaling
function Recipe.OnGiveXP.MechWeldScaled(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, player:getPerkLevel(Perks.Mechanics) * 5)
    player:getXp():AddXP(Perks.MetalWelding, player:getPerkLevel(Perks.MetalWelding) * 5)
    player:getXp():AddXP(Perks.Strength, 12)
end
