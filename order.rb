class Order
  attr_reader :book, :reader
  def initialize(params)
    @book, @reader, @date = params
  end

  def to_s
    "#{@book};#{@reader};#{@date};"
  end
end
