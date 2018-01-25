print "Enter a number of minutes to convert to Hours/Minutes: " # clarify user input - why are they entering minutes? :)
input = gets.chomp

input_minutes = input.to_i            # or, more efficient and Ruby-like is just 'gets.chomp.to_i' 
hours = input_minutes / 60        # do you need floor ? 
minutes = input_minutes - n_hours * 60  # variable names - what does the n stand for? maybe use just 'hours' and 'minutes' - more clear

puts "That is #{hours} hours and #{minutes} minutes"

=begin
SAMPLE OUTPUT
---------------------
Enter a number of minutes: 245

That is 4 hours and 5 minutes
=end

=begin
CHANGELOG

** 2018.01.25 8:50 AM UPDATE**

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

3. UI Changes
  - Changed Input Prompt to "Enter a number of minutes to convert to Hours/Minutes: "
  

=end