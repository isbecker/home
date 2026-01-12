{
  services.kanshi.enable = true;

  services.kanshi.settings = [
    {
      profile.name = "desktop";
      profile.outputs = [
        {
          criteria = "DP-1";
          mode = "2560x1440@165Hz";
          position = "0,0";
        }
        {
          criteria = "DP-2";
          mode = "1920x1080@144Hz";
          position = "2560,0";
        }

      ];
    }
  ];
}
