require 'nokogiri'
require 'open-uri'

def get_name(page)
    web_object = page.css("a.currency-name-container.link-secondary")
    name_coin = []
    web_object.each { |link| name_coin << link.text }
    return name_coin
end


def get_price(page)
    web_object = page.css("a.price")
    price_coin = []
    web_object.each { |link| price_coin << link["data-usd"] }
    return price_coin
end

def perform

  while (true)

    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/").read)

    name = get_name(page)
    price = get_price(page)

    my_coin_hash = Hash[name.zip(price)]

    my_coin_hash.each do |key, value|
      puts "Le cours du #{key} est de $#{value}"
    end

    sleep(3600)

  end

end

perform
