{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = true;
        no_fade_out = true;
        ignore_empty_input = true;
      };

      background = [
        {
          color = "rgb(0, 0, 0)";
          blur_passes = 0;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "<i>...</i>";
          shadow_passes = 2;
        }
      ];
    };
  };
}
