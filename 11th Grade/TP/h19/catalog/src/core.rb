Array.class_eval do
	def stay what
		return reject {|x| x.end_with? '!'} if what == :+
		select {|x| x.end_with? '!'} if what == :-
	end
end

class Song
	attr_accessor :name, :artist, :genre, :subgenre, :tags

	def initialize name, artist, genre, subgenre, tags
		@name, @artist, @genre, @subgenre = name, artist, genre, subgenre
		@tags = Array(tags)
	end

	def match_tags? values
		return false unless (@tags & values).count == values.stay(:+).count
		if values.stay(:-).count > 0
			return false if (@tags - values).include? *values.stay(:-).map {|x| x.chop}
		end
		true
	end

	def match? criteria
		criteria.keys.each do |key|
			if key == :tags
				return match_tags? Array(criteria[key])
			elsif key == :filter
				return false unless criteria[key].call(self)
			else
				return false unless eval("@#{key.to_s}") == criteria[key]
			end
		end
		true
	end

	def load_tags! tags
		@tags |= tags
		@tags << @genre.downcase
		@tags << @subgenre.downcase if @subgenre
	end
end

class Collection
	attr_accessor :songs, :songs_as_strings, :artist_tags

	def initialize songs, artists
		@songs_as_strings = songs.lines.to_a.map {|l| l.chomp}
		@artist_tags = eval(artists)
		@songs = Array.new
		parse!
		load_songs_tags!
	end

	def find criteria = {}
		@songs.select {|s| s.match?(criteria)}
	end

	def parse!
		songs_as_strings.map do |line|
			n, a, gs, t = line.split('.').map {|s| s.strip}
			g, s = gs.split(',').map {|x| x.strip}
			t = t.split(',').map {|x| x.strip} unless t.nil?
			@songs << Song.new(n, a, g, s, t)
		end
	end

	def load_songs_tags!
		@artist_tags.map do |artist, tags|
			find(artist: artist).map {|s| s.load_tags! tags}
		end
	end
end
