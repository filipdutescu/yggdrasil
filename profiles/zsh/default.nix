{
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;

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
}
