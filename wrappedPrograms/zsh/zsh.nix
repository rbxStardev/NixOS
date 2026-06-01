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

    env.STARSHIP_CONFIG = builtins.toFile "starship.toml" ''
      "$schema" = "https://starship.rs/config-schema.json"

      palette = "noctalia"

      format = "[░▒▓](p_main)[  ](bg:p_main fg:on_p_main)[](fg:p_main bg:dir_bg)$directory[](fg:dir_bg bg:git_bg)$git_branch$git_status[](fg:git_bg bg:lang_bg)$nix_shell$nodejs$rust$golang$php[](fg:lang_bg bg:time_bg)$time[ ](fg:time_bg)\n$character"

      [character]
      error_symbol = "[❯](bold red)"
      success_symbol = "[❯](bold green)"

      [directory]
      format = "[ $path ]($style)"
      style = "fg:on_dir bg:dir_bg"
      truncation_length = 3
      truncation_symbol = "…/"

      [directory.substitutions]
      Documents = "󰈙 "
      Downloads = " "
      Music = " "
      Pictures = " "

      [git_branch]
      format = "[[ $symbol $branch ](fg:on_git bg:git_bg)]($style)"
      style = "bg:git_bg"
      symbol = ""

      [git_status]
      format = "[[($all_status$ahead_behind )](fg:on_git bg:git_bg)]($style)"
      style = "bg:git_bg"

      [nix_shell]
      format = "[[ $symbol ($state) ](fg:on_lang bg:lang_bg)]($style)"
      impure_msg = "impure"
      pure_msg = "pure"
      style = "bg:lang_bg"
      symbol = ""

      [time]
      disabled = false
      format = "[[  $time ](fg:on_time bg:time_bg)]($style)"
      style = "bg:time_bg"
      time_format = "%R"

      [palettes.noctalia]
      p_main = "green"
      on_p_main = "black"
      dir_bg = "yellow"
      on_dir = "black"
      git_bg = "blue"
      on_git = "black"
      lang_bg = "cyan"
      on_lang = "black"
      time_bg = "bright-black"
      on_time = "black"
      err = "red"
    '';
  };

  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        imports = [self.wrappersModules.zsh];
      }).wrapper;
  };
}
