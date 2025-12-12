{
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
