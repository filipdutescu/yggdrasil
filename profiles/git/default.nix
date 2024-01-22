{
  programs.git = {
    enable = true;

    userName = "Filip Dutescu";
    userEmail = "filip@hucksy.dev";

    delta = {
      enable = true;
      options = {
        hyperlinks = true;
        light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        line-numbers = true;
        navigate = true; # use n and N to move between diff sections
        side-by-side = true;
        whitespace-error-style = "22 reverse";
      };
    };

    signing = {
      key = null;
      signByDefault = true;
    };

    extraConfig = {
      core = {
        whitespace = "space-before-tab, trailing-space";
      };

      diff = {
        colorMoved = "default";
      };

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
