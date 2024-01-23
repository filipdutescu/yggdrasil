{ pkgs, inputs, stateVersion, ... }:
{
  makeSystem = hostname:
    inputs.nixpkgs.lib.nixosSystem {
      inherit (pkgs) system;

      specialArgs = { inherit pkgs inputs stateVersion; };

      modules = [
        ../common/modules.nix
        ../hosts/${hostname}
      ];
    };
}
