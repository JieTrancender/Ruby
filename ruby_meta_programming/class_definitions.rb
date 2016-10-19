class MyClass
  puts 'Hello'
end

result = class MyClass
           self
end

puts result

def add_method_to a_class
  a_class.class_eval do
    def m
      'Hello'
    end
  end
end

add_method_to String
puts "JieTrancender".m

class MyClass
  def method_one
    def method_two
      'Hello'
    end
  end
end

obj = MyClass.new
puts obj.method_one
puts obj.method_two

class MyClass
  @my_var = 1

  def self.read
    @my_var
  end

  def write
    @my_var = 2
  end

  def read
    @my_var
  end
end

obj = MyClass.new
obj.write
puts obj.read
puts MyClass.read

class Loan
  def initialize book
    @book = book
    @time = Loan.time_class.now
  end

  def self.time_class
    @time_class || Time
  end

  def to_s
    "#{@book.upcase} loaned on #{@time}"
  end
end

class FakeTime
  def self.now
    'Wed October 19 13:46:32'
  end
end

require 'minitest/autorun'

class TestLoan < Minitest::Test
  def test_conversion_to_string
    Loan.instance_eval do
      @time_class = FakeTime
    end
    loan = Loan.new('War and Peace')
    assert_equal 'WAR AND PEACE loaned on Wed October 19 13:46:32', loan.to_s
  end
end

class TestAssert < Minitest::Test
  def test_string
    assert_equal 'My name is mo jie', 'My name is mo jie'
  end
end