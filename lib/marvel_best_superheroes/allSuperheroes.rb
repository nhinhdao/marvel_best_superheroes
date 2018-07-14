require 'pry'
require 'open-uri'

class AllSuperheroes

    attr_accessor :name, :url

    SITE = "https://comicvine.gamespot.com/profile/noahmaximillion/lists/top-100-marvel-superheroes/48749/"

    #array contains all superheroes information
    @@allsuperheroes = []

    def initialize(name = nil, url = nil)
        @name = name
        @url = url
        @@allsuperheroes << self
    end

    def self.scrape_all_superheroes
        binding.pry
        Nokogiri::HTML(open(SITE)).css("ul.editorial"). each do |hero|
            self.new(hero.css("div h3"), hero.css("a").attribute("href"))
        end
    end

    def self.all
        @@allsuperheroes
    end

end
