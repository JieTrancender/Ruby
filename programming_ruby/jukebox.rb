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
