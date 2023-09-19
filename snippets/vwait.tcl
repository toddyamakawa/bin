#!/usr/bin/env tclsh
# USAGE: ./vwait.tcl
# DESCRIPTION: Example using vwait

variable done timeout
proc print_bye {} {
	after 1000
	puts "bye"
	set ::done 1
}

after 0 print_bye
puts "hi"

vwait done

