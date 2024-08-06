{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    foot
  ];

  programs.foot.enable = true;
  programs.foot.settings = {
    main = {
      # font = "GeistMono Nerd Font:size=9.5:fontfeatures=calt:fontfeatures=dlig:fontfeatures=liga";
      # box-drawings-uses-font-glyphs = "yes";
      font = "Iosevka:size=10";
      font-size-adjustment = 1;
      dpi-aware = "no";
    };
    mouse.hide-when-typing = "yes";

    key-bindings = {
      scrollback-up-line = "Control+Shift+k";
      scrollback-down-line = "Control+Shift+j";
    };

    colors = {
      foreground = "dcd7ba";
      background = "1f1f28";
      selection-foreground = "c8c093";
      selection-background = "2d4f67";
      regular0 = "090618";
      regular1 = "c34043";
      regular2 = "76946a";
      regular3 = "c0a36e";
      regular4 = "7e9cd8";
      regular5 = "957fb8";
      regular6 = "6a9589";
      regular7 = "c8c093";
      bright0 = "727169";
      bright1 = "e82424";
      bright2 = "98bb6c";
      bright3 = "e6c384";
      bright4 = "7fb4ca";
      bright5 = "938aa9";
      bright6 = "7aa89f";
      bright7 = "dcd7ba";
      "16" = "ffa066";
      "17" = "ff5d62";
    };
  };
}
