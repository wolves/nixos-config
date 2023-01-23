{
  services.syncthing = {
    enable = true;
    user = "wlvs";
    group = "users";
    configDir = "$HOME/.config/syncthing";
  };
}
