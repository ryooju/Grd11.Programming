print "Enter a number of minutes: "
input = gets.chomp

minutes = Integer(input)
n_hours = (minutes/60).floor
n_minutes = minutes - n_hours * 60

puts "That is #{n_hours} hours and #{n_minutes} minutes"

=begin
SAMPLE OUTPUT
---------------------
Enter a number of minutes: 245

That is 4 hours and 5 minutes
=end