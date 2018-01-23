# Random code from online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# -------------------

balance = 500

puts "Your balance $#{balance}"
puts "How much do you want to withdraw?"
input = gets.chomp

if input.include? "$"
    input = input.tr('$', '')
  end

if input.numeric?
    input = input.to_i  

  if input < 0
    puts "Sorry, you can't withdraw a negative number"
    exit 
  end

  puts "Please take your cash ..."
  puts "Please take your card ..."

  if input <= balance
    puts "Your new balance: $#{balance - input}"
  else
    puts "Sorry, you have insufficient funds to withdraw that amount"
  end
  
else
  puts "Your input is not a text"
end