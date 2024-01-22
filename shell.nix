{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:
let
  name = "Yggdrasil";
in
pkgs.mkShell {
  inherit name;

  buildInputs = with pkgs; [
    # development packages
    git

    # general Unix utils
    curl
    jq
    which

    # others
    pfetch
  ];
}
