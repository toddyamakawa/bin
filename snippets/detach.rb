#!/usr/bin/env ruby
# USAGE: detach.rb
# DESCRIPTION: Detach process
fork_pid = fork do
	puts '[fork] start'
	sleep 1
	puts '[fork] done'
	exit 2
end
Process.detach(fork_pid)
begin
	puts '[main] wait'
	forked_pid = Process.wait(fork_pid)
	status = $?
	exit status.exitstatus
rescue Interrupt
	puts '[main] interrupt'
	exit 130
rescue Errno::ECHILD
	puts '[main] echild'
	exit 0
end
