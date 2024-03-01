#!/usr/bin/env tclsh
# USAGE: ./namespace.tcl
# DESCRIPTION: Example using namespace
namespace eval orig_namespace {
	namespace export *
	set internal_var "world"

	proc hello {} {
		variable internal_var
		puts "Hello $internal_var"
	}
}

namespace eval short {
	namespace import ::orig_namespace::*
}

short::hello

