class Book
  attr_reader :title
  def initialize(params)
    @title, @author = params
  end

  def to_s
    "#{@title};#{@author};"
  end
end
