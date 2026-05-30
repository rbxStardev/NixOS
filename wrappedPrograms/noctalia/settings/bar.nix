{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    settings = {
      bar = {
        barType = "floating";
        position = "left";
        monitors = [];
        density = "default";
        showOutline = true;
        showCapsule = true;
        capsuleOpacity = 1;
        capsuleColorKey = "none";
        widgetSpacing = 6;
        contentPadding = 2;
        fontScale = 1;
        enableExclusionZoneInset = true;
        backgroundOpacity = 0.34;
        useSeparateOpacity = true;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        hideOnOverview = false;
        displayMode = "always_visible";
        autoHideDelay = 500;
        autoShowDelay = 150;
        showOnWorkspaceSwitch = true;
        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "Clock";
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Workspace";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              colorizeDistroLogo = true;
              colorizeSystemIcon = "tertiary";
              customIconPath = "";
              enableColorization = true;
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "plugin:special-workspaces";
            }
          ];
        };
        mouseWheelAction = "none";
        reverseScroll = false;
        mouseWheelWrap = true;
        middleClickAction = "none";
        middleClickFollowMouse = false;
        middleClickCommand = "";
        rightClickAction = "controlCenter";
        rightClickFollowMouse = true;
        rightClickCommand = "";
        screenOverrides = [];
      };
    };
  };
}
