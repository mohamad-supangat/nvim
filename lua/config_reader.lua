-- ~/.config/nvim/lua/config_reader.lua
local M = {}

-- Path ke file konfigurasi
local config_path = vim.fn.stdpath("config") .. "/.nvim.json"

-- Fungsi untuk membaca file JSON
function M.read_config()
	-- Cek apakah file exists
	if not vim.loop.fs_stat(config_path) then
		vim.notify("Config file not found: " .. config_path, vim.log.levels.WARN)
		return {}
	end

	-- Baca file
	local file = io.open(config_path, "r")
	if not file then
		vim.notify("Cannot open config file", vim.log.levels.ERROR)
		return {}
	end

	local content = file:read("*all")
	file:close()

	-- Parse JSON
	local success, config = pcall(vim.json.decode, content)
	if not success then
		vim.notify("Error parsing JSON config: " .. config, vim.log.levels.ERROR)
		return {}
	end

	return config or {}
end

-- Fungsi untuk menulis config ke file
function M.write_config(config)
	local success, json = pcall(vim.json.encode, config)
	if not success then
		vim.notify("Error encoding config to JSON", vim.log.levels.ERROR)
		return false
	end

	local file = io.open(config_path, "w")
	if not file then
		vim.notify("Cannot write config file", vim.log.levels.ERROR)
		return false
	end

	file:write(json)
	file:close()

	vim.notify("Config saved successfully", vim.log.levels.INFO)
	return true
end

-- Fungsi untuk mendapatkan nilai spesifik dengan default
function M.get(key, default)
	local config = M.read_config()

	-- Navigasi nested key (contoh: "plugins.lsp.enabled")
	local keys = {}
	for k in string.gmatch(key, "[^.]+") do
		table.insert(keys, k)
	end

	local value = config
	for _, k in ipairs(keys) do
		if type(value) ~= "table" then
			return default
		end
		value = value[k]
		if value == nil then
			return default
		end
	end

	return value
end

-- Fungsi untuk update nilai spesifik
function M.set(key, value)
	local config = M.read_config()

	-- Navigasi ke parent key
	local keys = {}
	for k in string.gmatch(key, "[^.]+") do
		table.insert(keys, k)
	end

	local current = config
	for i = 1, #keys - 1 do
		if current[keys[i]] == nil then
			current[keys[i]] = {}
		end
		current = current[keys[i]]
	end

	-- Set value
	current[keys[#keys]] = value

	-- Save config
	return M.write_config(config)
end

-- Watch file untuk perubahan (opsional)
function M.watch_config(callback)
	local watcher

	-- Fungsi untuk cek perubahan
	local last_mtime = vim.loop.fs_stat(config_path) and vim.loop.fs_stat(config_path).mtime or 0

	watcher = vim.loop.new_fs_event()
	watcher:start(config_path, {}, function(err, fname, events)
		if err then
			return
		end

		local stat = vim.loop.fs_stat(config_path)
		if stat and stat.mtime > last_mtime then
			last_mtime = stat.mtime
			if callback then
				local new_config = M.read_config()
				callback(new_config)
			end
		end
	end)

	return watcher
end

return M
