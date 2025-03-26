-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.color_scheme = "Catppuccin Macchiato"
--config.color_scheme = 'Tangoesque (terminal.sexy)'
config.color_scheme = 'GruvboxDarkHard'

config.font_size = 9
config.font = wezterm.font 'Fira Code'
--config.font = wezterm.font ('Fira Code',{ weight= 'DemiBold'})
config.window_decorations = "RESIZE"
config.default_cursor_style = 'SteadyBar'

-- Make inactive panes darker
config.inactive_pane_hsb = {
  saturation = 0.8, -- Adjust to your liking
  brightness = 0.4, -- Darker inactive panes
  hue = 1.0,
}

-- tmux
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    mods = "ALT",
    key = "[",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "ALT",
    key = "]",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "ALT",
    key = "r",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    mods = "ALT",
    key = "e",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    mods = "ALT",
    key = "LeftArrow",
    action = wezterm.action.ActivatePaneDirection "Next"
  },
  {
    mods = "ALT",
    key = "DownArrow",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "ALT",
    key = "UpArrow",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "ALT",
    key = "RightArrow",
    action = wezterm.action.ActivatePaneDirection "Prev"
  },
  {
    mods = "ALT",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Prev"
  },
  {
    mods = "ALT",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "ALT",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "ALT",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Next"
  },
  {
    mods = "ALT",
    key = "s",
    action = wezterm.action.ActivatePaneDirection "Next"
  },
  {
    mods = "ALT",
    key = "a",
    action = wezterm.action.ActivatePaneDirection "Prev"
  },

  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
  {
    mods = "LEADER",
    key = "w",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },

}

for i = 1, 9 do
  -- alt + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

for i = 1, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- tmux status
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a) -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW }
  })
end)

-- and finally, return the configuration to wezterm
return config
