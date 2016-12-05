class Reader
  def initialize (name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def to_s
    "#{@name};#{@email};#{@city};#{@street};#{@house};"
  end
end
