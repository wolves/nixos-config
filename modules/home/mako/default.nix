{ config, ... }:

{
  programs.mako = {
    enable = true;
    # iconPath = 
    font = "Lato 12";
    margin = "8";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#2A2A37";
    borderColor = "#54546D";
    textColor = "#DCD7BA";
  };
}
