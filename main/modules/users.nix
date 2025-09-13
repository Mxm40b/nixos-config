{ config, lib, pkgs, inputs, ... }:

{
  users =
    {
      users.mxmfrpr =
        {
        
      
          isNormalUser = true;
          extraGroups =
            [
              "wheel" "networkmanager" "video" "input" "realtime"
              #"audio" "jackaudio"
              "dialout"
            ]; 
          shell = pkgs.nushell;
          home = "/home/mxmfrpr";
        };
      groups.realtime = { };
      
      users.greeter =
        {
          isSystemUser = true;
          extraGroups =
            [
              "wheel" "networkmanager" "video" "input" "realtime"
              #"audio" "jackaudio"
              "dialout"
            ]; 
        };
    };
}
