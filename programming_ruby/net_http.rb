require 'net/http'

Net::HTTP.start('www.baidu.com') do |http|
	response = http.get('/index.html')
	puts "Code = #{response.code}"
	puts "Message = #{response.message}"
	response.each {|key, value| printf "%-14s = %-40.40s\n", key, value}
	p response.body[0, 200]
	# p response.body
end