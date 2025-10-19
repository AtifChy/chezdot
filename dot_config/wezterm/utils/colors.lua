---@class Utils.Colors
local M = {}

---@type Wezterm
local wezterm = require("wezterm")

local color_scheme = "Catppuccin Macchiato"

---@type Palette
local scheme = {}

function M.init()
	local s = wezterm.get_builtin_color_schemes()[color_scheme]
	if s then
		scheme = s
	end
end

---@return string
function M.get_scheme_name()
	return color_scheme
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
