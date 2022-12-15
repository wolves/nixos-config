{
  pkgs,
  lib,
  config,
  ...
}: {
  # Manage Extra Files in ~
  home.file."${config.xdg.dataHome}/fonts/ProductSans".source = lib.cleanSourceWith {
    filter = name: _: (lib.hasSuffix ".ttf" (baseNameOf (toString name)));
    src = pkgs.fetchzip {
      url = "https://befonts.com/wp-content/uploads/2018/08/product-sans.zip";
      sha256 = "sha256-PF2n4d9+t1vscpCRWZ0CR3X0XBefzL9BAkLHoqWFZR4=";
      stripRoot = false;
    };
  };
  home.file."${config.xdg.dataHome}/fonts/IosevkaWlvs".source = lib.cleanSourceWith {
    filter = name: _: (lib.hasSuffix ".ttf" (baseNameOf (toString name)));
    src = pkgs.fetchzip {
      url = "https://github.com/wolves/iosevka-wlvs/archive/refs/tags/v1.0.0.zip";
      sha256 = "sha256-XwFOxkQrR3CeOq4jOYYHdgPyigjS7ah287qwZAJ710E=";
      stripRoot = false;
    };
  };
}
