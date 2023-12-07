{ config, pkgs, ... }:
let
  myAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";

    ls = "exa -al --color=always --group-directories-first";
    la = "exa -a --color=always --group-directories-first"; # all files and dirs
    ll = "exa -aalgh --color=always --group-directories-first"; # long format
    lt = "exa -aT --color=always --group-directories-first"; # tree listing
    "l." = "exa -a | rg '^\.'";

    md = "mkdir";

    # confirm before overwriting something
    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -iv";

    # GIT
    gad = "git add .";
    gc = "git commit -m";
    gcl = "git clone";
    gco = "git checkout";
    gd = "git diff";
    gl = "git log --oneline --graph --decorate";
    gp = "git push";
    gpf = "git push -f";
    gpr = "git pull --rebase";
    grc = "git rebase --continue";
    gs = "git status --short --branch";
  };

  myFuncs = {
    g = {
      body = ''
	if count $argv >/dev/null
          git $argv
	else
          git status --short --branch
	end
      '';
    };
  };
in
{
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    functions = myFuncs;
    interactiveShellInit = ''
      set -Ux fish_greeting
      ${pkgs.zoxide}/bin/zoxide init fish | source
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };

  programs.starship.enable = true;
  programs.starship.settings = {
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
}
