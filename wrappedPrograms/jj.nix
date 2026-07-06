# ==============================================================================
# FILE: wrappedPrograms/jj.nix
# ==============================================================================
# Wraps Jujutsu (jj) and its UI client (jjui) using Lassulus' wrapPackage.
# ==============================================================================
{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    tomlFormat = pkgs.formats.toml {};
    defaultRevset = "all()";
    logCommand = ["log" "--reversed" "--no-pager" "-r" defaultRevset "-n" "20"];

    jjuiSettings = {
      preview = {
        show_at_start = true;
      };
    };

    jjuiConfigDir = pkgs.runCommand "jjui-config-dir" {} ''
      mkdir -p $out
      cp ${tomlFormat.generate "config.toml" jjuiSettings} $out/config.toml
    '';

    jjSettings = {
      user = {
        name = "rbxStardev";
        email = "miguelscb0310@gmail.com";
      };
      aliases = {
        l = logCommand;
      };
      ui = {
        default-command = logCommand;
      };
      snapshot = {
        max-new-file-size = "15MiB";
      };
    };

    jjConfigFile = tomlFormat.generate "jj-config.toml" jjSettings;
  in {
    packages.jjui = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.jjui;
      flags = {
        "-r" = defaultRevset;
      };
      env = {
        JJUI_CONFIG_DIR = "${jjuiConfigDir}";
      };
    };

    packages.jujutsu = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.jujutsu;
      env = {
        JJ_CONFIG = "${jjConfigFile}";
      };
    };
  };
}
