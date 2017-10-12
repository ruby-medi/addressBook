require "./contact"

class AddressBook
  attr_reader :contact
  
  def initialize
    @contact = []
  end
  
  def print_contact_list
    puts "Contact list"
    
    contact.each do |item|
      puts item.to_s("last_first")
    end
  end
end

address_book= AddressBook.new

hao= Contact.new
hao.first_name = "Hao"
hao.last_name= "Zheng"
hao.add_phone_number("home", "514-444-444")
hao.add_phone_number("work", "514-555-444")
hao.add_address("Home", "123 Main St.", "", "Montreal", "Qc.", "H1H 1H1")

address_book.contact.push(hao)
address_book.print_contact_list