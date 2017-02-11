Chat Bell
=========

Chat Bell is a tiny mod ringing a bell on player's name quote in chat.
The functionality can be enabled/disabled by /chatbell command.
Players preferences are saved on disk in <world>/chatbell by default
The command & players settings can be disabled. Chatbell is activated for all then.

Config in init.lua


Mod dependencies: none


Let the users chose their sound
-------------------------------

You can let users chose their sound using [Sounds Pack] (http://wiki.minetest.net/Sound_Packs).
In init.lua:
- set use_settings = false
- set sound = chatbell_sound
Then, users can place chatbell_sound.ogg of their choice in the shared sound folder.


License
=======

Copyright (C) 2017 Bousket
Chat Bell code is licensed under CC0
https://creativecommons.org/publicdomain/zero/1.0/

For sounds: see sounds/credits.txt
