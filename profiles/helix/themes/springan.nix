let
  # normal colours
  black = "#1e1f21";
  red = "#c16a6d";
  green = "#8ab97b";
  yellow = "#c9c76b";
  blue = "#7b82b9";
  magenta = "#b17aba";
  cyan = "#7bb0b9";
  gray = "#303436";
  white = "#d3d0cb";

  # light colours
  light-gray = "#e7e5df";
  light-red = "#c97e80";
  light-green = "#a1c794";
  light-yellow = "#d3d175";
  light-blue = "#949ac7";
  light-magenta = "#c193c8";
  light-cyan = "#94bfc7";

  # dark colours
  dark-yellow = "#4B4A1B";
in {
  "attribute" = {fg = light-cyan;};
  "comment" = {
    fg = light-gray;
    modifiers = ["dim" "italic"];
  };
  "constant" = {
    fg = light-blue;
    modifiers = ["bold"];
  };
  "constant.builtin" = {
    fg = light-blue;
    modifiers = ["bold"];
  };
  "constant.character.escape" = {
    fg = red;
    modifiers = ["bold"];
  };
  "constant.numeric" = {fg = green;};
  "constructor" = {
    fg = blue;
    modifiers = ["bold"];
  };
  "function" = {
    fg = blue;
    modifiers = ["bold"];
  };
  "function.macro" = {
    fg = magenta;
    modifiers = ["underlined"];
  };
  "function.builtin" = {fg = blue;};
  "keyword" = {fg = light-red;};
  "keyword.directive" = {fg = red;};
  "label" = {fg = light-cyan;};
  "module" = {fg = light-cyan;};
  "namespace" = {fg = light-cyan;};
  "operator" = {
    fg = cyan;
    modifiers = ["bold"];
  };
  "punctuation" = {fg = white;};
  "punctuation.delimiter" = {fg = white;};
  "special" = {fg = blue;};
  "string" = {fg = yellow;};
  "type" = {fg = light-magenta;};
  "type.builtin" = {fg = light-magenta;};
  "variable.builtin" = {fg = yellow;};
  "variable.parameter" = {fg = green;};
  "variable.other.member" = {fg = green;};

  # markdown;
  "markup.heading" = {
    fg = red;
    modifiers = ["bold"];
  };
  "markup.raw.inline" = {fg = green;};
  "markup.raw.block" = {modifiers = ["italic"];};
  "markup.bold" = {
    fg = yellow;
    modifiers = ["bold"];
  };
  "markup.italic" = {
    fg = magenta;
    modifiers = ["italic"];
  };
  "markup.list" = {
    fg = light-red;
    modifiers = ["bold"];
  };
  "markup.quote" = {fg = yellow;};
  "markup.link.url" = {
    fg = blue;
    modifiers = ["underlined"];
  };
  "markup.link.text" = {fg = cyan;};

  # editor;
  "ui.background" = {bg = black;};
  "ui.background.separator" = {fg = light-red;};
  "ui.cursor" = {
    fg = black;
    bg = white;
    modifiers = ["bold"];
  };
  "ui.cursor.primary" = {
    fg = black;
    bg = white;
    modifiers = ["bold"];
  };
  "ui.cursor.match" = {
    fg = black;
    bg = white;
    modifiers = ["bold"];
  };
  "ui.cursorline.primary" = {bg = gray;};
  "ui.debug.active" = {fg = yellow;};
  "ui.debug.breakpoint" = {fg = red;};
  "ui.highlight" = {bg = gray;};
  "ui.highlight.frameline" = {bg = dark-yellow;};
  "ui.linenr" = {
    fg = green;
    modifiers = ["dim"];
  };
  "ui.linenr.selected" = {
    fg = light-green;
    modifiers = ["bold"];
  };
  "ui.selection" = {
    fg = black;
    bg = light-magenta;
    modifiers = ["bold"];
  };
  "ui.selection.primary" = {
    fg = black;
    bg = magenta;
    modifiers = ["bold"];
  };
  "ui.text" = {fg = "white";};
  "ui.virtual.whitespace" = {fg = light-magenta;};
  "ui.virtual.indent-guide" = {
    fg = light-magenta;
    modifiers = ["dim"];
  };
  "ui.virtual.inlay-hint" = {
    fg = white;
    modifiers = ["dim"];
  };
  "ui.virtual.ruler" = {
    fg = light-magenta;
    modifiers = ["dim"];
  };

  # statusline;
  "ui.statusline" = {
    fg = light-green;
    bg = black;
  };
  "ui.statusline.inactive" = {
    fg = light-green;
    bg = black;
    modifiers = ["dim"];
  };
  "ui.statusline.insert" = {
    fg = black;
    bg = yellow;
    modifiers = ["bold"];
  };
  "ui.statusline.normal" = {
    fg = black;
    bg = green;
    modifiers = ["bold"];
  };
  "ui.statusline.select" = {
    fg = black;
    bg = magenta;
    modifiers = ["bold"];
  };
  "ui.statusline.debug" = {
    fg = black;
    bg = red;
    modifiers = ["bold"];
  };

  # popups; menus; dialogs;
  "ui.help" = {
    fg = cyan;
    bg = black;
  };
  "ui.menu" = {
    fg = white;
    bg = black;
  };
  "ui.menu.selected" = {
    fg = green;
    modifiers = ["bold"];
  };
  "ui.menu.scroll" = {
    fg = blue;
    bg = gray;
  };
  "ui.popup" = {
    fg = cyan;
    bg = black;
  };
  "ui.window" = {
    fg = cyan;
    bg = black;
  };

  # diagnostics;
  "diagnostic.error" = {
    underline = {
      color = red;
      style = "curl";
    };
  };
  "diagnostic.hint" = {
    underline = {
      color = white;
      style = "curl";
    };
  };
  "diagnostic.info" = {
    underline = {
      color = cyan;
      style = "curl";
    };
  };
  "diagnostic.warning" = {
    underline = {
      color = light-yellow;
      style = "curl";
    };
  };

  error = red;
  hint = {
    fg = white;
    modifiers = ["dim"];
  };
  info = cyan;
  warning = light-yellow;

  # git;
  "diff.delta" = {fg = yellow;};
  "diff.minus" = {fg = light-red;};
  "diff.plus" = {fg = light-green;};
}
