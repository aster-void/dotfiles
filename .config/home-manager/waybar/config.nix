{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./style.css;
    settings = [{
      return-type = "json";
      height = 26;
      layer = "top";
      position = "top";
      tray = { spacing = 10; };
      modules-left = [
        "hyprland/workspaces"
        "hyprland/mode"
      ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        # "privacy-item"
        "pulseaudio"
        "network"
        "battery"
        "clock"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% 󰂄";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format = "{:%Y-%m-%d %H:%M}";
        alt = false;
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
        };
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        tooltip-format = " {essid}  {bandwidthUpBits}  {bandwidthDownBits} | {ipaddr} {ifname}";
        format-disconnected = "Disconnected⚠";
        format-ethernet = "Ethernet 󰈁";
        format-linked = "No IP 󰌷";
        format-wifi = "{signalStrength}%";
      };
      pulseaudio = {
        format = "{volume}%{icon} {format_source}";
        format-bluetooth = "{volume}%{icon} {format_source}";
        format-bluetooth-muted = "{icon} {format_source}";
        format-icons = {
          default = [ "" "" "" ];
          car = "";
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = "{format_source}";
        format-source = "";
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
/* default config as jsonc:
  
        // "layer": "top", // Waybar at top layer
        // "position": "bottom", // Waybar position (top|bottom|left|right)
        "height": 30, // Waybar height (to be removed for auto height)
        // "width": 1280, // Waybar width
        "spacing": 4, // Gaps between modules (4px)
        // Choose the order of the modules
        "modules-left": [
        "sway/workspaces",
        "sway/mode",
        "sway/scratchpad",
        "custom/media"
        ],
        "modules-center": [
        "sway/window"
        ],
        "modules-right": [
        "mpd",
        "idle_inhibitor",
        "pulseaudio",
        "network",
        "power-profiles-daemon",
        "cpu",
        "memory",
        "temperature",
        "backlight",
        "keyboard-state",
        "sway/language",
        "battery",
        "battery#bat2",
        "clock",
        "tray"
        ],
        // Modules configuration
        // "sway/workspaces": {
        //     "disable-scroll": true,
        //     "all-outputs": true,
        //     "warp-on-scroll": false,
        //     "format": "{name}: {icon}",
        //     "format-icons": {
        //         "1": "",
        //         "2": "",
        //         "3": "",
        //         "4": "",
        //         "5": "",
        //         "urgent": "",
        //         "focused": "",
        //         "default": ""
        //     }
        // },
        "keyboard-state": {
        "numlock": true,
        "capslock": true,
        "format": "{name} {icon}",
        "format-icons": {
            "locked": "",
            "unlocked": ""
        }
        },
        "sway/mode": {
        "format": "<span style=\"italic\">{}</span>"
        },
        "sway/scratchpad": {
        "format": "{icon} {count}",
        "show-empty": false,
        "format-icons": ["", ""],
        "tooltip": true,
        "tooltip-format": "{app}: {title}"
        },
        "mpd": {
        "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
        "format-disconnected": "Disconnected ",
        "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
        "unknown-tag": "N/A",
        "interval": 5,
        "consume-icons": {
            "on": " "
        },
        "random-icons": {
            "off": "<span color=\"#f53c3c\"></span> ",
            "on": " "
        },
        "repeat-icons": {
            "on": " "
        },
        "single-icons": {
            "on": "1 "
        },
        "state-icons": {
            "paused": "",
            "playing": ""
        },
        "tooltip-format": "MPD (connected)",
        "tooltip-format-disconnected": "MPD (disconnected)"
        },
        "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "",
            "deactivated": ""
        }
        },
        "tray": {
        // "icon-size": 21,
        "spacing": 10
        },
        "clock": {
        // "timezone": "America/New_York",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
        },
        "cpu": {
        "format": "{usage}% ",
        "tooltip": false
        },
        "memory": {
        "format": "{}% "
        },
        "temperature": {
        // "thermal-zone": 2,
        // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        // "format-critical": "{temperatureC}°C {icon}",
        "format": "{temperatureC}°C {icon}",
        "format-icons": ["", "", ""]
        },
        "backlight": {
        // "device": "acpi_video1",
        "format": "{percent}% {icon}",
        "format-icons": ["", "", "", "", "", "", "", "", ""]
        },
        "battery": {
        "states": {
            // "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{capacity}% {icon}",
        "format-full": "{capacity}% {icon}",
        "format-charging": "{capacity}% ",
        "format-plugged": "{capacity}% ",
        "format-alt": "{time} {icon}",
        // "format-good": "", // An empty format will hide the module
        // "format-full": "",
        "format-icons": ["", "", "", "", ""]
        },
        "battery#bat2": {
        "bat": "BAT2"
        },
        "power-profiles-daemon": {
      "format": "{icon}",
      "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
      "tooltip": true,
      "format-icons": {
        "default": "",
        "performance": "",
        "balanced": "",
        "power-saver": ""
      }
        },
        "network": {
        // "interface": "wlp2*", // (Optional) To force the use of this interface
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
        },
        "pulseaudio": {
        // "scroll-step": 1, // %, can be a float
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
        },
        "custom/media": {
        "format": "{icon} {}",
        "return-type": "json",
        "max-length": 40,
        "format-icons": {
            "spotify": "",
            "default": "🎜"
        },
        "escape": true,
        "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
        // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
        }
        }
        */
