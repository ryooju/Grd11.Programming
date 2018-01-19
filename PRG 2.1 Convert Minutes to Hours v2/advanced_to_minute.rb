# Random code from online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

print "Enter a number of minutes: "
input = gets.chomp
error_code = 0

if input.numeric?
  minutes = Integer(input)
  if minutes >= 0

    n_hours = (minutes/60).floor
    n_minutes = minutes - n_hours * 60

    puts "That is #{n_hours} hour#{"s" if n_hours >1} and #{n_minutes} minute#{"s" if n_minutes >1}"
  else
    error_code = 2
  end

else 
  error_code = 1
end

if error_code == 0
  puts "Success"

else
	case error_code
	when 1
		puts "Err 1. Your input is not a number"
	when 2
		puts "Err 2. Your input is not greater or equal than one"
	else
		puts "UnKnown Error. Code: #{error_code}. Please contact developer"	 #This should never trigger
    end
end

=begin
Error Code

1 - is not number
2 - < 0



SAMPLE OUTPUT
--------------------

Alans-Mac:2 Control Flow alan$ ruby minutes_to_hours_2.rb 
Enter a number of minutes: -5
Sorry, you have to enter more than 0 minutes

Alans-Mac:2 Control Flow alan$ ruby minutes_to_hours_2.rb 
Enter a number of minutes: sure thing
Sorry, you have to enter a number and it must be bigger than 0

Alans-Mac:2 Control Flow alan$ ruby minutes_to_hours_2.rb 
Enter a number of minutes: 245
That is 4 hours and 5 minutes
=end