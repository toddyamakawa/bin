#!/usr/bin/env ruby
require 'yaml'

# ==============================================================================
# OBJECT FUNCTIONS
# ==============================================================================
class Object
	def to_cfg(parent = '')
		return ["#{parent}=#{self.to_s}"]
	end
end

class Integer
	def to_cfg(parent = '')
		return ["#{parent}=#{self.to_s}"]
	end
end

class String
	def to_cfg(parent = '')
		return ["#{parent}='#{self}'"]
	end
end

class Array
	def to_cfg(parent = '')
		config = Array.new
		self.each_with_index do |item, index|
			config << [item.to_cfg("#{parent}[#{index}]")]
		end
		return config
	end
end

class Hash
	def to_cfg(parent = '')
		config = Array.new
		parent = "#{parent}." unless parent.empty?
		self.keys.sort.each do |key|
			config << self[key].to_cfg("#{parent}#{key}")
		end
		return config
	end
end


# ==============================================================================
# RUN
# ==============================================================================
puts YAML.load(ARGF).to_cfg

