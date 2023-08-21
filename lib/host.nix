{ system, pkgs, home-manager, lib, user, homeManagerSysDataPath, ... }:
with builtins; {
  makeHost = {
    name,
    networkInterfaces,
    wifiInterfaces,
    initrdMods,
    kernelMods,
    kernelParams,
    kernelPackages,
    cpuCores,
    stateVersion,
    }:
    let
      networkInterfaces = listToAttrs (map (ni: {
        name = "${ni}";
        value = {
          useDHCP = true;
        };
      }) networkInterfaces);

      sys_users = (map (u: user.makeSystemUser u) users);
    in lib.nixosSystem {
      inherit system;

      modules = [
        {
          # enable flake support
          nix = {
            package = pkgs.nixFlakes;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
          };
        }
        {
          # kernel settings
          boot.initrd.availableKernelModules = initrdMods;
          boot.kernelModules = kernelMods;
          boot.kernelParams = kernelParams;
          boot.kernelPackages = kernelPackages;


          # networking
          networking = {
            hostName = "${name}";
            interfaces = networkInterfaces;
            wireless.interfaces = wifiInterfaces;
            networkmanager.enable = true;
            useDHCP = false;
          };

          # NixOS specific settings
          nixpkgs.pkgs = pkgs;
          nix.maxJobs = lib.mkDefault cpuCores;

          system.stateVersion = stateVersion;
        }
      ];
    }
}
