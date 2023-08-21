{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    inherit (nixpkgs) lib;

    util = import ./lib {
      inherit system pkgs home-manager lib; overlays = (pkgs.overlays);
    };

    inherit (utils) user host;

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkgs) [];
    };
    
    system = "x86_64-linux";

    homeManagerSysDataPath = "/etc/hmsystemdata.json";

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
  in {
      homeManagerConfigurations = {
        filip = user.makeHomeManagerUser {
          inherit stateVersion homeManagerSysDataPath;
          
        };
      };

      nixosConfigurations = {
        laptop = host.makeHost {
          inherit stateVersion homeManagerSysDataPath;
          name = "laptop";
          networkInterfaces = [ "enp7s0" "wlan0" ];
          kernelPackages = pkgs.linuxPackages;
          initrdMods = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
          kernelMods = [ "kvm-intel" ];
          kernelParams = [ "nvidia_drm.modeset=1" ];
          systemConfig = {
            # your abstracted system config
          };
          users = [{
            name = "filip";
            groups = [ "wheel" "networkmanager" "video", "input", "audio" ];
            uid = 1000;
            shell = pkgs.zsh;
          }];
          cpuCores = 6;
        };
      };
    };
}
