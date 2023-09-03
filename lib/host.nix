{ pkgs, home-manager, system, lib, ... }:
with builtins; rec {
  makeHost = {
    name,
    systemPackages ? [],
    # networkInterfaceNames,
    stateVersion
    }:
    let
      # networkInterfaces = listToAttrs (map (ni: {
      #   name = "${ni}";
      #   value = {
      #     useDHCP = lib.mkDefault true;
      #   };
      # }) networkInterfaceNames);
    in {
      # Use the systemd-boot EFI boot loader.
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # networking
      networking = {
        hostName = "${name}";
        # interfaces = networkInterfaces;
        networkmanager.enable = true;
        # useDHCP = false;
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
    boot.initrd = {
      availableKernelModules = initrdMods;
      kernelModules = initrdKernelMods;
    };
    boot.kernelModules = kernelMods;
    boot.kernelParams = kernelParams;
    boot.extraModulePackages = [];

    boot.initrd.luks.devices."${luksDeviceName}".device = luksDevice;
    fileSystems = fileSystemPaths;

    swapDevices = [];
  
    nixpkgs.hostPlatform = lib.mkDefault system;
    powerManagement.cpuFreqGovernor = lib.mkDefault cpuFreqGovernor;
    hardware.cpu = cpu;
  };
}
