{ config, pkgs, lib, ... }:

{
    # enable OpenGL
    hardware.opengl.enable = true;

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

  programs.sway.extraSessionCommands = ''
      export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
      export WLR_RENDERER=vulkan
  '';

}
