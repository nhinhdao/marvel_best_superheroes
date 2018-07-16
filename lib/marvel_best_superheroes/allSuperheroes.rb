require 'pry'
require "nokogiri"
require 'open-uri'

class AllSuperheroes

    attr_accessor :name, :url

    SITE = "https://comicvine.gamespot.com/profile/noahmaximillion/lists/top-100-marvel-superheroes/48749/"

    #array contains all superheroes information
    @@all = []

    def initialize(name = nil, url = nil)
        @name = name
        @url = url
        @@all << self
    end


    def self.create_all_superheroes
        Nokogiri::HTML(open(SITE)).css("ul.editorial").css("li").map do |hero|
            name = hero.css("h3").text
            url = hero.css("a").attribute("href").value
            self.new(name, url)
        end
    end

    def self.all
        @@all
    end
    
end
