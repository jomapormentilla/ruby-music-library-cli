require 'pry'

class Song
    extend Concerns::Findable

    attr_accessor :name, :genre
    attr_reader :artist

    @@all = []

    def initialize( name, artist=nil, genre=nil )
        @name = name
        
        @artist = artist
        self.artist=( artist )
        
        @genre = genre
        self.genre=( genre )
        
        save
    end

    def save
        @@all << self
    end

    def artist=( artist )
        @artist = artist
        if artist != nil
            @artist.add_song( self )
        end
    end

    def genre=( genre )
        @genre = genre
        if genre != nil
            @genre = genre
        end
    end

    def self.new_from_filename( filename )
        arr = filename.gsub("."," - ").split(" - ")
        artist = arr[0]
        name = arr[1]
        genre = arr[2]
        
        new_song = self.find_or_create_by_name( name )
        new_song.artist = Artist.find_or_create_by_name( artist )
        new_song.genre = Genre.find_or_create_by_name( genre )

        new_song
    end

    def self.create_from_filename( filename )
        new_from_filename( filename ).save
    end

    def self.create( name )
        self.new( name )
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end