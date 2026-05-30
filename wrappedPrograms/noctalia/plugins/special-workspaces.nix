{inputs, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
    preInstalledPlugins.special-workspaces = {
      enabled = true;
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      src = "${inputs.noctalia-plugins.outPath}/special-workspaces";
      settings = {
        mainIcon = "layout-grid";
        expandDirection = "up";
        primarySymbolColor = "none";
        primaryShowPill = true;
        primaryPillColor = "none";
        primarySize = 0.9;
        primaryBorderRadius = 0;
        primaryFocusColor = "primary";
        panelBackgroundColor = "none";
        panelBackgroundEnabled = false;
        workspaces = [
          {
            name = "communication";
            icon = "message";
            symbolColor = "none";
            showPill = true;
            pillColor = "primary";
            size = 0.9;
            borderRadius = 0;
            focusColor = "primary";
          }
          {
            name = "music";
            icon = "music";
            symbolColor = "none";
            showPill = true;
            pillColor = "primary";
            size = 0.9;
            borderRadius = 0;
            focusColor = "primary";
          }
          {
            name = "special";
            icon = "star";
            symbolColor = "none";
            showPill = true;
            pillColor = "primary";
            size = 0.9;
            borderRadius = 0;
            focusColor = "primary";
          }
          {
            name = "sysmon";
            icon = "cpu";
            symbolColor = "none";
            showPill = true;
            pillColor = "primary";
            size = 0.9;
            borderRadius = 0;
            focusColor = "primary";
          }
          {
            name = "todo";
            icon = "pencil-check";
            symbolColor = "none";
            showPill = true;
            pillColor = "primary";
            size = 0.9;
            borderRadius = 0;
            focusColor = "primary";
          }
        ];
        drawer = true;
        hideEmptyWorkspaces = true;
      };
    };
  };
}
