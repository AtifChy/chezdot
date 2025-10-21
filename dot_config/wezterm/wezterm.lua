---@type Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Initialize color manager
require("utils.colors").init()

-- Apply configurations
require("config.launch").apply(config)
require("config.appearance").apply(config)
require("config.fonts").apply(config)
require("config.keys").apply(config)

-- Setup event handlers
require("config.events").setup()

return config
