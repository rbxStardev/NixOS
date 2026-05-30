{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
      };
  };
}
