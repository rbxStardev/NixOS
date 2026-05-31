{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    settings = {
      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontFixed = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        scrollbarAlwaysVisible = true;
        boxBorderEnabled = false;
        panelBackgroundOpacity = 0.71;
        translucentWidgets = false;
        panelsAttachedToBar = false;
        settingsPanelMode = "attached";
        settingsPanelSideBarCardStyle = false;
      };
    };
  };
}
