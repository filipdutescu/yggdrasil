{
  theme = "springan";

  editor = {
    line-number = "relative";
    scrolloff = 8;
    mouse = false;
    cursorline = true;
    cursorcolumn = true;
    color-modes = true;
    bufferline = "always";
    auto-save = true;

    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "block";
    };

    statusline = {
      left = ["mode" "spacer" "spinner" "spacer" "version-control"];
      center = ["file-name"];
      right = ["workspace-diagnostics" "file-type" "selections" "position" "file-encoding"];
      separator = "│";
    };

    lsp = {
      display-messages = true;
      display-inlay-hints = true;
    };

    whitespace = {
      render = {
        space = "none";
        tab = "none";
        newline = "all";
      };

      characters = {
        newline = "󱞥";
      };
    };

    indent-guides = {
      render = true;
      character = "│";
    };
  };

  keys = {
    normal = {
      X = "extend_line_above";
    };
  };
}
