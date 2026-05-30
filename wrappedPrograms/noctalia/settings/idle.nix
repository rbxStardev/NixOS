{self, ...}: {
  flake.wrappersModules.noctalia-shell = {...}: {
      settings = {
        idle = {
          enabled = true;
          screenOffTimeout = 600;
          lockTimeout = 660;
          suspendTimeout = 0;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "";
          customCommands = "[]";
        };
      };
  };
}
