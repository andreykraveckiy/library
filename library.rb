require './author'
require './book'
require './reader'
require './order'

class Library
  attr_reader :authors, :books, :readers, :orders
  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
    puts 'Use :load method for load library from file.'
  end

  def load
    load_from_file('Author', @authors, 'author.txt')
    load_from_file('Book', @books, 'book.txt')
    load_from_file('Reader', @readers, 'reader.txt')
    load_from_file('Order', @orders, 'order.txt')
  end

  def save
    save_to_file(@authors, 'author.txt')
    save_to_file(@books, 'book.txt')
    save_to_file(@readers, 'reader.txt')
    save_to_file(@orders, 'order.txt')
  end

# for interface
  def new_author(params)
    new_class_instance("Author", @authors, params)
  end

  def new_book(params)
    if !@authors.map(&:name).index(params.last)
      puts "Library does not have the author #{params.last}"
      return
    end
    new_class_instance("Book", @books, params)
  end

  def new_reader(params)
    new_class_instance("Reader", @readers, params)
  end

  def new_order(params)
    if !@books.map(&:title).index(params.first)
      puts "Library does not have the book #{params.first}"
      return
    end
    if !@readers.map(&:name).index(params[1])
      puts "#{params[1]} wasn't registered at this library"
      return
    end
    new_class_instance("Order", @orders, params)
  end  

  def best_reader
    readers = @orders.map(&:reader)
    uniq = readers.uniq
    good_name = uniq.first
    uniq.each do |name|
      good_name = name if readers.count(good_name) < readers.count(name)
    end
    answer = [good_name]
    uniq.each do |name|
      answer << name if readers.count(good_name) == readers.count(name) && good_name != name
    end
    answer
  end

  def popular_book
    books = @orders.map(&:book)
    uniq = books.uniq
    good_title = uniq.first
    uniq.each do |title|
      good_title = title if books.count(good_title) < books.count(title)
    end
    answer = [good_title]
    uniq.each do |title|
      answer << title if books.count(good_title) == books.count(title) && good_title != title
    end
    answer
  end

  def the_3_most_popular
    books = @orders.map(&:book)
    uniq = books.uniq
    uniq.sort! { |x,y| books.count(y)<=>books.count(x) }
    "#{uniq.first}-#{books.count(uniq.first)}; #{uniq[1]}-#{books.count(uniq[1])}; #{uniq[3]}-#{books.count(uniq[2])}"
  end

  private

    def load_from_file(class_name, collection, file_name)
      begin
        file = File.open(file_name, 'r')
        file.each_line { |line| new_class_instance(class_name, collection, line.split(';')) }
        file.close
      rescue Exception => e
        puts e.message
      end
    end

    def save_to_file(collection, file_name)
      begin          
        return if collection.empty?
        file = File.open(file_name, 'w')  
        collection.each { |obj| file.puts obj }
        file.close
      rescue Exception => e
        puts e.message
      end
    end

    def new_class_instance(class_name, collection, params)
      collection << Kernel.const_get(class_name).new(params)
    end 
end
