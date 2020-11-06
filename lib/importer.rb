require 'pry'

class MusicImporter
    attr_accessor :path

    def initialize( path )
        @path = path
    end

    def files
        content = Dir.entries(@path)
        i = 0
        mp3_files = []
        while i < content.length
            if i >= 2
                mp3_files << content[i]
            end
            i += 1
        end
        mp3_files
    end

    def import
        files.each do |song|
            Song.create_from_filename( song )
        end
    end
end