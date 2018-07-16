require_relative "./allSuperheroes.rb"
require_relative "./superhero.rb"
require 'nokogiri'
require 'colorize'
require 'pry'

class CommandLineInterface

    BASEPATH = "https://comicvine.gamespot.com"

    def display
        AllSuperheroes.create_all_superheroes

        puts "\nHere shows TOP 100 MARVEL SUPERHEROES of all time: ".colorize(:bold).colorize(:blue)
        puts "*********************oooOOOooo*********************\n"
        puts "What BADGE you are interested in:\n".colorize(:light_blue)
        puts "1. OP - TOP 10 MOST BADASS SUPERHEROES".colorize(:light_blue)
        puts "2. LEGENDARY - SUPERHEROES RANKED 11-25".colorize(:light_blue)
        puts "3. SUPER-DUPER - SUPERHEROES RANKED 26-50".colorize(:light_blue)
        puts "4. INCREDIBLE - SUPERHEROES RANKED 51-100".colorize(:light_blue)

        get_badge

        get_superhero_site

        display_superhero

        get_other_input
    end

    def get_other_input
        puts "Do you want to learn more about other Superheroes? Type 'Y/Yes' or type 'Exit/No' to end the program"
        input = gets.strip
        if input.upcase == "Y" or input.upcase == "YES"
            get_badge
            get_superhero_site
            display_superhero
            get_other_input
        elsif input.upcase == "EXIT" || input.upcase == "N" || input.upcase == "NO"
            puts "\n___May the FORCE be with you!!!___\n".colorize(:blue)
        else
            get_other_input
        end
    end


    def get_badge
        puts "\nPlease type in the Badge number to access: "
        input = gets.strip
        case input
            when "1" 
                puts "\n Here comes TOP 10 MOST BADASS/OP SUPERHEROES \n".colorize(:blue).colorize(:bold)
                list_all_superheroes(AllSuperheroes.all[0..9])
            when "2"
                puts "\n Here comes the Legendary Superheroes \n".colorize(:blue).colorize(:bold)
                list_all_superheroes(AllSuperheroes.all[11..25])
            when "3"
                puts "\n Here comes the Super-duper Superheroes \n".colorize(:blue).colorize(:bold)
                list_all_superheroes(AllSuperheroes.all[26..50])
            when "3"
                puts "\n Here comes the Incredible Superheroes \n".colorize(:blue).colorize(:bold)
                list_all_superheroes(AllSuperheroes.all[51..100])
            else 
                puts "Invalid input"
                get_badge
        end
    end

    def get_superhero_site
        puts "\nWhich superhero do you want to learn more about? "
        puts "Please type in superhero number:"
        input = gets.strip.to_i - 1
        if input >= 0 && input < all_superheroes_sites.size
            puts "Please wait while we evoke #{all_superheroes_names[input]}...\n"
            Superheroes.get_superhero_infos(all_superheroes_sites[input])
        else 
            puts "Invalid input"
            get_superhero_site
        end
    end


    def list_all_superheroes(heroes)
        heroes.each do |hero|
            puts "#{hero.name}"
        end
    end

    #collect each hero website from AllSuperheroes
    def all_superheroes_sites
        AllSuperheroes.all.map { |e|  "#{BASEPATH}#{e.url}"}
    end

    #this method is called when program evokes individual superhero
    def all_superheroes_names
        AllSuperheroes.all.map { |e|  "#{e.name}".split(". ")[1]}
    end

    #create a superhero base on user input
    def create_superhero(site)
        Superheroes.get_superhero_infos(site)
    end

    #Print out each Superhero's informations in desired format
    def display_superhero
        Superheroes.all.each do |hero|
            puts "#{hero.name.upcase}".colorize(:blue).colorize(:bold)
            puts ""
            puts "  > Biography:".colorize(:blue)
            puts ""
            puts "#{hero.biography}"
            puts ""
            puts "  > General Information: ".colorize(:blue).colorize(:bold)
            puts ""
            puts "    - Super name:".colorize(:light_blue) + "     #{hero.supername}"
            puts "    - Real name:".colorize(:light_blue) + "      #{hero.realname}"
            puts "    - Gender:".colorize(:light_blue) + "         #{hero.gender}"
            puts "    - Character Type:".colorize(:light_blue) + " #{hero.charactertype}"
            puts "    - Birthday:".colorize(:light_blue) + "       #{hero.birthday}"
            puts "    - Died:".colorize(:light_blue) + "           #{hero.died}"
            puts "    - Powers:".colorize(:light_blue) +"          #{hero.powers}"
        end
    end

end
