{ pkgs, home-manager, system, lib, ... }:
{
  makeSystem = hostname: let
    coreModules = import ../common/modules.nix { inherit pkgs; };

    hostModules = import ../hosts/${hostname} { inherit home-manager; };
  in lib.nixosSystem {
    inherit system;
    
    modules = hostModules ++ [
      coreModules
    ];
  };
}
