{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };

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

      # GIT;
      gad="git add .";
      gc="git commit";
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
}
