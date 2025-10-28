{
  pkgs,
  config,
  inputs,
  ...
}
: 

{
  home.file = {
    ".config/REAPER/UserPlugins/reaper_reapack-x86_64.so" = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
  };
}
