{pkgs, ...}: let
  hostUtils = import ../../lib/host.nix {inherit pkgs;};
in {
  imports = [
    (hostUtils.makeHardware {
      luksDeviceName = "cryptroot";
      luksDevice = "/dev/disk/by-uuid/3b7d6d12-4d2d-4c88-9f34-584bc23af5fc";
      initrdMods = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
      kernelMods = ["kvm-intel"];
      kernelParams = ["splash"];
      cpuFreqGovernor = "powersave";
      cpu = {intel.updateMicrocode = pkgs.lib.mkDefault true;};
      fileSystemEntries = [
        {
          path = "/";
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = ["subvol=root" "compress=zstd" "noatime" "discard=async"];
        }
        {
          path = "/home";
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = ["subvol=home" "compress=zstd" "noatime" "discard=async"];
        }
        {
          path = "/nix";
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = ["subvol=nix" "compress=zstd" "noatime" "discard=async"];
        }
        {
          path = "/boot";
          device = "/dev/disk/by-label/NIXBOOT";
          fsType = "vfat";
        }
      ];
    })
    # NVIDIA settings
    # For laptops also see https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29
    {
      # Enable OpenGL
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      # Load NVIDIA driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        # Use the NVIDIA open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Laptop settings
        # Modesetting is required.
        modesetting.enable = true;

        powerManagement = {
          # NVIDIA power management. Experimental, and can cause sleep/suspend to fail.
          enable = false;
          # Fine-grained power management. Turns off GPU when not in use.
          # Experimental and only works on modern NVIDIA GPUs (Turing or newer).
          finegrained = false;
        };

        prime = {
          # https://nixos.wiki/wiki/Nvidia#Optimus_PRIME_Option_A:_Offload_Mode
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = "PCI:00:02:0";
          nvidiaBusId = "PCI:01:00:0";
        };
      };
    }
  ];
}
