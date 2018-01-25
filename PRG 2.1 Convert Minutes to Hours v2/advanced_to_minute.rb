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
  input_minutes = input.to_i
  if input_minutes >= 0

    hours = input_minutes / 60
    minutes = input_minutes - hours * 60

    puts "That is #{hours} hour#{"s" if hours > 1} and #{minutes} minute#{"s" if minutes > 1}"
  else
    error_code = 2
  end

else 
  error_code = 1
end

if error_code != 0
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

=begin
CHANGELOG

** 2018.01.25 8:56 AM UPDATE**

1. Variable Name Changes
  - n_hours --> hours
  - n_minutes --> minutes
  Removed 'n_' which standed for 'new'

  - minutes --> input_minute
  Changed variable name to make it not conflict with new changed
  variable.

2. Logic Changes
  - Removed floor since Integer devide by Integer will always
    result in Integer, no decimal.
  - Changed Integer() function to .to_i function.
  - Remove Debug Purpose Error code = 0 Success Message

3. UI Changes
  - Changed Input Prompt to "Enter a number of minutes to convert to Hours/Minutes: "
  

=end