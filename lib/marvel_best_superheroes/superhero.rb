require "nokogiri"
require "open-uri"
require "pry"
require_relative "./allSuperheroes.rb"

class Superheroes

    attr_accessor :name, :biography, :supername, :realname, :aliases, :gender, :charactertype, :birthday, :powers

    @@all = []

    def initialize(name = nil, biography = nil, supername = nil, realname = nil, aliases = nil, gender = nil, charactertype = nil, birthday = nil, powers = nil)
        @name = name
        @biography = biography
        @supername = supername
        @realname = realname
        @aliases = aliases
        @gender = gender
        @charactertype = charactertype
        @birthday = birthday
        @powers = powers
        @@all << self
    end
    
    def allsites
        AllSuperheroes.all.map { |e|  "#{BASEPATH}#{e.url}"}
    end

    def self.get_superhero_infos(site)

        Superheroes.reset

        doc = Nokogiri::HTML(open(site)).css("table.table tbody")
        name = Nokogiri::HTML(open(site)).css("h1").text.strip
        biography = Nokogiri::HTML(open(site)).css("h3.display-view").text
        supername = doc.css("div[data-field='realName']").text.strip.split(/\n/).first
        aliases = doc.css("div[data-field='aliases']").text.strip.split("\r\n").map{|i| "\n                      #{i}"}.join
        realname = doc.css("div[data-field='realName']").text.strip.split(/\n/).last.strip
        gender = doc.css("div[data-field='gender']").text.strip
        charactertype = doc.css("div[data-field='origin']").text.strip
        birthday = doc.css("div[data-field='birthday']").text.strip
        powers = doc.css("div[data-field='powers']").text
                
        self.new(name, biography, supername, realname, aliases, gender, charactertype, birthday, powers)
    end

    def self.all
        @@all
    end

    def self.reset
        @@all = []
    end
    # binding.pry                    
end
