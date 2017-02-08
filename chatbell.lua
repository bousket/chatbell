-- Play a sound when the player's name appears in chat

local settings_file = minetest.get_worldpath() .. "/chat_bell"
local spam_time = 2 -- don t play another sound before this time in seconds
chat_bell = {} -- player related infos struct -- [player]: {enabled, last played time}


-- Enable/Disable Sound Command
minetest.register_chatcommand("chatbell", {
	description = "Plays a sound when your name is quoted in chat (spam protection of ".. spam_time .."s)",
	privs = {
		interact = true
	},
	func = function(name, param)
		chat_bell[name].enabled = not chat_bell[name].enabled
		save_settings()
		return true, "Chat bell is " .. (chat_bell[name].enabled and "enabled" or "disabled") .. "."
	end
})


-- Play a sound on player's name quote
minetest.register_on_chat_message(function(name, message)
	message = message:lower()
	local player_name = nil
    for _,player in ipairs(minetest.get_connected_players()) do
		player_name = player:get_player_name()
		if message:find(player_name:lower()) and -- quoted --
		   chat_bell[player_name].enabled and -- sound enabled --
		   (minetest.get_us_time() - chat_bell[player_name].time) > spam_time * 1000000 then -- no spam --
			chat_bell[player_name].time = minetest.get_us_time()
			minetest.sound_play("chatbell_coins", {to_player = player_name})
		end
	end

    return true
end)


-- Init or refresh chat_bell structure when a player connects
minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if chat_bell[player_name] == nil then
		chat_bell[player_name] = {enabled = false, time = minetest.get_us_time()}
	else
		chat_bell[player_name].time = minetest.get_us_time()
	end
end)




local function load_settings()
	local input, err = io.open(settings_file, "r")
	if not input then
		return minetest.log("info", "Could not load chat_bell config file: " .. err)
	end

	local cur_time = minetest.get_us_time()
	for name, active in input:read("*a"):gmatch("([%w_-]+)%s(%S+)[\r\n]") do
		chat_bell[name] = {enabled = (active == "true"), time = cur_time}
	end
	input:close()
end

load_settings()


function save_settings()
	local data = {}
	local output, err = io.open(settings_file, "w")
	if output then
		for player_name, entry in pairs(chat_bell) do
			table.insert(data, string.format("%s %s\n", player_name, tostring(entry.enabled)))
		end
		output:write(table.concat(data))
		io.close(output)
		return true
	end
	minetest.log("action", "Unable to write to chat_bell config file: " .. err)
	return false
end

