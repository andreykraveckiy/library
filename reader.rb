class Reader
  attr_reader :name
  def initialize (params)
    @name, @email, @city, @street, @house = params
  end

  def to_s
    "#{@name};#{@email};#{@city};#{@street};#{@house};"
  end
end
