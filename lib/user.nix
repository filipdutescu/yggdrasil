{ home-manager, ... }:
{
  makeUser = { name, groups, uid ? null, shell ? null, ... }: [
    {
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
    }
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${name}" = import ../users/${name}/home.nix;
      };
    }
  ];
}