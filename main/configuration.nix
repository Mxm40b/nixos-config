# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      # ../hardware-configuration.nix
      #"${nixos-hardware}/apple/t2"
      #<nixos-hardware/apple/t2>
      #./home.nix
      ./modules/boot.nix
      ./modules/services.nix
      ./modules/nixSettings.nix
      ./modules/hardware.nix
      ./modules/systemd.nix 
      ./modules/programs.nix
      ./modules/systemPackages.nix
      ./modules/users.nix
      ./modules/fonts.nix

      ./modules/security.nix
      ./modules/networking.nix
      ./modules/xdg.nix

      # ./modules/environmentVariables.nix

      ./modules/pipewire_sink_conf.nix
      # ./modules/pipewire_sink_conf_better.nix
      # /home/mxmfrpr/projects/tiny-dfr/module.nix
      # ./modules/not-so-tiny-dfr.nix
    ];



  # services.tiny-dfr.enable = false;



  location.provider = "geoclue2";

  time.timeZone = lib.mkDefault "Europe/Paris";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "colemak";
    #useXkbConfig = true;
  };







  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    DRI_PRIME = "0";
    
    EDITOR = "hx";
    SYSTEMD_EDITOR = "hx";
    VISUAL = "hx";

    # LD_LIBRARY_PATH = "";
  };
  
  powerManagement.enable = true;
  powerManagement.powertop.enable = false;








  
  environment.variables = {
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";

      };


  #environment.variables = let
  #    makePluginPath = format:
  #      (makeSearchPath format [
  #        "$HOME/.nix-profile/lib"
  #        "/run/current-system/sw/lib"
  #        "/etc/profiles/per-user/$USER/lib"
  #      ])
  #      + ":$HOME/.${format}";
  #  in {
  #    DSSI_PATH   = makePluginPath "dssi";
  #    LADSPA_PATH = makePluginPath "ladspa";
  #    LV2_PATH    = makePluginPath "lv2";
  #    LXVST_PATH  = makePluginPath "lxvst";
  #    VST_PATH    = makePluginPath "vst";
  #    VST3_PATH   = makePluginPath "vst3";
#
#      
#GDK_BACKEND = "wayland";
#  QT_QPA_PLATFORM = "wayland";
#  SDL_VIDEODRIVER = "wayland";
#    };




  
  
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };



  documentation.man.generateCaches = false;


  system.stateVersion = "24.11"; # Did you read the comment?



}
            



  
