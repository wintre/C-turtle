require "#{Dir.pwd}/src/core.rb"

describe Collection do
	before(:each) do
		@songs = File.open("#{Dir.pwd}/catalog/songs.txt", "r").read
		@artists = File.open("#{Dir.pwd}/catalog/artists.txt", "r").read
		@c = Collection.new(@songs, @artists)
		@c.parse
	end

	it "should reads songs from file" do
		@c.songs_as_strings.first.should eq('My Favourite Things.          John Coltrane.      Jazz, Bebop.        popular, cover')
	end

	it "should reads artists from file" do
		@c.artist_tags.should eq({'John Coltrane' => %w[saxophone], 'Bach' => %w[piano polyphony]})
	end

	it "should parse song string read from file" do
		@c.songs.first.name.should eq('My Favourite Things')
		@c.songs.first.artist.should eq('John Coltrane')
		@c.songs.first.genre.should eq('Jazz')
		@c.songs.first.subgenre.should eq('Bebop')
		@c.songs.first.tags.should eq(['popular', 'cover'])

		@c.songs.last.subgenre.should eq(nil)
	end

	it "should can find song by its name" do
		@c.find(name: 'Fur Elise').first.artist.should eq('Beethoven')
	end

	it "should can find song by its tags" do
		@c.find(tags: %w[weird cool]).first.artist.should eq('Miles Davis')
	end

	it "should can find song by its artists name" do
		@c.find(artist: 'John Coltrane').first.name.should eq('My Favourite Things')
		@c.find(artist: 'Bach').last.name.should eq('Goldberg Variations')
	end
end
