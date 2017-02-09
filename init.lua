-- Chat Bell - Mod for minetest
-- Copyright (C) 2017 Bousket
--
-- ChatBell is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as 
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- ChatBell is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with ChatBell.  If not, see <http://www.gnu.org/licenses/>.
--
-------------------------------------------------------------------------------
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!! This mod is temporary and should be implemented client side. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
-- Feature:
--  * Emits a sound on my name
--  * /chatbell Enable/Disable this ability
--  * Save players preferences on disk


-- Chatbell config
chatbell = {

--sound = "chatbell_sound", -- See Readme.txt for mod sound packs usage
--sound = "chatbell_coins",
sound = "chatbell_i-demand-attention",

spam_time = 2, -- don t play another sound before this time in seconds

use_settings = true, -- turn it to false to use chatbell for all players. Disable /chatbell command & settings on disk

player_settings = {}, -- player related infos struct -- [player]: {enabled, last played time}

} 



local mod_path = minetest.get_modpath(minetest.get_current_modname())
dofile(mod_path.."/chatbell.lua")

if chatbell.use_settings then
	dofile(mod_path.."/settings.lua")
end
