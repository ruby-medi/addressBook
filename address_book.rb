require "./contact"
require "yaml"

class AddressBook
  attr_reader :contact
  
  def initialize
    @contact = []
    open()
  end
  
  def open
    if File.exist?("contact.yml")
     @contact = YAML.load_file("contact.yml")
    end
  end
  
  def save
    File.open("contact.yml", "w") do |file|
      file.write(contact.to_yaml)
    end
  end
  
  def run
    loop do
      puts "Address Book"
      puts "a: Add contact"
      puts "p: Print Address book"
      puts "s: Search"
      puts "e:exit"
      print " enter your choice: "
      input=gets.chomp.downcase
      print "\n"
      
      case input
        when "a"
          add_contact
        when "p"
          print_contact_list
        when "s"
          print "Search term: "
            search= gets.chomp
            find_by_name(search)
            find_by_phone_number(search)
            find_by_address(search)
            print "\n"
        when "e"
          save()
        break
        
        print "\n"
      end
      
    end
  end
  
  def print_results(search, results)
    puts search
    
     results.each do |item|
        puts item.to_s("full_name")
        item.print_phone_numbers
        item.print_addresses
        puts "\n"
     end 
  end
  
  def add_contact
    contacts = Contact.new
    print "First name: "
    contacts.first_name= gets.chomp
    print "Middle name: "
    contacts.middle_name= gets.chomp
    print "Last name: "
    contacts.last_name= gets.chomp
    
    loop do
      puts "Add phone number or address?"
      puts "p: Add phone number"
      puts "a: Add address"
      puts "(Any other key to go back)"
      response = gets.chomp.downcase
      
      case response
        when "p"
          phone= PhoneNumber.new
          print "Phone number kind (Home , Work ,etc):"
          phone.kind= gets.chomp
          print "Number: "
          phone.number = gets.chomp
          contacts.phone_numbers.push(phone)
        when "a"
          address = Address.new
          print "Address Kind (Home, Work, etc): "
          address.kind = gets.chomp
          print "Address line 1: "
          address.street_1 = gets.chomp
          print "Address line 2: "
          address.street_2 = gets.chomp
          print "City: "
          address.city = gets.chomp
          print "State: "
          address.state = gets.chomp
          print "Postal Code: "
          address.postal_code = gets.chomp
          contacts.addresses.push(address)
        else
        print "\n"
         break
      end
    end
    
    contact.push(contacts)
    
    
  end
    
    
  def find_by_name(name)
    results = []
    search = name.downcase
    
    contact.each do |item|
      if item.full_name.downcase.include?(search)
        results.push(item)
      end
     print_results("name search results (#{search})", results)
    end
  end
  
  def find_by_phone_number(number)
    results=[]
    search=number.gsub("-","")
    contact.each do |item|
      item.phone_numbers.each do |element|
        if element.number.gsub("-","").include?(search)
          results.push(item) unless results.include?(contact) 
        end
      end
    end
    print_results("phone search results (#{search})",results)
  end
  
  def find_by_address(query)
    results =[]
    search= query.downcase
    
    contact.each do |contact|
      contact.addresses.each do |address|
        if address.to_s("long").downcase.include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end  
    end
    print_results("Address search results (#{search})", results)
    
    
   
  end
  
  def print_contact_list
    puts "Contact list"
    
    contact.each do |item|
      puts item.to_s("last_first")
    end
  end
end

address_book= AddressBook.new
address_book.run
=begin
hao= Contact.new
hao.first_name = "Hao"
hao.last_name= "Zheng"
hao.add_phone_number("home", "514-444-444")
hao.add_phone_number("work", "514-555-444")
hao.add_address("Home", "123 Main St.", "", "Montreal", "Qc.", "H1H 1H1")

address_book.contact.push(hao)
#address_book.print_contact_list
  
#address_book.find_by_name("h")
#address_book.find_by_phone_number("514-444-444")
address_book.find_by_address("main")
=end