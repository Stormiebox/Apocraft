-- Apocraft_RecipeInjector.lua
-- This script hooks into the game's load process to dynamically inject "NearItem" 
-- requirements (like specific crafting tables) into recipes from other mods.

local RecipeInjector = {}

-- A list of rules to apply if a specific mod is active.
-- Since Zomboid's Lua API doesn't natively tag a recipe with its "Mod ID", 
-- we target them by their "Category", "Module" name, or exact "recipeNames".
local InjectionRules = {
    -- ==========================================
    -- ELECTRONICS & MECHANICS
    -- ==========================================
    {
        modID = "LWBetterElectronics",
        category = "Electrical",
        tableID = "Mechanic Table"
    },
    {
        modID = "LightSwitchOverhaul",
        category = "Electrical",
        tableID = "Mechanic Table"
    },
    {
        modID = "zReBetterLockpicking",
        category = "Survivalist",
        tableID = "Mechanic Table"
    },
    {
        modID = "zReBetterLockpickingLYSLP",
        category = "Survivalist",
        tableID = "Mechanic Table"
    },
    {
        modID = "MoreLockManagement",
        category = "Welding",
        tableID = "Mechanic Table"
    },

    -- ==========================================
    -- MEDICAL & CHEMISTRY
    -- ==========================================
    {
        modID = "herbalist",
        category = "Herbalist",
        tableID = "Laboratory Table"
    },
    {
        modID = "iMedsFixed",
        category = "Health",
        tableID = "Laboratory Table"
    },
    {
        modID = "piesfirstaidoverhaul",
        category = "Health",
        tableID = "Laboratory Table"
    },
    {
        modID = "piesfirstaidoverhaul-jobless",
        category = "Health",
        tableID = "Laboratory Table"
    },
    {
        modID = "zReModVaccin20byk",
        category = "Vaccine",
        tableID = "Laboratory Table"
    },
    {
        modID = "zReModVaccin20byk",
        category = "Chemistry",
        tableID = "Laboratory Table"
    },
}

local function InjectTables()
    local activatedMods = getActivatedMods()
    local scriptManager = ScriptManager.instance
    local allRecipes = scriptManager:getAllRecipes()
    
    -- 1. Gather all rules where the required mod is actually active
    local activeRules = {}
    for _, rule in ipairs(InjectionRules) do
        if activatedMods:contains(rule.modID) then
            table.insert(activeRules, rule)
        end
    end

    -- If none of the targeted mods are active, exit early to save performance
    if #activeRules == 0 then return end

    -- 2. Iterate through all loaded recipes in the game
    for i = 0, allRecipes:size() - 1 do
        local recipe = allRecipes:get(i)
        local recModule = recipe:getModule():getName()
        local recCategory = recipe:getCategory() or ""
        local recName = recipe:getOriginalName() or recipe:getName()
        
        -- 3. Check if this recipe matches any of our active rules
        for _, rule in ipairs(activeRules) do
            local isMatch = false
            
            if rule.recipeNames then
                -- Match by specific recipe names
                for _, name in ipairs(rule.recipeNames) do
                    if name == recName then
                        isMatch = true
                        break
                    end
                end
            else
                -- Match by Module Name AND/OR Category
                local moduleMatch = (rule.moduleName == nil) or (recModule == rule.moduleName)
                local categoryMatch = (rule.category == nil) or (recCategory == rule.category)
                
                if moduleMatch and categoryMatch then
                    isMatch = true
                end
            end
            
            -- 4. Apply the Crafting Enhanced Table ID
            if isMatch then
                -- Check if the recipe already has a NearItem or NeedToBeAgainst assigned
                local hasNearItem = false
                
                pcall(function()
                    local nearItem = recipe:getNearItem()
                    if nearItem and nearItem ~= "" then
                        hasNearItem = true
                    end
                end)
                
                if not hasNearItem then
                    pcall(function()
                        local needAgainst = recipe:getNeedToBeAgainst()
                        if needAgainst and needAgainst ~= "" then
                            hasNearItem = true
                        end
                    end)
                end
                
                if not hasNearItem then
                    -- Because Project Zomboid will throw a hard exception if we call a non-existent 
                    -- Java method from Lua, we use 'pcall' (protected call) to safely attempt the injection.
                    local success = pcall(function() recipe:setNearItem(rule.tableID) end)
                    
                    -- Fallback to the vanilla 'NeedToBeAgainst' property if NearItem doesn't exist as a direct setter
                    if not success then
                        pcall(function() recipe:setNeedToBeAgainst(rule.tableID) end)
                    end
                end
                
                -- Break out of the rule loop so we don't apply multiple tables to the same recipe
                break
            end
        end
    end
end

-- Inject right after all scripts are loaded and parsed
Events.OnGameBoot.Add(InjectTables)

return RecipeInjector