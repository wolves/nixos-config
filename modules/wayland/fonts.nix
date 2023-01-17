{
  config,
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      #material-icons
      material-design-icons
      carlito
      vegur
      inter
      iosevka-bin
      lato
      source-code-pro
      noto-fonts
      noto-fonts-emoji
      font-awesome
      jetbrains-mono
      corefonts
      (nerdfonts.override {
        fonts = [
          "Iosevka"
          "JetBrainsMono"
          "FiraCode"
        ];
      })
    ];

    enableDefaultFonts = false;

    fontconfig = {
      defaultFonts ={
        monospace = [
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
