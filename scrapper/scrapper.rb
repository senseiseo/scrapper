require 'nokogiri' 
require 'httparty'
require 'byebug'

def scraper 
    url = "https://funpay.ru/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    game_listing = parsed_page.css('div.promo-game-item') # 219 name of game 
    game_listing.each  do |game_listing|
        game = {
            title: game_listing.css('div.game-title').text ,
            link:  game_listing.css('a')[1].text,
            url:   game_listing.css('a')[0].attributes["href"].value
        }
            byebug
    end 
end
# gameCards количесвто титлов div.game-title, gamePromo промо всего div.game-title-item



scraper