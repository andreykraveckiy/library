require './library.rb'

hello_string = %{
+-----------------------------------+
|    h - help                       |
|    ac - create author             |
|    as - show authors              |
|    bc - create book               |
|    bs - show books                |
|    rc - create reader             |
|    rs - show readers              |
|    oc - create order              |
|    os - show orders               |
|-----------------------------------|
|    lw - sawe library to files     |
|    eo - extra orders              |
|    br - the best reader           |
|    pb - the most popuar book      |
|    3mp - the 3 most popuar books  |
|    q - EXIT                       |
+-----------------------------------+
  }

$lib = Library.new

def create_author
  params = []
  puts 'Write author\'s full name:'
  params << $stdin.gets.chomp
  puts 'Write author\'s biography:'
  params << $stdin.gets.chomp
  $lib.new_author(params)
end

def create_book
  params = []
  puts 'Write book\'s title:'
  params << $stdin.gets.chomp
  puts 'Write author\'s full name:'
  params << $stdin.gets.chomp
  $lib.new_book(params)
end

def create_reader
  params = []
  puts 'Write user\'s full name:'
  params << $stdin.gets.chomp
  puts 'Write reader email:'
  params << $stdin.gets.chomp
  puts 'Enter reader\'s city:'
  params << $stdin.gets.chomp
  puts 'Enter reader\'s street:'
  params << $stdin.gets.chomp
  puts 'Enter reader\'s house:'
  params << $stdin.gets.chomp
  $lib.new_reader(params)
end

def create_order
  params = []
  puts 'Write book\'s title:'
  params << $stdin.gets.chomp
  puts 'Write user\'s full name:'
  params << $stdin.gets.chomp
  params << Time.now
  $lib.new_order(params)
end

puts hello_string
$lib.load
while true
  case p = $stdin.gets.chomp
  when 'q'
    break
  when 'h'
    puts hello_string
  when 'ac'
    create_author
  when 'as'
    puts $lib.authors
  when 'bc'
    create_book
  when 'bs'
    puts $lib.books
  when 'rc'
    create_reader
  when 'rs'
    puts $lib.readers
  when 'oc'
    create_order
  when 'os'
    puts $lib.orders
  when 'lw'
    puts $lib.save
  when 'eo'
    $lib.fake_orders
  when 'br'
    puts $lib.best_reader
  when 'pb'
    puts $lib.popular_book
  when '3mp'
    puts $lib.the_3_most_popular
  else
    puts "I can't work with command #{p}"
  end    
end
  