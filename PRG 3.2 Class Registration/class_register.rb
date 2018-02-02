class_list = []

puts "-------------"
puts "|"
puts "| STUDENT REGISTRATION"
puts "|"
puts "-------------"

while true
  print "Do you wish to (a)dd a student, (p)print the roster or (e)exit: "
  input = gets.chomp
  
  if input.downcase == "a"
    puts "Enter a student name"
    print " >  "
    input_name = gets.chomp
    unless input_name == ""
      class_list << input_name
    else
      puts "No Text Detected"
    end
    
  elsif input.downcase == "p"
    puts "-------------"
    puts "|"
    puts "| CLASS ROSTER"
    puts "|"
    puts "-------------"
    
    class_list.sort.each do |name|
      puts name
    end
    puts "Total Students: #{class_list.length}"
  elsif input.downcase == "e"
    exit
  else
    puts "Error. Unknown argument. Please use 'a' - add,   'p' - print,   or   'e' - exit"
  end
end
