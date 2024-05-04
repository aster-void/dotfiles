{ pkgs, ... }:
{
  home.packages = with pkgs; [
    markdown-oxide
    rust-analyzer
  ];
}
