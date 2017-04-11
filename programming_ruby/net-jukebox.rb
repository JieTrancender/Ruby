# -*- coding: UTF-8 -*-

class Song
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

	def duration_in_minutes=(new_duration)
		@duration = (new_duration * 60).to_i
	end

	def play
		@plays += 1
		@@plays += 1
		"This song: #@plays plays. Total #@@plays plays."
	end

	attr_reader :name, :artist, :duration
	attr_writer :duration
end

class KaraokeSong < Song
	def initialize(name, artist, duration, lyrics)
		super(name, artist, duration)
		@lyrics = lyrics
	end

	def lyrics
		@lyrics
	end
end

class SongList
	MAX_TIME = 5 * 60

	def initialize
		@songs = Array.new
	end

	def self.is_too_long(song)
		return song.duration > MAX_TIME
	end

	def append(song)
		@songs.push(song)
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
		@songs.length
	end

	# def with_title(title)
	# 	for i in 0...@songs.length
	# 		return @songs[i] if title == @songs[i].name
	# 	end
	# 	return nil
	# end
	def with_title(title)
		@songs.find {|song| title == song.name}
	end
end

File.open("songs_data.txt", "r") do |song_file|
	songs = SongList.new
	song_file.each do |line|
		file, length, name, title = line.chomp.split(/\s*\|\s*/)
		name.squeeze!(" ")
		title.squeeze!(" ")
		# mins, secs = length.split(/:/)
		mins, secs = length.scan(/\d+/)
		songs.append(Song.new(title, name, mins.to_i * 60 + secs.to_i))
	end

	# puts songs[1], songs[0], songs[2]
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

	def lookup(word)
		@index[word.downcase]
	end
end

class SongList
	def initialize
		@songs = Array.new
		@index = WordIndex.new
	end

	def append(song)
		@songs.push(song)
		@index.add_to_index(song, song.name, song.artist)
		self
	end

	def lookup(word)
		@index.lookup(word)
	end
end

class VU
	include Comparable
	attr :volume

	def initialize(volume)
		@volume = volume
	end

	def inspect
		'#' * @volume
	end

	def <=>(other)
		self.volume <=> other.volume
	end

	def succ
		raise(IndexError, "Volume too big") if @volume >= 9
		VU.new(@volume.succ)
	end
end

songs = SongList.new
f = File.open("songs_data.txt", "r")
f.each do |line|
	file, length, name, title = line.chomp.split(/\s*\|\s*/)
	name.squeeze!(" ")
	title.squeeze!(" ")
	mins, secs = length.scan(/\d+/)
	songs.append(Song.new(title, name, mins.to_i * 60 + secs.to_i))
end
f.close
puts songs.lookup("Fats")
puts songs.lookup("ain't")
puts songs.lookup("RED")
puts songs.lookup("WoRlD")

# medium_volume = VU.new(4)..VU.new(7)
# puts medium_volume.to_a
# puts medium_volume.include?(VU.new(3))
# puts medium_volume
# puts VU.new(4).inspect

# while line =gets
# 	puts line if line =~ /start/ .. line =~ /end/
# end

# require 'test/unit'
# class TestSongList < Test::Unit::TestCase
# 	def test_delte
# 		list = SongList.new
# 		s1 = Song.new('title1', 'artist1', 1)
# 		s2 = Song.new('title2', 'artist2', 2)
# 		s3 = Song.new('title3', 'artist3', 3)
# 		s4 = Song.new('title4', 'artist4', 4)

# 		list.append(s1).append(s2).append(s3).append(s4)

# 		assert_equal(s1, list[0])
# 		assert_equal(s3, list[2])
# 		assert_nil(list[9])

# 		assert_equal(s1, list.delete_first)
# 		assert_equal(s2, list.delete_first)
# 		assert_equal(s4, list.delete_last)
# 		assert_equal(s3, list.delete_last)
# 		assert_nil(list.delete_last)
# 	end
# end
