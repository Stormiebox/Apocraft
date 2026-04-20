-- ApoEnhancedForaging.lua
-- Introduces a rewarding foraging system using Procedural Hotspots and Search Mode hooks.

require "TimedActions/ISScavengeAction"

local ApoEnhancedForaging = {}

-- 1. PROCEDURAL HOTSPOT CHECKER
-- We divide the map into 10x10 tile "zones" and hash them.
-- No save data or chunk-loading APIs required!
local function isForagingHotspot(x, y)
    local zoneX = math.floor(x / 10)
    local zoneY = math.floor(y / 10)

    -- Procedural Hash
    local hash = (zoneX * 374761393) + (zoneY * 668265263)
    local roll = math.abs(hash) % 100 -- Roll from 0 to 99

    local hotspotChance = 10.0
    if SandboxVars.ApoEnhancedForaging and SandboxVars.ApoEnhancedForaging.HotspotChance then
        hotspotChance = SandboxVars.ApoEnhancedForaging.HotspotChance
    end

    return roll < hotspotChance
end

-- 2. HOOKING INTO VANILLA SEARCH MODE
-- We wait for the game to boot, then wrap the vanilla foraging action.
local function InjectEnhancedForaging()
    if not ISScavengeAction then return end

    -- Save the original vanilla function
    local original_perform = ISScavengeAction.perform

    -- Overwrite it with our custom wrapper
    function ISScavengeAction:perform()
        -- 1. Call the original function so the player gets the vanilla item normally
        original_perform(self)

        -- 2. Run our Apocraft Bonus Logic
        local character = self.character
        if not character then return end

        -- Give a 15% chance for a foraging "Jackpot" so we don't flood the server economy on every single twig pickup.
        if ZombRand(100) < 15 then
            local skillLevel = character:getPerkLevel(Perks.Foraging)
            local multiplier = 1

            -- Check if this specific square is in a procedural hotspot
            if isForagingHotspot(character:getX(), character:getY()) then
                multiplier = 2
            end

            local bonusItems = {
                "Base.Twigs", "Base.Stone", "Base.WildGarlic", "Base.Ginseng",
                "Base.HerbsCommon", "Base.BerryBlue", "Base.BerryBlack",
                "Base.MushroomGeneric1", "Base.MushroomGeneric3", "Base.MushroomGeneric4",
                "Base.MushroomGeneric5", "Base.MushroomGeneric6", "Base.MushroomGeneric7"
            }

            local item = bonusItems[ZombRand(1, #bonusItems + 1)]
            local itemCount = (skillLevel + 1) * multiplier

            character:getInventory():AddItems(item, itemCount)

            -- Inform the player of their jackpot!
            if character:isLocalPlayer() then
                if multiplier == 2 then
                    character:setHaloNote(getText("IGUI_Found_Foraging_Hotspot"), 0, 255, 0, 300)
                else
                    character:setHaloNote(getText("IGUI_Found_Extra_Stash"), 200, 200, 200, 300)
                end
            end
        end
    end
end

-- Inject our custom code right as the game sets up actions
Events.OnGameBoot.Add(InjectEnhancedForaging)

return ApoEnhancedForaging
