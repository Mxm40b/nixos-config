{
  pkgs,
  config,
  inputs,
  ...
}
: 

let
  opentrack-proton = (import ./opentrack-proton.nix { inherit pkgs; });
in

{
    # xdg.desktopEntries.lutris-fhs =
    #   {
    #     name = "Lutris (FHS)";
    #     exec = "lutris-fhs";
    #     icon = "lutris";
    #     terminal = false;
    #     categories = [ "Game" ];
    #   };
  
  home.packages =
    with pkgs;
    [

      

      #vim
      
      ### HOOOOLY
      # ripgrep
      

      # mupdf
      # timg
      sioyek
      anki
      waybar
      #ollama
      
      vulkan-tools
      
      (lutris.override
        {
          extraPkgs = pkgs:
            [
              gamescope
              gamemode
              libdecor
            ];
        }
      )
      #rocmPackages.rocm-smi
      # python312Packages.pytorch

      # hypridle

      # python312Packages.python
      # onnxruntime
      # python312Packages.onnx
      # mesa
      #sl
      #midori
      zip
      unzip
      ferdium

      
      # lynx
      # browsh

      # browsr

      # elinks
      # w3m

      #flightgear
      # python312Packages.icnsutil
      # inxi

      pwvucontrol

      #music-player
      # carla

      # libinput
      # psmisc
      wl-clipboard
      pfetch
      alsa-utils
      wev
      # file

      # wineWayland
      wineWowPackages.waylandFull
      # wineWowPackages.stable
      # wineWowPackages.staging
      winetricks
      # libwebp

      blender-hip
      calibre

      # librewolf-wayland
      
      # tor
      # tor-browser-bundle-bin
      # zim
      #logseq
      #affine
      
      # mission-planner
      
      qbittorrent
      yazi

      # cups
      # onlyoffice-bin
      libreoffice
      # cavalier
      # cava
      
      foot
      
      # tdf
      # termpdfpy
      
      # llama-cpp
      # chess-tui
      helix
      # dotool
      linuxKernel.packages.linux_latest_libre.bbswitch

      
      #bibata-cursors-translucent
      # bibata-cursors

      # vimix-cursors
      # banana-cursor
      # afterglow-cursors-recolored
      # breeze-hacked-cursor-theme
      # hackneyed

      
      # nwg-look
      #
      
      wl-screenrec
      # gnuplot
      # kdePackages.kalgebra
      # octave
      # rofi-wayland
      #rofi-pass-wayland
      # rofi-emoji-wayland
      # marksman
      
      # audacity
      # vlc
      mpv
      #vital
      # firefox
      # yt-dlp
      # remmina
      #immersed
      #steam-play-none

      # wlx-overlay-s
      
      #vimix-cursors
      #alvr
      # opencomposite
      # spotify-player
      # spotify-cli-linux
      # wayvnc
      inputs.zen-browser.packages."${pkgs.system}".default
      #nur.repos.ataraxiasjel.waydroid-script

      #dillo-plus
      #
      # envision
      #immersed-vr
      #vcv-rack
      
      ventoy-full

      # obs-studio

      # vlc
      #open-webui
      ardour
      # gpu-viewer
      # glxinfo
      # neovim

      # ngrrram

      # wireworld

      ### learning music
      # lenmus


      # typst

      # typstwriter

      #(tatoeba site:)[https://tatoeba.org/en] 
      #(foreign language text reader to try:)[https://foreign-language-text-reader.sourceforge.io/FLTR_Documentation.pdf]

      # oh-my-git

      rustlings
      #marble
      # marble-marcher-ce
      # gnujump
      # jumpnbump
      
      # jump
      # zoxide
      # pazi
      # fltrdr


      # ckan

      # xwayland-run


      # vivaldi


      qalculate-gtk


      # gnome-calendar
      # calcure
      # remind

      # jami

      # abaddon
      # revolt-desktop
      # qtox
      # element-web

      # opencomposite
      # libheif
      # feh

      # python312Packages.pip

      # rclone-browser

      rkrlv2

      # sfxr-qt

      tonelib-noisereducer

      mooSpace

      sfxr

      ChowPhaser

      rakarrack

      caps
      tonelib-gfx
      hybridreverb2
      jamesdsp
      stone-phaser
      bslizr
      dragonfly-reverb
      aether-lv2
      fverb
      texlivePackages.moreverb

      ladspaPlugins
      faust2ladspa
      
      # cheese
      # yed
      # tenki

      telegram-desktop


      pamixer

      # urn-timer

      # lunatask
      # pomodoro-gtk
      # pom
      # flitter

      # taskwarrior3
      # taskwarrior-tui
      
      # dijo
      # harsh

      # doing
      # watson

      # libirecovery
      #checkra1n

      # xorg.xhost

      # toipe

      # frostwire-bin

      # nvtopPackages.panfrost

      mplayer

      # anime-downloader
      # radarr

      # fooyin

      #transmission
      # deluge
      # plasma5Packages.ktorrent

      easyeffects

      #idevicerestore

      # soulseekqt

      # tty-share

      # krita

      nemo

      # rocq-core

      ghc


      moonlight-qt


      # plasma5Packages.kdenlive

      # gpxsee
      # gnome-maps

      # oneko

      # smenu

      # vesktop

      # ii
      # kdePackages.konversation
      # cbonsai
      # vtm
      # pscircle
      # tofi

      
      # hyprsunset
      # hyprpolkitagent
      #hyprnotify
      # hyprsysteminfo

      # hyprshade

      # dissent
      # fractal

      # bitwarden

      # grsync
      # rsync

      # kdePackages.marble

      # zrythm

      # kdePackages.okular
      # koodo-reader

      # readarr

      # coolreader

      #inputs.thorium-browser.defaultPackage.${system}

      # foliate

      # bookworm

      # epy

      # cloc

      # gpt4all

      # ninja

      # servo

      #brlcad
      # freecad
      #openscad-unstable

      # whatsapp-for-linux

      # inkscape

      # xinput_calibrator
      # yabridge
      # yabridgectl

      # exercism

      # ffmpeg

      # autotalent

      # dracut

      #rustdesk

      # prismlauncher

      # gdb

      # keypunch

      # vitetris
      # sbclPackages.cl-tetris3d

      mommy

      #sirula

      gdb

      # mesa-demos

      # pulseview
          
      # msr-tools

      # kdePackages.kdeconnect-kde

      # niri
      
      fuzzel

      # piper-tts

      inputs.swww.packages.${pkgs.system}.swww

      # swaylock

      at

      xwayland-satellite

      # keepassxc

      mako

      # fira
      # encode-sans
      # hubot-sans
      # inriafonts
      # garamond-libre
      # maple-mono-SC-NF
      # maple-mono-NF
      # _3270font
      # tewi-font
      # moralerspace
      # ocr-a

      # hachimarupop

      # fontforge
      # fontpreview

      # glslviewer

      chromium
      # gcc

      # taoup

      # python313Packages.psutil

      # opencomposite
      # vapor

      # osu-lazer

      kitty
      alacritty

      # bottles

      # steam-run
      protonup

      tinymist

      bemoji

      tldr

      unrar

      # opentrack-proton
      # opentrack
      # aitrack

      cmake

      rustc

      bat
      # eza
      # gitui
      # dust

      # starship

      # ghostty

      bacon

      rusty-man

      ripgrep-all
      mask
      mprocs

      mdbook

      rustfmt
      rust-analyzer

      lldb

      jujutsu
      # lazyjj


      xxkb
      xkbvalidate
      xkblayout-state

      larynx

      # i3

      heroic
      # legendary-heroic

      # nut

      # gnome-mines
      # freesweep
      # libremines
      # minesweep-rs

      # nudoku
      # gnome-sudoku
      # plasma5Packages.ksudoku

      reaper
      reaper-reapack-extension

      # gnome-usage
      kdePackages.filelight

      # gamescope

      p7zip

      python3

      clang-tools

      # goldendict-ng
      # sdcv
      # wordnet


      # emacsPackages.anki-connect

      github-cli

      # piper-tts
      # marytts
      # ekho
      nyxt

      feh
      gthumb

      upower
      
      signal-desktop
      # kdePackages.kclock

      nixd
      nixdoc

      helvum

      coppwr

      # vencord
      webcord-vencord
      vesktop

      cargo

      haruna

      qemu
      quickgui
      quickemu

      firefox

      jack2
      jack-example-tools

      bankstown-lv2
      lv2
      swh_lv2

      python313Packages.ipython
      ty
      python313Packages.mypy
      # spyder
      python313Packages.pylsp-mypy
      python313Packages.pyls-spyder

      wolfram-engine
    ];
}
