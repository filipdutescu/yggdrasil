{ pkgs, home-manager, system, lib, ... }:
with builtins; rec {
  makeUser = { name, groups, uid, shell, ... }: {
    users.groups."${name}" = {};
    users.users."${name}" = {
      inherit uid;
      inherit name;
      inherit shell;
      isNormalUser = true;
      group = "${name}";
      extraGroups = groups;
      initialPassword = "nixos";
    };
  };

  makeHostConfiguration = {
    name,
    usernames,
    systemPackages ? [],
    networkInterfaceNames,
    initrdMods,
    initrdKernelMods ? [],
    kernelMods,
    kernelParams ? [],
    kernelPackages ? [],
    cpuCores,
    }:
    let
      networkInterfaces = listToAttrs (map (ni: {
        name = "${ni}";
        value = {
          useDHCP = lib.mkDefault true;
        };
      }) networkInterfaceNames);

      users = (map (u: makeUser u) usernames);
    in {
      # Use the systemd-boot EFI boot loader.
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # kernel settings
      boot.initrd = {
        availableKernelModules = initrdMods;
        kernelModules = initrdKernelMods;
      };
      boot.kernelModules = kernelMods;
      boot.kernelParams = kernelParams;
      boot.kernelPackages = kernelPackages;
      boot.extraModulePackages = [];

      # networking
      networking = {
        hostName = "${name}";
        interfaces = networkInterfaces;
        networkmanager.enable = true;
        useDHCP = false;
      };

      # NixOS specific settings
      nixpkgs.pkgs = pkgs;
      nixpkgs.hostPlatform = lib.mkDefault system;
      nix.maxJobs = lib.mkDefault cpuCores;

      system.stateVersion = stateVersion;
    };

  makeHardware = with lib.attrsets; {
    luksDeviceName,
    luksDevice,
    fileSystemEntries,
    cpuFreqGovernor,
    cpu,
  }:
  let
    fileSystems = mergeAttrsList (map (fs: {
      fileSystems."${fs.path}" = {
        inherit (fs) device fsType options;
      };
    }) fileSystemEntries);
  in mergeAttrsList [
    fileSystems
    {
      boot.initrd.luks.devices."${luksDeviceName}".device = luksDevice;
    
      powerManagement.cpuFreqGovernor = cpuFreqGovernor;
      hardware.cpu = cpu;
    }
  ];
}
