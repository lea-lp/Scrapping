require 'nokogiri'
require 'open-uri'

#Voici les 594 députés de la 15ème législature (576 en cours de mandat).

def get_name(url)
  page = open(url).read
  nokogiri_object = Nokogiri::HTML(page)
  name_depute = nokogiri_object.css("span.list_nom")
  array = name_depute.to_a
  array.map! {|name| name.text.strip}
  return array
end
#puts get_name(""https://www.nosdeputes.fr/deputes"")

def get_mail(url)
  page = open(url).read
  nokogiri_object = Nokogiri::HTML(page)
  mail_depute = nokogiri_object.xpath("//*[@id='b1']/ul[2]/li[1]/ul/li[1]/a")
  return mail_depute.text
end
#puts get_mail("https://www.nosdeputes.fr/damien-abad")


def get_url(url)
    page = open(url).read
    nokogiri_object = Nokogiri::HTML(page)
    web_object = nokogiri_object.css("a")
    array = []
    web_object.each do |link|
      array << link["href"]
    end
    array.map do |i|
      "https://www.nosdeputes.fr/deputes" + i
      array.delete(/deputes#[A-Z]/)
    end
    return array
end
puts get_url("https://www.nosdeputes.fr/deputes")
