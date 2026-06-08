#!/usr/bin/env bash
# ==============================================================================
# FILE: wrappedPrograms/zsh/zsh-init.sh
# ==============================================================================
# Provides initialization logic for the ZSH wrapper. This includes custom 
# functions like a wrapper for 'nix shell' and integration with 'yazi'.
# ==============================================================================

# Append to the history file immediately, rather than waiting until the shell exits
setopt INC_APPEND_HISTORY

# Override the built-in 'cd' to automatically list directory contents with eza
cd() {
  builtin cd "$@" &&
    eza --icons --group-directories-first
}

# Wrapper function to intercept 'nix shell' and force it to be impure,
# otherwise defaults to the standard nix behavior
function nix() {
  if [[ "$1" == "shell" ]]; then
    IN_NIX_SHELL=impure command nix "$@"
  else
    command nix "$@"
  fi
}

# Wrapper for 'yazi' file manager to change the parent shell's directory 
# to the last visited directory upon exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Initialize Starship prompt
eval "$(starship init zsh)"
