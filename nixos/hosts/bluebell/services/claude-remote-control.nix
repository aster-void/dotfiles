{ pkgs, ... }:
{
  systemd.services.claude-remote-control = {
    description = "Claude Code Remote Control";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Login shell so PATH from profile is available (binary install of claude)
      ExecStart = "${pkgs.bash}/bin/bash -lc 'exec claude remote-control --name \"claude@bluebell\"'";
      User = "claude";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
