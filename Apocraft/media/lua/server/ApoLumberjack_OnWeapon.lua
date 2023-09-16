-- ApoLumberJack_OnWeapon.lua
-- This script links the weapon hit event with the lumberjack logic.

-- Required libraries for the XP system.
require "XpSystem/XpUpdate"

-- Import the main logic for lumberjack actions.
local loggingOnWeapon = require "ApoLumberjack_Main"

-- Add the hit function to the OnWeaponHitTree event.
-- This event is triggered when a weapon hits a tree.
-- It passes two parameters: 'owner' (the character doing the hitting) and 'weapon' (the weapon used).
Events.OnWeaponHitTree.Add(loggingOnWeapon.hit)
