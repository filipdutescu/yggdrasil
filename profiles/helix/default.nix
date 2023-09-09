{
  programs.helix = {
    enable = true;

    settings = import ./config.nix;

    themes.springan = import ./themes/springan.nix;
  };
}
