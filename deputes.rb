# /// PAR SOUCI DE RAPIDITE, JE NE MONTRE QUE LES 20 PREMIERS DEPUTES
# POSSIBILITE DE VERIFIER EN ENLEVANT LES INDEXS


require 'nokogiri'
require 'open-uri'

#DECLARATION DE LA METHODE = SEARCH NAME
def get_name(url)
  page = open(url).read
  nokogiri_object = Nokogiri::HTML(page)
  name_depute = nokogiri_object.css("span.list_nom")
  array = name_depute.to_a
  array.map! {|name| name.text.strip} #enleve les espaces avant & apres string
  return array[0..20] #ne montre que les 20 premiers elements
end

#DECLARATION DE LA METHODE = SEARCH MAIL
def get_mail(get_url)
  page = open(get_url).read
  nokogiri_object = Nokogiri::HTML(page)
  mail_depute = nokogiri_object.xpath("//*[@id='b1']/ul[2]/li[1]/ul/li[1]/a")
  return mail_depute.text
end

#DECLARATION DE LA METHODE = SEARCH URL
def get_url
  nokogiri_object = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
  web_object = nokogiri_object.xpath('//tr/td/a') #.xpath = cherche plus precisement
  array = []
  web_object.each {|link| array << link["href"]}
  # ajoute le reste de l'url contenant les noms à l'url de base
  array.map! {|url| url = "https://www.nosdeputes.fr" + url}
  return array
end

#DECLARATION DE LA METHODE = PERFORM
def perform
  mails = []
  #ne montre que les 20 premiers elements
  get_url[0..20].each {|url| mails << get_mail(url)}
  #supprime les doublons
  the_mails = mails.uniq
  names = get_name("https://www.nosdeputes.fr/deputes")
  #creation du hash
  my_hash = Hash[names.zip(the_mails)]

  #pour voir le résultat sous forme de hash
  # puts my_hash

  #presentation plus claire
  my_hash.each {|key, value| puts "L'email du député #{key} est '#{value}'", "\n"}
end

perform
