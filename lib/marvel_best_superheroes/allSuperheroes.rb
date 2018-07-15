require 'pry'
require "nokogiri"
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

    # binding.pry
    def getList
        Nokogiri::HTML(open(SITE)).css("ul.editorial").css("h3").map {|hero| hero.text}
    end

    def getAllSites
        Nokogiri::HTML(open(SITE)).css("ul.editorial").css("li a").map { |e|  e.attribute("href").value}
    end

    def self.scrape_all_superheroes
        for x in (0..getList.size) do
            self.new(getList[x], getAllSites[x])
        end
    end

    def self.all
        # binding.pry
        @@allsuperheroes
    end
    binding.pry
end
