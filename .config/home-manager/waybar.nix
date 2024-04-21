{config, pkgs, lib, ...}: 
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

      * {
        font-family: "MesloLGL Nerd Font";
        border-radius: 10px;
        margin: 0px 5px;
        background-color: #31363F;
        color: #76ABAE;
      }
      #pulseaudio {
        background-color: #76ABAE;
      }
      #clock {
      }
      
      window#waybar {
        border-bottom: none;
        background-color: rgba(34, 40, 49, 0.5);
        color: rgb(34, 40, 49);
      }

    '';
    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      tray = { spacing = 10; };
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
      modules-right = [
        "pulseaudio"
        "tray"
        "network"
        "battery"
        "clock"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format = "{:%Y-%m-%d | %H:%M}";
        alt = false;
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-alt = " {bandwidthUpBits}  {bandwidthDownBits}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} 󰈁";
        format-linked = "{ifname} (No IP) 󰌷";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      "hyprland/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    }];
  };
}
