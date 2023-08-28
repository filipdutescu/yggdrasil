{ pkgs, home-manager, system, lib, ... }:
let
  host = import ./host.nix { inherit pkgs home-manager system lib; };
in host.makeHardware {
  luksDeviceName = "cryptroot";
  luksDevice = "/dev/disk/by-uuid/3b7d6d12-4d2d-4c88-9f34-584bc23af5fc";
  cpuFreqGovernor = lib.mkDefault "powersave";
  cpu = {
    intel.updateMicrocode = lib.mkDefault true;
  };
  fileSystemEntries = [
    {
      path = "/";
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" "discard=async" ];
    }
    {
      path = "/home";
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" "discard=async" ];
    }
    {
      path = "/nix";
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" "discard=async" ];
    }
    {
      path = "/boot";
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    }
  ];
}
