# Random code from online
# Check value if it is a "Float"
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# Another Randomcode from Online
# https://stackoverflow.com/questions/34594018/how-to-code-press-key-to-continue
require 'io/console'
def wait_key
  print "\nPress any button to continue"  
  STDIN.getch              
  print "            \r" # extra space to overwrite in case next sentence is short    
end

# Global Variables
$firstname = Hash.new()
$lastname = Hash.new()
$address = Hash.new()
$city = Hash.new()
$state_district = Hash.new()
$postalcode = Hash.new()

FIELD_SIZE = 15

# Functions

def cls
  system "clear" or system "cls"
end

def dummy
  # Dummy Inputs. When testing uncommit below
  
  dummy = [
      {
        firstname: "John",
        lastname: "Smith",
        address: "#####",
        city: "City1",
        state_district: "Workd",
        postalcode: "15432"

      },
      {
        firstname: "Bob",
        lastname: "Builder",
        address: "#####",
        city: "City2",
        state_district: "World",
        postalcode: "12345"
      },
      {
        firstname: "Devy",
        lastname: "Devevloper",
        address: "####",
        city: "City3",
        state_district: "Mars",
        postalcode: "00569"
      }
    ]
  return dummy
end

def data_to_array(*option_ids)
  # For table_display. Combine different hashes with id data to
  # format I used to code with table_display.
  
  # FIELD_SIZE = 20
  array = Array.new
  $firstname.each do |id, fname|
    if(option_ids.any? && !(option_ids[0].include? id))
      next
    end
    array << [fname.clone.prepend(id.to_s + ". "), $lastname[id], $address[id], $city[id], $state_district[id], $postalcode[id]]
  end
  return array
end

def table_display(array)
  # headings = ['option1', 'option2', 'option3]
  # Yet Another Random Code from online
  # Originally from 4.2 Assignment
  # https://stackoverflow.com/questions/48678790/output-hash-in-a-table-like-format
  roster =
    array.map do |s|
      s.map do |f|
        f.to_s.ljust(FIELD_SIZE) # 1 row
      end.join('   ')            # join columns with spaces
    end.join($/)                 # join rows with OS-dependent CR/LF
  
  titles =
    ["\n   FIRSTNAME", "LASTNME", "ADDRESS", "CITY", "STATE", "POSTALCODE"].map do |t|
      t.to_s.ljust(FIELD_SIZE)
    end.join(' | ')              # join with bars

  puts titles + "\n"
  105.times {print '-'}
  puts "\n" + roster
end

def add(fname, lname, address, city, state_district, postalcode)
  id = $firstname.length
  
  while ($firstname[id] != nil || $lastname[id] != nil || $address[id] != nil  || 
    $city[id] != nil || $state_district[id] != nil || $postalcode[id] != nil ) 
    id += 1    
  end
  
  $firstname[id] = fname.capitalize 
  $lastname[id] = lname.capitalize 
  $address[id] = address.capitalize 
  $city[id] = city.capitalize 
  $state_district[id] = state_district.capitalize 
  $postalcode[id] = postalcode
  
  puts "\nAdded New User #{id}"
  puts "Name: #{$firstname[id]} #{$lastname[id]}"
  puts "Address: #{$address[id]}, #{$city[id]}, #{$state_district[id]}"
  puts "Postal Code: #{$postalcode[id]}"
  puts ""
end

dummy.each {|entry|
  add(entry[:firstname], entry[:lastname], entry[:address], entry[:city], entry[:state_district], entry[:postalcode])
  }

# CUI

cls

puts "-----------------------------"
puts "|"
puts "| Address Book"
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
    
    option_data = {
        # Incase future code reviewer is wondering
        # ["Future User Input", "User Guide String"]
        :f => ["", "First Name"],
        :l => ["", "Last Name"],
        :a => ["", "Address"],
        :c => ["", "City"],
        :s => ["", "State"],
        :p => ["", "Postal Code"]
        }
    
    option_data.each do |key, value|
      puts "\n   Enter the #{value[1]}"
      print "    > "
      value[0] = gets.chomp
      while value[0] == ""
        puts "\n   ** ERROR ** Text is empty."
        puts "\n   Enter the #{value[1]}"
        print "    > "
        value[0] = gets.chomp
      end
    end
    add(option_data[:f][0], option_data[:l][0], option_data[:a][0], option_data[:c][0], option_data[:s][0], option_data[:p][0])
  elsif input.downcase == "p"
    puts "\n--------------- \n" +
          "| Address Book \n" +
          "--------------- \n"  # Felt lazy to add them individual put
    
    table_display(data_to_array) 
    
  elsif input.downcase == "l"
    results = []
    
    option_data = {
        :f => [$firstname, "First Name"],
        :l => [$lastname, "Last Name"],
        :a => [$address, "Address"],
        :c => [$city, "City"],
        :s => [$state_district, "State"],
        :p => [$postalcode, "Postal Code"]
        }
    
    puts ""
    puts "-----------------------------"
    puts "What would you like it to search?"
    puts "(F)irst Name, (L)ast Name, (A)ddress, (C)ity or (S)tates"
    puts "-----------------------------"
    print "  > "
    argument = gets.chomp.downcase.strip
    if option_data.keys.include? argument.to_sym
      option_name = option_data[argument.to_sym][1]
      option_hash = option_data[argument.to_sym][0]
      
      input = ""
      results = []
      while input == ""
        puts "\n   Enter #{option_name}"
        print "    > "
        input = gets.chomp
        if input == ""
          puts "** ERROR #{option_name} is REQUIRED"
        end
      end
      option_hash.each do |id, value|
        if value.downcase.include? input.downcase
          results << id
        end
      end
    else
      puts "Unknown Input : (F)irst Name, (L)ast Name, (A)ddress, (C)ity or (S)tates"
    end
    
    if results.empty?
      puts "\nWARNING: NO RESULT FOUND"
    else
      puts "\n--------------- \n" +
          "| Search Result \n" +
          "--------------- \n"  # Felt lazy to add them individual put
      table_display(data_to_array(results))
    end
    
  elsif input.downcase == "q"
    exit
  else
    puts "Unknown Input : (A)dd, (P)rint, (L)ookup or (Q)uit"
  end
  wait_key
  cls
end