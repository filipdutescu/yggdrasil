{ pkgs, home-manager, system, lib, stateVersion, ... }:
let
  userUtils = import ../../lib/user.nix { inherit home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs system lib; };
  hardwareConfiguration = import ./hardware.nix { inherit pkgs system lib; };
in
{
  imports = [
    hardwareConfiguration
    (hostUtils.makeHost {
      inherit stateVersion;
      name = "niflheimr";
      networkInterfaceNames = [ "enp7s0" "wlp0s20f3" ];
      systemPackages = with pkgs; [
        spotify
        ungoogled-chromium
      ];
    })
    (userUtils.makeUser {
      inherit stateVersion;
      name = "filip";
      groups = [ "wheel" "networkmanager" "libvirtd" ];
    })
    ./desktop.nix
    ./localization.nix
  ];
}
