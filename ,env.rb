#!/usr/bin/env ruby

# Check pattern
pattern = nil
if not ARGV.empty?
	pattern = /#{ARGV.join('.*')}/i
end

ENV.sort.each do |key, values|
	line = "#{key}=#{values}"
	next if pattern and not (line =~ pattern)

	# Print regular environment variable
	if not (values =~ /:/) or (key =~ /^DISPLAY/)
		puts line
		next
	end

	# Print colon-separated variables (e.g. $PATH)
	values.split(':').each_with_index do |value, index|
		line = "#{key}[#{index}]=#{value}"
		next if pattern and not (line =~ pattern)
		puts line
	end
end

