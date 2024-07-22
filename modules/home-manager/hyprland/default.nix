{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = (with outputs.homeManagerModules; [
    hypridle
    hyprlock
  ]) ++ [
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;
  };
}

