{ pkgs, ... }: {
  systemd.network.networks = {
    "wlan0" = {
      matchConfig.PermanentMACAddress = "58:a0:23:d5:11:37";

      networkConfig ={
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
      dhcpV4Config.RouteMetric = 600;
      ipv6AcceptRAConfig.RouteMetric = 600;
      linkConfig.RequiredForOnline = "no";
    };

    "enp7s0" = {
      matchConfig.PermanentMACAddress = "98:fa:9b:2d:3f:48";

      networkConfig ={
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
      dhcpV4Config.RouteMetric = 100;
      ipv6AcceptRAConfig.RouteMetric = 100;
      linkConfig.RequiredForOnline = "no";
    };

    "virbr0" = {
      matchConfig.Name = "virbr0";

      networkConfig = {
        DHCPPrefixDelegation = true;
        IPv6AcceptRA = false;
        IPv6SendRA = true;
      };
      linkConfig.RequiredForOnline = "no";
    };
  };
}
