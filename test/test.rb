# -*- coding: UTF-8 -*-

def call_block
	puts "start of method"
	yield
	yield
	puts "end if method"
end

call_block { puts "in the block"}

def call_block
	yield("Hello", 99)
end

call_block {|str, num| puts "#{str} #{num}"}

animals = %w( ant bee cat dog elk )
animals.each do |animal|
	puts animal
end

%w( ant bee cat elk dog).each {|name| print name, " "}

printf("Number: %5.2f, \nString: %s\n", 1.23, "Hello")

# line = gets
# print line

ARGF.each {|line| puts line if line =~ /Ruby/}