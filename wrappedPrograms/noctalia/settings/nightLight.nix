{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        nightLight = {
          enabled = false;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
      };
  };
}
