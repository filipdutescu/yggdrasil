{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "nvidia-settings"
            "nvidia-x11"
            "spotify"
            "steam"
            "steam-original"
          ];
      };

      system = "x86_64-linux";

      # Every once in a while, a new NixOS release may change configuration
      # defaults in a way incompatible with stateful data. For instance, if the
      # default version of PostgreSQL changes, the new version will probably
      # be unable to read your existing databases. To prevent such breakage,
      # you should set the value of this option to the NixOS release with which
      # you want to be compatible. The effect is that NixOS will use defaults
      # corresponding to the specified release (such as using an older version
      # of PostgreSQL). It’s perfectly fine and recommended to leave this value
      # at the release version of the first install of this system. Changing this
      # option will not upgrade your system. In fact it is meant to stay constant
      # exactly when you upgrade your system. You should only bump this option, if
      # you are sure that you can or have migrated all state on your system which
      # is affected by this option.
      stateVersion = "23.05"; # Did you read the comment?

      utils = import ./lib { inherit pkgs inputs stateVersion; };
    in
    {
      nixosConfigurations = {
        niflheimr = utils.makeSystem "niflheimr";
      };
    };
}
