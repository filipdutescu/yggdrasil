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

  environment.shellAliases = {
    adios = "shutdown now";
    cp = "cp -i";
    grep = "rg --color=auto";
    la = "ls -lA --color=auto";
    ll = "ls -l --color=auto";
    ls = "ls --color=auto";

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

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;

    autosuggestions.enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    enableLsColors = true;

    setOptions = [
      "AUTO_CD"
      "NOMATCH"
    ];

    syntaxHighlighting.enable = true;
  };
}
