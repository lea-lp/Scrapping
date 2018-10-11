

  require 'nokogiri'
  require 'open-uri'

  def get_the_email_of_a_townhal_from_its_webpage (url)
      page = open(url).read
      nokogiri_object = Nokogiri::HTML(page)
      e_mail_mairie = nokogiri_object.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
      return e_mail_mairie.text
  end
   # get_the_email_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/bethemont-la-foret.html")

  def get_the_name_of_a_townhal_from_its_webpage (url)
      page = open(url).read
      nokogiri_object = Nokogiri::HTML(page)
      name_mairie = nokogiri_object.xpath("/html/body/div/main/section[1]/div/div/div/h1")
      return name_mairie.text
  end
  # puts get_the_name_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/vaureal.html")


  def get_all_the_urls_of_val_doise_townhalls (url)
      web_links = Nokogiri::HTML(open(url).read)
      web_object = web_links.css("a")
      array = []
      web_object.each do |link|
        array << link["href"]
      end
      tab = array.grep(/.*95/)
      tab.map do |i|
          i[0]= "" + "http://annuaire-des-mairies.com"
      end
      return tab
  end
  # puts get_all_the_urls_of_val_doise_townhalls ("http://annuaire-des-mairies.com/val-d-oise.html")

  def perform
      tabmail = []
      tabname = []

      get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html").each do |url_town|
          tabmail << get_the_email_of_a_townhal_from_its_webpage(url_town)
      end
      # return  tabmail

      get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html").each do |url_town|
          tabname << get_the_name_of_a_townhal_from_its_webpage(url_town)
      end
      # return tabname

      puts my_hash = Hash[tabname.zip(tabmail)]

  end
    perform
