---@type Wezterm
local wezterm = require("wezterm")

---@class Config
local config = wezterm.config_builder and wezterm.config_builder() or {}

local target = wezterm.target_triple
if target:match("windows") then
	config.default_prog = { "nu.exe" }
	-- config.default_domain = "WSL:archlinux"
	config.launch_menu = {
		{
			label = "Command Prompt",
			args = { "cmd.exe", "/K" },
			domain = { DomainName = "local" },
		},
		{
			label = "PowerShell 7",
			args = { "pwsh.exe", "-NoLogo" },
			domain = { DomainName = "local" },
		},
		{
			label = "NuShell",
			args = { "nu.exe" },
			domain = { DomainName = "local" },
		},
		{
			label = "xonsh",
			args = { "xonsh.exe" },
			domain = { DomainName = "local" },
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

config.initial_rows = 38
config.initial_cols = 112

config.window_padding = {
	left = 5,
	right = 5,
	top = 0,
	bottom = 0,
}

config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}

config.use_resize_increments = true

config.color_schemes = {
	["Catppuccin Macchiato"] = require("colors.catppuccin-macchiato"),
}

-- config.color_scheme = "OneDark (base16)"
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Catppuccin Macchiato"

local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
local crust = scheme.tab_bar.background
local mantle = scheme.tab_bar.inactive_tab.bg_color

config.colors = {
	selection_fg = "none",
	selection_bg = "rgba(255, 255, 255, 0.2)",
}

config.command_palette_bg_color = scheme.visual_bell
config.command_palette_fg_color = scheme.foreground
config.command_palette_font_size = 13.0
config.command_palette_rows = 14

config.window_frame = {
	active_titlebar_bg = mantle,
	active_titlebar_fg = scheme.foreground,
	inactive_titlebar_bg = crust,
	inactive_titlebar_fg = scheme.foreground,
}

config.colors.tab_bar = {
	background = "none",

	active_tab = {
		bg_color = scheme.background,
		fg_color = scheme.ansi[5],
		intensity = "Bold",
	},

	inactive_tab = {
		bg_color = mantle,
		fg_color = scheme.brights[1],
	},
	inactive_tab_hover = {
		bg_color = scheme.background,
		fg_color = scheme.ansi[8],
	},

	new_tab = {
		bg_color = scheme.background,
		fg_color = scheme.brights[1],
	},
	new_tab_hover = {
		bg_color = scheme.ansi[1],
		fg_color = scheme.ansi[5],
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

config.font_size = 11
config.font = wezterm.font_with_fallback({
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
config.animation_fps = 5

config.cursor_thickness = 1
config.underline_position = -2
-- config.underline_thickness = 1
config.strikethrough_position = "0.6cell"

-- config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.keys = {
	{
		key = "q",
		mods = "SHIFT|CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "w",
		mods = "ALT|CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "s",
		mods = "ALT|CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "ALT|CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- workaround for neovim ctrl+space keybinding
	{
		key = " ",
		mods = "CTRL",
		action = wezterm.action.SendKey({
			key = " ",
			mods = "CTRL",
		}),
	},
}

return config

-- local colors = {
-- 	background = "#1e222a",
-- 	foreground = "#d7dae0",
--
-- 	tab_background = "#282c34",
-- 	hover_foreground = "#abb2bf",
--
-- 	black = "#3f4451",
-- 	red = "#e06c75",
-- 	green = "#98c379",
-- 	yellow = "#d19a66",
-- 	blue = "#61afef",
-- 	magenta = "#c678dd",
-- 	cyan = "#56b6c2",
-- 	white = "#d7dae0",
--
-- 	bright_black = "#5a6374",
-- 	bright_red = "#ff7a7c",
-- 	bright_green = "#a5e075",
-- 	bright_yellow = "#e5c07b",
-- 	bright_blue = "#4dc4ff",
-- 	bright_magenta = "#de73ff",
-- 	bright_cyan = "#4cd1e0",
-- 	bright_white = "#e6e6e6",
-- }
