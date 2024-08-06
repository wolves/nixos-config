{
  config,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["GeistMono"];})
      # powerline
      iosevka
      font-awesome
      ubuntu_font_family
      terminus_font
      intel-one-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["GeistMono Nerd Font"];
      };
    };
  };
}
