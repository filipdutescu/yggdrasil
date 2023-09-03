{ home-manager, ... }:
{
  makeUser = { name, groups, uid ? null, shell ? null, ... }: {
    imports = [ home-manager.nixosModules.home-manager ];

    users = {
      mutableUsers = false;

      users."${name}" = {
        inherit uid name shell;
        isNormalUser = true;
        extraGroups = groups;
        initialPassword = "nixos";
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users."${name}" = import ../users/${name}/home.nix;
    };
  };
}