require_relative "../lib/allSuperheroes.rb"
require_relative "../lib/superhero.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface

    #website where all the information of Marvel Superheroes comes from
    BASEFILE = "https://comicvine.gamespot.com/profile/noahmaximillion/lists/top-100-marvel-superheroes/48749/"

    def display
        list_all_superheroes
    end

    def list_all_superheroes
        puts "Here shows TOP TIER MARVEL SUPERHEROES of all time: ".colorize(:bold).colorize(:orange)
        puts "*********************oooOOOooo*********************".colorize(:light_blue)
        AllSuperheroes.all.each do |hero|
            puts "#{hero.name}"

    def display_AllSuperheroess
        Superheroes.all.each do |hero|
            puts "#{hero.name.upcase}".colorize(:blue).colorize(:bold)
            puts "\n"
            puts "  > Biography:".colorize(:green)
            puts " #{hero.biography}"
            puts "\n"
            puts "  > General Information: ".colorize(:blue).colorize(:bold)
            puts "      - Super name:".colorize(:light_blue) + " #{hero.supername}"
            puts "      - Real name:".colorize(:light_blue) + " #{hero.realname}"
            puts "      - Gender:".colorize(:light_blue) + " #{hero.gender}"
            puts "      - Character Type:".colorize(:light_blue) + " #{hero.charactertype}"
            puts "      - Birthday:".colorize(:light_blue) + " #{hero.birthday}"
            puts "      - Died:".colorize(:light_blue) + " #{hero.died}"
            puts "      - Powers:".colorize(:light_blue)
            puts "          #{hero.powers}"
        end
    end

end