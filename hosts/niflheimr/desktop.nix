{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    spotify
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  sound.enable = pkgs.lib.mkForce false;
  hardware.pulseaudio.enable = pkgs.lib.mkForce false;
  
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      inter
      libertine
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig.defaultFonts = {
      serif = ["Linux Libertine"];
      sansSerif = ["Inter"];
      monospace = ["FiraCode Nerd Font Mono"];
    };
  };
}
