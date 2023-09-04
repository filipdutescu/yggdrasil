{ pkgs, system, lib, ... }:
with builtins; {
  makeHost = {
    name,
    systemPackages ? [],
    networkInterfaceNames,
    stateVersion
    }:
    let
      networkInterfaces = listToAttrs (map (ni: {
        name = "${ni}";
        value = {
          useDHCP = lib.mkDefault true;
        };
      }) networkInterfaceNames);
    in {
      # Use the systemd-boot EFI boot loader.
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # networking
      networking = {
        hostName = "${name}";

        # careful with the interfaces, the wifi one seems to be fragile
        # using the original `hardware-configuration.nix` it is happy
        # moving it to this setup, with a function, sometimes it allows it
        # sometimes it is angry at the one disturbing its sleep
        interfaces = networkInterfaces;
        useDHCP = false;
        networkmanager.enable = true;
      };

      # NixOS specific settings
      nixpkgs.pkgs = pkgs;
      system.stateVersion = stateVersion;
    };

  makeHardware = with lib.attrsets; {
    luksDeviceName,
    luksDevice,
    initrdMods,
    initrdKernelMods ? [],
    kernelMods,
    kernelParams ? [],
    fileSystemEntries,
    cpuFreqGovernor,
    cpu,
  }:
  let
    fileSystemPaths = mergeAttrsList (map (fs@{ path, device, fsType, ... }: 
    if hasAttr "options" fs then {
      "${path}" = { inherit (fs) device fsType options; };
    } else {
      "${path}" = { inherit device fsType; };
    }) fileSystemEntries);
  in {
    # kernel settings
    boot = {
      initrd = {
        availableKernelModules = initrdMods;
        kernelModules = initrdKernelMods;

        luks.devices."${luksDeviceName}".device = luksDevice;
      };
      kernelModules = kernelMods;
      kernelParams = kernelParams;
      extraModulePackages = [];
    };

    fileSystems = fileSystemPaths;

    swapDevices = [];
  
    nixpkgs.hostPlatform = lib.mkDefault system;
    powerManagement.cpuFreqGovernor = lib.mkDefault cpuFreqGovernor;
    hardware = {
      cpu = cpu;
      enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}
