{
  hyprshot,
  writeShellApplication,
}:
writeShellApplication {
  name = "hyprshot";
  runtimeInputs = [hyprshot];

  text = ''
    echo '[WORKAROUND] disabling animation temporarily'
    hyprctl keyword animations:enabled false
    trap 'hyprctl reload config-only; echo "[WORKAROUND] re-enabled animation"' EXIT
    hyprshot "$@"
  '';
}
