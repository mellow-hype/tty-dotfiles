{ config, pkgs, lib, ... }:

{
  # enable OpenGL
  hardware.opengl.enable = true;

  # NVIDIA setup
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;

}
