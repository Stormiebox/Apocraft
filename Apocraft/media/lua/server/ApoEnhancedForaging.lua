-- ApoEnhancedForaging.lua
-- This script introduces a more rewarding foraging system where players can find
-- more items based on their foraging skill. Additionally, certain areas in the map
-- are designated as "hotspots" where the foraging yield is doubled.

-- Import the external module.
require "!_TargetSquare_OnLoad.lua"

-- List to store known foraging hotspots.
local hotspots = {}

-- Function to handle when a chunk of the map is loaded. It will determine if the
-- chunk is a foraging hotspot.
function OnChunkLoadedHandler(wx, wy)
    -- Get the chance from SandboxVars. If not set, default to 10%.
    local hotspotChance = SandboxVars.ApoEnhancedForaging.HotspotChance or 10.0

    if ZombRand(100) < hotspotChance then
        local hotspot = { x = wx, y = wy }
        table.insert(hotspots, hotspot)

        -- Use the TargetSquare OnLoad API to remember this hotspot across game loads.
        System.addCommand(wx, wy, 0, { command = "MarkForagingHotspot", x = wx, y = wy })
    end
end

-- Function from our !_TargetSquare_OnLoad.lua API to process saved foraging hotspot data
-- and add them back to the game when the chunk is loaded.
function System.OnLoadCommands.MarkForagingHotspot(square, command)
    table.insert(hotspots, { x = command.x, y = command.y })
end

-- Function to handle when a player initiates foraging. The yield and type of items
-- they find will be influenced by their foraging skill and whether they're in a hotspot.
function OnPlayerForageHandler(player)
    local skillLevel = player:getPerkLevel(Perks.Foraging)
    local multiplier = 1

    -- Check if the player is within a foraging hotspot.
    local playerX, playerY = player:getX(), player:getY()
    for _, hotspot in pairs(hotspots) do
        if math.abs(hotspot.x - playerX) <= 10 and math.abs(hotspot.y - playerY) <= 10 then
            multiplier = 2 -- Double the yield if in a hotspot.
            break
        end
    end

    -- Determine the number of items player finds based on the new enhanced foraging system.
    local bonusItems = {
        "Base.Twigs",
        "Base.Stone",
        "Base.WildGarlic",
        "Base.Ginseng",
        "Base.HerbsCommon",
        "Base.BerryBlue",
        "Base.BerryBlack",
        "Base.MushroomGeneric1",
        "Base.MushroomGeneric3",
        "Base.MushroomGeneric4",
        "Base.MushroomGeneric5",
        "Base.MushroomGeneric6",
        "Base.MushroomGeneric7"
    }

    local item = bonusItems[ZombRand(1, #bonusItems + 1)]
    local itemCount = (skillLevel + 1) * multiplier
    player:getInventory():AddItems(item, itemCount)

    -- Inform the player they found something.
    player:setHaloNote("I've found something interesting!")
end

-- Attach the handlers to the appropriate events.
Events.OnChunkLoaded.Add(OnChunkLoadedHandler)
Events.OnPlayerForage.Add(OnPlayerForageHandler)

return {
    OnChunkLoadedHandler = OnChunkLoadedHandler,
    OnPlayerForageHandler = OnPlayerForageHandler
}
