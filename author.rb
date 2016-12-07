class Author
  attr_reader :name
  def initialize(params)
    @name, @biography = params
  end

  def to_s
    "#{@name};#{@biography};"
  end
end
