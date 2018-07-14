require "open-uri"
require "pry"
require_relative "./allSuperheroes.rb"

class Superheroes

    attr_accessor :name, :biography, :supername, :realname, :gender, :charactertype, :birthday, :died, :powers

    BASEPATH = "https://comicvine.gamespot.com/"
    @@heroes = []

    def initialize(name = nil, biography = nil, supername = nil, realname = nil, gender = nil, charactertype = nil, birthday = nil, died = nil, powers = nil)
        @name = name
        @biography = biography
        @supername = supername
        @realname = realname
        @gender = gender
        @charactertype = charactertype
        @birthday = birthday
        @died = died
        @powers = powers
        @@heroes << self
    end

    #collect each hero website from AllSuperheroes
    def allsites
        AllSuperheroes.all.map { |e|  "#{BASEPATH}#{e.url}"}
    end

    def self.get_all_heroes_info
        binding.pry
        allsites.each do |site|
            Nokogiri::HTML(open(site)).each do |info|
                name = Nokogiri::HTML(open(site)).css("h1").text.strip
                biography = Nokogiri::HTML(open(site)).css("h3.display-view").text
                supername = info.css("table.table tbody")[0].css("span")
                realname = info.css("tr")[1].css("span")
                gender = info.css("tr")[5].css("span")
                charactertype = info.css("tr")[6].css("span")
                birthday = info.css("tr")[9].css("span")
                died = info.css("tr")[10].css("span")
                powers = info.css("tr")[11].css("div.bar").text
                self.new(name, biography, supername, realname, gender, charactertype, birthday, died, powers)
            end
        end
    end

    def self.all
        @@heroes
    end

end
