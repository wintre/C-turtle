require "#{Dir.pwd}/src/core.rb"

describe Collection do
	before(:each) do
		@songs = File.open("#{Dir.pwd}/catalog/songs.txt", "r").read
		@artists = File.open("#{Dir.pwd}/catalog/artists.txt", "r").read
		@c = Collection.new(@songs, @artists)
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
		@c.songs.first.tags.should include('popular', 'cover')

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

	it "should add genre and subgenre to tags (smallcased)" do
		@c.find(tags: %w[jazz bebop]).first.name.should eq('My Favourite Things')
	end

	it "should add the info from the artists dictionary to the catalog" do
		@c.find(tags: %w[saxophone]).first.name.should eq('My Favourite Things')
		@c.find(tags: 'saxophone').first.name.should eq('My Favourite Things')
	end

	it "should have option to make negative calls to 'find' with !" do
		@c.find(tags: %w[jazz cover!]).first.name.should eq('Alabama')
	end

	it "should return all songs if 'find' receive no arguments" do
		@c.find().count.should eq(20)
	end

	it "should return empty list if 'find' have no matches" do
		@c.find(artist: 'Lil Wayne').should eq([]) # Everybody knows that Lil is not an artist. :)
	end

	it "should can find songs by more then one parametar" do
		@c.find(artist: 'John Coltrane', tags: 'melancholic').first.name.should eq('Alabama')
	end

	it "should can find songs by lambdas" do
		@c.find(filter: ->(song) { song.name.start_with?('My') }).first.name.should eq('My Favourite Things')
	end
end
