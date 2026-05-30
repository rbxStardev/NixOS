{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        plugins = {
          autoUpdate = false;
          notifyUpdates = true;
        };
      };
  };
}
