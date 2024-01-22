{ pkgs, home-manager, system, lib, stateVersion, ... }:
{
  makeSystem = hostname: let
    coreModules = import ../common/modules.nix { inherit pkgs; };

    hostModules = import ../hosts/${hostname} { inherit pkgs home-manager system lib stateVersion; };
  in lib.nixosSystem {
    inherit system;

    modules = [
      coreModules
      hostModules
    ];
  };
}
