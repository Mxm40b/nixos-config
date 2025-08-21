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
