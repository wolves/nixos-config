{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "wolves";
      userEmail = "cstingl@protonmail.com";
      extraConfig = {
        init = { defaultBranch = "main";};
        rerere.enabled = true;
        push.default = "current";
        merge.stat = "true";
        branch = {
          autosetupmerge = "true";
          autosetuprebase = "always";
        };
        delta = {
          syntax-theme = "Nord";
          line-numbers = true;
        };
      };
      lfs.enable = true;
      delta.enable = true;
      aliases = {
      };
    };

    fish = {
      enable = true;
      # vendor = {
      #   completions.enable = true;
      #   config.enable = true;
      #   functions.enable = true;
      # };

      interactiveShellInit = ''
        set -g fish_greeting ""

        function g
          if count $argv > /dev/null
            git $argv
          else
            git status --short --branch
          end
        end

        # Bang Bang
        function __history_previous_command
          switch (commandline -t)
          case "!"
            commandline -t $history[1]; commandline -f repaint
          case "*"
            commandline -i !
          end
        end

        function __history_previous_command_arguments
          switch (commandline -t)
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
          end
        end
        # Bindings for !! and !$
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments


        function backup --argument filename
          cp $filename $filename.bak
        end

        ${pkgs.zoxide}/bin/zoxide init fish | source
        ${pkgs.starship}/bin/starship init fish | source
        ${pkgs.direnv}/bin/direnv hook fish | source
      '';

      shellAliases = {
        # Navigation
        ".."="cd ..";
        "..."="cd ../..";
        ".3"="cd ../../..";
        ".4"="cd ../../../..";
        ".5"="cd ../../../../..";
        
        # Appliications
        vim="nvim";
        vi="nvim";
        nv="nvim";
        tm="tmux";
        
        # Filess and Folders
        # li > exa
        ls="exa -al --color=always --group-directories-first";
        la="exa -a --color=always --group-directories-first";  # all files and dirs
        ll="exa -aalgh --color=always --group-directories-first";  # long format
        lt="exa -aT --color=always --group-directories-first"; # tree listing
        # l.=\exa -a | rg '^\.'";
        
        md="mkdir";
        # confirm before overwriting something
        cp="cp -iv";
        mv="mv -iv";
        rm="rm -iv";

        gad="git add .";
        gc="git commit -m";
        gcam="git commit --amend -m";
        gcl="git clone";
        gco="git checkout";
        gd="git diff";
        gl="git log --oneline --graph --decorate";
        gp="git push";
        gpf="git push -f";
        gpr="git pull --rebase";
        grc="git rebase --continue";
        gs="git status --short --branch";
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
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
          format = "[$symbol($version)]($style) ";
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

    tmux = {
      enable = true;
      baseIndex = 1;
      extraConfig = builtins.readFile ./tmux.conf;
      escapeTime = 30;
      keyMode = "vi";
      shortcut = "a";
      terminal = "xterm-256color";

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.online-status
        tmuxPlugins.pain-control
      ];
    };
  };
}
