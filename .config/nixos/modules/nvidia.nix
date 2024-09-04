{ config, pkgs, lib, variables, ... }:

{
    # Set this var to true to let other config files know
    variables.useNvidia = true;

    # set videoDrivers for GUI
    services.xserver.videoDrivers = ["nvidia"];

    # enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        extraPackages = with pkgs; [
            vulkan-tools
            vulkan-validation-layers
            mesa
        ];
    };

    # load modules explicitly
    boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

    # NVIDIA setup
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaPersistenced = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

}
