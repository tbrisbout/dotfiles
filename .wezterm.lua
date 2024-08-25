local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Nightfly (Gogh)'

config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 16.0

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.9
config.window_frame = {
  -- font_size = 10.0,
  inactive_titlebar_bg = '#192330',
  active_titlebar_bg = '#ffffff',
}

config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 0,
}

config.enable_scroll_bar = true

local a = wezterm.action

config.leader = { key = "Space", mods = "CTRL", timeout = "300ms"  }
config.keys = {
  {
    key = 'n',
    mods = 'LEADER',
    action = a.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = a.ActivateTabRelative(-1),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = a.ActivateTabRelative(1),
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = a.TogglePaneZoomState,
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = a.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = a.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = a.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = a.ActivatePaneDirection 'Down',
  },
  {
    key = '|',
    mods = 'LEADER',
    action = a.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '=',
    mods = 'LEADER',
    action = a.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = a.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}

return config
