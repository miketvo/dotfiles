local wezterm = require('wezterm')
local act = wezterm.action
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

----------------------------
-- WezTerm Configurations --
----------------------------

-- Default shell
config.default_prog = { 'powershell' }

-- Behavior
config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 600
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.initial_cols = 120
config.initial_rows = 30
config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
  'wsl.exe',
  'wslhost.exe',
}

-- Custom tab titles
wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local title = pane.title
  if pane.domain_name then
    if pane.domain_name == 'local' then
      if (string.find(title, 'powershell') ~= nil) or (string.find(title, 'pwsh') ~= nil) then
        title = '󰨊 Powershell'
      elseif string.find(title, 'cmd') ~= nil then
        title = ' Command Prompt'
      end
    elseif pane.domain_name == 'WSL:archlinux' then
      title = '󰣇 Arch Linux'
    elseif pane.domain_name == 'WSL:kali-linux' then
      title = ' Kali Linux'
    elseif pane.domain_name == 'WSL:Debian' then
      title = '󰣚 Debian'
    end
  end
  return string.format(' %-24s ', title)
end)

-- Mode display
local KEY_TABLE_MODE_NAME = {
  ['resize_pane'] = 'Resize',
  ['activate_pane'] = 'Activate Pane'
}
wezterm.on('update-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    mode_name = KEY_TABLE_MODE_NAME[name]
    window:set_right_status(wezterm.format {
      { Attribute = { Underline = 'None' } },
      { Foreground = { Color = '#2e2e2e' } },
      { Background = { Color = '#ff8c00' } },
      { Text = ' ' .. mode_name .. ' ' }
    })
  else
    window:set_right_status('')
  end
end)

-- Eye candy
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
config.integrated_title_button_alignment = 'Right'
config.integrated_title_button_style = 'Windows'
config.show_tab_index_in_tab_bar = false
config.font = wezterm.font('JetBrainsMono Nerd Font Propo', { weight = 'DemiBold' })
config.font_size = 10.0
config.window_padding = {
  left = '12px',
  right = '12px',
  top = '12px',
  bottom = '12px',
}
config.window_background_opacity = 0.75
config.win32_system_backdrop = 'Acrylic'
config.window_frame = {
  font = wezterm.font('JetBrainsMono Nerd Font Propo', { weight = 'Bold' }),
  font_size = 9.0,
  active_titlebar_bg = '#2e2e2e',
  inactive_titlebar_bg = '#2e2e2e',
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}
config.command_palette_bg_color = '#2e2e2e'
config.command_palette_fg_color = '#d3d3d3'
config.command_palette_font_size = 10.0
config.command_palette_rows = 14

-- Default color scheme
config.color_scheme = 'nord'
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#2e3440',
      fg_color = '#d8dee9',
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
      bg_color = '#3b3b3b',
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

-- Dynamic color scheme
wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local domain_name = pane:get_domain_name()
  if domain_name then
    if domain_name == 'local' then
      overrides.color_scheme = 'nord'
      overrides.colors = {
        tab_bar = {
          active_tab = {
            bg_color = '#2e3440',
            fg_color = '#d8dee9',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
          },
        },
      }
    elseif domain_name == 'WSL:archlinux' then  -- Kanagawa Dragon: https://github.com/rebelot/kanagawa.nvim/blob/master/extras/wezterm/kanagawa-dragon.lua
      overrides.force_reverse_video_cursor = true
      overrides.colors = {
        foreground = "#c5c9c5",
		background = "#181616",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = {
			"#0d0c0c",
			"#c4746e",
			"#8a9a7b",
			"#c4b28a",
			"#8ba4b0",
			"#a292a3",
			"#8ea4a2",
			"#c8c093",
		},
		brights = {
			"#a6a69c",
			"#e46876",
			"#87a987",
			"#e6c384",
			"#7fb4ca",
			"#938aa9",
			"#7aa89f",
			"#c5c9c5",
		},

        tab_bar = {
          active_tab = {
            bg_color = '#181616',
            fg_color = '#c5c9c5',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
          },
        },
      }
    elseif domain_name == 'WSL:kali-linux' then
      overrides.color_scheme = 'Gruvbox Material (Gogh)'
      overrides.colors = {
        tab_bar = {
          active_tab = {
            bg_color = '#282828',
            fg_color = '#d8dee9',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
          },
        },
      }
    elseif domain_name == 'WSL:Debian' then
      overrides.color_scheme = 'Calamity'
      overrides.colors = {
        tab_bar = {
          active_tab = {
            bg_color = '#2b2330',
            fg_color = '#d5ced9',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
          },
        },
      }
    end
  end
  window:set_config_overrides(overrides)
end)

-- Keybindings
config.leader = { key = 'Space', mods = 'CTRL|SHIFT' }
config.keys = {

  { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },
  { key = 'F11', action = act.ToggleFullScreen },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowLauncher },
  { key = 't', mods = 'CTRL|SHIFT', action = act.ShowTabNavigator },
  { key = 'x', mods = 'SHIFT|ALT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
  { key = 'x', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  { key = 'LeftArrow', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivateTabRelative(1) },
  {
    key = 'p',
    mods = 'CTRL|SHIFT',
    action = act.ActivateCommandPalette,
  },

  {
    key = '+',
    mods = 'SHIFT|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'SHIFT|ALT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- ALT+R will put us in resize-pane mode until we cancel that mode.
  {
    key = 'r',
    mods = 'SHIFT|ALT',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- ALT+W will put us in activate-pane mode until we press some other
  -- key or until 1 second (1000ms) of time elapses.
  {
    key = 'w',
    mods = 'SHIFT|ALT',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
      timeout_milliseconds = 1000,
    },
  },

}
config.key_tables = {
  -- Resize-pane mode
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Activate-pane mode
  activate_pane = {
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
  },
}

--[[ End of WezTerm Configurations ]]
--

return config
