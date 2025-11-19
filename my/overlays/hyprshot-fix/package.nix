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
    trap 'hyprctl keyword animations:enabled true; echo "[WORKAROUND] re-enabled animation"' EXIT
    hyprshot "$@"
  '';
}
