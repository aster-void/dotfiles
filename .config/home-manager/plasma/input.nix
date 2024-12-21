{
  keyboard = {
    layouts = [{
      layout = "us";
      variant = "English (Workman)";
    }];
    repeatDelay = 250;
    repeatRate = 40;
    options = [
      "caps:esc"
    ];
  };
  touchpads = [
    {
      name = "touchpad";
      # @CHANGEME: change name and vendorId to your touchpad (can be found with `cat /proc/bus/input/devices`)
      productId = "06cb";
      vendorId = "cece";
      enable = true;
      disableWhileTyping = true;
      pointerSpeed = 0.20;
      naturalScroll = true;
      tapToClick = true;
    }
  ];
}
