-- Play a sound when the player's name appears in chat




-- Play a sound on player's name quote
minetest.register_on_chat_message(function(name, message)
	message = message:lower()
	local player_name = nil
    for _,player in ipairs(minetest.get_connected_players()) do
		player_name = player:get_player_name()
		if message:find(player_name:lower()) and -- quoted --
		   chatbell.player_settings[player_name].enabled and -- sound enabled --
		   (minetest.get_us_time() - chatbell.player_settings[player_name].time) > chatbell.spam_time * 1000000 then -- no spam --
			chatbell.player_settings[player_name].time = minetest.get_us_time()
			minetest.sound_play(chatbell.sound, {to_player = player_name})
		end
	end

    return true
end)



-- Init or refresh chatbell players settings structure when a player connects
minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if chatbell.player_settings[player_name] == nil then
		chatbell.player_settings[player_name] = {enabled = not chatbell.use_settings, time = minetest.get_us_time()}
	else
		chatbell.player_settings[player_name].time = minetest.get_us_time()
	end
end)
