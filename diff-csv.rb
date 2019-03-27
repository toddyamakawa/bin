#!/usr/bin/env ruby

# --- Generate Hash from CSV File ---
# CSV file input
#   key, value1, value2, ...
# becomes
#   key => [value1, value2, ...]
def csv_to_hash(csv)
	raise "File not found: #{csv}" unless File.file?(csv)
	hash = Hash.new
	File.read(csv).split("\n").each do |line|
		key, *fields = line.split(/,\s*/)
		hash[key] = fields
	end
	return hash
end

# --- Diff Arrays --
def diff_arrays(arr1, arr2)
	arr1 ||= Array.new
	arr2 ||= Array.new
	max_index = [arr1.size, arr2.size].max
	join = Array.new
	(0..(max_index-1)).each do |i|
		left = arr1[i] || 'nil'
		right = arr2[i] || 'nil'
		if left == right
			join << left
		else
			join << "#{left} -> #{right}"
		end
	end
	return join.join(', ')
end


if __FILE__ == $0

	# Get CSV files
	old_csv, new_csv = ARGV

	# Create hashes from CSV files
	old_hash = csv_to_hash(old_csv)
	new_hash = csv_to_hash(new_csv)

	# Print differences
	(old_hash.keys + new_hash.keys).sort.uniq.each do |key|
		puts "#{key}, #{diff_arrays(old_hash[key], new_hash[key])}"
	end
end

