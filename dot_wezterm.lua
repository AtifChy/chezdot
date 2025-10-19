---@type Wezterm
local wezterm = require("wezterm")

---@class Config
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.front_end = "WebGpu"
config.max_fps = 165
config.animation_fps = 165

local target = wezterm.target_triple
if target:match("windows") then
	config.default_prog = { "nu.exe" }
	-- config.default_domain = "WSL:archlinux"
	config.launch_menu = {
		{
			label = "Command Prompt",
			args = { "cmd.exe", "/K" },
		},
		{
			label = "PowerShell 7",
			args = { "pwsh.exe", "-NoLogo" },
		},
		{
			label = "NuShell",
			args = { "nu.exe" },
		},
		{
			label = "xonsh",
			args = { "xonsh.exe" },
		},
	}
end

-- config.window_close_confirmation = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"nu.exe",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
	"wsl.exe",
	"wslhost.exe",
	"conhost.exe",
}

if target:match("windows") then
	config.window_decorations = "RESIZE"
end

-- config.initial_rows = 38
-- config.initial_cols = 112

config.window_padding = {
	left = 10,
	right = 10,
	top = 5,
	bottom = 5,
}

-- Dynamically adjust padding based on alt screen status
wezterm.on("update-status", function(window, _)
	local tab = window:active_tab()
	local panes = tab:panes()
	local alt_screen_active = false

	for _, pane in ipairs(panes) do
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	local overrides = {}
	if alt_screen_active then
		overrides = {
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
		}
	else
		overrides = {
			window_padding = config.window_padding,
		}
	end
	window:set_config_overrides(overrides)
end)

config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}

config.use_resize_increments = true

-- config.color_scheme = "OneDark (base16)"
config.color_scheme = "Catppuccin Macchiato"

---@type Palette
local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
-- local crust = scheme.tab_bar.inactive_tab.bg_color
-- local mantle = scheme.tab_bar.background

config.colors = {
	selection_fg = "none",
	selection_bg = "rgba(255, 255, 255, 0.2)",
}

config.command_palette_bg_color = scheme.visual_bell
config.command_palette_fg_color = scheme.foreground
config.command_palette_font_size = 13.0
config.command_palette_rows = 14

-- config.window_frame = {
-- 	active_titlebar_bg = crust,
-- 	active_titlebar_fg = scheme.foreground,
-- 	inactive_titlebar_bg = mantle,
-- 	inactive_titlebar_fg = scheme.foreground,
-- }

config.colors.tab_bar = {
	new_tab = {
		bg_color = scheme.tab_bar.background,
		fg_color = scheme.tab_bar.new_tab.fg_color,
	},
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.force_reverse_video_cursor = true

-- if target:match("windows") then
-- 	config.window_background_opacity = 0
-- 	config.win32_system_backdrop = "Mica"
-- end

config.font_size = 10
config.font = wezterm.font_with_fallback({
	-- {
	-- 	family = "Monaspace Neon",
	-- 	weight = "DemiBold",
	-- 	harfbuzz_features = {
	-- 		"calt",
	-- 		"ss01",
	-- 		"ss02",
	-- 		"ss03",
	-- 		"ss04",
	-- 		"ss05",
	-- 		"ss06",
	-- 		"ss07",
	-- 		"ss08",
	-- 		"ss09",
	-- 		"ss10",
	-- 		"liga",
	-- 	},
	-- },
	-- {
	-- 	family = "Fira Code",
	-- 	weight = "Medium",
	-- },
	{
		family = "Operator Mono SSm Lig",
		weight = "Medium",
	},
	{
		family = "Symbols Nerd Font Mono",
		scale = 0.85,
	},
	"JetBrains Mono",
	"Segoe UI Symbol",
	"Segoe UI Emoji",
})
config.font_rules = {
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font("Operator Mono SSm Lig", {
			weight = "Medium",
			foreground = scheme.brights[1],
		}),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font("Operator Mono SSm Lig", {
			weight = "Medium",
			style = "Italic",
			foreground = scheme.brights[1],
		}),
	},
}

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 500

config.line_height = 1.2
-- config.dpi = 144.0

config.cursor_thickness = 1
config.underline_position = -4
-- config.underline_thickness = 1
config.strikethrough_position = "0.55cell"

-- config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 34

---@param tab TabInformation
local function tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return title
	end
	return tab.active_pane.title
end

local LEFT_SEPARATOR = wezterm.nerdfonts.ple_upper_right_triangle
local RIGHT_SEPARATOR = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
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

	local fg, bg
	if tab.is_active then
		fg = scheme.tab_bar.active_tab.bg_color
		bg = scheme.background
	elseif hover then
		fg = scheme.tab_bar.inactive_tab_hover.fg_color
		bg = scheme.visual_bell
	else
		fg = scheme.split
		bg = scheme.tab_bar.inactive_tab.bg_color
	end

	return {
		{ Background = { Color = scheme.tab_bar.background } },
		{ Foreground = { Color = bg } },
		{ Text = LEFT_SEPARATOR },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = scheme.tab_bar.background } },
		{ Foreground = { Color = bg } },
		{ Text = RIGHT_SEPARATOR },
	}
end)

wezterm.on("update-status", function(window, _)
	local leader = ""
	if window:leader_is_active() then
		leader = " "
		leader = wezterm.format({
			{ Foreground = { Color = scheme.indexed[16] } },
			{ Text = " " .. leader },
		})
	end
	window:set_left_status(leader)
end)

local act = wezterm.action
config.leader = { key = "Space", mods = "CTRL|SHIFT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "c", mods = "LEADER", action = act.RotatePanes("Clockwise") },

	{ key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

	{ key = "p", mods = "LEADER", action = act.PasteFrom("Clipboard") },
	{ key = "y", mods = "LEADER", action = act.CopyTo("Clipboard") },

	{ key = "f", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },

	-- Regular keymaps
	{ key = "q", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = false }) },
	{ key = "w", mods = "ALT|CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "s", mods = "ALT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Workaround for neovim ctrl+space keybinding
	{ key = " ", mods = "CTRL", action = act.SendKey({ key = " ", mods = "CTRL" }) },
	{ key = ".", mods = "CTRL", action = act.SendKey({ key = ".", mods = "CTRL" }) },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "LeftArrow", action = act.MoveTabRelative(-1) },
		{ key = "RightArrow", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

wezterm.on("update-status", function(window, _)
	local name = window:active_key_table()
	if name then
		if name == "resize_pane" then
			name = " RESIZE PANE"
		elseif name == "move_tab" then
			name = "󰓩 MOVE TAB"
		end

		name = wezterm.format({
			{ Background = { Color = scheme.tab_bar.background } },
			{ Foreground = { Color = scheme.background } },
			{ Text = LEFT_SEPARATOR },
			{ Background = { Color = scheme.background } },
			{ Foreground = { Color = scheme.indexed[16] } },
			{ Text = " " .. name .. " " },
			{ Background = { Color = scheme.tab_bar.background } },
			{ Foreground = { Color = scheme.background } },
			{ Text = RIGHT_SEPARATOR },
		})
	end
	window:set_right_status(name or "")
end)

return config
