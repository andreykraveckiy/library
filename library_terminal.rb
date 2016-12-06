require './library.rb'

hello_string = %{
+-----------------------------------+
|    h - help                       |
|    ac - create author             |
|    as - show authors              |
|    b - create book                |
|    r - create reader              |
|    o - mark which reader take book|
|    q - EXIT                       |
+-----------------------------------+
  }

$lib = Library.new

def create_author
  puts 'Write author\'s full name:'
  name = $stdin.gets.chomp
  puts 'Write author\'s biography:'
  biography = $stdin.gets.chomp
  $lib.author({name: name, biography: biography})
end

puts hello_string
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
  when 'b'
    puts "You press #{p}"
  when 'r'
    puts "You press #{p}"
  when 'o'
    puts "You press #{p}"
  else
    puts "I can't work with command #{p}"
  end    
end


  