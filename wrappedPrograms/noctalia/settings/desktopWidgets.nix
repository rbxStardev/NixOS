{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        desktopWidgets = {
          enabled = true;
          overviewEnabled = true;
          gridSnap = false;
          gridSnapScale = false;
          monitorWidgets = [
            {
              name = "eDP-1";
              widgets = [
              ];
            }
          ];
        };
      };
  };
}
