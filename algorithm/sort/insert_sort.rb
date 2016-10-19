class Array
  def insert_sort!
    (0...self.length).to_a.each do |j|
      key = self[j]
      i = j - 1
      while i >= 0 and self[i] > key
        self[i + 1] = self[i]
        i = i - 1
      end
      self[i + 1] = key
    end
    self
  end
end

nums = gets.split(',')

nums.to_a.insert_sort!

nums.each do |num|
  print num, ' '
end

puts nums
