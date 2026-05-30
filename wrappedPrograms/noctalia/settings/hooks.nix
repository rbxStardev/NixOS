{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
          startup = "";
          session = "";
          colorGeneration = "";
        };
      };
  };
}
