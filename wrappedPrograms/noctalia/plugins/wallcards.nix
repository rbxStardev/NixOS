{inputs, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    preInstalledPlugins.wallcards = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      src = "${inputs.noctalia-plugins.outPath}/wallcards";
    };
  };
}
