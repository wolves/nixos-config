{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      directory = {
        style = "blue";
        read_only = " ";
        format = " [$path]($style)[$read_only]($read_only_style) ";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };

      git_branch = {
        symbol = " ";
        format = "[$branch]($style) ";
        style = "bright-black";
      };

      git_status = {};
    };
  };
}

