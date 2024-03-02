{pkgs, ...}: {
  # Ensure the legacy software out
  services.xserver.enable = pkgs.lib.mkForce false;
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
      (nerdfonts.override {fonts = ["FiraCode"];})
    ];

    fontconfig.defaultFonts = {
      serif = ["Linux Libertine"];
      sansSerif = ["Inter"];
      monospace = ["FiraCode Nerd Font Mono"];
    };
  };
}
