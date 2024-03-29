{
  pkgs,
  config,
  inputs,
  stateVersion,
  ...
}: let
  userUtils = import ../../lib/user.nix {
    inherit (inputs) home-manager;
    inherit config;
  };
  hostUtils = import ../../lib/host.nix {inherit pkgs;};
in {
  imports = [
    ./disko.nix
    ./hardware.nix
    (hostUtils.makeHost {
      inherit stateVersion;
      name = "niflheimr";
      networkInterfaceNames = ["enp7s0" "wlan0"];
      systemPackages = with pkgs; [
        libreoffice-fresh
        spotify
        ungoogled-chromium
      ];
    })
    (userUtils.makeUser {
      inherit stateVersion;
      name = "filip";
      groups = ["wheel" "networkmanager" "libvirtd"];
    })
    ./desktop.nix
    ./localization.nix
  ];
}
