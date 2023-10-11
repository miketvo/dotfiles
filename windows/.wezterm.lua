local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end


--[[ Configurations ]]--

-- Default shell
config.default_prog = { 'powershell' }

-- Behavior
config.window_close_confirmation = 'NeverPrompt'

-- Eye candy
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
config.integrated_title_button_alignment = 'Right'
config.integrated_title_button_style = 'Windows'
config.show_tab_index_in_tab_bar = false
-- config.window_background_opacity = 0.8
-- config.win32_system_backdrop = 'Acrylic'
config.color_scheme = 'OneHalfDark'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Medium' })
config.font_size = 10.0
config.window_padding = {
  left = '12px',
  right = '12px',
  top = '12px',
  bottom = '12px',
}
config.window_frame = {
  font = wezterm.font { family = 'JetBrainsMono Nerd Font Mono', weight = 'Bold' },
  font_size = 10.0,
  active_titlebar_bg = '#2e2e2e',
  inactive_titlebar_bg = '#2e2e2e',
}
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#282c34',
      fg_color = '#dcdfe4',
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = '#2e2e2e',
      fg_color = '#808080',
    },

    inactive_tab_hover = {
      bg_color = '#313640',
      fg_color = '#909090',
      italic = true,

    },

    new_tab = {
      bg_color = '#2e2e2e',
      fg_color = '#808080',
    },

    new_tab_hover = {
      bg_color = '#3b3b3b',
      fg_color = '#909090',
      italic = true,
    },
  },
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

--[[ =============================]] --


return config
