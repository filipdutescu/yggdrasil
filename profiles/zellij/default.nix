{
  programs.zellij = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      keybinds = {
        unbind = {
          _args = ["Ctrl o"];
        };

        session = {
          bind = {
            _args = ["Ctrl e"];
            SwitchToMode = "Normal";
          };
        };

        shared_except = {
          _args = ["session" "locked"];
          bind = {
            _args = ["Ctrl e"];
            SwitchToMode = "Session";
          };
        };
      };

      theme = "springan";
      themes.springan = import ./themes/springan.nix;
    };
  };
}
