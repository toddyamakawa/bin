#!/usr/bin/env ruby
require 'expect'
require 'pty'

host = 'HOST'
port = 'PORT'
user = 'USER'
password = 'PASSWORD'
ssh_cmd = ['ssh', '-p', port, "#{user}@#{host}"]
#p ssh_cmd.join(' ')

PTY.spawn(*ssh_cmd) do |stdout, stdin, pid|
	p stdout.expect('Password:')
	p stdout.gets
	stdin.printf("#{password}\r")
	stdout.each do |line|
		puts line
	end
	rescue Errno::EIO
end

