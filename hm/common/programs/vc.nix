{
  programs = {
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
