{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.tmux = {
    pkgs,
    lib,
    ...
  }: {
    shell = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.environment;
    prefix = "C-a";
    baseIndex = 1;
    paneBaseIndex = 1;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    terminal = "xterm-256color";
    terminalOverrides = ",*256col*:Tc,*:Ss=\\E[%p1%d q:Se=\\E[ q";

    setEnvironment = {
      COLORTERM = "truecolor";
    };

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.better-mouse-mode;
      }
      {
        plugin = pkgs.tmuxPlugins.gruvbox;
        configBefore = ''
          set -g @tmux-gruvbox 'dark'
          set -g @tmux-gruvbox-statusbar-alpha 'true'
        '';
      }
    ];

    configAfter = ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  perSystem = {pkgs, ...}: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.tmux];
    };
  };
}
