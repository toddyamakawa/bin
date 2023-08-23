#!/usr/bin/env bash

#( set -o posix; set )

for arg in ${!ARG@}; do
	echo "arg: $arg"
done

# if -- then passthrough

# https://abseil.io/docs/python/guides/flags
# DEFINE_string: takes any input and interprets it as a string.
# DEFINE_bool or DEFINE_boolean: typically does not take an argument: pass --myflag to set FLAGS.myflag to True, or --nomyflag to set FLAGS.myflag to False. --myflag=true and --myflag=false are also supported, but not recommended.
# DEFINE_float: takes an input and interprets it as a floating point number. This also takes optional arguments lower_bound and upper_bound; if the number specified on the command line is out of range, it raises a FlagError.
# DEFINE_integer: takes an input and interprets it as an integer. This also takes optional arguments lower_bound and upper_bound as for floats.
# DEFINE_enum: takes a list of strings that represents legal values. If the command-line value is not in this list, it raises a flag error; otherwise, it assigns to FLAGS.flag as a string.
# DEFINE_list: Takes a comma-separated list of strings on the command line and stores them in a Python list object.
# DEFINE_multi_string: The same as DEFINE_string, except the flag can be specified more than once on the command line. The result is a Python list object (list of strings), even if the flag is only on the command line once.
# DEFINE_multi_integer: The same as DEFINE_integer, except the flag can be specified more than once on the command line. The result is a Python list object (list of ints), even if the flag is only on the command line once.
# DEFINE_multi_enum: The same as DEFINE_enum, except the flag can be specified more than once on the command line. The result is a Python list object (list of strings), even if the flag is only on the command line once.

# Mine:
#
# DEFINE_file:
# DEFINE_files:
# DEFINE_dir:
# DEFINE_dirs:

# Always enabled:
# DEFINE_verbose:
# DEFINE_debug:
# DEFINE_dryrun:

