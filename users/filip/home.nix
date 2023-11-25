{ pkgs, stateVersion, ... }:
{
  home.stateVersion = stateVersion; # Please read the comment before changing.

  home.packages = with pkgs; [
    delta
    gcc
    git
    gnupg
    htop
    rustup
    steam
    thunderbird
    zellij
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "hx";
    MOZ_ENABLE_WAYLAND = 1;
    PATH = "PATH=$HOME/.cargo/bin:$PATH";
    VISUAL = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../profiles/git
    ../../profiles/helix
    ../../profiles/starship
    ../../profiles/wezterm
    ../../profiles/zellij
    ../../profiles/zsh
  ];

  services.gpg-agent.enable = true;
}
