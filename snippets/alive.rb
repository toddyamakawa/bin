#!/usr/bin/env ruby
# USAGE: alive.rb PID
# DESCRIPTION: Check if PID is alive
def alive?(pid)
	begin
		Process.kill(0, pid.to_i)
	return true
	#rescue Errno::EPERM
	rescue Errno::ESRCH
		return false
	end
end
p alive?(ARGV.first)
