{ pkgs, home-manager, system, lib, stateVersion, ... }:
let
  userUtils = import ../../lib/user.nix { inherit home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs system lib; };
  hardwareConfiguration = import ./hardware.nix { inherit pkgs system lib; };
in [
  (hostUtils.makeHost {
    inherit stateVersion;
    name = "niflheimr";
    networkInterfaceNames = [ "enp7s0" "wlp0s20f3" ];
  })
  (userUtils.makeUser {
    inherit stateVersion;
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
