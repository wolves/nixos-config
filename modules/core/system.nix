{
  config,
  pkgs,
  ...
}: {
  services.dbus = {
    packages = with pkgs; [dconf];
    enable = true;
  };

  environment.variables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BAT_THEME="gruvbox-dark";
    BROWSER="firefox";
  };

  environment.systemPackages = with pkgs; [
    git
    nano
    vim
    pciutils
    rust-bin.stable.latest.default
    usbutils
    wget
  ];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.utf8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
