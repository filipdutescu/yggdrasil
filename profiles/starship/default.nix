let
  modules = import ./modules.nix;
  palette = import ./palette.nix;
  prompt = import ./prompt.nix;
in {
  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      add_newline = false;

      scan_timeout = 10;

      nix_shell.heuristic = true;
      username.format = "[$user]($style) ";
    }
    // modules
    // palette
    // prompt;
  };
}
