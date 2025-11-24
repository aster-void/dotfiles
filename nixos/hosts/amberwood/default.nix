{
  my.profiles.gaming.enable = true;
  my.boot.enableLanzaboote = true;

  # Intel HDAオーディオコーデックが応答せず起動時に4秒遅延するため無効化
  # USB/HDMI/DisplayPortオーディオは引き続き使用可能
  boot.blacklistedKernelModules = ["snd_hda_intel"];
}
