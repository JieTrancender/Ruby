class Song
	attr_reader :name, :artist, :duration
	attr_writer :duration

	@@plays = 0

	def initialize(name, artist, duration)
		@name = name
		@artist = artist
		@duration = duration
		@plays = 0
	end

	def to_s
		"Song: #@name--#@artist (#@duration)"
	end

	def duration_in_minutes
		@duration / 60.0
	end

	def duration_in_minutes= (new_duration)
		@duration = (new_duration * 60).to_i
	end

	def play
		@plays += 1
		@@plays += 1
		"This song: #@plays plays, Total #@@plays plays."
	end
end

class KaraokeSong < Song
	def initialize(name, artist, duration, lyrics)
		super(name, artist, duration)
		@lyrics = lyrics
	end

	def to_s
		super + " [#@lyrics]"
		#"Song: #@name--#@artist (#@duration) {#@lyrics}"
	end
end

class SongList
	MAX_TIME = 5 * 60

	def initialize
		@songs = Array.new
		@index = WordIndex.new
	end

	def append(song)
		@songs.push(song)
		@index.add_to_index(song, song.name, song.artist)
		self
	end

	def delete_first
		@songs.shift
	end

	def delete_last
		@songs.pop
	end

	def [](index)
		@songs[index]
	end

	def length
		@songs.size
	end

	#def with_title(title)
	#	for i in 0...@songs.length
	#		return @songs[i] if title == @songs[i].name
	#	end
	#	return nil
	#end

	def with_title(title)
		@songs.find { |song| title == song.name}
	end

	def look_up(word)
		@index.look_up(word)
	end
	

	class << self
		def is_too_long(song)
			return song.duration > MAX_TIME
		end
	end
end

class MyLogger
	private_class_method :new

	@@logger = nil

	class << self
		def create
			@@logger = new unless @@logger
			@@logger
		end
	end
end

class WordIndex
	def initialize
		@index = {}
	end

	def add_to_index(obj, *phrases)
		phrases.each do |phrase|
			phrase.scan(/\w[-\w']+/) do |word|
				word.downcase!
				@index[word] = [] if @index[word].nil?
				@index[word].push(obj)
			end
		end
	end

	def look_up(word)
		@index[word.downcase]
	end
end


File.open("songs_data.txt", "r") do |file|
	songs = SongList.new

	file.each do |line|
		file, length, name, title = line.chomp.split(/\s*\|\s*/)
		name.squeeze!(" ")
		title.squeeze!(" ")
		mins, secs = length.scan(/\d+/)
		songs.append(Song.new(title, name, mins.to_i * 60 + secs.to_i))
	end

	(0...songs.length).each do |index|
		puts songs[index]
	end

	puts "test index...."

	puts songs.look_up("Fats")
	puts songs.look_up("ain't")
	puts songs.look_up("RED")
	puts songs.look_up("WoRLD")
end


song = Song.new("Bicyclops", "Fleck", 260)
puts song.inspect
puts song.to_s

song = KaraokeSong.new("My Way", "SInatra", 226, "And now, the...")
puts song.inspect
puts song.to_s

s1 = Song.new("song_one", "artist_one", 123)
s2 = Song.new("song_two", "artist_two", 234)

#require 'minitest/autorun'
#
#class SongTest < Minitest::Test
#	def test_simple
#		song = Song.new("Bicyclops", "Fleck", 260)
#		song.inspect
#		assert_equal("Bicyclops", song.name)
#	end
#end

#require 'minitest/autorun'

#class SongTest < Minitest::Test
#	def test_delete
#		list = SongList.new
#		s1 = Song.new("title1", "artist1", 123)
#		s2 = Song.new("title2", "artist2", 234)
#		s3 = Song.new("title3", "artest3", 345)
#
#		list.append(s1).append(s2).append(s3)
#
#		assert_equal(s1, list.delete_first)
#		assert_equal(s2, list.delete_first)
#		assert_equal(s3, list.delete_last)
#		assert_nil(list.delete_last)
#	end
#end

