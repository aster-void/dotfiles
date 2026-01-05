{}
# {config, ...}: {
#   age.secrets.cloudflared-bluebell.file = ../../../../secrets/cloudflared/bluebell.json.age;
#   services.cloudflared = {
#     enable = true;
#     tunnels.bluebell = {
#       credentialsFile = config.age.secrets.cloudflared-bluebell.path;
#       default = "http_status:404";
#       ingress = {
#         "syncthing.aster-void.dev" = "http://localhost:8384";
#       };
#     };
#   };
# }

