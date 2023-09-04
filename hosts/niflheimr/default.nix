{ pkgs, home-manager, system, lib, ... }:
let
  userUtils = import ../../lib/user.nix { inherit home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs system lib; };
  hardwareConfiguration = import ./hardware.nix { inherit pkgs system lib; };
in [
  (hostUtils.makeHost {
    name = "niflheimr";
    networkInterfaceNames = [ "enp7s0" "wlp0s20f3" ];
    stateVersion = "23.05";
  })
  (userUtils.makeUser {
    name = "filip";
    groups = [ "wheel" "networkmanager" ];
  })
  hardwareConfiguration
  {
    imports = [
        ./desktop.nix
        ./localization.nix
      ];

    # networking.useDHCP = false;
    # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  }
]
