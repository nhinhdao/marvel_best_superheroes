require "nokogiri"
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
        # binding.pry
        allsites.each do |site|

            doc = Nokogiri::HTML(open(site)).css("table.table tbody")
            name = Nokogiri::HTML(open(site)).css("h1").text.strip
            biography = Nokogiri::HTML(open(site)).css("h3.display-view").text
            supername = doc.css("div[data-field='realName']").text.strip.split(/\n/).first
            realname = doc.css("div[data-field='realName']").text.strip.split(/\n/).last.strip
            gender = doc.css("div[data-field='gender']").text.strip
            charactertype = doc.css("div[data-field='origin']").text.strip
            birthday = doc.css("div[data-field='birthday']").text.strip
            died = doc.css("div[data-field='issuesDied']").text
            powers = doc.css("div[data-field='powers']").text
                
            self.new(name, biography, supername, realname, gender, charactertype, birthday, died, powers)
        end
    end


    def self.all
        @@all
    end
end
