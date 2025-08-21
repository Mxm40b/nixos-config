{
  pkgs,
  config,
  inputs,
  ...
}
: 

{
  programs =
    {
      home-manager.enable = true;
      neovim =
        {
          enable = false;
          defaultEditor = false;
          viAlias = true;
          plugins =
            with pkgs.vimPlugins;
            [
  	          vim-startify
              neoscroll-nvim
  	          true-zen-nvim
  	        ];
        };
      hyprlock =
        {  
          enable = false;
          settings =
            {
              animations =
                {
                  enable = false;
                };
              general =
                {
                  grace = 0;
                  hide_cursor = true;
                };
            
              background = [
                {
                  path = "screenshot";
                  blur_passes = 3;
                  blur_size = 8;
                }
              ];
            
              input-field =
                [
                  {
                    size = "200, 50";
                    position = "0, -80";
                    monitor = "";
                    dots_center = true;
                    fade_on_empty = false;
                    font_color = "rgb(202, 211, 245)";
                    inner_color = "rgb(91, 96, 120)";
                    outer_color = "rgb(24, 25, 38)";
                    outline_thickness = 5;
                    placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
                    shadow_passes = 2;
                  }
                ];
            };
        };
      plover =
        {
          enable = true;
          # package = inputs.plover-flake.packages.${pkgs.system}.plover-full;
          package = inputs.plover-flake.packages.${pkgs.system}.plover.withPlugins (
            ps: with ps; [
              plover-lapwing-aio
              plover-wtype-output
            ]
          );
        };
      # safeeyes.enable = true;
    
      # snixembed =
      #   {
      #     enable = true;
      #     beforeUnits =
      #       [
      #         "safeeyes.service"
      #       ];
      #   };
      # steam = {
      #   enable = true;
      #   remotePlay.openFirewall = true; 
      #   dedicatedServer.openFirewall = true; 
      #   localNetworkGameTransfers.openFirewall = true;
      # };
    };

}
