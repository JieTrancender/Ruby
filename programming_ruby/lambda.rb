def n_times(thing)
	return lambda {|n| thing * n}
end

p1 = n_times(23)
puts p1.call(3)
puts p1.call(4)