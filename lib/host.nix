{pkgs, ...}:
with builtins; let
  system = pkgs.system;
  lib = pkgs.lib;
in {
  /*
  Configures the host related information, such as network interfaces, bootloader or system
  packages.

  Here is a detailed overview of what is configured through this function:
    - bootloader: use systemd, UEFI
    - boot process related settings:
      - initrd - enable systemd and turn off verbosity
      - do not print console logs by default
      - enable and customise Plymouth
    - networking:
      - set DHCP to true for all given network interfaces
      - set host name
      - use NetworkManager
    - NixOS specific settings:
      - system state version
      - nixpkgs to use

  Type: makeHost :: AttrSet -> AttrSet

  Example:
    makeHost {
     stateVersion = "23.11";
     name = "myhost";
     networkInterfaceNames = [ "eth0" "wlan0" ];
   }
   => { ... }
  */
  makeHost = {
    # the host name for the system to be created
    name,
    # packages to be installed system-wide
    systemPackages ? [],
    # the names of the network interfaces which should be configured
    networkInterfaceNames,
    # NixOS system state version for which the configuration is written
    stateVersion,
  }: let
    networkInterfaces = listToAttrs (map
      (ni: {
        name = "${ni}";
        value = {
          useDHCP = lib.mkDefault true;
        };
      })
      networkInterfaceNames);
  in {
    boot = {
      # Use the systemd-boot EFI boot loader.
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      initrd = {
        verbose = false;
        systemd.enable = true;
      };
      # do not show logs by default during boot (complementary to `boot.initrd.verbose = false;`)
      consoleLogLevel = 0;
      kernelParams = ["quiet" "udev.log_level=3"];

      # nice boot screen and prompt for LUKS password
      plymouth = {
        enable = true;
        logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      };
    };

    # networking
    networking = {
      hostName = "${name}";

      # careful with the interfaces, the wifi one seems to be fragile
      # using the original `hardware-configuration.nix` it is happy
      # moving it to this setup, with a function, sometimes it allows it
      # sometimes it is angry at the one disturbing its sleep
      interfaces = networkInterfaces;
      useDHCP = pkgs.lib.mkDefault false;

      networkmanager.enable = true;
      networkmanager.wifi.backend = "iwd";
      networkmanager.dhcp = "internal";

      firewall.enable = true;
      wireless.iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
        };
      };
      dhcpcd.enable = false;
    };

    environment.systemPackages = systemPackages;

    # NixOS specific settings
    nixpkgs.pkgs = pkgs;
    system.stateVersion = stateVersion;
  };

  /*
  Configure hardware-dependent or related settings, such as file system partitions, LUKS disk
  encryption or CPU cores and frequency governor.

  Here is a detailed overview of what is configured through this function:
    - boot process related settings:
      - initrd kernel modules and available kernel modules
      - kernel modules and parameters
      - LUKS encrypted disk device
    - hardware-dependent settings:
      - CPU settings (ie update Intel/AMD microcode)
      - enable redistributable firmware
      - power profile for the CPU frequency governor
      - host platform architecture

  Type: makeHardware :: AttrSet -> AttrSet

  Example:
   makeHardware {
     luksDeviceName = "cryptroot";
     luksDevice = "/dev/disk/by-uuid/3b7d6d12-4d2d-4c88-9f34-584bc23af5fc";
     initrdMods = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
     kernelMods = [ "kvm-intel" ];
     kernelParams = [ "splash" ];
     cpuFreqGovernor = "powersave";
     cpu = { intel.updateMicrocode = lib.mkDefault true; };
   }
   => { ... }
  */
  makeHardware = {
    # List of kernel modules in the initial ramdisk used during the boot process, which must
    # include all modules necessary for mounting the root device
    initrdMods,
    # Kernel modules always loaded by initrd
    initrdKernelMods ? [],
    # List of kernel modules to be loaded in the second stage of the boot process
    kernelMods,
    # List of parameters with which the kernel should be started up
    kernelParams ? [],
    # Governor type to be used to regulate the frequency of the available CPUs
    cpuFreqGovernor,
    # Intel/AMD specific CPU settings, such as updating microcode
    cpu,
  }: {
    boot = {
      initrd = {
        # setup kernel modules used during the boot process and used to mount the root device
        availableKernelModules = initrdMods;
        # setup kernel modules to be loaded by initrd
        kernelModules = initrdKernelMods;
      };
      kernelModules = kernelMods;
      kernelParams = kernelParams;
      extraModulePackages = [];
    };

    # setup the system architecture
    nixpkgs.hostPlatform = lib.mkDefault system;

    # configure CPU related settings (power managerment, microcode updating etc.)
    powerManagement.cpuFreqGovernor = lib.mkDefault cpuFreqGovernor;
    hardware = {
      cpu = cpu;
      enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}
