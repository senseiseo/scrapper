require 'nokogiri' 
require 'httparty'
require 'byebug'

def scraper 
    url = "https://funpay.ru/"                                       #  Ссылка на сайт для парсинга   
    unparsed_page = HTTParty.get(url)                                # с парсинг ссылки через гем HTTParty 
    parsed_page = Nokogiri::HTML(unparsed_page.body)                 # парс данных через накогири 
    games = Array.new                                                # cоздаем пустой массив для записи в нее данных после парсинга
    game_listing = parsed_page.css('div.promo-game-item')            # фильтрация данных по заголовкам

    page = 1 
    per_page = game_listing.count  #196
    total = parsed_page.css('div.social-statistic-info')[0].text           # nil
    total = total.split(' ')[0].to_i * 1000 + total.split(' ')[1].to_i
    last_page = (total.to_f / per_page.to_f).round                   #Находит последнюю страницу сайта если это возможно


    game_listing.each  do |game_listing|                             # перебор и сортировка данных

        link = game_listing.css('a').text                            # пробегаем по строке и если заглавная добавляем к ней ! потом сплит через ! не идаельный вариант 
             str_new = ''
            link.each_char {|c| 
                if /[A-Z, А-Я]/.match(c)
                  c = c.replace '!' + c
                end
                 str_new = str_new + c
            }
            link = str_new.split('!')
            link.delete_at(0)
        game = {
            title: game_listing.css('div.game-title')[0].text ,
            link:  link ,    # не работает сплит  правильно , надо чинить 
            url:   game_listing.css('a')[0].attributes["href"].value
        }
            games << game 
    end 
    byebug
end
# gameCards количесвто титлов div.game-title, gamePromo промо всего div.game-title-item



scraper  