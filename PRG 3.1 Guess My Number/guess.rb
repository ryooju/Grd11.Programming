=begin
SAMPLE OUTPUT
---------------------------

I'm thinking of a number between 1 and 10
What is your guess?
> 7
Sorry, that's wrong. Next guess?
> 10
Sorry, that's wrong. Next guess?
> -4
Please enter a number between 1 and 10
> 8
Sorry, that's wrong. Next guess?
> 6

Correct! My number was 6
=end

# Random code from online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# -------------------

random = Random.rand(9) + 1

puts "I'm thinking of a number between 1 and 10."

while true
  puts "What is your guess?"
  print " >  "
  input = gets.chomp
  
  if(input.numeric?)
    input = input.to_i
    if input == random
      puts "Correct! My number was #{random}"
      break
    end
    puts "Sorry, that's wrong. Next guess?"
  else
    puts "Invalid Number. No Text Please."
  end
end