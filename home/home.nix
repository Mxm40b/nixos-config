{
  pkgs,
  config,
  inputs,
  ...
}
: 

{
  home.username = "mxmfrpr";
  home.homeDirectory = "/home/mxmfrpr";

  imports =
    [
      # ./modules/waybar.nix
      ./modules/wlogout.nix
      inputs.plover-flake.homeManagerModules.plover

      ./modules/programs.nix
      ./modules/packages.nix

      # ./modules/services.nix
    ];



    wayland.windowManager.hyprland = {
      enable = false;
      package = pkgs.hyprland;
      xwayland.enable = true;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      systemd.enable = true;
      
      plugins =
        [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        ];
      
      settings =
        {
          
        };
    };




  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

   
    
  gtk = {
    enable = true;
    cursorTheme =
      {
        #package = pkgs.vimix-cursors;
        package = pkgs.afterglow-cursors-recolored;
        name = "Afterglow-Recolored-Catppuccin-Sapphire";
        size = 24;
      };
    theme =
      {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

    iconTheme =
      {
        name = "Adwaita";
        # name = "candy-icons";
        package = pkgs.adwaita-icon-theme;
        # package = pkgs.candy-icons;
      };
  };

  qt =
    {
      enable = true;
      style =
        {
          name = "adwaita-dark";
          package = pkgs.adwaita-qt;
        };
    };

  home.pointerCursor =
    {
      gtk.enable = true;
      x11.enable = true;
      name = "Afterglow-Recolored-Catppuccin-Sapphire";
      size = 24;
      package = pkgs.afterglow-cursors-recolored;
    };

  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  
}
