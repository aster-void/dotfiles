{
  keyboard = {
    layouts = [{
      layout = "us";
      variant = "workman";
    }];
    repeatDelay = 250;
    repeatRate = 40;
    options = [
      "caps:escape"
    ];
  };
  touchpads = [
    {
      # @CHANGEME: change name and vendorId to your touchpad (can be found with `cat /proc/bus/input/devices`)
      name = "DNBK1000:00 06CB:CECE Touchpad";
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
