local M = {}

---@type Wezterm
local wezterm = require("wezterm")
---@type Utils.Colors
local colors = require("utils.colors")

---@param config Config
function M.apply(config)
	config.font_size = 10
	config.line_height = 1.2

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
				foreground = colors.get().brights[1],
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font("Operator Mono SSm Lig", {
				weight = "Medium",
				style = "Italic",
				foreground = colors.get().brights[1],
			}),
		},
	}

	config.command_palette_font_size = 14
end

return M
