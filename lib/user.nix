{
  config,
  home-manager,
  ...
}: {
  /*
  Configure the user related settings and additional software, such as home-manager.

  Here is a detailed overview of what is configured through this function:
    - users:
      - disalbe mutable users, ensure all users must be declared in the system configuration
      - setup a normal user for the given name, which uses a given shell and has the given
        groups, UID and an initial password
    - home-manager:
      - use the system configuration’s `pkgs` argument in Home Manager, instead of own packages
      - enable installation of user packages through `users.users.<name>.packages`
      - load user specific `home.nix`
      - use save system state version as the system configuration's

  Type: makeUser :: AttrSet -> AttrSet

  Example:
    makeUser {
     stateVersion = "23.11";
     name = "johndoe";
     groups = [ "wheel" "networkmanager" "libvirtd" ];
   }
   => { ... }
  */
  makeUser = {
    # NixOS system state version for which the configuration is written
    stateVersion,
    # Name of the user to be created
    name,
    # Groups that the created user should be a part of
    groups,
    # The UID of the created user
    uid ? null,
    ...
  }: {
    imports = [home-manager.nixosModules.home-manager];

    users = {
      # only allow users to be created through the system configuration
      mutableUsers = false;

      users."${name}" = {
        inherit uid name;
        isNormalUser = true;
        extraGroups = groups;
        hashedPasswordFile = config.sops.secrets.hashed_password.path;
      };
    };

    home-manager = {
      # follow system packages
      useGlobalPkgs = true;
      # allow user packages to be defined through `users.users.<name>.packages`
      useUserPackages = true;

      users."${name}" = import ../users/${name}/home.nix;
      extraSpecialArgs = {inherit stateVersion;};
    };
  };
}
