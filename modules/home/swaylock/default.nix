{
  config,
  ...
}: {
  programs.swaylock.settings = let
    # TODO: Update colors to use a global color theme
    crust = "#16161D"; # Kanagawa SumiInk0
    base = "#1F1F28"; #Kanagawa SumiInk1
    sumiInk4 = "#54546D";

    red = "#E46867"; # Kanagawa WaveRed
    blue = "#7E9CD8"; # Kanagawa CrystalBlue
    yellow = "#DCA561"; # Kanagawa AutumnYellow
    orange = "#FFA066"; # Kanagawa SurimiOrange
  in {
    image = "$HOME/wallpaper/lightbars.png";
    effect-blur = "30x3";

    scaling = "fill";

    indicator = true;
    indicator-x-position = "930";
    indicator-y-position = "515";
    indicator-radius = "456";
    clock = true;
    ignore-empty-password = true;
    disable-caps-lock-text = true;

    timestr = "%I:%M %p";
    datestr = "";

    font = "Product Sans";
    font-size = "52";
    text-color = "${blue}";

    text-ver-color = "00000000";
    text-wrong-color = "00000000";
    text-clear-color = "00000000";
    inside-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    inside-clear-color = "00000000";
    inside-caps-lock-color = "00000000";
    ring-color = "00000000";
    ring-ver-color = "00000000";
    ring-wrong-color = "00000000";
    ring-clear-color = "00000000";
    line-color = "00000000";
    line-clear-color = "00000000";
    line-ver-color = "00000000";
    key-hl-color = "00000000";
    bs-hl-color = "00000000";
    caps-lock-bs-hl-color = "00000000";
    caps-lock-key-hl-color = "00000000";
    separator-color = "00000000";

    # bs-hl-color = "${red}";
    # key-hl-color = "${orange}";
    # inside-clear-color = "${red}";
    # inside-color = "${yellow}";
    # inside-ver-color = "${blue}";
    # inside-wrong-color = "${red}";
    # line-color = "${crust}";
    # ring-color = "${base}";
    # separator-color = "${sumiInk4}";
  };
}

