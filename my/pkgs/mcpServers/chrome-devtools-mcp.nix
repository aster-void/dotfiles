{
  writeShellApplication,
  nodejs,
}: let
  version = "0.8.1";
in
  writeShellApplication {
    name = "chrome-devtools-mcp";
    runtimeInputs = [nodejs];
    text = ''
      npx -y chrome-devtools-mcp@${version} "$@"
    '';
  }
