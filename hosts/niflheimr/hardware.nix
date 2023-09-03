{ pkgs, home-manager, system, lib, ... }:
let
  hostUtils = import ../../lib/host.nix { inherit pkgs home-manager system lib; };
in hostUtils.makeHardware {
  luksDeviceName = "cryptroot";
  luksDevice = "/dev/disk/by-uuid/3b7d6d12-4d2d-4c88-9f34-584bc23af5fc";
  initrdMods = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  kernelMods = [ "kvm-intel" ];
  cpuFreqGovernor = "powersave";
  cpu = { intel.updateMicrocode = lib.mkDefault true; };
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