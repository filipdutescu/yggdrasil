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
    zellij
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../profiles/zsh
  ];

  programs.git = {
    enable = true;

    userName = "Filip Dutescu";
    userEmail = "filip@hucksy.dev";

    delta = {
      enable = true;
      options = {
        navigate = true;    # use n and N to move between diff sections
        light = false;      # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        side-by-side = true;
      };
    };

    signing = {
      key = null;
      signByDefault = true;
    };

    extraConfig = {
      fetch = {
        prune = true;
      };

      merge = {
        conflictstyle = "diff3";
      };

      pull = {
        rebase = true;
      };
    };
  };

  services.gpg-agent.enable = true;
}
