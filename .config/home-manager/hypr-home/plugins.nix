{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
    # hyprpicker # segmentatin fault
  ];
  home.sessionVariables = {
    # hyprshot saving directory
    # HYPRSHOT_DIR = "~/Pictures/Screenshots"; #... didn't work well; use home directory as a temporary storage.
  };
}
