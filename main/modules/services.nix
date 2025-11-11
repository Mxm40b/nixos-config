{ config, lib, pkgs, inputs, ... }:

{
  services =
    {
      journald.extraConfig =
        ''
          SystemMaxFileSize=50M
          RuntimeMaxUse=10M
        '';

      logind =
        {
          settings.Login =
            {
              HandleLidSwitch = "lock";
              HandlePowerKey = "lock";
              HandlePowerKeyLongPress = "poweroff";
              KillUserProcesses = true;
            };
        };
      thermald.enable = true;
      tlp =
        {
          enable = true;
          settings =
            {
              # INTEL_GPU_MIN_FREQ_ON_AC = 350;
              # INTEL_GPU_MAX_FREQ_ON_AC = 600;
              #INTEL_GPU_MIN_FREQ_ON_BAT = 100;
              # CPU_SCALING_GOVERNOR_ON_AC = "powersave";
              CPU_SCALING_GOVERNOR_ON_AC = "performance";
              CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
              # CPU_SCALING_GOVERNOR_ON_BAT = "performance";
  
              CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
              # CPU_ENERGY_PERF_POLICY_ON_AC = "power";
              CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
              # CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";

  
              CPU_MIN_PERF_ON_AC = 0;
              # CPU_MAX_PERF_ON_AC = 12;
              CPU_MAX_PERF_ON_AC = 80;
              CPU_MIN_PERF_ON_BAT = 0;
              CPU_MAX_PERF_ON_BAT = 80;
  
              # Optional helps save long term battery health
              START_CHARGE_THRESH_BAT0 = 20; # 40 and bellow it starts to charge
              STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
            };
        };
      power-profiles-daemon.enable = false;
      blueman.enable = true;
      pipewire = 
        # {
        #   enable = true;
        #   pulse.enable = true;
        # }
        {
          enable = true;
          wireplumber.enable = true;
          pulse.enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          jack.enable = true;
          extraConfig.pipewire."92-low-latency" =
            {
             "context.properties" =
               {
                 "default.clock.rate" = 48000;
                 "default.clock.quantum" = 1024;
                 "default.clock.min-quantum" = 256;
                 "default.clock.max-quantum" = 1024;
               };
             "pulse.properties" =
               {
                 "pulse.min.req" = "32/48000";
                 "pulse.default.req" = "1024/48000";
                 "pulse.max.req" = "1024/48000";
                 "pulse.max.quantum" = "1024/48000";
               };
             "stream.properties" =
               {
                 "node.latency" = "64/48000";
                 "resample.quality" = 0.1;
               };
            };
          wireplumber.extraConfig =
            {
              "10-bluez" =
                {
                  "monitor.bluez.properties" =
                    {
                     "bluez5.enable-sbc-xq" = true;
                     "bluez5.enable-msbc" = true;
                     "bluez5.enable-hw-volume" = true;
                     "bluez5.roles" =
                       [
                         "hsp_hs"
                         "hsp_ag"
                         "hfp_hf"
                         "hfp_ag"
                         "a2dp_sink"
                         "a2dp_source"
                       ];
                    };
                };
              # "60-apple-t2-profile" =
              #   {
              #     "monitor.alsa.rules" =
              #       [
              #         {
              #           matches =
              #             [
              #               { "device.name" = "alsa_card.pci-0000_04_00.3"; }
              #             ];
              #           actions =
              #             {
              #               update-props =
              #                 {
              #                   "device.profile" = "Default";
              #                 };
              #             };
              #         }
              #       ];
              #   };
            };
          extraLv2Packages =
            [
              pkgs.lsp-plugins
              pkgs.ladspaPlugins
              pkgs.calf
              pkgs.bankstown-lv2
              pkgs.lv2
              pkgs.swh_lv2
            ];
        };
    # pulseaudio.enable = lib.mkForce true;
     pulseaudio =
       {
         enable = false;
         daemon.config = {
           default-sample-format = "s24le";
           default-sample-rate = "48000";
           alternate-sample-rate = "44100";
           resample-method = "soxr-vhq";
           default-fragments = "4";
           default-fragment-size-msec = "10";
         };
       };
      #getty.autologinUser = "mxmfrpr";
      ollama =
        {
          enable = false;
          #rocmOverrideGfx = "10.1.2";
        };
      #xserver = {
        #xkb.layout = "us,,";
        #xkbVariant = "colemak,,";
        #xkbOptions = "grp:alt_space_toggle caps:swapescape";
      #};
      
          
      printing =
        {
          enable = false;
          listenAddresses = [ "*:631" ];
          allowFrom = [ "all" ];
          browsing = true;
          defaultShared = true;
          openFirewall = true;
          drivers = with pkgs;
            [
              gutenprint
              #cnijfilter2
            ];
        };
      wivrn =
        {
          enable = false;
          openFirewall = true;
          defaultRuntime = true;
          autoStart = false;
          config =
            {
              enable = true;
              json =
                {
                  # 1.0x foveation scaling
                  scale = 1.0;
                  # 100 Mb/s
                  bitrate = 10000000;
                  encoders =
                    [
                      {
                        encoder = "vaapi";
                        codec = "h265";
                        # 1.0 x 1.0 scaling
                        width = 1.0;
                        height = 1.0;
                        offset_x = 0.0;
                        offset_y = 0.0;
                      }
                    ];
                };
            };
        };
      usbmuxd =
        {
          enable = false;
          #package = pkgs.usbmuxd2;
        };
      sunshine =
        {
          enable = false;
          autoStart = true;
          capSysAdmin = true;
          openFirewall = true;
        };
      geoclue2 =
        {
          enable = true;
          #appConfig."org.gnome.Maps" = {
          #  isAllowed = true;
          #  isSystem = false;
          #};
          appConfig."firefox" = {
            isAllowed = true;
            isSystem = false;
          };
          geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
        };
      automatic-timezoned =
        {
          enable = true;
        };
      systembus-notify.enable = false;
      udev.extraRules =
        ''
            KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput",
            SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="low"
            KERNEL=="cpu_dma_latency", GROUP="realtime"
        '';
      switcherooControl.enable = true;
      safeeyes.enable = false;
      gnome.at-spi2-core.enable = true;
      displayManager = {
        gdm.enable = false;
      };
      desktopManager = {
        gnome.enable = false;
      };

      # greetd = {
      #   enable = true;
      #   settings = rec {
      #     initial_session = {
      #       command = "sh -c `systemctl stop tiny-dfr; sleep 2sec; .//home/mxmfrpr/projects/tiny-dfr/result/bin/tiny-dfr; sleep 2sec; su mxmfrpr; sleep 2sec; ${pkgs.niri}/bin/niri-session`";
      #       user = "root";
      #     };
      #     default_session = initial_session;
      #   };
      # };

      greetd =
        let
          niri-config = pkgs.writeText "niri-config" ''
            hotkey-overlay {
                skip-at-startup
            }
            environment {
                GTK_USE_PORTAL "0"
                GDK_DEBUG "no-portals"
            }
            input {
              keyboard {
                  xkb {
                      layout "us,us,ru"
                      variant "colemak,,"
                      // You can set rules, model, layout, variant and options.
                      // For more information, see xkeyboard-config(7).

                      // For example:
                      // layout "us,ru"
                      // options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
                      options "caps:swapescape, grp:alt_space_toggle"
                  }

                  // Enable numlock on startup, omitting this setting disables it.
                  numlock
              }

              // Next sections include libinput settings.
              // Omitting settings disables them, or leaves them at their default values.
              touchpad {
                  // off
                  // tap
                  // dwt
                  // dwtp
                  // drag false
                  // drag-lock
                  natural-scroll
                  accel-speed 0.3
                  // accel-profile "flat"
                  // scroll-method "two-finger"
                  // disabled-on-external-mouse
              }

              mouse {
                  // off
                  // natural-scroll
                  accel-speed 0.18
                  accel-profile "flat"
                  // scroll-method "no-scroll"
              }
            }


            // window-rule {
            //   match is-focused=true
            //   match at-startup=true


            //   open-on-output "eDP-2"
            // }




            // other settings

            // output "eDP-2" {
            //   off
            // }

            spawn-at-startup "sh" "-c" "`${pkgs.gtkgreet}/bin/gtkgreet; pkill -f niri`"
            // spawn-at-startup "kitty" "tuigreet" "--cmd" "niri-session" ";" "pkill" "-f" "niri"
            // spawn-at-startup "waybar"
            '';
        in
          {
            enable = true;
            settings = {
              default_session = {
                # command = "niri -c ${niri-config}";
                # command = "niri-session";
                # command = "niri -c ${niri-config}";
                command = "tuigreet --cmd niri-session";
                user = "greeter";
              };
            };
          };

    };
    programs.regreet.enable = false;
}
