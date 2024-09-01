{ config, pkgs, lib, ... }:

{
  # enable OpenGL
  hardware.opengl.enable = true;

  # have to use nouveau for sway
  services.xserver.videoDrivers = ["nouveau"];
}
