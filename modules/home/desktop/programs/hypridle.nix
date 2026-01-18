_: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # 20分 (1200秒) でロック
        {
          timeout = 1200;
          on-timeout = "loginctl lock-session";
        }
        # 1時間 (3600秒) で画面オフ
        {
          timeout = 3600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # 2時間 (7200秒) でスリープ → 2時間後にハイバネート
        {
          timeout = 7200;
          on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
  };
}
