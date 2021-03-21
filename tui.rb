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
$format[:header] = "\e[1;38:5:46;48:5:238m"
$format[:footer] = "\e[100;93m"
$format[:reset] = "\e[0m"
$format[:table_border] = "\e[38:5:243m"
$format[:cursor_format] = "\e[48:5:238m"
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
	CLEAR = "\e[2J"

	# '\e[1;Nr':   Limit scrolling to scrolling area.
	#SCROLLING_AREA = "\e[1;30r"

	def Screen.clear()
		print(CLEAR)
	end

	def Screen.revert()
		str = REVERT_BUFFER + ENABLE_LINE_WRAP + SHOW_CURSOR
		print(str)
	end

	def Screen.setup()
		at_exit {
			Screen.revert()
		}
		str = ALT_BUFFER + DISABLE_LINE_WRAP + HIDE_CURSOR + CLEAR
		print(str)
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
		lines, columns = `stty size`.split(' ').map(&:to_i)
		header_str = $format[:header] + string.ljust(columns+1) + $format[:reset]
		print_at(0, 0, header_str)
	end

	def Screen.footer(string)
		lines, columns = `stty size`.split(' ').map(&:to_i)
		footer_str = $format[:footer] + string.ljust(columns+1) + $format[:reset]
		print_at(lines, 0, footer_str)
	end
end


# ==============================================================================
# INITIALIZE
# ==============================================================================
# row is for terminal
# line is for printed text

Screen.setup()
Screen.header("TITLE")
$start_row = 2
$end_row = 10
Screen.print_at($end_row + 1, 0, "FOOTER")
print("\e[#{$start_row};#{$end_row}r")
$max_rows = $end_row - $start_row + 1

$lines = (5..50).map(&:to_s)
$CURSOR_LINE = 0
$start_line = 0
$max_line = $lines.size - 1

def print_line(i)
	format = ''
	if i == $CURSOR_LINE
		format = $format[:cursor_format]
	end
	print("\r#{format}#{$lines[i]}#{$format[:reset]}")
end


def move_cursor(final_line)
	if final_line < 0 or final_line > $max_line
		return
	end

	# Move/scroll down
	if final_line - $start_line > $max_rows
		initial_line = $CURSOR_LINE
		$CURSOR_LINE = final_line
		(initial_line..final_line).each do |i|
			print_line(i)
			print("\eD")
		end

	else
		initial_line = $CURSOR_LINE

		# Set $CURSOR_LINE to clear cursor
		$CURSOR_LINE = final_line
		print("\r")
		print_line(initial_line)

		Screen.print_at($start_row + $CURSOR_LINE, 1, '')
		print_line($CURSOR_LINE)
	end
end


Screen.print_at($start_row, 1, '')
($start_line..($start_line + $max_rows - 2)).each do |i|
	print_line(i)
	print("\n")
end
Screen.print_at($start_row, 1, '')


# ==============================================================================
# LOOP
# ==============================================================================
get_next = true
while get_next
	begin
		char = get_char
		case char
			when 'q' then exit
			when 'j'
				move_cursor($CURSOR_LINE + 1)
			when 'k'
				move_cursor($CURSOR_LINE - 1)
				#print("\eM")
				#print("\eL")
				#print("\eA")
			else
				# p char
		end
	rescue
		next
	end
end

