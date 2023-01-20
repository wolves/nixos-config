{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libsixel
  ];
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        shell = "${pkgs.tmux}/bin/tmux";
        term = "xterm-256color";
        font = "Iosevka Nerd Font Mono:size=12,monospace:size=12";
        pad = "6x6 center";
        dpi-aware = "auto";
        # dpi-aware = "yes";
      };
      colors = {
        alpha = "0.9";
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

        bright0  = "727169";
        bright1  = "e82424";
        bright2  = "98bb6c";
        bright3  = "e6c384";
        bright4  = "7fb4ca";
        bright5  = "938aa9";
        bright6  = "7aa89f";
        bright7  = "dcd7ba";

        "16"       = "ffa066";
        "17"       = "ff5d62";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
