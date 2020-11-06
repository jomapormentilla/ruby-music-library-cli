class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize( name )
        @name = name
        @songs = []
        save
    end
 
    def add_song( song )
        if song.artist == nil
            song.artist = self
        end
        
        if @songs.include?(song)
            #
        else
            @songs << song
        end
    end

    def genres
        Genre.all.collect{ |genre| genre }
    end

    def save
        @@all << self
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