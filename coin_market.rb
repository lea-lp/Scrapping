require 'nokogiri'
require 'open-uri'

#DECLARATION DE LA METHODE = SEARCH NAME
def get_name(page)
    web_object = page.css("a.currency-name-container.link-secondary")
    name_coin = [] #stocke les donnees dans nouvel array
    web_object.each { |link| name_coin << link.text }
    return name_coin
end

#DECLARATION DE LA METHODE = SEARCH PRICE
def get_price(page)
    web_object = page.css("a.price")
    price_coin = [] #stocke les donnees dans nouvel array
    web_object.each { |link| price_coin << link["data-usd"] }
    return price_coin
end

#DECLARATION DE LA METHODE = PERFORM
def perform

  while (true) #boucle infinie pour la fonction -sleep-

    #lien general
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/").read)

    name = get_name(page)
    price = get_price(page)

    my_coin_hash = Hash[name.zip(price)]

    #pour voir le résultat sous forme de hash
    # puts my_coin_hash

    #presentation plus claire
    my_coin_hash.each {|key, value| puts "Le cours du #{key} est de $#{value}", "\n"}



    sleep(3600) #relance la boucle toutes les heures

  end

end

perform
