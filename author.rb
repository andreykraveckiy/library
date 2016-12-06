class Author
  def initialize(name, biography)
    @name = name
    @biography = biography
    puts 'Author is created'
  end

  def to_s
    "#{@name};#{@biography};"
  end
end
