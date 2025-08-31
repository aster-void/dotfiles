{
  pkgs,
  my,
  inputs,
  system,
  ...
}: {
  home.packages =
    (with my.pkgs; [
      # == my tools ==
      setpaper
      wpick
    ])
    ++ [
      inputs.zen-browser.packages.${system}.beta
    ]
    ++ (with pkgs; [
      # == basic tools ==
      # Browser
      firefox
      chromium
      brave

      # Develop
      ## Code Editor
      zed-editor
      # code-cursor
      windsurf
      drawio

      ## Terminal
      alacritty
      kitty
      ghostty

      # System manager
      blueberry # gui bluetooth manager
      dunst # notification daemon
      ## bluetooth
      bluez
      bluez-tools

      ## media ctl
      pavucontrol
      pulseaudio
      brightnessctl
      asciinema
      solaar # logicool conf

      ## GPU
      nvtopPackages.full

      # WM
      hyprpicker # color picker
      blobdrop # drag & drop from shell

      ## Screen Shot / record
      hyprshot
      gpu-screen-recorder # screen recorder
      wf-recorder # another screen recorder

      ## Wallpaper
      variety
      hyprpaper

      ## bars
      waybar
      polybar
      eww
      ## Launchers
      nwg-launchers
      walker
      rofi

      # File Viewer
      feh # image viewer that is too simple
      kdePackages.gwenview # file manager that actually works
      vlc # music player
      playerctl

      # Apps
      ## Social
      slack
      discord
      vesktop # another discord client
      legcord # yet another discord client
      jitsi # what

      ## Notions
      # notion-app # not supported for linux
      notion-app-enhanced
      appflowy # another notion

      obsidian

      ## File Editor
      nomacs # view and crop image better
      gthumb
      gimp
      inkscape # looks like image and video editor
      ## Other Apps
      localsend

      arandr # display placer

      # gui drivers? idk
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      qt6Packages.qtstyleplugin-kvantum # SVG based theme engine for Qt/KDE
      gtk3
      gtk4
      xwayland
    ]);
}
