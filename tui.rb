#!/usr/bin/env ruby
# vi: ft=ruby


# ==============================================================================
# SETTINGS
# ==============================================================================

require 'open3'

if STDOUT.isatty
	# TODO: Check this?
end

# Format
$format = Hash.new
$prompt_format = "\e[100;93m"
$highlight_format = "\e[1;38:5:15;48:5:88m"
$hint_format = "\e[1;38:5:0;48:5:229m"
$hint_characters = 'asdfgqwertzxcvb'
$format[:header] = "\e[1;38:5:46;48:5:240m"
$format[:footer] = "\e[38:5:226;48:5:240m"
$format[:reset] = "\e[0m"
$format[:table_border] = "\e[38:5:243m"
$format[:cursor_format] = "\e[48:5:237m"
print_format = false
#print_format = true
if print_format
	$format.each do |key, value|
		puts "#{value}#{key}#{$format[:reset]}"
	end
	exit
end
$default_sep = "#{$format[:table_border]}|#{$format[:reset]}"


# ==============================================================================
# FUNCTIONS
# ==============================================================================

# Define a function to get character
def get_char
	begin
		system("stty raw -echo")
		char = STDIN.getc
	ensure
		system("stty -raw echo")
	end
	return char
end

class String
	# Remove ANSI escape characters
	def noansi; return self.gsub(/\e\[([;\d]+)?m/, ''); end
end


# ==============================================================================
# SCREEN
# ==============================================================================
class Screen

	ALT_BUFFER = "\e[?1049h"
	REVERT_BUFFER = "\e[?1049l"
	DISABLE_LINE_WRAP = "\e[?7l"
	ENABLE_LINE_WRAP = "\e[?7h"
	HIDE_CURSOR = "\e[?25l"
	SHOW_CURSOR = "\e[?25h"
	CLEAR_SCROLL_AREA="\e[0r"
	CLEAR = "\e[2J"

	# '\e[1;Nr':   Limit scrolling to scrolling area.
	#SCROLLING_AREA = "\e[1;30r"

	def Screen.clear()
		print(CLEAR)
	end

	def Screen.revert()
		str = REVERT_BUFFER + ENABLE_LINE_WRAP + SHOW_CURSOR + CLEAR_SCROLL_AREA
		print(str)
	end

	def Screen.setup()
		at_exit {
			Screen.revert()
		}
		str = ALT_BUFFER + DISABLE_LINE_WRAP + HIDE_CURSOR + CLEAR
		print(str)
	end

	def Screen.get_size()
		return `stty size`.split(' ').map(&:to_i)
	end

	def Screen.print_at_row(row, string)
		print("\033[#{row};#{string}")
	end

	def Screen.print_at_col(col, string)
		print("\033[#{col};#{string}")
	end

	def Screen.print_at(row, col, string)
		print("\033[#{row};#{col}H#{string}")
	end

	def Screen.header(string)
		lines, columns = Screen.get_size()
		header_str = $format[:header] + string.ljust(columns+1) + $format[:reset]
		print_at(0, 0, header_str)
	end

	def Screen.footer(lstr, rstr = '')
		lines, columns = Screen.get_size()
		footer_str = lstr.ljust(columns+1)
		rsize = rstr.size
		if rsize > 0
			footer_str = footer_str.split('')[0..(-1-rsize)].join('') + rstr
		end
		footer_str = $format[:footer] + footer_str + $format[:reset]
		print_at(lines, 0, footer_str)
	end
end


# ==============================================================================
# INITIALIZE
# ==============================================================================
# row is for terminal
# line is for printed text

title = 'TITLE'
Screen.setup()
Screen.header(title)
$LINES, $COLUMNS = Screen.get_size()

# Rows
$start_row = 2
$end_row = $LINES
$max_rows = $end_row - $start_row
print("\e[#{$start_row};#{$end_row-1}r")

# Lines
$lines = (5..50).map(&:to_s)
$CURSOR_LINE = 0
$start_line = 0
$max_line = $lines.size - 1


$DEBUG = ''
def print_status()
	cursor_line = "[#{$CURSOR_LINE}/#{$max_line}]"
	dimensions = "[#{$LINES}x#{$COLUMNS}]"
	#pos = `echo -e "\e[6n"`
	Screen.footer("#{$DEBUG}:", cursor_line + dimensions)
	Screen.print_at($start_row + ($CURSOR_LINE - $start_line), 1, '')
end


def print_line(i)
	format = ''
	if i == $CURSOR_LINE
		format = $format[:cursor_format]
	end
	str = $lines[i]
	print("\r#{format}#{str.ljust($COLUMNS)}#{$format[:reset]}")
end


def move_cursor(to_line)
	if to_line < 0 or to_line > $max_line
		return
	end

	from_line = $CURSOR_LINE
	$CURSOR_LINE = to_line

	# Move/scroll down
	# TODO: Check if entire screen needs to be redrawn
	if to_line - $start_line > $max_rows - 1

		print("\eM")
		(from_line..to_line).each do |i|
			print("\eD")
			#print("\n")
			print_line(i)
		end
		$start_line = to_line - ($max_rows - 1)
		#$DEBUG = "#{$CURSOR_LINE}:#{$start_line}:#{to_line}:#{from_line}"

	# Move/scroll up
	# TODO: Check if entire screen needs to be redrawn
	elsif to_line - $start_line < 0
		print("\eD")
		(to_line..from_line).reverse_each do |i|
			print("\eM")
			print_line(i)
		end
		$start_line = to_line
		#$DEBUG = "#{$CURSOR_LINE}:#{$start_line}:#{to_line}:#{from_line}"

	else
		# Clear initial line
		#print("\r")
		print_line(from_line)

		# Print new line
		Screen.print_at($start_row + ($CURSOR_LINE - $start_line), 1, '')
		print_line($CURSOR_LINE)
	end

	print_status()
end


print_status()
Screen.print_at($start_row - 1, 1, '')
$max_rows.times.each do |i|
	print("\n")
	print_line(i)
end
Screen.print_at($start_row, 1, '')


# ==============================================================================
# LOOP
# ==============================================================================
get_next = true

clear_missing_chars = true
missing_chars = ''

while get_next
	begin
		$DEBUG = ''
		if clear_missing_chars
			missing_chars = ''
		else
			clear_missing_chars = true
		end

		char = get_char
		case char
			when 'q' then exit
			when 'g'
				move_cursor(0)
			when 'G'
				# TODO: Fix this
				move_cursor($max_line)
			when 'J'
				Screen.print_at($end_row, 1, '')
				$start_line = $start_line + 1
				print("\eD")
			when 'j'
				move_cursor($CURSOR_LINE + 1)
			when 'k'
				move_cursor($CURSOR_LINE - 1)
				#print("\eM")
				#print("\eL")
				#print("\eA")
			else
				clear_missing_chars = false
				missing_chars += char
				#$DEBUG = "[not found '#{missing_chars}']"
				print_status()
		end
	rescue
		next
	end
end

