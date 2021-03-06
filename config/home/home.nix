{ ... }:

{
  programs = {
    home-manager = {
      enable = true;
      path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
    };
  };
  services.dunst = {
    enable = true;
    settings =
      {
        global = {
          monitor = 0;
          follow = "mouse";
          geometry = "300x60-20+48";
          indicate_hidden = "yes";
          shrink = "no";
          separator_height = 0;
          padding = 32;
          horizontal_padding = 32;
          frame_width = 2;
          sort = "no";
          idle_threshold = 120;
          font = "rissole 8";
          line_height = 4;
          markup = "full";
          format = "<b>%s</b>\n%b";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = "yes";
          ignore_newline = "no";
          stack_duplicates = false;
          hide_duplicate_count = "yes";
          show_indicators = "no";
          icon_position = "off";
          sticky_history = "yes";
          history_length = 20;
          browser = "chromium -new-tab";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
        };

        urgency_low = {
          timeout = 4;
          background = "#141c21";
          foreground = "#93a1a1";
          frame_color = "#8bc34a";
        };

        urgency_normal = {
          timeout = 8;
          background = "#141c21";
          foreground = "#93a1a1";
          frame_color = "#ba68c8";
        };

        urgency_critical = {
          timeout = 0;
          background = "#141c21";
          foreground = "#93a1a1";
          frame_color = "#ff7043";
        };
      };
  };
}
