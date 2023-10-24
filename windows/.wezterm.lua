local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

----------------------------
-- WezTerm Configurations --
----------------------------

-- Default shell
config.default_prog = { "powershell" }

-- Behavior
config.initial_cols = 120
config.initial_rows = 30
config.window_close_confirmation = "NeverPrompt"

wezterm.on("format-tab-title", function(tab)
	local pane = tab.active_pane
	local title = pane.title
	if pane.domain_name then
		if pane.domain_name == "local" then
			if (string.find(title, "powershell") ~= nil) or (string.find(title, "pwsh") ~= nil) then
				title = " Powershell "
			elseif string.find(title, "cmd") ~= nil then
				title = " Command Prompt "
			else
				title = " Powershell - " .. title .. " "
			end
		elseif pane.domain_name == "WSL:Ubuntu-22.04" then
			title = " Ubuntu "
		elseif pane.domain_name == "WSL:kali-linux" then
			title = " Kali Linux "
		end
	end
	return title
end)

config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
	"wsl.exe",
	"wslhost.exe",
}

-- Eye candy
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.integrated_title_button_alignment = "Right"
config.integrated_title_button_style = "Windows"
config.show_tab_index_in_tab_bar = false
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 10.0
config.window_padding = {
	left = "12px",
	right = "12px",
	top = "12px",
	bottom = "12px",
}

config.window_background_opacity = 0.8
config.win32_system_backdrop = "Acrylic"

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Bold" }),
	font_size = 10.0,
	active_titlebar_bg = "#2e2e2e",
	inactive_titlebar_bg = "#2e2e2e",
}

config.color_scheme = "nord"
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#2e3440",
			fg_color = "#d8dee9",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "#2e2e2e",
			fg_color = "#808080",
		},

		inactive_tab_hover = {
			bg_color = "#3b3b3b",
			fg_color = "#909090",
			italic = true,
		},

		new_tab = {
			bg_color = "#2e2e2e",
			fg_color = "#808080",
		},

		new_tab_hover = {
			bg_color = "#3b3b3b",
			fg_color = "#909090",
			italic = true,
		},
	},
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

--[[ End of WezTerm Configurations ]]
--

return config
