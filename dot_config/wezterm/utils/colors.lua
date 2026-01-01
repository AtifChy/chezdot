---@class Utils.Colors
local M = {}

---@type Wezterm
local wezterm = require("wezterm")

local color_scheme = "Catppuccin Macchiato"

---@type Palette
local scheme = {}
local cached_scheme = nil

function M.init()
	if not cached_scheme then
		cached_scheme = wezterm.color.get_builtin_schemes()[color_scheme] or {}
	end
	scheme = cached_scheme
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
