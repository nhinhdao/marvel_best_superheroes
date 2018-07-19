
class MarvelBestSuperheroes::CommandLineInterface

    #main method to be called on bin - executed file
    def display

        create_superheroes

        puts "\nHERE SHOWS TOP 100 MARVEL SUPERHEROES OF ALL TIME: ".bold.red
        puts "..................................................\n"
        puts "\nWhat TIER you are interested in:\n".bold.yellow
        puts "1. OP - TOP 10 MOST BADASS SUPERHEROES".yellow
        puts "2. LEGENDARY - SUPERHEROES RANKED 11-25".yellow
        puts "3. SUPER-DUPER - SUPERHEROES RANKED 26-50".yellow
        puts "4. INCREDIBLE - SUPERHEROES RANKED 51-100".yellow

        get_badge_and_list_SHs_in_badge
        add_attributes_or_find_by_input
        get_other_input
    end



    #create all 100 SHs with indexes, names and urls
    def create_superheroes
        file = MarvelBestSuperheroes::Scraper.get_all_names_and_pages
        MarvelBestSuperheroes::Superheroes.create_from_file(file)
    end



    #ask user to choose badge
    def get_badge_and_list_SHs_in_badge
        puts "\nPlease type in the TIER number to access:"
        input = gets.strip
        case input
            when "1"
                puts "\nHere comes TOP 10 MOST BADASS/OP SUPERHEROES\n".bold.blue
                list_all_superheroes(MarvelBestSuperheroes::Superheroes.all[0..9])
            when "2"
                puts "\nHere comes the Legendary Superheroes\n".bold.blue
                list_all_superheroes(MarvelBestSuperheroes::Superheroes.all[10..24])
            when "3"
                puts "\nHere comes the Super-duper Superheroes\n".bold.blue
                list_all_superheroes(MarvelBestSuperheroes::Superheroes.all[25..49])
            when "4"
                puts "\nHere comes the Incredible Superheroes\n".bold.blue
                list_all_superheroes(MarvelBestSuperheroes::Superheroes.all[50..100])
            else
                puts "Invalid input"
                get_badge
        end
    end



    #add attributes to new chosen SH or find already chosen SH
    def add_attributes_or_find_by_input
        puts "\nPlease type in superhero number you wish to learn more about?"
        input = gets.strip.to_i - 1 #input = i.e 1 - 1 = 0

        if input >= 0 && input < MarvelBestSuperheroes::Superheroes.all.size

            if !MarvelBestSuperheroes::Superheroes.all[input].gender #first time chosen SH doesn't have all attributes
                puts "\nPlease wait while we evoke #{MarvelBestSuperheroes::Superheroes.all[input].name}...\n"
                file = MarvelBestSuperheroes::Scraper.get_hero_infos(MarvelBestSuperheroes::Superheroes.all[input].url)
                MarvelBestSuperheroes::Superheroes.all[input].add_details_from_file(file)
                display_superhero(input)
            else
                puts "You already looked up #{MarvelBestSuperheroes::Superheroes.all[input].name}\n"
                puts "Please type Y/Yes to see him again or type N/No to see other Superhero"
                input2 = gets.strip.upcase
                if input2 == "Y" || input2 == "YES"
                    puts "Display #{MarvelBestSuperheroes::Superheroes.all[input].name} again:"
                    display_superhero(input)
                elsif input2 == "N" || input2 == "NO"
                    add_attributes_or_find_by_input
                else
                    puts "Invalid input"
                    add_attributes_or_find_by_input
                end
            end
        else
            puts "Invalid input"
            add_attributes_or_find_by_input
        end
    end


    #list only SH names who are listed in chosen BADGE/TIER
    def list_all_superheroes(heroes)
        heroes.each do |hero|
            puts "#{hero.index}. #{hero.name}"
        end
    end


    #Print out chosen Superhero's informations in desired format
    def display_superhero(input)
        hero = MarvelBestSuperheroes::Superheroes.all[input]
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


    #ask user to choose again
    def get_other_input
        puts "Do you want to learn more about other Superheroes?\n"
        puts "Type T/TIER to see Tier again or H/HERO to see other Superhero\n"
        puts "Or type 'Exit/No' to end the program\n"
        input = gets.strip.upcase
        if input == "T" || input == "TIER"
            get_badge_and_list_SHs_in_badge
            add_attributes_or_find_by_input
            get_other_input
        elsif input == "H" || input == "HERO"
            add_attributes_or_find_by_input
            get_other_input
        elsif input == "EXIT" || input == "N" || input == "NO"
            puts "\n___MAY THE FORCE BE WITH YOU!!!___\n".bold.yellow
        else
            puts "\nInvalid input"
            get_other_input
        end
    end

end
