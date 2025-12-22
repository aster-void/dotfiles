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
    skillsDir = ./skills;
    settings = {
      env.CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR = "1";
      permissions.deny = ["Read(**/.env)"];
    };
  };

  home.activation.registerClaudeMcpServers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    removed=0
    remove_failed=0
    added=0
    add_failed=0

    # Remove all user-level MCPs first to clean up stale entries
    if existing=$(${claude} mcp list 2>&1); then
      for name in $(echo "$existing" | ${pkgs.gnugrep}/bin/grep -oP '^\S+(?=:)'); do
        if $DRY_RUN_CMD ${claude} mcp remove --scope user "$name" 2>&1; then
          removed=$((removed + 1))
        else
          echo "Warning: Failed to remove MCP server '$name'" >&2
          remove_failed=$((remove_failed + 1))
        fi
      done
    else
      echo "Warning: Failed to list MCP servers: $existing" >&2
    fi || true

    # Add configured MCPs
    for name in $(${jq} -r '.mcpServers | keys[]' ${mcpConfig}); do
      config=$(${jq} -c ".mcpServers[\"$name\"]" ${mcpConfig})
      if $DRY_RUN_CMD ${claude} mcp add-json --scope user "$name" "$config" 2>&1; then
        added=$((added + 1))
      else
        echo "Warning: Failed to add MCP server '$name'" >&2
        add_failed=$((add_failed + 1))
      fi
    done || true

    echo "MCP servers: removed $removed (failed: $remove_failed), added $added (failed: $add_failed)"
  '';
}
