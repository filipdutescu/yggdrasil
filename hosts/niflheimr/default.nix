{ pkgs, home-manager, system, lib, ... }:
let
  userUtils = import ../../lib/user.nix { inherit home-manager; };
  hostUtils = import ../../lib/host.nix { inherit pkgs home-manager system lib; };
  hardwareConfiguration = import ./hardware.nix { inherit pkgs home-manager system lib; };
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
  # {
  #   # Enable the X11 windowing system.
  #   services.xserver.enable = true;

  #   # Enable the GNOME Desktop Environment.
  #   services.xserver.displayManager.gdm.enable = true;
  #   services.xserver.desktopManager.gnome.enable = true;

  #   sound.enable = pkgs.lib.mkForce false;
  #   hardware.pulseaudio.enable = pkgs.lib.mkForce false;
    
  #   services.pipewire = {
  #     enable = true;
  #     audio.enable = true;
  #     alsa.enable = true;
  #     alsa.support32Bit = true;
  #     pulse.enable = true;
  #     wireplumber.enable = true;
  #   };
  # }
  {
    imports = [
      ./desktop.nix
      ./localization.nix
    ];
  }
]
