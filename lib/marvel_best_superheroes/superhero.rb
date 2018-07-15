require "open-uri"
require "pry"
require_relative "./allSuperheroes.rb"

class Superheroes

    attr_accessor :name, :biography, :supername, :realname, :gender, :charactertype, :birthday, :died, :powers

    BASEPATH = "https://comicvine.gamespot.com"
    @@all = []

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
        @@all << self
    end

    #collect each hero website from AllSuperheroes
    def allsites
        AllSuperheroes.all.map { |e|  "#{BASEPATH}#{e.url}"}
    end

    def self.get_all_heroes_info
        binding.pry
        allsites.each do |site|
            doc = Nokogiri::HTML(open(site)).css("table.table tbody").css("div span")
            # Nokogiri::HTML(open(site)).css("table.table tbody").each do |info|
                name = Nokogiri::HTML(open(site)).css("h1").text.strip
                biography = Nokogiri::HTML(open(site)).css("h3.display-view").text
                supername = doc[0].text
                realname = doc[1].text
                gender = doc[5].text
                charactertype = doc[6].text
                birthday = doc[9].text
                died = doc[10].text
                powers = doc[11].text
                self.new(name, biography, supername, realname, gender, charactertype, birthday, died, powers)
            end
            Nokogiri::HTML(open(site)).css("table.table tbody").css("div span")[2].text
        end
    end
    doc = Nokogiri::HTML(open(site)).css("table.table tbody").css("div")[data-field="gender"].text
    def self.all
        @@all
    end

end
