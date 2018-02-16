=begin
Build a simple calculator that has methods for addition, subtraction, multiplication and division. The user should be able to specify two numbers, an operation, and then the calculator should do the work. 

Extra challenge: what other functions could your calculator have? How could you adapt your calculator to handle more than two numbers?
=end

# Random Code from online
class String
  def initial
    self[0,1]
  end
end

# Random Code II from Online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def addition (*number)
  result = 0
  number.each{|n|
    result += n
    }
  return result
end

def subtraction (*number)
  result = 0
  number.each{|n|
    result -= n
    }
  return result
end

def multiplication (*number)
  result = 1
  number.each{|n|
    result *= n
    }
  return result
end

def division (*number)
  result = 0 # Default value. It will ge updated
  i = 0
  number.each{|n|
    i = i + 1
    if i == 1
      result = n.to_f
    else
      result /= n
    end
    }
  return result
end

def get_numbers (input, operation)
  input.gsub!(operation, "")
  arguments = input.split(" ")
  total = []
  arguments.each do |args|
    unless args.numeric?
      puts "[ERROR] One of your number is not a integer"
      break
    end
    total << args.to_f
  end
  return total
end

$totalvalue = 0

# Overload - (input) or (operation, input)
## Used Semi Overload for future expendability.
def input_process (*args)
  if(args.size == 1)
    input = args[0]
    operation = input.initial
  elsif(args.size == 2)
    input = args[1]
    operation = input[0]
  else
    return
  end
  
  total = get_numbers(input, operation)

  if operation == "+"
    $totalvalue += addition(*total)
  elsif operation == "-"
    $totalvalue += subtraction(*total)
  elsif operation == "*"
    $totalvalue = multiplication($totalvalue, *total)
  elsif operation == "/"
    $totalvalue = division($totalvalue, *total)
  end
  total.clear
end

## CUI

puts "The Awesome Calculator"

while true
  puts "\nTotal Value: #{$totalvalue}"
  puts "\nWhat operation would you like to do?"
  puts " (+ Add | - Subtract | * Multiply | / Divide | (e)xit | (c)lear)"
  puts "(eg.) '+ 5' to add 5 to previous number."
  print "\n  > "
  
  input = gets.chomp.downcase
  
  if input == "e"
    exit
  end
  
  if ['+', '-', '*', '/'].include? input.initial
    input_process(input)
      
  elsif input.initial == "c"
    puts "Clear"
    $totalvalue = 0
  
  else
    puts "ERROR: Not a valid function."
  end
end