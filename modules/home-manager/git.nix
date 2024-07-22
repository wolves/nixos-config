{ config, pkgs, email, ... }:

{
  programs.git = {
    enable = true;
    userName = "wolves";
    userEmail = email;
    extraConfig = {
      github.user = "wolves";
      init.defaultBranch = "main";
      branch ={
        autosetupmerge = true;
        autosetuprebase = "always";
      };
      rerere.enabled = 1;
    };
  };
}

