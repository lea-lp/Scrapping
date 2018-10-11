
require 'nokogiri'
require 'open-uri'

html_data = open('http://annuaire-des-mairies.com/val-d-oise.html').read
nokogiri_object = Nokogiri::HTML(html_data)
my_elements = nokogiri_object.xpath("/html/body/table/tbody/tr[2]/td/table/tbody/tr/td[4]")

array = []

my_elements.each do |my_element|
  array << my_elements.text
end

puts array


# /html/body/table/tbody/tr[2]/td/table/tbody/tr/td[6]
