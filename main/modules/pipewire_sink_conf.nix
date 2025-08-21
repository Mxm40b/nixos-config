# SPDX-License-Identifier: MIT
# (C) 2022 The Asahi Linux Contributors

{ config, pkgs, lib, ... }:

let
  t2AppleAudioDSP = pkgs.fetchFromGitHub {
    owner = "lemmyg";
    repo = "t2-apple-audio-dsp";
    rev = "fdd10303c8e84d09cf31e8cd88a624a34b9ed186";
    sha256 = "UnoZMONaYyhXkntTN+iUwcyjSquIgcw/Tw+ooNX9CzA=";
  };
  originalTweeterFilePath = "/usr/share/pipewire/devices/apple/macbook_pro_t2_16_1_tweeters-48k_4.wav";
  newTweeterFilePath = "${t2AppleAudioDSP}/firs/macbook_pro_t2_16_1_tweeters-48k_4.wav";
  originalWooferFilePath = "/usr/share/pipewire/devices/apple/macbook_pro_t2_16_1_woofers-48k_4.wav";
  newWooferFilePath = "${t2AppleAudioDSP}/firs/macbook_pro_t2_16_1_woofers-48k_4.wav";

  configFile = "${t2AppleAudioDSP}/config/10-t2_161_speakers.conf";

  t2ConfigPkg = pkgs.stdenv.mkDerivation {
    name = "t2-speaker-config";
    src = t2AppleAudioDSP;

    buildInputs = [ pkgs.coreutils ]; # For `mkdir`, `sed`, etc.

    buildPhase = ''
      set -eu
      mkdir -p $out/share/pipewire/pipewire.conf.d
      sed -e 's|${originalTweeterFilePath}|${newTweeterFilePath}|g' \
          -e 's|${originalWooferFilePath}|${newWooferFilePath}|g' \
          "${configFile}" > "$out/share/pipewire/pipewire.conf.d/10-t2_161-sink.conf"
    '';

    # Skip installation phase since buildPhase already places files correctly
    installPhase = "true";

    # Add passthru.requiredLv2Packages
    passthru.requiredLv2Packages = [
      # Replace with actual LV2 packages, e.g., pkgs.someLv2Plugin
      # Example: pkgs.lsp-plugins
      pkgs.lsp-plugins
      pkgs.ladspaPlugins
      pkgs.calf
    ];
  };
in
{
  services.pipewire.configPackages = [
    t2ConfigPkg
  ];
}
