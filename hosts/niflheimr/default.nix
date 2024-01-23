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
    ./hardware.nix
    (hostUtils.makeHost {
      inherit stateVersion;
      name = "niflheimr";
      networkInterfaceNames = ["enp7s0" "wlp0s20f3"];
      systemPackages = with pkgs; [
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
