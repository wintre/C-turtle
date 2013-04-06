class Song
	attr_accessor :name, :artist, :genre, :subgenre, :tags

	def initialize name, artist, genre, subgenre, tags
		@name, @artist, @genre, @subgenre, @tags = name, artist, genre, subgenre, tags
	end

	def match? criteria
		criteria.keys.map {|c| return false unless eval("@#{c.to_s}") == criteria[c]}
		true
	end
end

class Collection
	attr_accessor :songs, :songs_as_strings, :artist_tags

	def initialize songs, artists
		@songs_as_strings = songs.lines.to_a.map {|l| l.chomp}
		@artist_tags = eval(artists)
		@songs = Array.new
	end

	def find criteria
		@songs.select {|s| s.match?(criteria)}
	end

	def parse
		songs_as_strings.map do |line|
			n, a, gs, t = line.split('.').map {|s| s.strip}
			g, s = gs.split(',').map {|x| x.strip}
			t = t.split(',').map {|x| x.strip} unless t.nil?
			@songs << Song.new(n, a, g, s, t)
		end
	end
end
