{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.egl-wayland
    pkgs.libglvnd
  ];

  services.xserver.videoDrivers = ["modesetting" "intel" "nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Common
      vulkan-loader
      vulkan-validation-layers
      # NVIDIA
      nvidia-vaapi-driver
      # AMD
      rocmPackages.clr.icd
      # Intel
      intel-media-driver
      intel-compute-runtime
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
      vulkan-validation-layers
    ];
  };

  nixpkgs.config.nvidia.acceptLicense = true;

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
