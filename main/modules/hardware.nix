{ config, lib, pkgs, inputs, ... }:
let
  tiny-dfr-better = pkgs.tiny-dfr.overrideAttrs (oldAttrs: rec {
    src = pkgs.fetchFromGitHub {
      owner = "dev-muhammad-adel"; # Replace with the desired GitHub owner
      repo = "tiny-dfr";   # Replace with the desired repository name
      rev = "app5"; # Replace with the desired commit, tag, or branch
      sha256 = "sha256-QfVRSA+5w7jf3qWN9IpMf+6O9RoWvBF7+WGp+kh5H30="; 
    };
    cargoHash = "sha256-17wh6i35kpknn2ph8ymqisk348nrmjyhs9a35dgqjwkvd636cx5k=";
    buildInputs = oldAttrs.buildInputs ++ [
      pkgs.freetype
      pkgs.fontconfig
    ];
  });
in
{
  hardware =
    {
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
          # package = tiny-dfr-better;
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
