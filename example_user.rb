class User
  attr_accessor :name, :email 
  # creates getter and setter
  # allows us to get and set @name @email (instance variables)
  
  def initialize(attributes = {}) # this gets executed when we create User.new
    @name = attributes[:name]
    @email = attributes[:email]
  end
  
  def formatted_email
    "#{@name} <#{@email}>"
  end
end