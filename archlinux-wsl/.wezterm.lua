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
config.default_prog = { 'zsh' }

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
  local tab_size = 24
  local pane = tab.active_pane
  local title = pane.title
  local process_names_map = {
    ['bash'] = 'Terminal',
    ['sh'] = 'Terminal',
    ['zsh'] = 'Terminal',
    ['fish'] = 'Terminal',
    ['tmux'] = 'Terminal',
    ['nu'] = 'Terminal',
    ['cmd.exe'] = 'Terminal',
    ['pwsh.exe'] = 'Terminal',
    ['powershell.exe'] = 'Terminal',
    ['wsl.exe'] = 'Terminal',
    ['wslhost.exe'] = 'Terminal',
    ['wezterm'] = 'Terminal',
    ['nvim'] = 'Neovim',
  }
  for key, value in pairs(process_names_map) do
    if title == key then
      title = value
      break
    end
  end
  title = title:gsub('^%l', string.upper)
  return string.format(' %-' .. tab_size .. 's ', title)
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
      { Foreground = { Color = '#181616' } },
      { Background = { Color = '#e6c384' } },
      { Text = ' ' .. mode_name .. ' ' }
    })
  else
    window:set_right_status('')
  end
end)

-- Eye candy
config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = false
config.font = wezterm.font('JetBrainsMono Nerd Font Propo', { weight = 'DemiBold' })
config.font_size = 10.0
config.window_padding = {
  left = '12px',
  right = '12px',
  top = '12px',
  bottom = '12px',
}
config.window_background_opacity = 0.9
config.window_frame = {
  font = wezterm.font('JetBrainsMono Nerd Font Propo', { weight = 'Bold' }),
  font_size = 9.0,
  active_titlebar_bg = '#181616',
  active_titlebar_fg = '#c5c9c5',
  inactive_titlebar_bg = '#181616',
  inactive_titlebar_fg = '#c5c9c5',
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_top_height = 0,
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}
config.command_palette_bg_color = '#181616'
config.command_palette_fg_color = '#dcd7ba'
config.command_palette_font_size = 10.0
config.command_palette_rows = 14

-- Color scheme: Kanagawa Dragon (UI) + Kanagawa Wave (Content)
config.color_scheme = 'Kanagawa Dragon (Gogh)'
config.colors = {
  foreground = "#dcd7ba",
  background = "#1f1f28",

  cursor_bg = "#c8c093",
  cursor_fg = "#c8c093",
  cursor_border = "#c8c093",

  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",

  scrollbar_thumb = "#16161d",
  split = "#16161d",

  ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
  brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

  tab_bar = {
    background = '#181616',

    active_tab = {
      bg_color = '#1f1f28',
      fg_color = '#dcd7ba',
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = '#1f1c1c',
      fg_color = '#605c5c',
    },

    inactive_tab_hover = {
      bg_color = '#141313',
      fg_color = '#dcd7ba',
      italic = true,
    },

    new_tab = {
      bg_color = '#1f1c1c',
      fg_color = '#605c5c',
    },

    new_tab_hover = {
      bg_color = '#141313',
      fg_color = '#dcd7ba',
      italic = true,
    },
  },
}

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

  -- Uncomment this to enable manual configuration hot-reloading using
  -- CTRL+SHIFT+ALT+R.
  -- {
  --   key = 'r',
  --   mods = 'CTRL|SHIFT|ALT',
  --   action = act.ReloadConfiguration,
  -- },
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
