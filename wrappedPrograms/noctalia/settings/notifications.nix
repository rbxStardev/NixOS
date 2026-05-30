{self, ...}: {
  flake.wrappersModules.noctalia-shell = {config, ...}: {
    settings = {
      notifications = {
        enabled = true;
        enableMarkdown = false;
        density = "default";
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        clearDismissed = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = true;
          volume = 0.5;
          separateSounds = true;
          criticalSoundFile = toString config.assets.notifCritical;
          normalSoundFile = toString config.assets.notifNormal;
          lowSoundFile = toString config.assets.notifLow;
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
        enableMediaToast = false;
        enableKeyboardLayoutToast = true;
        enableBatteryToast = true;
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
        ];
        monitors = [];
      };
    };
  };
}
