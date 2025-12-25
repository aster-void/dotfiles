{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  hazkey = inputs.nix-hazkey.packages.${system};
in {
  services.hazkey.enable = true;
  services.hazkey.libllama.package = hazkey.libllama-cpu;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-mozc-ut
    ];
  };
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
  };

  # fcitx5 configuration files
  xdg.configFile = {
    "fcitx5/config".text = ''
      [Hotkey]
      # Enumerate when holding modifier of Toggle key
      EnumerateWithTriggerKeys=False
      # Activate Input Method
      ActivateKeys=
      # Deactivate Input Method
      DeactivateKeys=
      # Temporarily Toggle Input Method
      AltTriggerKeys=
      # Enumerate Input Method Forward
      EnumerateForwardKeys=
      # Enumerate Input Method Backward
      EnumerateBackwardKeys=
      # Skip first input method while enumerating
      EnumerateSkipFirst=False
      # Enumerate Input Method Group Forward
      EnumerateGroupForwardKeys=
      # Enumerate Input Method Group Backward
      EnumerateGroupBackwardKeys=
      # Time limit in milliseconds for triggering modifier key shortcuts
      ModifierOnlyKeyTimeout=250

      [Hotkey/TriggerKeys]
      0=Super+space

      [Hotkey/PrevPage]
      0=Up

      [Hotkey/NextPage]
      0=Down

      [Hotkey/PrevCandidate]
      0=Shift+Tab

      [Hotkey/NextCandidate]
      0=Tab

      [Hotkey/TogglePreedit]
      0=Control+Alt+P

      [Behavior]
      # Active By Default
      ActiveByDefault=False
      # Reset state on Focus In
      resetStateWhenFocusIn=No
      # Share Input State
      ShareInputState=No
      # Show preedit in application
      PreeditEnabledByDefault=True
      # Show Input Method Information when switch input method
      ShowInputMethodInformation=True
      # Show Input Method Information when changing focus
      showInputMethodInformationWhenFocusIn=False
      # Show compact input method information
      CompactInputMethodInformation=True
      # Show first input method information
      ShowFirstInputMethodInformation=True
      # Default page size
      DefaultPageSize=5
      # Override XKB Option
      OverrideXkbOption=False
      # Custom XKB Option
      CustomXkbOption=
      # Force Enabled Addons
      EnabledAddons=
      # Force Disabled Addons
      DisabledAddons=
      # Preload input method to be used by default
      PreloadInputMethod=True
      # Allow input method in the password field
      AllowInputMethodForPassword=False
      # Show preedit text when typing password
      ShowPreeditForPassword=False
      # Interval of saving user data in minutes
      AutoSavePeriod=30
    '';

    "fcitx5/profile".text = ''
      [Groups/0]
      # Group Name
      Name=Default
      # Layout
      Default Layout=us-workman
      # Default Input Method
      DefaultIM=hazkey

      [Groups/0/Items/0]
      # Name
      Name=keyboard-us-workman
      # Layout
      Layout=

      [Groups/0/Items/1]
      # Name
      Name=hazkey
      # Layout
      Layout=

      [Groups/0/Items/2]
      # Name
      Name=mozc
      # Layout
      Layout=

      [GroupOrder]
      0=Default
    '';
  };
}
