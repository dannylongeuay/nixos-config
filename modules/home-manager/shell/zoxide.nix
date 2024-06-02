{
  programs = {
    zoxide.enable = true;
    fish = {
      shellAbbrs = {
        zz = "z -";
        "..." = "../..";
        "...." = "../../..";
      };
    };
  };
}
