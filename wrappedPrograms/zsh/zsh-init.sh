setopt INC_APPEND_HISTORY

cd() {
  builtin cd $@ &&
    eza --icons --group-directories-first
}

function nix() {
  if [[ "$1" == "shell" ]]; then
    IN_NIX_SHELL=impure command nix "$@"
  else
    command nix "$@"
  fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
