{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;
    # scripts = with pkgs; [
    #   mpvScripts.mpris
    #   mpvScripts.uosc
    #   mpvScripts.mpv-cheatsheet
    #   # mpvScripts.visualizer
    #   mpvScripts.cutter
    #   mpvScripts.autoload
    #   mpvScripts.thumbfast
    #   mpvScripts.vr-reversal
    #   mpvScripts.webtorrent-mpv-hook
    #   mpvScripts.quality-menu
    # ];
    # config = {
    #   osd-bar = "no";
    #   border = "no";
    # };
  };
}
