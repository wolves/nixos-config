{
  bluetooth = import ./bluetooth.nix;
  doas = import ./doas.nix;
  fonts = import ./fonts.nix;
  hyprland = import ./hyprland.nix;
  network = import ./network.nix;
  power = import ./power.nix;
  sshd = import ./sshd.nix;
}
