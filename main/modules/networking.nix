{ config, lib, pkgs, inputs, ... }:

{
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];
  networking =
    {
      networkmanager =
        {
          enable = true;
          wifi.powersave = true;
        };
      wireless =
        {
          enable = false;
          userControlled.enable = false;
        };
      hostName = "nixos"; # Define your hostname.
      firewall =
        {
          enable = true;
          allowedTCPPorts = [ 47984 47989 47990 48010 ];
          allowedUDPPortRanges =
            [
              { from = 47998; to = 48000; }
              #{ from = 8000; to = 8010; }
              { from = 2935; to = 2935; }
              { from = 9987; to = 9989; }
              { from = 4200; to = 4300; }
            ];
        };
    };
}
