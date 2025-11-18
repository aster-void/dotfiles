{
  programs.fuzzel = {
    enable = true;
    settings = {
      font = "SF Pro Text:size=16";
      prompt = ""; # Spotlight みたいに prompt を非表示
      icon-size = 22;

      # 見た目
      lines = 10;
      width = 60; # 画面幅の60%
      horizontal-pad = 40;
      vertical-pad = 20;
      inner-pad = 20;
      border-radius = 14;

      # 配置
      anchor = "center";
      y-margin = 20;

      # 背景
      background = "rgba(30,30,30,0.50)";
      text-color = "#ffffff";
      match-color = "#4aa3ff"; # macOS の青っぽい色

      # 影（Hyprland の影と合わさる）
      border-width = 0;
    };
  };
}
