-- ApoLumberJack_OnWeapon.lua
-- Apocraft_OnWeapon.lua
-- This script links the weapon hit event with the woodcutting logic.

-- Required libraries for the XP system.
require "XpSystem/XpUpdate"

-- Import the main logic for woodcutting actions.
local loggingOnWeapon = require "Apocraft_Woodcutting"

-- Add the hit function to the OnWeaponHitTree event.
-- This event is triggered when a weapon hits a tree.
-- It passes two parameters: 'owner' (the character doing the hitting) and 'weapon' (the weapon used).
Events.OnWeaponHitTree.Add(loggingOnWeapon.hit)
