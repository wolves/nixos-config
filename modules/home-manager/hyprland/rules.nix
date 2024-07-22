{ config, pkg, ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opaque, class:^(org.pwmt.zathura)$"
    ];
  };
}

