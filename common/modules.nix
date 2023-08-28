{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
   
  environment.systemPackages = with pkgs; [
    alacritty
    curl
    git
    helix
    firefox
    ripgrep
    zsh
  ];

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;

    setOptions = [
      "AUTO_CD"
      "NOMATCH"
    ];

    syntaxHighlighting.enable = true;
  };
}
