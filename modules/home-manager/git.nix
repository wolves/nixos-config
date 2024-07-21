{ config, pkgs, email, ... }:

{
  programs.git = {
    enable = true;
    userName = "Wolves";
    userEmail = email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

