{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = false;
          backlightDeviceMappings = [];
        };
      };
  };
}
