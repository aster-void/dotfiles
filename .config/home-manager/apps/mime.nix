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
    browser = createEntry inputs.zen-browser.packages.${system}.beta "zen-beta.desktop";
  in {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "text/xml" = browser;
      "image/png" = browser;
      "image/jpeg" = browser;
      "image/jpg" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/slack" = createEntry pkgs.slack "slack.desktop";
      "x-scheme-handler/notion" = createEntry pkgs.notion-app-enhanced "notion-app-enhanced.desktop";
      "application/x-zoom" = "/var/lib/flatpak/app/us.zoom.Zoom/current/active/export/share/applications/us.zoom.Zoom.desktop";
      "x-scheme-handler/zoommtg" = "/var/lib/flatpak/app/us.zoom.Zoom/current/active/export/share/applications/us.zoom.Zoom.desktop";
    };
  };
}
