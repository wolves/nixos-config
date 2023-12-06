{ config, pkgs, email, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.userName = "Wolves";
  programs.git.userEmail = email;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
}
