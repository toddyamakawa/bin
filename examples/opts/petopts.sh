#!/bin/sh
# ==============================================================================
# LICENSE
# ==============================================================================
# Author: Aaron G
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <https://unlicense.org>

# GitHub:
# - https://github.com/aaronNGi/petopts/blob/main/petopts.sh
# - https://github.com/aaronNGi/petopts/blob/main/example.sh

options="a b: h v"
usage="[-ahv] [-b param] [operand ...]"
version="petops example version 6.9"

die() { printf '%s: %s\n' "${0##*/}" "$*" >&2; exit 1; }
usage() { printf 'usage: %s %s\n' "${0##*/}" "$usage"; exit; }
version() { printf '%s\n' "$version"; exit; }

for o in $options; do unset "opt_${o%:}"; done

while getopts ":$options" o; do case $o in
	:) die "option requires an argument -- $OPTARG" ;;
	\?) die "unknown option -- $OPTARG" ;;
	*) eval "opt_$o=\$((opt_$o + 1)) arg_$o=\$OPTARG" ;;
esac; done; shift "$((OPTIND - 1))"
