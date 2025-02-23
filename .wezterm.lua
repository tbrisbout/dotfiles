local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.9
config.window_padding = { left = 15, right = 15, top = 15, bottom = 0 }
config.enable_scroll_bar = true

config.color_scheme = 'Nightfly (Gogh)'

config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 16.0

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    background = "transparent",
    active_tab = { bg_color = "#011627", fg_color = "#fafafa", intensity = "Bold" },
    inactive_tab = { bg_color = "transparent", fg_color = "#c0c0c0", intensity = "Half" },
    inactive_tab_hover = { bg_color = "transparent", fg_color = "#ffffff", intensity = "Bold" },
    new_tab = { bg_color = "transparent", fg_color = '#808080' },
    new_tab_hover = { bg_color = "transparent", fg_color = '#ffffff', intensity = "Bold" }
  }
}

local a = wezterm.action

config.leader = { key = "Space", mods = "CTRL", timeout = "200ms"  }
config.keys = {
  { key = 'n', mods = 'LEADER', action = a.SpawnTab 'CurrentPaneDomain' },
  { key = 'h', mods = 'LEADER', action = a.ActivateTabRelative(-1) },
  { key = 'l', mods = 'LEADER', action = a.ActivateTabRelative(1) },
  { key = 'm', mods = 'LEADER', action = a.TogglePaneZoomState },

  { key = 'h', mods = 'CTRL|SHIFT', action = a.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = a.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = a.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = a.ActivatePaneDirection 'Down' },

  { key = '|', mods = 'LEADER', action = a.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '=', mods = 'LEADER', action = a.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = a.SplitVertical { domain = 'CurrentPaneDomain' } },
}

return config
