{ config, lib, pkgs, inputs, ... }:

{
  nix =
    {
      gc =
        {
          automatic = true;
          randomizedDelaySec = "14m";
          dates = "weekly";
          options = "--delete-older-than 15d";
        };
  
      settings =
        {
          substituters = [ "https://cache.soopy.moe" "https://cache.nixos.org" ];
          trusted-substituters = [ "https://cache.soopy.moe" ]; # to allow building as a non-trusted user
          trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
          auto-optimise-store = true;
        };
      
        
        settings.experimental-features =
          [
            "nix-command"
            "flakes"
          ];
    };

  nixpkgs =
    {
      config.allowUnfree = true;
      config.permittedInsecurePackages =
        [
          
        ];
    };
}
