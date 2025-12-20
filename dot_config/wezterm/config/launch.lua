local M = {}

---@type Wezterm
local wezterm = require("wezterm")

local is_windows = wezterm.target_triple:find("windows") ~= nil

---@param config Config
function M.apply(config)
	config.front_end = "WebGpu"
	config.max_fps = 60
	config.animation_fps = 30

	if is_windows then
		config.default_prog = { "nu.exe" }
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
end

return M
