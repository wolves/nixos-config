{
  config,
  ...
}: {
  programs.swaylock.settings = {
    clock = true;
    effect-blur = "30x3";
    font = "Lato";
    ignore-empty-password = true;
    indicator = true;
    image = "$HOME/wallpaper/aenami_escape_1k.jpg";
  };
}

