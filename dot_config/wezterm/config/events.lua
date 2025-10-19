local M = {}

---@type Wezterm
local wezterm = require("wezterm")

---@type Utils.Colors
local colors = require("utils.colors")

local nerdfonts = wezterm.nerdfonts
local LEFT_SEPARATOR = nerdfonts.ple_upper_right_triangle
local RIGHT_SEPARATOR = nerdfonts.ple_upper_left_triangle

function M.setup()
	wezterm.on("format-tab-title", M.update_tab_title)
	wezterm.on("update-status", M.update_window_padding)
	wezterm.on("update-status", M.update_leader_key_status)
	wezterm.on("update-status", M.update_key_table_mode)
end

---@param tab TabInformation
local function tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return title
	end
	return tab.active_pane.title
end

---@param tab TabInformation
-- ---@param tabs TabInformation[]
-- ---@param panes PaneInformation[]
-- ---@param config Config
---@param hover boolean
---@param max_width number
function M.update_tab_title(tab, _, _, _, hover, max_width)
	local pad = 4
	local prefix = (tab.tab_index + 1) .. ": "
	local pane_count = #tab.panes ---@diagnostic disable-line: undefined-field

	local suffix = ""
	if pane_count > 1 then
		suffix = " [" .. pane_count .. "]"
	elseif tab.active_pane.is_zoomed then
		suffix = " [z]"
	end

	local title = tab_title(tab)

	local available = max_width - pad - #prefix - #suffix
	if available > 1 and #title > available then
		title = prefix .. "…" .. title:sub(-available + 1) .. suffix
	else
		title = prefix .. title .. suffix
	end

	local bg
	if tab.is_active then
		bg = colors.get().background
	elseif hover then
		bg = colors.get().tab_bar.inactive_tab_hover.bg_color
	else
		bg = colors.get().tab_bar.inactive_tab.bg_color
	end

	return {
		{ Background = { Color = colors.get().tab_bar.background } },
		{ Foreground = { Color = bg } },
		{ Text = LEFT_SEPARATOR },
		"ResetAttributes",
		{ Text = " " .. title .. " " },
		{ Background = { Color = colors.get().tab_bar.background } },
		{ Foreground = { Color = bg } },
		{ Text = RIGHT_SEPARATOR },
	}
end

---@type CallbackWindowPane
function M.update_window_padding(window, _)
	local tab = window:active_tab()
	local panes = tab:panes()
	local alt_screen_active = false

	for _, pane in ipairs(panes) do
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	local overrides = window:get_config_overrides() or {}
	if alt_screen_active then
		overrides.window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}
	else
		overrides.window_padding = nil
	end

	window:set_config_overrides(overrides)
end

---@type CallbackWindowPane
function M.update_leader_key_status(window, _)
	local leader = ""
	if window:leader_is_active() then
		leader = " "
		leader = wezterm.format({
			{ Foreground = { Color = colors.get().ansi[2] } },
			{ Text = " " .. leader },
		})
	end
	window:set_left_status(leader)
end

---@type CallbackWindowPane
function M.update_key_table_mode(window, _)
	local name = window:active_key_table()
	if name then
		if name == "resize_pane" then
			name = " RESIZE PANE"
		elseif name == "move_tab" then
			name = "󰓩 MOVE TAB"
		end
		name = wezterm.format({
			{ Background = { Color = colors.get().tab_bar.background } },
			{ Foreground = { Color = colors.get().background } },
			{ Text = LEFT_SEPARATOR },
			{ Background = { Color = colors.get().background } },
			{ Foreground = { Color = colors.get().indexed[16] } },
			{ Text = " " .. name .. " " },
			{ Background = { Color = colors.get().tab_bar.background } },
			{ Foreground = { Color = colors.get().background } },
			{ Text = RIGHT_SEPARATOR },
		})
	end
	window:set_right_status(name or "")
end

return M
