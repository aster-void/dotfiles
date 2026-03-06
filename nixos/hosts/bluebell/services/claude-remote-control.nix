{ pkgs, ... }:
{
  systemd.services.claude-remote-control = {
    description = "Claude Code Remote Control";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/home/claude/.local/bin/claude remote-control --name \"claude@bluebell\"";
      # /home/claude だと workspace trust が永続化されないバグがあるため repos で起動
      WorkingDirectory = "/home/claude/repos";
      User = "claude";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
