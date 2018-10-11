
  require 'nokogiri'
  require 'open-uri'

#DECLARATION DE LA METHODE = SEARCH EMAIL
  def get_the_email_of_a_townhal_from_its_webpage (url)
      page = open(url).read
      nokogiri_object = Nokogiri::HTML(page)
      e_mail_mairie = nokogiri_object.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
      return e_mail_mairie.text
  end

#DECLARATION DE LA METHODE = SEARCH NAME
  def get_the_name_of_a_townhal_from_its_webpage (url)
      page = open(url).read
      nokogiri_object = Nokogiri::HTML(page)
      name_mairie = nokogiri_object.xpath("/html/body/div/main/section[1]/div/div/div/h1")
      return name_mairie.text
  end

#DECLARATION DE LA METHODE = SEARCH URL
  def get_all_the_urls_of_val_doise_townhalls (url)
      web_links = Nokogiri::HTML(open(url).read)
      web_object = web_links.css("a")
      array = []
      web_object.each {|link| array << link["href"]}
      #grep : isole les elements contenant ces caracteres
      tab = array.grep(/.*95/)
      #construction du nouvel url :
      tab.map {|i| i[0]= "" + "http://annuaire-des-mairies.com"}
      return tab
  end

#DECLARATION DE LA METHODE = PERFORM
  def perform

      tabmail = [] #creation d'array pour le hash
      tabname = [] # //

      # insertion d'elements dans l'array [tabmail]
      get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html").each do |url_town|
          tabmail << get_the_email_of_a_townhal_from_its_webpage(url_town)
      end

      # insertion d'elements dans l'array [tabname]
      get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html").each do |url_town|
          tabname << get_the_name_of_a_townhal_from_its_webpage(url_town)
      end

      #creation du hash
      puts my_hash = Hash[tabname.zip(tabmail)]

  end
    perform
