# -*- coding: UTF-8 -*-

num = 81
6.times do
	puts "#{num.class}: #{num}"
	num *= num
end

f = File.open("integer.txt", "r")
f.each do |line|
	v1, v2 = line.split
	print Integer(v1) + Integer(v2), " "
end

puts "This is line #{$.}"

# 不会去掉前导缩进
string = <<END_OF_STRING
	The body of the string
	is the input lines up to
	one ending with the same
	text that followed the '<<'
END_OF_STRING

puts string

