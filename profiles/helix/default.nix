{
  programs.helix = {
    enable = true;

    defaultEditor = true;

    settings = import ./config.nix;

    themes.springan = import ./themes/springan.nix;
  };
}
