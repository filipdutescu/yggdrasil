{ pkgs, inputs, stateVersion, ... }:
let
  userUtils = import ../../lib/user.nix { inherit (inputs) home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs; };
  hardwareConfiguration = import ./hardware.nix { inherit pkgs; };
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
