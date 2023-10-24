#!/usr/bin/env bash
# USAGE: cgi [dir]
# DESCRIPTION: Start a cgi server
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#dir="${1:-.}"
#[[ -d "$dir" ]] || { print-error "Directory '$dir' not found"; exit 1; }
dir='.'

cgi_bin="$dir/cgi-bin"
if ! [[ -x "$cgi_bin/env.py" ]]; then
	mkdir -p "$cgi_bin"
	cp "$SCRIPT_DIR/cgi-env.py" "$cgi_bin/env.py"
fi

python_args=(-m http.server)
#python_args+=(-d "$dir")
python_args+=(--cgi)
print-run python3 "${python_args[@]}" "$@"

