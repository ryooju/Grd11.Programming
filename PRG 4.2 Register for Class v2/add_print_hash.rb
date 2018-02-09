=begin
P
---------------
| CLASS ROSTER
---------------

First Name	Last Name	Grade Level

Bob	Vazquez	12	
Lupe	Brown	11	
Cynthia	Jimenez	12	
=end

# Random code from online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# Another Randomcode from Online
require 'io/console'
def wait_key
  print "\nPress any button to continue"  
  STDIN.getch              
  print "            \r" # extra space to overwrite in case next sentence is short    
end   

students = []
FIELD_SIZE = 20

# Dummy Inputs. When testing uncommit below
students = [
  {
      "first_name" => "Bob",
      "last_name" => "Builder",
      "grade_level" => 4
      },
  {
      "first_name" => "Test",
      "last_name" => "Buida",
      "grade_level" => 3
      },
  {
      "first_name" => "Senior",
      "last_name" => "June",
      "grade_level" => 5
      },
  {
      "first_name" => "John",
      "last_name" => "Smith",
      "grade_level" => 2
      },
  {
      "first_name" => "Me",
      "last_name" => "Developer",
      "grade_level" => 11
      }]

puts "-----------------------------"
  puts "|"
  puts "| STUDENT REGISTRATION"
  puts "|"
  puts "-----------------------------"

while true
  puts ""
  puts "-----------------------------"
  puts "(A)dd, (P)rint, (L)ookup or (Q)uit"
  puts "-----------------------------"
  print "  > "
  input = gets.chomp.strip
  
  if input.downcase == "a"
    puts "\n   Enter a student's First name"
    print "    > "
    first_name = gets.chomp

    puts "\n   Enter the student's Last name"
    print "    > "
    last_name = gets.chomp

    puts "\n   What grade are they in?"
    print "    > "
    grade_level = gets.chomp
    
    # Empty String Error Checking
    while first_name == ""
      puts "\n   ** ERROR ** Text is empty."
      puts "\n   Enter a student's First name"
      print "    > "
      first_name = gets.chomp
    end
    while last_name == ""
      puts "\n   ** ERROR ** Text is empty."
      puts "\n   Enter the student's Last name"
      print "    > "
      last_name = gets.chomp
    end
    while grade_level == ""
      puts "\n   ** ERROR ** Text is empty."
      puts "\n   What grade are they in?"
      print "    > "
      grade_level = gets.chomp
    end
	while !grade_level.numeric?
	  puts "\n   ** ERROR ** Grade Level must be in number"
      puts "\n   What grade are they in?"
      print "    > "
      grade_level = gets.chomp
	end

    # Add Entry to Data
    students << {
      "first_name" => first_name,
      "last_name" => last_name,
      "grade_level" => grade_level
      }
    
    puts "\n!! SYSTEM : #{first_name} Added !!"
  
  elsif input.downcase == "p"
    puts "\n--------------- \n" +
          "| CLASS ROSTER \n" +
          "--------------- \n"  # Felt lazy to add them individual put
    
    # Yet Another Random Code from online
    roster =
      students.map do |s|
        s.values.map do |f|
          f.to_s.ljust(FIELD_SIZE) # 1 row
        end.join('   ')            # join columns with spaces
      end.join($/)                 # join rows with OS-dependent CR/LF
    titles =
      ['First Name', 'Last Name', 'Grade Level'].map do |t|
        t.to_s.ljust(FIELD_SIZE)
      end.join(' | ')              # join with bars
	
    puts titles, roster
    
  elsif input.downcase == "l"
    results = []
    
    puts ""
    puts "-----------------------------"
    puts "What would you like it to search?"
    puts "(F)irst Name, (L)ast Name or (G)rade level"
    puts "-----------------------------"
    print "  > "
    argument = gets.chomp.downcase.strip
    
    if argument == "f"
      first_name = ""
      while first_name == ""
        puts "\n   Enter a student's First name"
        print "    > "
        first_name = gets.chomp
        if first_name == ""
          puts "** ERROR First Name is REQUIRED"
        end
      end
      
      students.each do |student|
        if student["first_name"].downcase.include? first_name.downcase
          results << student
        end
      end
    elsif argument == "l"
      last_name = ""
      while last_name == ""
        puts "\n   Enter a student's Last name"
        print "    > "
        last_name = gets.chomp
        if last_name == ""
          puts "** ERROR Last Name is REQUIRED"
        end
      end
      
      students.each do |student|
        if student["last_name"].downcase.include? last_name.downcase
          results << student
        end
      end
    elsif argument == "g"
      grade_level = ""
      while grade_level == "" || !grade_level.numeric?
        puts "\n   Enter a student's Grade"
        print "    > "
        grade_level = gets.chomp
        if grade_level == "" || !grade_level.numeric?
          puts "** ERROR GradeLevel is EMPTY or NOT A NUMBER"
        end
      end
      
      students.each do |student|
        if student["grade_level"].downcase.include == grade_level
          results << student
        end
      end
    else
      puts "Unknown Input : (F)irst Name, (L)ast Name or (G)rade level"
    end
    
    if results.empty?
      puts "\nWARNING: NO RESULT FOUND"
    else
      puts "\n--------------- \n" +
          "| Search Result \n" +
          "--------------- \n"  # Felt lazy to add them individual put
      
      # Yet Another Random Code from online
      roster =
        results.map do |s|
          s.values.map do |f|
            f.to_s.ljust(FIELD_SIZE) # 1 row
          end.join('   ')            # join columns with spaces
        end.join($/)                 # join rows with OS-dependent CR/LF
      titles =
        ['First Name', 'Last Name', 'Grade Level'].map do |t|
          t.to_s.ljust(FIELD_SIZE)
        end.join(' | ')              # join with bars

      puts titles, roster
    end
    
  elsif input.downcase == "q"
    exit
  else
    puts "Unknown Input : (A)dd, (P)rint, (L)ookup or (Q)uit"
  end
  wait_key
  system "clear" or system "cls"
end