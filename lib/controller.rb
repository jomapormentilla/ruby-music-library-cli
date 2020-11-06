require 'pry'

class MusicLibraryController
    attr_accessor :path

    WELCOME = [
        "Welcome to your music library!",
        "To list all of your songs, enter 'list songs'.",
        "To list all of the artists in your library, enter 'list artists'.",
        "To list all of the genres in your library, enter 'list genres'.",
        "To list all of the songs by a particular artist, enter 'list artist'.",
        "To list all of the songs of a particular genre, enter 'list genre'.",
        "To play a song, enter 'play song'.",
        "To quit, type 'exit'.",
        "What would you like to do?"
    ]

    def initialize( path='./db/mp3s' )
        @path = path
        MusicImporter.new( path ).import
    end

    def call
        input = nil
        WELCOME.each do |message|
            puts message
            if input != "exit"
                input = gets.strip

                case input
                when "list songs"
                    list_songs
                when "list artists"
                    list_artists
                when "list genres"
                    list_genres
                when "list artist"
                    list_songs_by_artist
                when "list genre"
                    list_songs_by_genre
                when "play song"
                    play_song
                end
            end
        end
    end

    def list_songs
        sorted = Song.all.sort_by{ |song| song.name }.uniq
        sorted.each.with_index(1){ |song, index| puts "#{ index }. #{ song.artist.name } - #{ song.name } - #{ song.genre.name }" }
    end

    def list_artists
        sorted = Artist.all.sort_by{ |artist| artist.name }.uniq
        sorted.each.with_index(1){ |artist, index| puts "#{  index }. #{ artist.name }" }
    end

    def list_genres
        sorted = Genre.all.sort_by{ |genre| genre.name }.uniq
        sorted.each.with_index(1){ |genre, index| puts "#{  index }. #{ genre.name }" }
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        sorted = Song.all.sort_by{ |song| song.name }.uniq.select{ |song| song.artist.name == input }
        sorted.each.with_index(1){ |song, index| puts "#{ index }. #{ song.name } - #{ song.genre.name }" }
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        sorted = Song.all.sort_by{ |song| song.name }.uniq.select{ |song| song.genre.name == input }
        sorted.each.with_index(1){ |song, index| puts "#{ index }. #{ song.artist.name } - #{ song.name }" }
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        song_list = Song.all.sort_by{ |song| song.name }.uniq

        if input.between?(1, song_list.length)
            song_list.each.with_index(1) do |song, index|
                if index == input
                    puts "Playing #{ song.name } by #{ song.artist.name }"
                end
            end
        end
    end
end