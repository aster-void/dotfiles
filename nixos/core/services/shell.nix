{shared, ...}: {
  # シェルエイリアス
  environment.shellAliases = shared.config.mkShellAliases "bash";
}
