{
  config,
  pkgs,
  ...
}: let
  myAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";

    nv = "nvim";

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

    dcm = "docker-compose";
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
in {
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    functions = myFuncs;
    interactiveShellInit = ''
      set -Ux fish_greeting

      set -e fish_user_paths
      set -U fish_user_paths $GOPATH/bin $fish_user_paths

      ${pkgs.zoxide}/bin/zoxide init fish | source
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };
}

