-- Enable /chatbell command & Save players settings on disk

local settings_file = minetest.get_worldpath() .. "/chatbell"


-- Enable/Disable Sound Command
minetest.register_chatcommand("chatbell", {
	description = "Plays a sound when your name is quoted in chat (spam protection of ".. chatbell.spam_time .."s)",
	func = function(name, param)
		chatbell.player_settings[name].enabled = not chatbell.player_settings[name].enabled
		save_settings()
		return true, "Chat bell is " .. (chatbell.player_settings[name].enabled and "enabled" or "disabled") .. "."
	end
})


local function load_settings()
	local input, err = io.open(settings_file, "r")
	if not input then
		return minetest.log("info", "Could not load chatbell config file: " .. err)
	end

	local cur_time = minetest.get_us_time()
	for name, active in input:read("*a"):gmatch("([%w_-]+)%s(%S+)[\r\n]") do
		chatbell.player_settings[name] = {enabled = (active == "true"), time = cur_time}
	end
	input:close()
end

load_settings()


function save_settings()
	local data = {}
	local output, err = io.open(settings_file, "w")
	if output then
		for player_name, entry in pairs(chatbell.player_settings) do
			table.insert(data, string.format("%s %s\n", player_name, tostring(entry.enabled)))
		end
		output:write(table.concat(data))
		io.close(output)
		return true
	end
	minetest.log("action", "Unable to write to chatbell config file: " .. err)
	return false
end

