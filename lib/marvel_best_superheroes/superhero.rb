
class MarvelBestSuperheroes::Superheroes

    attr_accessor :index, :name, :biography, :supername, :realname, :aliases, :gender, :charactertype, :birthday, :powers, :url


    #class variable which stores informations of all superheroes
    @@all = []


    #instantiate new Superheroes class
    def initialize(attributes)
        attributes.each {|key, value| self.send("#{key}=", "#{value}")}
        @@all << self
    end


    #after scrape from the main website, create new SHs and add 3 first attributes to all SHs
    def self.create_from_file(file1)
        #file1 = [{index: ..., name: ..., url: ...}, {index: ..., name: ..., url: ...},...]
        file1.each {|hero| self.new(hero)}
    end


    #after scrape from invidual page, add the rest attributes to chosen SH
    def add_details_from_file(file2)
        # binding.pry
        #file2 = {bio: ..., supername: ..., realname: ..., gender:..., aliases:..., powers: ...}
        file2.each {|key, value| self.send("#{key}=", "#{value}")}
    end


    #give access to SH class variable
    def self.all
        @@all
    end
end
