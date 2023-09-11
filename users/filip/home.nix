{ pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    delta
    git
    git-crypt
    gnupg
    htop
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
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
    TERM = "alacritty";
    VISUAL = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../profiles/git
    ../../profiles/helix
    ../../profiles/starship
    ../../profiles/zellij
    ../../profiles/zsh
  ];

  services.gpg-agent.enable = true;
}
