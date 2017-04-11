# -*- coding: UTF-8 -*-
class Example
	# initialize方法默认是private
	# private_class_method :new
	# private_method :test
	def initialize
	end

	def Example.class_method_one
		puts "Hello World! one"
	end

	def self.class_method_two
		puts "Hello World! two"
	end

	class << self
		def class_method_three
			puts "Hello World! three"
		end
	end

	def test
		puts "Test"
	end

	def test1
	end

	def test2
	end

	def test3
	end

	public :test1
	protected :test2
	private :test3
end

Example.class_method_one
Example.class_method_two
Example.class_method_three

Example.new().test

class MyLogger
	private_class_method :new
	@@logger = nil

	def MyLogger.create
		@@logger = new unless @@logger
		@@logger
	end
end

puts MyLogger.create.object_id
puts MyLogger.create.object_id