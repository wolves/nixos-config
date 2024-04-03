{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = lib.mkForce false;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };
}
