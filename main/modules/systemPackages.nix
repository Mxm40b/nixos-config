{ config, lib, pkgs, inputs, ... }:


let lutrisFHS = pkgs.buildFHSEnv
  {
    name = "lutris-fhs";
    targetPkgs =
      pkgs: (with pkgs; [
        lutris
        wineWowPackages.waylandFull
        winetricks
        # proton-ge-bin
        protonup
        vulkan-loader
        vulkan-tools
        libGL
        dxvk
        vkd3d
        vkd3d-proton
        openal
        glxinfo
        libpulseaudio
        # libXrandr
        # libXcursor
        # libXext
        # libXi
        libglvnd
        mesa
        openal
        pciutils

        pixman

        dconf

        gamescope
        gamemode
      ]);
    runScript =
      ''
        bash -c '
          # export PROTONUP_PATH="$HOME/.local/share/lutris-proton"
          # ${pkgs.protonup}/bin/protonup --dir "$PROTONUP_PATH"
          # ${pkgs.protonup}/bin/protonup --yes
          # export STEAM_COMPAT_TOOLS_PATHS="$PROTONUP_PATH"
          lutris
        '
      '';
  };

in

{
  # permittedInsecurePackages = [
    # "ventoy-1.1.05"
  # ];


  
  environment.systemPackages =
    with pkgs;
    [
      # tinyobjloader
      # gcc
      # fmt
      #glslang
      # cmake
      # glfw
      # vulkan-loader
      # vulkan-headers
      # vulkan-validation-layers

      # shaderc
      
      # wget
      #hyprland
      #hyprlandPlugins.hy3
      networkmanager
      libimobiledevice
      # i3
      btop
      git
      # kitty
      # wofi
      # playonlinux
      ranger
      # xfce.thunar
      # xfce.thunar-volman
      appimage-run
      # cpupower-gui
      # python312Packages.pyasyncore
      #steam
      bluez
      bluetuith
      # stress
      #pwvucontrol
      # helvum
      #pw-viz
      #wl-screenrec
      brightnessctl


      ### important??
      # thermald
      # powertop
      lm_sensors
      
      # gnumake
      nix-search
      # radeon-profile
      #mesa-demos
      # mesa
      # driversi686Linux.mesa

      # xorg.xev

      spotify
      # fish
      # acpidump-all
      # coreboot-toolchain.x64
      # tiny-dfr
      # youtube-tui
      
      wiki-tui
      s-tui
      tui-journal

      radeontop
      nushell
      clinfo
      # rar

      # light
      
      fortune

      glow

      mdcat

      #rocmPackages.rpp
      ladspaPlugins
      calf
      lsp-plugins
      pavucontrol

      musikcube

      ### do I _really_ need this??
      # wayland-pipewire-idle-inhibit

      # clang-tools
      # system-config-printer
      usbutils
      #dillo-plus
      
      # weather
      
      # wego
      wthrr

      # xygrib
      
      hyprshot
      # kupfer
      #xdg-desktop-portal-hyprland
      #rustdesk
      rocmPackages.rocm-smi
      vital
      #vcv-rack
      # ardour

      lzip

      # python312Packages.tqdm
      # python312Packages.requests
      # python312Packages.inquirerpy
      glaumar_repo.qrookie

      # ntfsprogs

      helix
      pulseeffects-legacy
      # fancontrol_gui

      parted
      # gparted
      #usbmuxd2
      #libusbmuxd
      
      # checkra1n
      # libirecovery
      # idevicerestore
      # ifuse
      # vapor

      lutrisFHS

      clinfo
      kdePackages.qtsvg

      # goldendict-ng
    ];
}
