{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        colorSchemes = {
          useWallpaperColors = false;
          predefinedScheme = "Gruvbox";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "tonal-spot";
          monitorForColors = "";
          syncGsettings = true;
        };
      };
  };
}
