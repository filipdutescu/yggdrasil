{ config, pkgs, ... }:

{
  # home.username = "filip";
  # home.homeDirectory = "/home/filip";

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

  programs.zsh = {
    enable = true;
    # enableAutoSuggestions = true;

    # profileExtra = ''
    #   if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    #     exec Hyprland
    #   fi
    # '';

    shellAliases = {
      adios = "shutdown now";
      cp = "cp -i";
      dt = "delta";
      grep = "rg --color=auto";
      la = "ls -lA --color=auto";
      ll = "ls -l --color=auto";
      ls = "ls --color=auto";
      z = "zellij";

      # git related aliases
      ga = "git add";
      gb = "git branch";
      gck = "git checkout";
      gcn = "git clone";
      gcm = "git commit";
      gf = "git fetch";
      gd = "git diff";
      gl = "git log";
      gmg = "git merge";
      gpl = "git pull";
      gph = "git push";
      grs = "git reset";
      grb = "git rebase";
      grm = "git remote";
      gsh = "git stash";
      gss = "git status";
      gt = "git tag";
      gw = "git worktree";
    };
  };

  services.gpg-agent.enable = true;
}
