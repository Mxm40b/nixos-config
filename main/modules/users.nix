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
          packages = with pkgs; [
            tree
          ];
          shell = pkgs.nushell;
        };
      groups.realtime = { };
    };
}
