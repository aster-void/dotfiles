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
      name = "DNBK1000:00 06CB:CECE Touchpad";
      # @CHANGEME: change name and vendorId to your touchpad (can be found with `cat /proc/bus/input/devices`)
      vendorId = "06cb";
      productId = "cece";
      enable = true;
      disableWhileTyping = true;
      pointerSpeed = 0.20;
      naturalScroll = true;
      tapToClick = true;
    }
  ];
}
