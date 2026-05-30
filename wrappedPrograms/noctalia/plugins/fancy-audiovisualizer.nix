{inputs, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    preInstalledPlugins.fancy-audiovisualizer = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      src = "${inputs.noctalia-plugins.outPath}/fancy-audiovisualizer";
    };
  };
}
