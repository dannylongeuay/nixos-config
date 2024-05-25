{
  programs = {
    fish = {
      shellAbbrs = {
        ga = "git add -A";
        gap = "git add -p";
        gb = "git branch";
        gbd = "git branch -d";
        gbD = "git branch -D";
        gc = "git checkout";
        gcb = "git checkout -b";
        gd = "git diff";
        gdh = "git diff HEAD";
        gds = "git diff --staged";
        glo = "git log --oneline";
        gm = "git merge";
        gma = "git merge --abort";
        gmc = "git merge --continue";
        gpl = "git pull";
        gpu = "git push";
        gs = "git status";
        g = "git";
      };
      functions = {
        _gcm = ''
          argparse h/help b/breaking -- $argv
          set -l breaking ""
          set -l cmd
          if set -q _flag_breaking
              set breaking '!'
          end
          switch (count $argv)
              case 4
                  set cmd git commit -m "\"$argv[1]($argv[3])$breaking: $argv[2] $argv[4..-1]\""
              case 3
                  set cmd git commit -m "\"$argv[1](*)$breaking: $argv[2] $argv[3..-1]\""
              case '*'
                  set cmd echo "Incorrect number of arguments"
          end
          eval $cmd
        '';
        gfeat = ''_gcm feat ":sparkles:" $argv'';
        gfix = ''_gcm fix ":bug:" $argv'';
        gperf = ''_gcm perf ":zap:" $argv'';
        gchore = ''_gcm chore ":wrench:" $argv'';
        grefactor = ''_gcm refactor ":recycle:" $argv'';
        gstyle = ''_gcm style ":art:" $argv'';
        gdocs = ''_gcm docs ":pencil:" $argv'';
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    git = {
      enable = true;
      userName = "dannylongeuay";
      userEmail = "dannylongeuay@yahoo.com";
      delta = {
        enable = true;
        catppuccin.enable = false;
        options = {
          navigate = true;
          line-numbers = true;
          side-by-side = true;
        };
      };
      extraConfig = {
        advice.statusHints = false;
        color.ui = true;
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
      };
    };
  };
}
