require 'nokogiri'
require 'open-uri'

#Voici les 594 députés de la 15ème législature (576 en cours de mandat).

def get_name(url)
  page = open(url).read
  nokogiri_object = Nokogiri::HTML(page)
  name_depute = nokogiri_object.css("span.list_nom")
  array = name_depute.to_a
  array.map! {|name| name.text.strip}
  return array[0..4]
end
#puts get_name(""https://www.nosdeputes.fr/deputes"")

def get_mail(get_url)
  page = open(get_url).read
  nokogiri_object = Nokogiri::HTML(page)
  mail_depute = nokogiri_object.xpath("//*[@id='b1']/ul[2]/li[1]/ul/li[1]/a")
  return mail_depute.text
end
#puts get_mail("https://www.nosdeputes.fr/damien-abad")


def get_url
    nokogiri_object = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
    # puts web_object = nokogiri_object.xpath('//div[@class="list_table"]/table/tbody')
    web_object = nokogiri_object.xpath('//tr/td/a')
    array = []
    web_object.each do |link|
      array << link["href"]
    end
    array.map! do |url|
      url = "https://www.nosdeputes.fr" + url
    end
    return array

end

def perform
  mails = []
  get_url[0..4].each do |url|
   mails << get_mail(url)
 end
 the_mails = mails.uniq
 names = get_name("https://www.nosdeputes.fr/deputes")

 my_hash = Hash[names.zip(the_mails)]

 puts my_hash

end

perform
