{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        noctaliaPerformance = {
          disableWallpaper = true;
          disableDesktopWidgets = true;
        };
      };
  };
}
