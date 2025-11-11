{ config, lib, pkgs, inputs, ... }:

{
  programs =
    {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; 
        dedicatedServer.openFirewall = true; 
        localNetworkGameTransfers.openFirewall = true;
      };
      
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      fish.enable = false;
      alvr.enable = false;
      alvr.openFirewall = true;
      git =
        {
          enable = true;
          lfs.enable = true;
        };
      
      #gtk.enable = true;
      #home-manager.enable = true;
      neovim.defaultEditor = false;
      envision =
        {
          enable = false;
          openFirewall = true; # This is set true by default
        };
      adb.enable = false;
      nix-ld.enable = true;
      appimage.binfmt = true; 
      ladybird.enable = true;
      kdeconnect.enable = false;

      dconf.enable = true;
        gamescope =
        {
          enable = false;
          capSysNice = false;
        };
      gamemode =
        {
          enable = false;
          enableRenice = false;
        };
      # kclock =
      #   {
      #     enable = true;
      #   };
      niri.enable = true;

      # regreet.enable = false;
    };
  virtualisation = {
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
    };
  };
}
