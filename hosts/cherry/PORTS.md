# Cherry Port Map

## Services

| Port  | Protocol | Service              | Bind Address | Exposure        | Source File                      |
|-------|----------|----------------------|--------------|-----------------|----------------------------------|
| 22    | TCP      | SSH                  | *            | cloudflared     | (system default)                 |
| 7002  | TCP      | Claude Code Viewer   | localhost    | local only      | services/claude-code-viewer.nix  |
| 7003  | TCP      | Syncthing GUI        | localhost    | cloudflared     | services/syncthing.nix           |
| 7004  | TCP      | llama-cpp            | localhost    | local only      | services/llama-cpp.nix           |

## Minecraft

| Port  | Protocol | Service              | Bind Address | Exposure        | Source File                      |
|-------|----------|----------------------|--------------|-----------------|----------------------------------|
| 25565 | TCP      | Minecraft (astronaut)| 0.0.0.0      | firewall open   | services/minecraft.nix           |
| 25566 | TCP      | Minecraft (hardcore) | 0.0.0.0      | firewall open   | services/minecraft.nix           |
| 25567 | TCP      | Minecraft (reserved) | 0.0.0.0      | firewall open   | services/minecraft.nix           |
| 25568 | TCP      | Minecraft (reserved) | 0.0.0.0      | firewall open   | services/minecraft.nix           |
| 25569 | TCP      | Minecraft (reserved) | 0.0.0.0      | firewall open   | services/minecraft.nix           |
| 25570 | TCP      | Minecraft (reserved) | 0.0.0.0      | firewall open   | services/minecraft.nix           |

## WiFi AP (dnsmasq)

| Port | Protocol | Service | Bind Address | Exposure    | Source File         |
|------|----------|---------|--------------|-------------|---------------------|
| 53   | TCP/UDP  | DNS     | wlp2s0       | LAN (AP)    | system/wifi-ap.nix  |
| 67   | UDP      | DHCP    | wlp2s0       | LAN (AP)    | system/wifi-ap.nix  |
| 68   | UDP      | DHCP    | wlp2s0       | LAN (AP)    | system/wifi-ap.nix  |

## Cloudflare Tunnel Ingress

| Domain                    | Backend               |
|---------------------------|-----------------------|
| cherry.aster-void.dev     | ssh://localhost:22    |
| syncthing.aster-void.dev  | http://localhost:7003 |
