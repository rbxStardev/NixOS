{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        dock = {
          enabled = true;
          position = "bottom";
          displayMode = "auto_hide";
          dockType = "floating";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [];
          pinnedApps = [];
          colorizeIcons = false;
          showLauncherIcon = false;
          launcherPosition = "end";
          launcherUseDistroLogo = false;
          launcherIcon = "";
          launcherIconColor = "none";
          pinnedStatic = false;
          inactiveIndicators = false;
          groupApps = false;
          groupContextMenuMode = "extended";
          groupClickAction = "cycle";
          groupIndicatorStyle = "dots";
          deadOpacity = 0.6;
          animationSpeed = 2;
          sitOnFrame = false;
          showDockIndicator = true;
          indicatorThickness = 3;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
        };
      };
  };
}
