{
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) getExe;
  # nix-repository = inputs.nix-repository.packages.${pkgs.stdenv.system};

  mcpConfig = inputs.mcp-servers-nix.lib.mkConfig pkgs {
    programs = {
      context7.enable = true;
    };
    # settings.servers = {
    #   claude-flow = {
    #     command = getExe nix-repository.claude-flow;
    #     args = ["mcp" "start"];
    #   };
    #   ruv-swarm = {
    #     command = getExe nix-repository.ruv-swarm;
    #     args = ["mcp" "start" "--protocol=stdio"];
    #   };
    # };
  };

  claude = getExe pkgs.edge.claude-code;
  jq = getExe pkgs.jq;
in {
  programs.claude-code = {
    enable = true;
    package = pkgs.edge.claude-code;
    memory.source = ./claude.md;
  };

  home.activation.registerClaudeMcpServers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Remove all user-level MCPs first to clean up stale entries
    for name in $(${claude} mcp list 2>/dev/null | ${pkgs.gnugrep}/bin/grep -oP '^\S+(?=:)'); do
      $DRY_RUN_CMD ${claude} mcp remove --scope user "$name"
    done

    # Add configured MCPs
    for name in $(${jq} -r '.mcpServers | keys[]' ${mcpConfig}); do
      config=$(${jq} -c ".mcpServers[\"$name\"]" ${mcpConfig})
      $DRY_RUN_CMD ${claude} mcp add-json --scope user "$name" "$config"
    done
  '';
}
