{ pkgs, home-manager, lib, system, overlays, homeManagerSysDataPath, ... }:
with builtins; {
  makeHomeManagerUser = { name, config, stateVersion }:
    home-manager.lib.homeManagerConfiguration {
      inherit stateVersion system username pkgs;

      configuration =
        let
          trySettings = tryEval (fromJSON (readFile homeManagerSysDataPath));
          machineData = if trySettings.success then trySettings.value else {};

          machineModule = { pkgs, config, lib, ... }: {
            options.machineData = lib.mkOption {
              default = {};
              description = "Settings passed from NixOS system configuration. If not present will be empty";
            };

            config.machineData = machineData;
          };
        in {
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfree = true;

          systemd.user.startServices = true;
          home.stateVersion = stateVersion;
          home.username = name;
          home.homeDirectory = "/home/${name}";

          imports = [ ../modules/users machineModule ];
        };
      
      homeDirectory = "/home/${name}";
    };

  makeSystemUser = { name, groups, uid, shell, ... }: {
    users.users."${name}" = {
      inherit uid;
      inherit name;
      inherit shell;
      isNormalUser = true;
      isSystemUser = true;
      extraGroups = groups;
      initialPassword = "nixos";
    };
  };
}
