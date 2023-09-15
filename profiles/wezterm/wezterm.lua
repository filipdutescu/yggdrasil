local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false;
config.enable_wayland = true;
config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.window_close_confirmation = 'NeverPrompt';

local black = "#1e1f21"
local red = "#c16a6d"
local green = "#8ab97b"
local yellow = "#c9c76b"
local blue = "#7b82b9"
local purple = "#b17aba"
local cyan = "#7bb0b9"
local gray = "#565e61"
local light_gray = "#e7e5df"
local light_red = "#c97e80"
local light_green = "#a1c794"
local light_yellow = "#d3d175"
local light_blue = "#949ac7"
local light_purple = "#c193c8"
local light_cyan = "#94bfc7"
local white = "#d3d0cb"

config.colors = {
  background = black,
  foreground = white,

  cursor_bg = white,
  cursor_border = white,
  cursor_fg = black,

  ansi = { black, red, green, yellow, blue, purple, cyan, white },

  brights = { gray, light_red, light_green, light_yellow, light_blue, light_purple, light_cyan, light_gray },
}

return config
