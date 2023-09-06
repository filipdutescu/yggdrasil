{
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
}
