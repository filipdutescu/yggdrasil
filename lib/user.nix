{ home-manager, ... }:
{
  makeUser = { name, groups, uid ? null, shell ? null, ... }: {
    imports = [ home-manager.nixosModules.home-manager ];
  
    users = {
      # mutableUsers = false;

      groups."${name}" = {};
      users."${name}" = {
        inherit uid;
        inherit name;
        inherit shell;
        isNormalUser = true;
        group = "${name}";
        extraGroups = groups;
        initialPassword = "nixos";
      };
    };
  # }
  # home-manager.nixosModules.home-manager {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users."${name}" = import ../users/${name}/home.nix;
    };
  # }
  };
}