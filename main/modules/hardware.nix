{ config, lib, pkgs, inputs, ... }:
let
  # not-so-tiny-dfr = import (pkgs.fetchFromGitHub {
  #   owner = "dev-muhammad-adel";
  #   repo = "tiny-dfr";
  #   rev = "app5";
  #   sha256 = "sha256-ERWoAXtfekziV5bmPpnFa76RlRNnsKPNyL69gQCd/Zo=";
  # }) { inherit pkgs; };
  not-so-tiny-dfr = import ./not-so-tiny-dfr.nix { inherit pkgs; inherit lib; };
in
{
  hardware =
    {
      # apple-t2.kernelChannel = "stable";
      firmware =
        [
          (pkgs.stdenvNoCC.mkDerivation (final: {
            name = "brcm-firmware";
            src = ../firmware/brcm;
            installPhase = 
              ''
                mkdir -p $out/lib/firmware/brcm
                cp ${final.src}/* "$out/lib/firmware/brcm"
              '';
            }))
        ];

      bluetooth =
        {
          enable = true;
          powerOnBoot = false;
          settings = 
            {
              General =
                {
                  Enable = "Source,Sink,Media,Socket";
                };
            };
        };

      apple.touchBar =
        {
          enable = false;
          settings = 
            {
              MediaLayerDefault = true;
              ShowButtonOutlines = false;
              EnablePixelShift = false;
            };
          # package = import /home/mxmfrpr/projects/tiny-dfr/default.nix { inherit pkgs; };
          # package = not-so-tiny-dfr;
        };

      graphics = 
        {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs;
            [
              amdvlk
              #pkgs.mesa.opencl
              
              vpl-gpu-rt

              mesa
              intel-media-driver
            ];
          extraPackages32 = with pkgs;
            [
              driversi686Linux.amdvlk  

              # driversi686Linux.mesa
            ];
        };

      amdgpu.amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };

      intel-gpu-tools.enable = true;
        
    
      enableAllFirmware = true;
    
      enableRedistributableFirmware = true;
    
      alsa.enable = false;
      
      cpu.x86.msr =
        {
          enable = true;
          settings.allow-writes = "on";
        };
    };
}
