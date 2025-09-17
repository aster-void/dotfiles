# Cloudflare Tunnel DNS

For each tunnel you create, do:

1) Login: `cloudflared tunnel login`
2) Add DNS Route: `cloudflared tunnel route dns <tunnel> <domain.example.com>`

on any machine.
It can be your dev machine or home server, it doesn't matter.
