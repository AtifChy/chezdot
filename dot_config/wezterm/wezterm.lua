---@type Wezterm
local wezterm = require("wezterm")

---@class Config
local config = wezterm.config_builder and wezterm.config_builder() or {}

---@type Utils.Colors
local colors = require("utils.colors")
colors.init()

require("config.launch").apply(config)
require("config.appearance").apply(config)
require("config.fonts").apply(config)
require("config.keys").apply(config)

require("config.events").setup()

return config
