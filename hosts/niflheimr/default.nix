{ pkgs, home-manager, system, lib, ... }:
let
  userUtils = import ../../lib/user.nix { inherit home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs home-manager system lib; };
in [
  ./configuration.nix
  {
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./localization.nix
      ];
  }
  # home-manager.nixosModules.home-manager {
  #   home-manager = {
  #     useGlobalPkgs = true;
  #     useUserPackages = true;
  #     users.filip = import ../../users/filip/home.nix;
  #   };
  # }
  ]
  ++ (userUtils.makeUser {
    name = "filip";
    groups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  })
# ]
