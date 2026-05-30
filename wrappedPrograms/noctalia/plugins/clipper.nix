{inputs, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    preInstalledPlugins.clipper = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      src = "${inputs.noctalia-plugins.outPath}/clipper";
    };
  };
}
