# line.nix - LINE messenger package for NixOS
{
  lib,
  stdenv,
  fetchurl,
  p7zip,
  writeShellScript,
  copyDesktopItems,
  makeDesktopItem,
  wineWowPackages,
  winetricks,
}: let
  pname = "line";
  version = "7.14.1.0";

  # The Microsoft Store LINE package (actually an NSIS installer)
  src = fetchurl {
    url = "https://cdn.storeedgefd.dsx.mp.microsoft.com/wus2/cachedpackages/f91105b9-01ba-4560-a72e-859a3f025632_2d16eb41ee7664287d261b6d16baa1202544b9e7e9fe836e160d4ea1dc289fcf";
    sha256 = "sha256-LRbrQe52ZCh9JhttFrqhICVEuefp/oNuFg1Oodwon88=";
    name = "line-installer.exe";
  };

  # Desktop entry for LINE
  desktopItem = makeDesktopItem {
    name = "line";
    exec = "line";
    icon = "line";
    desktopName = "LINE";
    comment = "LINE messenger for desktop";
    categories = ["Network" "InstantMessaging"];
    keywords = ["chat" "messaging" "line"];
    startupNotify = true;
    startupWMClass = "LINEAPP.exe";
  };
in
  stdenv.mkDerivation {
    inherit pname version src;

    nativeBuildInputs = [
      p7zip
      copyDesktopItems
    ];

    buildInputs = [
      wineWowPackages.stagingFull
      winetricks
    ];

    desktopItems = [desktopItem];

    unpackPhase = ''
      runHook preUnpack

      # Extract the NSIS installer using 7z with auto-yes to all prompts
      echo "Extracting LINE installer..."
      ${p7zip}/bin/7z x "$src" -o./line-extracted -y -bb1

      # Navigate to extracted directory
      cd line-extracted

      runHook postUnpack
    '';

    # No compilation needed - we're just installing pre-built Windows binaries
    buildPhase = ''
      runHook preBuild
      echo "No build phase needed for pre-built Windows application"
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      # Create installation directories
      echo "Creating installation directories..."
      mkdir -p $out/share/line
      mkdir -p $out/bin
      mkdir -p $out/share/icons/hicolor/256x256/apps
      echo "Directories created successfully"

      # Copy all extracted files to the installation directory
      echo "Copying LINE application files..."
      cp -r ./* $out/share/line/ || true
      echo "Files copied successfully"

      # The main executable from the extraction is LINE.exe
      # Create a symlink with the expected name
      echo "Checking for LINE.exe..."
      if [ -f "$out/share/line/LINE.exe" ]; then
        ln -sf LINE.exe $out/share/line/LINEAPP.exe
        echo "Created symlink: LINEAPP.exe -> LINE.exe"
      else
        echo "LINE.exe not found, searching for alternatives..."
        # Fallback: try to find any LINE-related executable
        LINE_EXE=$(find $out/share/line -name "*LINE*.exe" -not -path "*/unins*" | head -1)
        if [ -n "$LINE_EXE" ]; then
          ln -sf "$(basename "$LINE_EXE")" "$out/share/line/LINEAPP.exe"
          echo "Created symlink: LINEAPP.exe -> $(basename "$LINE_EXE")"
        else
          echo "Error: Could not find LINE executable"
          find $out/share/line -name "*.exe" | head -10
          exit 1
        fi
      fi

      # Make executables executable
      echo "Setting executable permissions..."
      find $out/share/line -name "*.exe" -exec chmod +x {} \; 2>/dev/null || true
      echo "Permissions set successfully"

      # Create a proper wrapper using a shell script with Wine prefix initialization
      install -Dm755 /dev/stdin $out/bin/line <<EOF
      #!/bin/sh

      # Set up Wine environment - MUST set WINEARCH before creating prefix
      export WINEARCH=win64
      export WINEPREFIX="\$HOME/.local/share/line/wine-prefix"
      export WINEDLLOVERRIDES="mscoree,msxml3,msxml6,nvcuda,nvapi,nvapi64=n"
      export WINEDEBUG=+err

      # Configure winetricks to use wineWowPackages
      export WINE="${wineWowPackages.stagingFull}/bin/wine"

      # Ensure Wine binaries are available
      export PATH="${wineWowPackages.stagingFull}/bin:${winetricks}/bin:\$PATH"

      # Initialize Wine prefix if it doesn't exist
      if [ ! -d "\$WINEPREFIX" ]; then
        echo "Initializing Wine prefix for LINE..."

        # Initialize Wine with 64-bit architecture - let Wine create the directory
        "${wineWowPackages.stagingFull}/bin/wineboot" --init

        # Wait for wine initialization to complete
        sleep 3

        # Install required Windows components using winetricks
        echo "Installing required Windows components..."
        "${winetricks}/bin/winetricks" -q dotnet48 vcrun2019 corefonts

        # Additional DLLs that LINE might need
        "${winetricks}/bin/winetricks" -q gdiplus msxml6 d3dx9

        echo "Wine prefix initialization complete"
      fi

      # Set up LINE installation directory in Wine prefix
      LINE_INSTALL_DIR="\$WINEPREFIX/drive_c/Program Files/LINE"
      if [ ! -d "\$LINE_INSTALL_DIR" ]; then
        echo "Setting up LINE installation directory..."
        mkdir -p "\$LINE_INSTALL_DIR"

        # Copy all LINE files to the proper Windows installation directory
        cp -r "$out/share/line/"* "\$LINE_INSTALL_DIR/"

        # Create registry entries for LINE installation using Wine registry commands
        echo "Creating registry entries for LINE installation..."

        # Create LINE uninstall entry
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LINE" /v "DisplayName" /t REG_SZ /d "LINE" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LINE" /v "DisplayVersion" /t REG_SZ /d "7.14.1.0" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LINE" /v "InstallLocation" /t REG_SZ /d "C:\\Program Files\\LINE" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LINE" /v "Publisher" /t REG_SZ /d "LINE Corporation" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\LINE" /v "UninstallString" /t REG_SZ /d "C:\\Program Files\\LINE\\LineUnInst.exe" /f

        # Create LINE app paths
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\LINEAPP.exe" /ve /t REG_SZ /d "C:\\Program Files\\LINE\\LINEAPP.exe" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\LINEAPP.exe" /v "Path" /t REG_SZ /d "C:\\Program Files\\LINE" /f

        # Create LINE Corporation registry entries
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKCU\\SOFTWARE\\LINE Corporation\\LINE" /v "InstallPath" /t REG_SZ /d "C:\\Program Files\\LINE" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKCU\\SOFTWARE\\LINE Corporation\\LINE" /v "Version" /t REG_SZ /d "7.14.1.0" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\LINE Corporation\\LINE" /v "InstallPath" /t REG_SZ /d "C:\\Program Files\\LINE" /f
        "${wineWowPackages.stagingFull}/bin/wine" reg add "HKLM\\SOFTWARE\\LINE Corporation\\LINE" /v "Version" /t REG_SZ /d "7.14.1.0" /f

        # Create additional installation validation files that LINE might expect
        echo "Creating installation validation files..."

        # Create a version file
        echo "7.14.1.0" > "\$LINE_INSTALL_DIR/version.txt"

        # Create installation marker files
        touch "\$LINE_INSTALL_DIR/.installed"
        echo "$(date +%Y%m%d)" > "\$LINE_INSTALL_DIR/install.dat"

        # Create LINE configuration directory in AppData
        mkdir -p "\$WINEPREFIX/drive_c/users/\$USER/AppData/Roaming/LINE"
        mkdir -p "\$WINEPREFIX/drive_c/users/\$USER/AppData/Local/LINE"

        # Create basic configuration files
        echo '{"installPath":"C:\\\\Program Files\\\\LINE","version":"7.14.1.0"}' > "\$WINEPREFIX/drive_c/users/\$USER/AppData/Roaming/LINE/config.json"

        echo "Installation artifacts created"
      fi

      # Launch LINE from the proper installation directory
      cd "\$LINE_INSTALL_DIR"
      exec "${wineWowPackages.stagingFull}/bin/wine" "\$LINE_INSTALL_DIR/LINEAPP.exe" "\$@"
      EOF

      # Try to find and install icon
      echo "Looking for icon files..."
      ICON_FILE=$(find $out/share/line -name "*.ico" -o -name "*.png" 2>/dev/null | grep -i "line\|logo" | head -1 || true)
      if [ -n "$ICON_FILE" ] && [ -f "$ICON_FILE" ]; then
        cp "$ICON_FILE" $out/share/icons/hicolor/256x256/apps/line.png 2>/dev/null || echo "Failed to copy icon, continuing..."
        echo "Icon installed: $ICON_FILE"
      else
        echo "No suitable icon found, skipping icon installation"
      fi

      echo "Install phase completed successfully"
      runHook postInstall
    '';

    # Don't strip Windows executables
    dontStrip = true;
    dontPatchELF = true;

    meta = with lib; {
      description = "LINE messenger desktop application";
      longDescription = ''
        LINE is a popular messaging application. This package contains the
        Microsoft Store version which supports full features including:
        - Voice and video calls
        - LINE Keep
        - LINE Note
        - All standard messaging features

        The application runs through wine for better compatibility
        and stability compared to plain Wine.
      '';
      homepage = "https://line.me/";
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
      maintainers = [];

      # This is a Windows application running through compatibility layers
      sourceProvenance = with sourceTypes; [binaryNativeCode];
    };
  }
