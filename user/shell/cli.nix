{ config, pkgs, ... }:

{
  imports = [
    ./tmux
  ];
  
  home.packages = with pkgs; [
    killall
    libnotify
    eza fd bottom ripgrep
    tealdeer
    duf
    zoxide
    fzf
    rsync
    unzip
    brightnessctl

    (pkgs.writeShellScriptBin "dvd" ''
      #!/bin/sh
      echo "use flake \"github:the-nix-way/dev-templates?dir=$1\"" >> .envrc
      direnv allow
    '')
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "base16-256";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
