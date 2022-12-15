{
  config,
  ...
}: {
  programs.swaylock.settings = let
    # TODO: Update colors to use a global color theme
    crust = "#16161D"; # Kanagawa SumiInk0
    base = "#1F1F28"; #Kanagawa SumiInk1
    sumiInk4: = "#54546D";

    red = "#E46867"; # Kanagawa WaveRed
    blue = "#7E9CD8"; # Kanagawa CrystalBlue
    yellow = "#DCA561"; # Kanagawa AutumnYellow
    orange = "#FFA066"; # Kanagawa SurimiOrange
  in {
    clock = true;
    effect-blur = "30x3";
    font = "Lato";
    ignore-empty-password = true;
    indicator = true;
    image = "$HOME/wallpaper/aenami_escape_1k.jpg";
    bs-hl-color = ${red};
    key-hl-color = ${orange};
    inside-clear-color = ${red};
    inside-color = ${yellow};
    inside-ver-color = ${blue};
    inside-wrong-color = ${red};
    line-color = ${crust};
    ring-color = ${base};
    separator-color = ${sumiInk4};
  };
}

