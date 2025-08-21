{ config, lib, pkgs, inputs, ... }:

{
  boot =
    {
      loader =
        {
          efi.efiSysMountPoint = "/boot";
          #efi.canTouchEfiVariables = true;
          systemd-boot =
            {
              enable = true;
            };
          timeout = 0;
        };

      kernelModules = [ "hid_apple" ];
      kernelParams =
        [ 
          "CONFIG_MODULE_FORCE_UNLOAD=y"
          #"video=3072x1920"
          "splash"
          "quiet"
        
          "intel_iommu=on"
          "iommu=pt"
          "pcie_ports=compat"
        
          #"i915.enable_guc=3"
          #"kvm.enable_virt_at_load=0"

          "video=eDP-2:d"
        ];
      initrd.kernelModules = [ "amdgpu" ];
      #initrd.availableKernelModules = [ "nvme" "ext4" ];
    
      modprobeConfig.enable = true;
      extraModprobeConfig = ''options apple-gmux force_igd=y'';
    };
}
