{ pkgs, home-manager, system, lib, ... }:
{
  makeSystem = hostname: let
    coreModules = import ../common/modules.nix { inherit pkgs; };

    hostModules = import ../hosts/${hostname} { inherit pkgs home-manager system lib; };
  in lib.nixosSystem {
    inherit system;
    
    modules = hostModules ++ [
      coreModules
    ];
  };
}
