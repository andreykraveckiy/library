require './author'
require './book'
require './reader'
require './order'

class Library
  REQUIRED_COLLECTIONS = %w(Author Book Reader Order)
  attr_reader :authors, :books, :readers, :orders
  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
    puts 'Use :load method for load library from file.'
  end

  def load
    REQUIRED_COLLECTIONS.each do |name|
      load_from_file(name)
    end
  end

  def save
    REQUIRED_COLLECTIONS.each do |name|
      save_to_file(name)
    end
  end

# for interface
  def new_author(params)
    new_class_instance("Author", @authors, params)
  end

  def new_book(params)
    unless @authors.map(&:name).index(params.last)
      puts "Library does not have the author #{params.last}"
      return
    end
    new_class_instance("Book", @books, params)
  end

  def new_reader(params)
    new_class_instance("Reader", @readers, params)
  end

  def new_order(params)
    unless @books.map(&:title).index(params.first)
      puts "Library does not have the book #{params.first}"
      return
    end
    unless @readers.map(&:name).index(params[1])
      puts "#{params[1]} wasn't registered at this library"
      return
    end
    new_class_instance("Order", params)
  end  

  def best_reader(counter = nil)
    popular_in_order_by(:reader, counter)
  end

  def popular_book(counter = nil)
    popular_in_order_by(:book, counter)
  end

  def the_3_most_popular
    books = popular_book(3)
    @orders.select { |e| books.include?(e.book) }.map(&:reader).uniq.count
  end

  private

    def load_from_file(class_name)
      begin
        file = File.open(to_file_name(class_name), 'r')
        file.each_line { |line| new_class_instance(class_name, line.split(';')) }
        file.close
      rescue Exception => e
        puts e.message
      end
    end

    def popular_in_order_by(field, counter = nil)
      grouped_by = @orders.group_by { |e| e.send(field) }
      sort_fields = grouped_by.keys.sort { |x,y| grouped_by[y].count <=> grouped_by[x].count }
      return sort_fields.first(counter) if counter
      sort_fields.select { |e| grouped_by[e].count == grouped_by[sort_fields.first].count }
    end

    def to_file_name(name)
      name.downcase + '.txt'
    end

    def to_collection(name)
      instance_variable_get("@#{name.downcase + 's'}")
    end

    def save_to_file(class_name)
      begin          
        return if to_collection(class_name).empty?
        file = File.open(to_file_name(class_name), 'w')  
        to_collection(class_name).each { |obj| file.puts obj }
        file.close
      rescue Exception => e
        puts e.message
      end
    end

    def new_class_instance(class_name, params)
      to_collection(class_name) << Kernel.const_get(class_name).new(params)
    end 
end
