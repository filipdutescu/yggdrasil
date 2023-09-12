local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false;
config.enable_wayland = true;
config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.window_close_confirmation = 'NeverPrompt';

return config
