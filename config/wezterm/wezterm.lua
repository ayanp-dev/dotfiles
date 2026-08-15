-- wezterm.lua

-- Pull in the WezTerm API
local wezterm = require 'wezterm'

-- This object will hold all of your configuration settings
local config = wezterm.config_builder()

-- ==========================================
-- Appearance & Fonts
-- ==========================================
config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.0

-- ==========================================
-- Window Decor & Transparency
-- ==========================================
-- 0.0 is fully transparent, 1.0 is opaque
config.window_background_opacity = 0.8

-- Completely removes the title bar and all window control buttons
config.window_decorations = "NONE"

-- ==========================================
-- Tab Bar
-- ==========================================
-- Hides the tab bar when there is only a single tab active
config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to WezTerm
return config
