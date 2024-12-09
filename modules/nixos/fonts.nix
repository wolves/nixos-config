{
  config,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.geist-mono
      powerline
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
