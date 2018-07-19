
class MarvelBestSuperheroes::Scraper

    #this method is to scrape all Superheroes (SH) indexes, names and urls
    def self.get_all_names_and_pages
        collection = []
        hero_info = {}
        doc = Nokogiri::HTML(open("https://comicvine.gamespot.com/profile/noahmaximillion/lists/top-100-marvel-superheroes/48749/"))
        doc.css("ul.editorial").css("li").each do |hero|
            hero_info = {
                :index => hero.css("h3").text.split(". ")[0].to_i,
                :name => hero.css("h3").text.split(". ")[1],
                :url =>  "#{"https://comicvine.gamespot.com"}#{hero.css("a").attribute("href").value}"
            }
            #hero_info = {index:..., name:..., url:...}
            collection << hero_info
        end
        collection
        #collection = [{index:..., name:..., url:...}, {index:..., name:..., url:...}]
    end


    #scrape other attributes : bio, realname, aliases, powers...
    def self.get_hero_infos(site)

        doc = Nokogiri::HTML(open(site)).css("table.table tbody")

        superhero_infos = {}

        superhero_infos = {
            :biography => Nokogiri::HTML(open(site)).css("h3.display-view").text,
            :supername => doc.css("div[data-field='realName']").text.strip.split(/\n/).first,
            :aliases => doc.css("div[data-field='aliases']").text.gsub("\r","").strip.split("\n").map{|i| "\n                      #{i}"}.join,
            :realname => doc.css("div[data-field='realName']").text.strip.split(/\n/).last.strip,
            :gender => doc.css("div[data-field='gender']").text.strip,
            :charactertype => doc.css("div[data-field='origin']").text.strip,
            :birthday => doc.css("div[data-field='birthday']").text.strip,
            :powers => doc.css("div[data-field='powers']").text
        }

        superhero_infos
    end

end
