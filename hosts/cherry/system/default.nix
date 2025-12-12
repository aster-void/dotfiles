{
  imports = [
    ./wifi-ap.nix
  ];

  security.sudo.extraRules = [
    {
      users = ["aster"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
