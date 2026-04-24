## Table of Contents
- [Apocraft Introduction](#apocraft-introduction)
- [Guide](#guide)
- [Enhanced Forage](#enhanced-forage)
- [Vanilla-Friendly & Compatibility](#vanilla-friendly--compatibility)
- [Crafting Tables & Required Mod](#crafting-tables--required-mod)
- [FAQs](#faqs)
- [Changelog](#changelog)
- [Feedback & Support](#feedback--support)


## Apocraft Introduction
Welcome to Apocraft, a vanilla-friendly crafting overhaul for Project Zomboid! Delve into over 1,000 diverse crafting recipes, complemented by unique SFX for a heightened experience. Along with the foundational support from the "Crafting Enhanced Core" mod, Apocraft now also integrates with the "Target Square: On Load Commands" API mod, introducing dynamic in-game environmental interactions and additional crafting capabilities. Tailored for compatibility with other mods, Apocraft is poised to redefine and enhance your survival journey!

## Guide
### Crafting Categories include:
- Cooking
- Carpentry
- Electrical
- Farming
- Forging (Smithing)
- Medical
- Metalworking
- Tailoring
- Survivalist

### Enhanced Crafting Features include:
- Diverse Paint Crafting
- Canning Galore
- Hair Dye Crafting
- Extensive Metalworking & Forging
- Extensive Recycling
- Weapon/Tool Repair
- Glass Molding
- Advanced Logging System: Leverage your character's Strength to efficiently identify and extract resources from specialized trees like the "Heartwood Trees", featuring a balanced extraction system and bonus log drops.
- Bio-Fuel Distillation & Refining: Convert wood mulch into crude bio-oil, and distill it further into usable gasoline and propane using custom-built laboratory equipment.

### Additional Features include:
- Unique SFX for Crafting
- Custom-made Magazine Textures
- Molds for Enhanced Forging

## Enhanced Forage
Delve deeper into the environment with the Enhanced Forage system. As your foraging skill increases, you'll find a wider variety of items and encounter foraging hotspots where yield is doubled. Harness the power of nature and make your survival a tad easier!

### How it works:
- As players explore the world of Project Zomboid, certain areas or "hotspots" provide a greater yield for foraging.
- The likelihood of these hotspots appearing is influenced by the in-game sandbox settings.
- Once within these hotspots, players receive double the yield when they forage, providing a significant boost to their resources.
- The type and amount of items players find are directly influenced by their foraging skill level. The higher the skill, the richer the rewards!
- Integrated notifications ensure players are aware of their environment, helping them make the most of these hotspots.

## Vanilla-Friendly & Compatibility
- **Vanilla Synergy:** Integrates seamlessly into the base game, enriching the experience without modifying the core essence.
- **Mod Compatibility:** Ensures harmony with most mods in the Project Zomboid workshop.

## Crafting Tables & Required Mod
- **New Crafting Tables:** Specialized tables that are key for the new recipes.
- **Crafting Enhanced Core:** Essential for the functioning of the crafting tables, elevating the crafting experience.

## FAQs
- **Q: Can I use this mod alongside XYZ mod?**
  > **A:** Apocraft is compatible with most Project Zomboid mods. Check the compatibility list or test first.
  
- **Q: How do I repair tools?**
  > **A:** Gather required materials as per the crafting menu and proceed with the crafting process.

- **Q: Where did the custom "Lumberjack" skill go?**
  > **A:** To ensure maximum compatibility and server stability, the custom Lumberjack skill, traits, and skill books have been separated into a dedicated submod! The core Apocraft mod now natively uses your character's vanilla Strength perk to calculate logging bonuses.

- **Q: How does the logging system work with special trees like the "Heartwood Trees"?**
  > **A:** Special trees now contain a hidden bonus pool of logs. As you chop them down, there is a chance per hit to safely dislodge extra special logs. Additionally, your character's Strength level gives you a flat chance to drop bonus standard logs with every swing!

- **Q: How do I create my own gasoline and propane?**
  > **A:** First, read the Apocraft Survivalist and Forging magazines to learn the blueprints. Construct a Bio-Fuel Distiller and Condenser at the Forge Table. Process wood into mulch at the Armory Table, then refine that mulch at the Laboratory Table to create Crude Bio-Oil, Gasoline, and Propane!

## Changelog
### Version 1.7.0
- **Refactored:** Separated the custom Lumberjack skill, traits, and skill books into a standalone submod to maintain absolute stability in the core Apocraft experience.
- **Overhaul:** Completely rebalanced the woodcutting and Special Trees system. Infinite log exploits have been patched, transitioning from a flat-drop system to a chance-based extraction system.
- **Integrated:** The vanilla Strength perk now governs your chances of extracting bonus logs from trees per swing.

### Version 1.6.0
- **Feature:** Overhauled Bio-Fuel and Propane distillation system!
- **New Items & Textures:** Added Bio-Fuel Distiller, Condenser, Wood Mulch, Crude Bio-Oil (Buckets/Pots), and Empty Propane Tanks. Included all corresponding ground and inventory textures.
- **Wood Mulching:** Added recipes to mulch various wood types (Logs, Branches, Twigs, Planks, Unusable Wood) using the Armory Table and logging tools.
- **Metalworking Integration:** Added recipes to craft Distillers, Condensers, and Propane Tanks at the Forge Table.
- **Bio-Fuel Distillation:** Added survivalist recipes to refine mulch into Crude Bio-Oil, Gasoline, and Propane at the Laboratory Table.
- **Custom SFX Hooks:** Integrated custom Apocraft sound effects into the new crafting steps.
- **Magazine Unlocks:** Hooked the new recipes into the existing skill learning progression (ApoForgingMagazine and ApoSurvivalistMagazine).

### Version 1.5.0
- **Overhaul:** Complete code and script audit across all recipe, item, and translation files. Standardized formatting, syntax, and engine hooks for maximum stability.
- **Added:** Over 20 new Metalworking recipes! You can now forge base materials (pipes, wire, sheet metal), tools (hammers, saws, wrenches), weapons (crowbars, machetes), and cooking supplies using the Forge Table.
- **Enhanced:** Jewelry recycling is now dynamically driven by Lua, allowing any combination of 3 watches or accessories to be melted down into Scrap Metal.
- **Fixed:** Critical bug where reusable tools (like scissors, needles, etc.) were incorrectly consumed and destroyed during crafting.
- **Fixed:** Realigned and fully translated UI categories under the unified "Apocraft" umbrella (e.g., Apocraft Metalworking, Apocraft Farming, Apocraft Survivalist).
- **Refactored:** Vastly optimized vehicle part crafting and Lua scripts for cleaner performance and safe mod compatibility (e.g., TraitTagFramework dependency is now safely checked).

### Version 1.4.0
- **Added:** Enhanced Forage system, introducing dynamic foraging hotspots where players can find a more diverse range of items based on their foraging skill. In these zones, foraging yields are doubled.
- **Integrated:** "Target Square: On Load Commands" API mod to support the Enhanced Forage system.

### Version 1.3.0
- **Added:** Integration of the "Lumberjack" skill with specialized trees like "Heartwood Trees".
- **Enhanced:** Lumberjack skill mechanics to align with the introduction of unique trees and advanced logging capabilities.

### Version 1.2.0
- **Added:** "Lumberjack" skill with associated recipes and functionalities.

### Version 1.1.0
- **Added:** 50 new carpentry recipes.
- **Fixed:** Bug related to glass molding.

### Version 1.0.0
- Initial commit and upload of the Apocraft mod project.

## Feedback & Support
Share your feedback to refine Apocraft! For issues or suggestions, reach out or comment on the workshop page.
