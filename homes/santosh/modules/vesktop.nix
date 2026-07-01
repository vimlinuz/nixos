{
  programs.vesktop = {
    enable = true;

    settings = {
      checkUpdates = false;
      minimizeToTray = true;
      tray = true;
      discordBranch = "stable";
    };

    vencord = {
      useSystem = true;

      settings = {
        autoUpdate = false;
        autoUpdateNotification = true;
        notifyAboutUpdates = false;
      };
    };

  };
}
