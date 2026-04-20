--- Item Loot Distribution for Apocrat Items.
--- Included Base.Bellows and Base.Tongs which are B41 hidden vanilla items.

require "Items/ProceduralDistributions"

local function insertLoot(tableName, itemName, weight)
    -- Check if the loot table actually exists to prevent errors
    if ProceduralDistributions.list[tableName] then
        table.insert(ProceduralDistributions.list[tableName].items, itemName)
        table.insert(ProceduralDistributions.list[tableName].items, weight)
    else
        print("ApocraftLoot: Could not find ProceduralDistribution table: " .. tostring(tableName))
    end
end

local function ApocraftLootDistributions()
    -- =========================================================================
    -- Hidden Vanilla Items (B41)
    -- =========================================================================

    -- Base.Bellows
    insertLoot("MetalworkTools", "Base.Bellows", 5)
    insertLoot("CrateMetalwork", "Base.Bellows", 2)
    insertLoot("ToolStoreMetalwork", "Base.Bellows", 5)

    -- Base.Tongs
    insertLoot("MetalworkTools", "Base.Tongs", 5)
    insertLoot("CrateMetalwork", "Base.Tongs", 2)
    insertLoot("ToolStoreMetalwork", "Base.Tongs", 5)

    -- =========================================================================
    -- Apocraft Mod Items
    -- =========================================================================

    -- General Tools & Misc
    insertLoot("CrateMisc", "Apocraft.EmptyLighter", 10)
    insertLoot("ConvenienceStoreMisc", "Apocraft.EmptyLighter", 10)
    insertLoot("CrateTools", "Apocraft.Chisel", 20)
    insertLoot("GarageTools", "Apocraft.Chisel", 15)
    insertLoot("ToolStoreTools", "Apocraft.Chisel", 20)

    -- Molds and Metalworking
    insertLoot("CrateMetalwork", "Apocraft.SmeltingMold", 10)
    insertLoot("CrateMetalwork", "Apocraft.SmeltingMold2", 5)
    insertLoot("CrateMetalwork", "Apocraft.IngotMold", 10)
    insertLoot("CrateMetalwork", "Apocraft.IngotMold2", 5)
    insertLoot("CrateMetalwork", "Apocraft.GlassPaneMold", 10)
    insertLoot("MetalworkTools", "Apocraft.SmeltingMold", 5)
    insertLoot("MetalworkTools", "Apocraft.IngotMold", 5)
    insertLoot("ToolStoreMetalwork", "Apocraft.SmeltingMold2", 5)
    insertLoot("ToolStoreMetalwork", "Apocraft.IngotMold2", 5)

    -- Materials
    insertLoot("CrateMaterials", "Apocraft.GlassPane", 10)
    insertLoot("CrateMaterials", "Apocraft.ShardsOfGlass", 15)

    -- Lumberjack Skill Books
    local lumberjackBooks = {
        "Apocraft.BookLumberjack1", "Apocraft.BookLumberjack2",
        "Apocraft.BookLumberjack3", "Apocraft.BookLumberjack4",
        "Apocraft.BookLumberjack5"
    }
    for _, book in ipairs(lumberjackBooks) do
        insertLoot("LibraryBooks", book, 10)
        insertLoot("BookstoreBooks", book, 10)
        insertLoot("CrateMagazines", book, 5)
    end
end

Events.OnPreDistributionMerge.Add(ApocraftLootDistributions)
