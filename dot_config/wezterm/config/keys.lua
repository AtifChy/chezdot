local M = {}

---@type Wezterm
local wezterm = require("wezterm")
local action = wezterm.action

---@param config Config
function M.apply(config)
	config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }
	config.keys = M.get_keys()
	config.key_tables = M.get_key_tables()
end

function M.get_keys()
	---@type Key[]
	local keys = {
		{ key = "|", mods = "LEADER|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
		{ key = "LeftArrow", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
		{ key = "DownArrow", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
		{ key = "UpArrow", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
		{ key = "RightArrow", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
		{ key = "r", mods = "LEADER", action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

		{ key = "q", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
		{ key = "z", mods = "LEADER", action = action.TogglePaneZoomState },
		{ key = "c", mods = "LEADER", action = action.RotatePanes("Clockwise") },

		{ key = "n", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
		{ key = "t", mods = "LEADER", action = action.ShowTabNavigator },
		{ key = "w", mods = "LEADER", action = action.CloseCurrentTab({ confirm = true }) },
		{ key = "[", mods = "LEADER", action = action.ActivateTabRelative(-1) },
		{ key = "]", mods = "LEADER", action = action.ActivateTabRelative(1) },
		{ key = "m", mods = "LEADER", action = action.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

		{ key = "p", mods = "LEADER", action = action.PasteFrom("Clipboard") },
		{ key = "y", mods = "LEADER", action = action.CopyTo("Clipboard") },

		{ key = "f", mods = "LEADER", action = action.Search({ CaseSensitiveString = "" }) },

		-- Regular keymaps
		{ key = "q", mods = "SHIFT|CTRL", action = action.CloseCurrentTab({ confirm = false }) },
		{ key = "w", mods = "ALT|CTRL", action = action.CloseCurrentPane({ confirm = false }) },
		{ key = "s", mods = "ALT|CTRL", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "ALT|CTRL", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Workaround for neovim ctrl+space keybinding
		{ key = "Space", mods = "CTRL", action = action.SendKey({ key = "Space", mods = "CTRL" }) },
		{ key = ".", mods = "CTRL", action = action.SendKey({ key = ".", mods = "CTRL" }) },
	}

	for i = 1, 9 do
		table.insert(keys, {
			key = tostring(i),
			mods = "LEADER",
			action = action.ActivateTab(i - 1),
		})
	end

	return keys
end

function M.get_key_tables()
	---@type table<string, Key[]>
	return {
		resize_pane = {
			{ key = "h", action = action.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j", action = action.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k", action = action.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l", action = action.AdjustPaneSize({ "Right", 1 }) },
			{ key = "LeftArrow", action = action.AdjustPaneSize({ "Left", 1 }) },
			{ key = "DownArrow", action = action.AdjustPaneSize({ "Down", 1 }) },
			{ key = "UpArrow", action = action.AdjustPaneSize({ "Up", 1 }) },
			{ key = "RightArrow", action = action.AdjustPaneSize({ "Right", 1 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
		move_tab = {
			{ key = "h", action = action.MoveTabRelative(-1) },
			{ key = "l", action = action.MoveTabRelative(1) },
			{ key = "LeftArrow", action = action.MoveTabRelative(-1) },
			{ key = "RightArrow", action = action.MoveTabRelative(1) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}
end

return M
