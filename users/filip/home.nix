{
  pkgs,
  stateVersion,
  ...
}: {
  home.stateVersion = stateVersion; # Please read the comment before changing.

  home.packages = with pkgs; [
    delta
    gcc
    git
    gnupg
    htop
    rustup
    steam
    thunderbird
    zellij
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "hx";
    MOZ_ENABLE_WAYLAND = 1;
    PATH = "PATH=$HOME/.cargo/bin:$PATH";
    VISUAL = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg = {
    enable = true;

    configFile = {
      "libvirt/qemu.conf" = {
        enable = true;
        text = ''
          # Adapted from /var/lib/libvirt/qemu.conf
          # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
          nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
        '';
      };
    };
  };

  imports = [
    ../../profiles/direnv
    ../../profiles/git
    ../../profiles/helix
    ../../profiles/starship
    ../../profiles/wezterm
    ../../profiles/zellij
    ../../profiles/zsh
  ];
}
