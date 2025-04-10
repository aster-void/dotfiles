{
  inputs,
  system,
  lib,
  pkgs,
  ...
}: {
  xdg.mime.enable = true;
  xdg.mimeApps = let
    createEntry = bin: desktopFilename: "${lib.getExe bin}/share/applications/${desktopFilename}";
    browserDesktop = createEntry inputs.zen-browser.packages.${system}.beta "zen-beta.desktop";
  in {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = browserDesktop;
      "text/html" = browserDesktop;
      "text/xml" = browserDesktop;
      "x-scheme-handler/ftp" = browserDesktop;
      "x-scheme-handler/http" = browserDesktop;
      "x-scheme-handler/https" = browserDesktop;
      "x-scheme-handler/slack" = createEntry pkgs.slack "slack.desktop";
      "x-scheme-handler/notion" = createEntry pkgs.notion-app-enhanced "notion-app-enhanced.desktop";
    };
  };
}
