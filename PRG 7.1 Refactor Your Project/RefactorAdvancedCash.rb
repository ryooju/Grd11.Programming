# Originally "PRG 5.2 Cash Mchine 2.0 Assignment
#
# THIS IS NOT YET REFACTORED: REFERENCE ORIGINAL CODE
#
# You can check original 5.2 code below
# https://github.com/ryooju/Grd11.Programming/tree/master/PRG%205.2%20Cash%20Machine%202.0

# ---- CLASS DEF ----
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
$currency = {
  k: {
    name: "Kenyan Shilling",
    balance: 30000,
    symbol: "KES",
    multi: 1000
    },
  u: {
    name: "US Dollars",
    balance: 300,
    symbol: "$",
    multi: 10
    },
  s: {
    name: "South Korea Won",
    balance: 100000,
    symbol: "₩",
    multi: 10000
    },
  r: {
    name: "Euro",
    balance: 10000,
    symbol: "E",
    multi: 10
    }
  }

# ---- METHOD ----
def cls
  system "clear" or system "cls"
end

def currency_checker(currency)
  return true unless $currency[currency.to_sym] == nil
  puts "FATAL ERROR: UNKNOWN CURRENCY"
  false
end

def check_balance(currency)
  $currency[currency.to_sym][:balance]
end

def get_syntax(currency)
  $currency[currency.to_sym][:symbol] 
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
  
  # Check if currency exist:
  return false unless currency_checker(currency)
  
  $currency[currency.to_sym][:balance] = amount
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
  
  unless amount > 0
    cls
    puts "WARNING: AMOUNT NEED TO BE GREATER THAN 0"
    return false
  end
  
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
  multi = $currency[currency.to_sym][:multi] if currency_checker(currency) # Check if currency exist
  
  aval_options = {
        a: 1,
        b: 2,
        c: 3,
        d: 4,
        f: 5,
        g: 10,
        h: 15,
        i: 20,
        j: 30
        }
  
  puts "\n-- Choose Amount to Withdraw --"
  prefix = ""
  prefix = get_syntax(currency) + " "
  
  half_length = (aval_options.length.to_f/2).ceil
  
  half_length.times do |i|
    print "\n" if i == 0
    key = aval_options.keys[i]
    print "(#{key}) #{prefix + (aval_options[key] * multi).to_s}"
    key = aval_options.keys[i+half_length]
    print "  |  (#{key}) #{prefix + (aval_options[key] * multi).to_s}" unless key.nil?
    puts ""
  end

  
  puts "(OR) Type amount in multiples of #{prefix} #{multi} (Without Currency Symbols)"
  
  input = gets.chomp.downcase
  exit if input == "e"
  
=begin
  if input.include? "$"
    input = input.tr('$', '')
  end
  
  if input.include? "ksh"
    input = input.tr('ksh', '')
  end
    
=end
  
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
      puts "\nWARNING: Number should be multiple of #{get_syntax(currency) + multi.to_s}"
      return false
    end
    
    withdraw_cash(currency, input)
  else
    if aval_options[input.to_sym] != nil
      withdraw_cash(currency, aval_options[input.to_sym] * multi)   
    else
      puts "\nWARNING: INVALID OPTION : PLEASE TRY AGAIN FROM BEGINNING."
    end
  end
end

def listoptions
  puts "Choose your currency: "
  
  $currency.each do |c, v|
    occ = v[:name].downcase.index(c.to_s)
    if occ.nil?
      puts "\n\n-- FATAL ERROR --"
      puts "Currency Index is NOT Found"
      puts "Ask Administrator to revise the currency"
      puts "'#{c}' is not found in '#{v[:name].downcase}'"
      puts "-- FATAL ERROR : EXITING --\n\n"
      exit
    end
    print v[:name].clone.insert(occ,"(").insert(occ + 2, ")")
    print " | or | " unless $currency.keys.last == c
  end
  print "\n"
end

# ----- CUI -----
curr = ""
input = ""

while 1
  puts "\n\n"
  listoptions
  puts "You can always Exit by typing 'e'\n"
  curr = gets.chomp.downcase
  
  exit if curr == "e"
  
  if $currency.keys.include? curr.to_sym
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
