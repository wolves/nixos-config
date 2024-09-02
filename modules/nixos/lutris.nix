{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    (
      lutris.override {
        extraPkgs = pkgs: [
          pkgs.libnghttp2
          pkgs.winetricks
        ];
      }
    )
  ];
}
