require "./phone_number"
require "./address"
class Contact
  
  attr_writer :first_name, :middle_name, :last_name
  attr_reader :phone_numbers, :addresses
  
  def initialize
    @phone_numbers = []
    @addresses= []
  end
  
  def add_phone_number(kind, number)
    phone_number= PhoneNumber.new
    phone_number.kind=kind
    phone_number.number=number
    phone_numbers.push(phone_number)
  end
  
  def add_address(kind, street_1, street_2, city, state, postal_code)
    address = Address.new
    
    address.kind=kind
    address.street_1=street_1
    address.street_2=street_2
    address.city=city
    address.state=state
    address.postal_code=postal_code
    addresses.push(address)
   
  end
  
  def first_name
    @first_name
  end
  
  def middle_name
    @middle_name
  end
  
  def last_name
    @last_name
  end
  
  def first_last
    first_name + " " + last_name
  end
  
  def last_first
    last_first = last_name
    last_first += ", "
    last_first += first_name
    
    if !@middle_name.nil?
      last_first += " "
      last_first += middle_name.slice(0,1)
      last_first += "."
    end
   return last_first
  end
  
  def full_name
    full_name= first_name
    if !@middle_name.nil?
      full_name += " "
      full_name += middle_name
    end
      full_name += " "
      full_name += last_name
      
    return full_name
   end
  
  def to_s(format= "full_name")
    case format
      when "full_name"
        full_name
      when 'last_first'
      last_first
      when "first"
      first_name
      when "last"
        last_name
      else
        first_last
    end
  end
  
  def print_phone_numbers
    puts "phone numbers"
    phone_numbers.each {|item| puts item}
  end
  
  def print_addresses
     puts "address"
     addresses.each do |item|
       puts item.to_s("short")
     end
  end
end

=begin
hao= Contact.new
hao.first_name = "Hao"
hao.last_name= "Zheng"
hao.add_phone_number("home", "514-444-444")
hao.add_phone_number("work", "514-555-444")
hao.add_address("Home", "123 Main St.", "", "Montreal", "Qc.", "H1H 1H1")
puts hao.to_s("full_name")
hao.print_phone_numbers
hao.print_addresses
=end