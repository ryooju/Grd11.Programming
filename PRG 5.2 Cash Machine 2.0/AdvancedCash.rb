# Random code from online
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class Integer
  def numeric?
    return true
  end
end

# ----- VAR -----
$balance_shilling = 30000
$balance_dollar = 300

# ---- METHOD ----

def cls
  system "clear" or system "cls"
end

def check_balance(currency)
  case currency.downcase
    when "d"
      return $balance_dollar
    when "k"
      return $balance_shilling
  end
end

def get_syntax(currency)
  return "$" if currency == "d"
  return "KES" if currency == "k"
  return nil  
end

def get_syntax_balance(currency)
  balance = check_balance(currency)
  return get_syntax(currency) + " " + balance.to_s
end

def set_balance(currency, amount)
  unless amount.numeric?
    puts "Amount Need to be in numbers"
    return false
  end
  case currency.downcase
    when "d"
      $balance_dollar = amount
    when "k"
      $balance_shilling = amount
  end
end

def withdraw_cash(currency, amount)
  unless amount.numeric?
    puts "Amount Need to be in numbers"
    return false
  end
  balance = check_balance(currency)
  if balance >= amount
    balance -= amount
    set_balance(currency, balance)
    cls
    puts "\nWithdraw Completed. Withdrawed: #{get_syntax(currency) + " " + amount.to_s} Current Balance #{get_syntax_balance(currency)}"
  else
      not_enough_balance(currency)
  end
end

def deposit_cash(currency, amount)
  unless amount.numeric?
    puts "Amount Need to be in numbers"
    return false
  end
  
  amount = amount.to_i
  
  balance = check_balance(currency)
  balance += amount
  set_balance(currency, balance)
  cls
  
  puts "\nDeposit Completed. Current Balance #{get_syntax_balance(currency)}"
end
  
def not_enough_balance(currency)
  cls
  puts "Not Enough Balance. Your Balance: #{get_syntax_balance(currency)}"
end

def withdraw_screen(currency)
  multi = 0
  multi = 10 if currency == "d"
  multi = 1000 if currency == "k"
  
  aval_options = {
        a: 1,
        b: 2,
        c: 3,
        d: 4,
        f: 5,
        g: 10,
        h: 15,
        i: 20
        }
  puts "\n-- Choose Amount to Withdraw --"
  prefix = ""
  prefix = get_syntax(currency) + " "
  
  puts "\n(a) #{prefix + (aval_options[:a] * multi).to_s}  |  (f) #{prefix + (aval_options[:f] * multi).to_s}"
  puts "(b) #{prefix + (aval_options[:b] * multi).to_s}  |  (g) #{prefix + (aval_options[:g] * multi).to_s}"
  puts "(c) #{prefix + (aval_options[:c] * multi).to_s}  |  (h) #{prefix + (aval_options[:h] * multi).to_s}"
  puts "(d) #{prefix + (aval_options[:d] * multi).to_s}  |  (i) #{prefix + (aval_options[:i] * multi).to_s}"
  puts "(OR) Type amount in multiples of $ 10" if currency == "d"
  puts "(OR) Type amount in multiples of KSH 1000" if currency == "k"
  input = gets.chomp.downcase
  exit if input == "e"
  
  if input.include? "$"
    input = input.tr('$', '')
  end
  
  if input.include? "ksh"
    input = input.tr('ksh', '')
  end
  
  if multi == 0
    puts "\nERROR: Unknown Issue"
    return false
  end
  
  if input.numeric?
    input = input.to_i
    
    if input <= 0
      cls
      puts "\nWARNING: Number should be postive number."
      return false
    end
    
    unless input % multi == 0
      cls
      puts "\nWARNING: Number should be multiple of KSH 1000 or $ 10"
      return false
    end
    
    withdraw_cash(currency, input)
    #irb test    
    
  else
    if aval_options[input.to_sym] != nil
      withdraw_cash(currency, aval_options[input.to_sym] * multi)
      
    else
      puts "\nWARNING: INVALID OPTION : PLEASE TRY AGAIN FROM BEGINNING."
    end
  end
end


# ----- CUI -----
curr = ""
input = ""

while 1
  puts "\n\nChoose your currency: ((d)ollars  |or|  (k)enyan shilling)"
  puts "You can always Exit by typing 'e'\n"
  curr = gets.chomp.downcase
  
  exit if curr == "e"
  
  if ["d", "k"].include? curr
    puts "\n(W)ithdraw  ||  (D)eposit  ||  (C)heck Balance"
    input = gets.chomp.downcase
    exit if input == "e"
    if input == "c"
      cls
      puts "Your balance is #{get_syntax_balance(curr)}"
    elsif input == "d"
      puts "\nEnter the amount to deposit"
      deposit_cash(curr, gets.chomp)
    elsif input == "w"
      withdraw_screen(curr)
      
    else
      puts "\WARNING: Invalid Operation"
    end
    
  else
    puts "\nWARNING: Invalid Currency"
  end
end
