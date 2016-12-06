require './author'
require './book'
require './reader'
require './order'

class Library
  attr_reader :authors, :books
  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
    puts 'Use :load method for load library from file.'
  end

  def load
    begin
      file = File.open('author.txt', 'r+')
      file.each_line do |line|
        authors << Author.new(line.split(';'))
      end
    rescue Error => e
      puts e.message
    ensure
      file.close
    end
  end

  def save
    begin
      file = File.open('author.txt', 'w')
      @authors.each do |author|
        file.puts author
      end
    rescue Error => e
      puts e.message
    ensure
      file.close
    end
  end

  def author(options={})
    @authors << Author.new(options[:name], options[:biography])
  end

  #def work_with_file
  # 
  #end
end
