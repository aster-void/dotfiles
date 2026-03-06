{ pkgs, ... }:
{
  systemd.services.claude-remote-control = {
    description = "Claude Code Remote Control";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/home/claude/.local/bin/claude remote-control --name \"claude@bluebell\"";
      User = "claude";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
