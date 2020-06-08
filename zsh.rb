#!/usr/bin/env ruby
# vi: ft=ruby

require 'open3'

Open3.popen3('zsh -i') do |stdin, stdout, stderr, wait_thr|

	# TODO: Figure out stdin

	stdout_thread = Thread.new do
		while line = stdout.gets
			puts line
		end
	end

	stderr_thread = Thread.new do
		while line = stderr.gets
			puts "\e[31m[stderr]\e[0m #{line.chomp}"
		end
	end

	p wait_thr.value
end

