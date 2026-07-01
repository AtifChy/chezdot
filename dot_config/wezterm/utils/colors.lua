---@class Utils.Colors
local M = {}

---@type Wezterm
local wezterm = require("wezterm")

-- local colorscheme = "Catppuccin Mocha"
local colorscheme = "Kanagawa Wave"

---@type Palette
local scheme = {}
local cached_scheme = nil

function M.init()
	if not cached_scheme then
		local schema_path = wezterm.config_dir .. "/colors/" .. colorscheme:gsub(" ", "-"):lower() .. ".toml"
		local ok, colors = pcall(wezterm.color.load_scheme, schema_path)
		if ok and colors then
			cached_scheme = colors
		else
			cached_scheme = wezterm.color.get_builtin_schemes()[colorscheme] or {}
		end
	end
	scheme = cached_scheme
end

---@return string
function M.get_scheme_name()
	return colorscheme
end

---@return Palette
function M.get()
	return scheme
end

---@param overrides Palette
function M.override(overrides)
	require("utils").deep_merge(scheme, overrides)
end

return M
