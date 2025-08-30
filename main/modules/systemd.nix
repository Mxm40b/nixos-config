{ config, lib, pkgs, inputs, ... }:

let
  makePluginPath = format:
        (lib.makeSearchPath format [
          "$HOME/.nix-profile/lib"
          "/run/current-system/sw/lib"
          "/etc/profiles/per-user/$USER/lib"
        ])
        + ":$HOME/.${format}";
in

{
  systemd =
    {
      sleep.extraConfig =
        ''
          AllowSuspend=yes
          AllowHibernation=no
          AllowHybridSleep=no
          AllowSuspendThenHibernate=no
        '';
      user.services.monado.environment =
        {
          STEAMVR_LH_ENABLE = "1";
          XRT_COMPOSITOR_COMPUTE = "1";
          WMR_HANDTRACKING = "0";
        };
      user.extraConfig = "DefaultLimitNOFILE=524288";
      tmpfiles.rules =
        [
          #"d /var/spool/samba 1777 root root -"
          "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
        ];
      user.services.mpris-proxy =
        {
          description = "Mpris proxy";
          after = [ "network.target" "sound.target" ];
          wantedBy = [ "default.target" ];
          serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
        };
      services =
        {
          systemd-journal-flush.enable = false;
          tlp.wantedBy = lib.mkForce [];
          home-manager-mxmfrpr.wantedBy = lib.mkForce [];
          switcheroo-control.wantedBy = lib.mkForce [];
          #fstrim.wantedBy = lib.mkForce [];
          tiny-dfr-better =
            {
              enable = true;
              serviceConfig =
                {
                  Description="Tiny Apple silicon touch bar daemon";
                  After="systemd-user-sessions.service getty@tty1.service plymouth-quit.service systemd-logind.service dev-tiny_dfr>";
                  BindsTo="dev-tiny_dfr_display.device dev-tiny_dfr_backlight.device dev-tiny_dfr_display_backlight.device";

                  ExecStart = "/home/mxmfrpr/projects/tiny-dfr/target/release/tiny-dfr";
                  Restart="always";

                  NoNewPrivileges=true;
                  ProtectSystem="strict";
                  ProtectHome=true;
                  PrivateTmp=true;
                  PrivateIPC=true;
                  ProtectKernelTunables=true;
                  ProtectKernelModules=true;
                  ProtectKernelLogs=true;
                  ProtectControlGroups="strict";
                  RestrictAddressFamilies="AF_UNIX AF_NETLINK";
                  RestrictNamespaces=true;
                  RestrictSUIDSGID=true;

                  # /nix/store/4kjm959rhs5ibscwp97mqjhgl35kv6p7-system-units/tiny-dfr.service.d/overrides.conf

                  # Environment="LOCALE_ARCHIVE=/nix/store/cccr51zb8xj8n5ayb5x6s1cqs3y7r3g7-glibc-locales-2.40-66/lib/locale/locale->;
                  # Environment="PATH=/nix/store/ih779chzzag1nm91fgnrndml4mghm3la-coreutils-9.7/bin:/nix/store/3xi6s71d3znq0ivl2r7yp>;
                  # Environment="TZDIR=/nix/store/ms10flhvgnd1nsfwnb355aw414ijlq8j-tzdata-2025b/share/zoneinfo";
                };
            };
        };
      settings.Manager =
        {
          DefaultTimeoutStartSec = "10s";
          DefaultTimeoutStopSec = "10s";
        };
      user.services.pipewire.environment = 
        {
          LADSPA_PATH = lib.mkForce "${pkgs.ladspaPlugins}/lib/ladspa";
          LV2_PATH    = lib.mkForce "${pkgs.calf}/lib/lv2:${pkgs.lsp-plugins}/lib/lv2";

          # DSSI_PATH   = makePluginPath "dssi";
          # LADSPA_PATH = makePluginPath "ladspa";
          # LV2_PATH    = makePluginPath "lv2";
          # LXVST_PATH  = makePluginPath "lxvst";
          # VST_PATH    = makePluginPath "vst";
          # VST3_PATH   = makePluginPath "vst3";
        };
      
    };
}
