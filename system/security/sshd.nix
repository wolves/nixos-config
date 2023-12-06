{ config, pkgs, ... }:

{
  services.openssh = {
    enable = false;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };
}
