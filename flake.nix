{


  description = "1997 original nixOS flake";

  nixConfig = {
    extra-substituters = ["https://cache.soopy.moe" "https://nix-gaming.cachix.org"];
    extra-trusted-public-keys = ["cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
  
  inputs =
    {
      lix =
        {
          url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
          flake = false;
        };
      lix-module =
        {
          url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
          inputs.nixpkgs.follows = "nixpkgs";
          inputs.lix.follows = "lix";
        };
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixos-hardware.url = "github:NixOS/nixos-hardware";
      home-manager =
        {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      zen-browser =
        {
          url = "github:youwen5/zen-browser-flake";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      musnix =
        {
          url = "github:musnix/musnix";
        };
      nur =
        {
          url = "github:nix-community/NUR";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      glaumar_repo =
        {
          url = "github:glaumar/nur";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      hyprland.url = "github:hyprwm/Hyprland";

      hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
      };
      nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
      plover-flake.url = "github:openstenoproject/plover-flake";
      swww.url = "github:LGFae/swww";
    };



  outputs =
    {
      # lix-module,
      # lix,
      #self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      zen-browser,
      nur,
      nixpkgs-xr,
      ...
    }@inputs:
    
  let
    pkgs = import nixpkgs
      {
        system = "x86_64-linux";
        config =
          {
            allowUnfree = true;
          };
        config.permittedInsecurePackages =
          [
            "electron-27.3.11"
            # "ventoy-1.1.05"
            "ventoy-1.1.07"
            "qtwebengine-5.15.19"
          ];
      };
    #nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations =
      {
        nixos = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules =
              [
                # lix-module.nixosModules.default
                
                ({
                nixpkgs.overlays =
                  [
                    (final: prev: {
                      glaumar_repo = inputs.glaumar_repo.packages."${prev.system}";
                    })
                  ];
                })
              {
                nixpkgs.overlays =
                  [
                    nur.overlays.default
                  ];
                nixpkgs.config.allowUnfree = true;
              }
            nixpkgs-xr.nixosModules.nixpkgs-xr
            inputs.musnix.nixosModules.musnix
              {
                musnix.enable = true;
              }
            ./main/configuration.nix
            ./hardware-configuration.nix
              {
                nixpkgs.config.allowUnfree = true;
              }
            nixos-hardware.nixosModules.apple-t2
            
            home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = { inherit pkgs; inherit inputs; };
                #home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                
                home-manager.users.mxmfrpr = import ./home/home.nix;
                
                # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                nixpkgs.config.allowUnfree = true;
                nixpkgs.config.allowBroken = true;
              }
          
          ];
        #specialArgs = { inherit inputs; };

        specialArgs = inputs;
      };
    };
  };
}
