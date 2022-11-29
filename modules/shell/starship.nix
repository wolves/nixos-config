{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      # format = """
      # $username\
      # $hostname\
      # $directory\
      # $git_branch\
      # $git_state\
      # $git_status\
      # $cmd_duration\
      # $line_break\
      # $python\
      # $character"""
      
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
      # format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)"
      # style = "cyan"
      # conflicted = "​"
      # untracked = "​"
      # modified = "​"
      # staged = "​"
      # renamed = "​"
      # deleted = "​"
      # stashed = "≡"
      
      # [git_state]
      # format = '\([$state( $progress_current/$progress_total)]($style)\) '
      # style = "bright-black"
      
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      golang.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = " ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      
      nodejs = {
        symbol = " ";
        version_format = "\${raw}";
        format = "\[[$symbol($version)]($style)\] ";
      };
      
      package.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      
      python = {
        symbol = " ";
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
      
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = " ";
      swift.symbol = "ﯣ ";
    };
  };
}
