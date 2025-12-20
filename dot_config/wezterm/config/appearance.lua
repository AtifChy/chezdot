local M = {}

---@type Utils.Colors
local colors = require("utils.colors")

---@param config Config
function M.apply(config)
	local colors_cache = colors.get()
	
	-- Window appearance
	config.initial_rows = 38
	config.initial_cols = 112
	config.window_decorations = "RESIZE"
	config.window_padding = { left = 10, right = 10, top = 5, bottom = 5 }
	config.window_content_alignment = { horizontal = "Center", vertical = "Center" }
	config.use_resize_increments = true

	-- Pane appearance
	config.inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	}

	-- Cursor appearance
	config.cursor_thickness = 1
	config.underline_position = -4
	-- config.underline_thickness = 1
	config.strikethrough_position = "0.55cell"
	config.force_reverse_video_cursor = true
	config.default_cursor_style = "BlinkingBar"
	config.cursor_blink_ease_in = "Constant"
	config.cursor_blink_ease_out = "Constant"
	config.cursor_blink_rate = 500

	-- Tab bar appearance
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	-- config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 34

	-- Colors
	colors.override({
		selection_fg = "none",
		selection_bg = require("utils").hex_to_rgba(colors_cache.selection_bg, 0.3),
	})

	if colors.get_scheme_name() == "Catppuccin Macchiato" then
		colors.override({
			tab_bar = {
				active_tab = {
					fg_color = colors_cache.tab_bar.active_tab.bg_color,
					bg_color = colors_cache.background,
				},
				inactive_tab = {
					fg_color = colors_cache.split,
				},
				new_tab = {
					fg_color = colors_cache.split,
					bg_color = colors_cache.tab_bar.background,
				},
				new_tab_hover = {
					fg_color = colors_cache.tab_bar.inactive_tab.fg_color,
					bg_color = colors_cache.tab_bar.inactive_tab.bg_color,
				},
			},
		})
	end

	config.command_palette_fg_color = colors_cache.foreground
	config.command_palette_bg_color = colors_cache.visual_bell
	config.command_palette_rows = 15

	config.colors = colors_cache
end

return M
