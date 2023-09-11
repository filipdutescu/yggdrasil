{
  programs.zellij = {
    enable = true;

    enableZshIntegration = true;
    defaultKeymap = "vicmd";

    settings = {
      keybinds = {
        session = {
          bind = {
            _args = [ "Ctrl o" ];
            SwitchToMode = "Normal";
          };
        };

        shared_except = {
          _args = [ "session" "locked" ];
          bind = {
            _args = [ "Ctrl e" ];
            SwitchToMode = "Session";
          };
        };
      };

      theme = "springan";
      themes.springan = import ./themes/springan.nix;
    };
  };
}
