{inputs, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    preInstalledPlugins.screen-shot-and-record = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      src = "${inputs.noctalia-plugins.outPath}/screen-shot-and-record";
      settings = {
        enableWindowsSelection = true;
        enableCross = true;
        screenshotEditor = "satty";
      };
    };
  };
}
