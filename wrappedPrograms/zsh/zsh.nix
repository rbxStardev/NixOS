{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.zsh = {
    config,
    lib,
    ...
  }: {
    settings = {
      shellAliases = {
        stop = "shutdown now";
        ls = "eza --icons --group-directories-first";
        l = "ls";
        ll = "eza -l --icons --group-directories-first";
        la = "eza -a --icons --group-directories-first";
        lla = "eza -la --icons --group-directories-first";
        cat = "bat";
      };

      completion.enable = true;

      autoSuggestions.enable = true;

      history = {
        size = 10000;
        ignoreAllDups = true;
        append = true;
        share = true;
      };
    };

    extraRC = builtins.readFile ./zsh-init.sh;
  };

  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        imports = [self.wrappersModules.zsh];
      }).wrapper;
  };
}
