require 'digest/md5'
require 'digest/sha1'

for hash_class in [Digest::MD5, Digest::SHA1]
	puts "Using #{hash_class.name}"
	puts hash_class.hexdigest("hello world")

	digest = hash_class.new
	digest << "hello"
	digest << " "
	digest << "world"
	puts digest.hexdigest
	puts 
end