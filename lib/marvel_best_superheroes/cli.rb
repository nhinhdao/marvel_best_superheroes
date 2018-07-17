require_relative "./allSuperheroes.rb"
require_relative "./superhero.rb"
require 'nokogiri'
require 'colorize'
require 'pry'

class CommandLineInterface

    BASEPATH = "https://comicvine.gamespot.com"

    def display
        AllSuperheroes.create_all_superheroes

        puts "\nHERE SHOWS TOP 100 MARVEL SUPERHEROES OF ALL TIME: ".bold.red
        puts "..................................................\n"
        puts "\nWhat BADGE you are interested in:\n".bold.yellow
        puts "1. OP - TOP 10 MOST BADASS SUPERHEROES".yellow
        puts "2. LEGENDARY - SUPERHEROES RANKED 11-25".yellow
        puts "3. SUPER-DUPER - SUPERHEROES RANKED 26-50".yellow
        puts "4. INCREDIBLE - SUPERHEROES RANKED 51-100".yellow

        get_badge
        get_superhero_site
        display_superhero
        get_other_input
    end

    def get_other_input
        puts "Do you want to learn more about other Superheroes?"
        puts "Type 'Y/Yes' or type 'Exit/No' to end the program"
        input = gets.strip
        if input.upcase == "Y" or input.upcase == "YES"
            get_badge
            get_superhero_site
            display_superhero
            get_other_input
        elsif input.upcase == "EXIT" || input.upcase == "N" || input.upcase == "NO"
            puts "\n___MAY THE FORCE BE WITH YOU!!!___\n".bold.yellow
        else
            puts "\n Invalid input"
            get_other_input
        end
    end


    def get_badge
        puts "\nPlease type in the Badge number to access: "
        input = gets.strip
        case input
            when "1"
                puts "\n Here comes TOP 10 MOST BADASS/OP SUPERHEROES \n".bold.blue
                list_all_superheroes(AllSuperheroes.all[0..9])
            when "2"
                puts "\n Here comes the Legendary Superheroes \n".bold.blue
                list_all_superheroes(AllSuperheroes.all[10..24])
            when "3"
                puts "\n Here comes the Super-duper Superheroes \n".bold.blue
                list_all_superheroes(AllSuperheroes.all[25..49])
            when "4"
                puts "\n Here comes the Incredible Superheroes \n".bold.blue
                list_all_superheroes(AllSuperheroes.all[50..100])
            else
                puts "Invalid input"
                get_badge
        end
    end

    def get_superhero_site
        puts "\nWhich superhero do you want to learn more about? "
        puts "Please type in superhero number:"
        input = gets.strip.to_i-1
        if input >= 0 && input < all_superheroes_sites.size
            puts "\nPlease wait while we evoke #{all_superheroes_names[input]}...\n"
            Superheroes.get_superhero_infos(all_superheroes_sites[input])
        else
            puts "Invalid input"
            puts "Please enter number in above selection"
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
            puts "\n#{hero.name.upcase}\n".bold.red
            puts "  <> Biography:\n".bold.blue
            puts "#{hero.biography}\n"
            puts "\n  <> General Information:".bold.blue
            puts "\n    - Super name:".bold.blue + "     #{hero.supername}"
            puts "\n    - Real name:".bold.blue + "      #{hero.realname}"
            puts "\n    - Aliases:".bold.blue + "      #{hero.aliases}"
            puts "\n    - Gender:".bold.blue + "         #{hero.gender}"
            puts "\n    - Character Type:".bold.blue + " #{hero.charactertype}"
            puts "\n    - Birthday:".bold.blue + "       #{hero.birthday}"
            puts "\n    - Powers:".colorize(:blue).bold + "#{hero.powers}"
        end
    end

end
