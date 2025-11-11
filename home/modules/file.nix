{
  pkgs,
  config,
  inputs,
  ...
}
: 

{
  home.file = {
    # ".config/REAPER/UserPlugins/reaper_reapack-x86_64.so".source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
    # ".config/REAPER/UserPlugins/sws/".source = "${pkgs.reaper-sws-extension}/UserPlugins/";
  };
}
