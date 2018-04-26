# Imports
require 'json'

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
$accounts = Hash.new
$account_pins = Hash.new

$file_loc = "./data.json"

$balance_dollar = 0
$balance_shilling = 0

# ---- METHOD ----

def load_file
  if $accounts.empty?
    json = File.read($file_loc)
    obj = JSON.parse(json)
    $accounts = obj
  end
end

def save_file
  unless $accounts.empty?
    File.write($file_loc, JSON.pretty_generate($accounts))
  end
end

def setup_data
  $account_pins = Hash.new # Clear Existing Hash
    $accounts.each do |account|
      $account_pins[account[1]["pin"]] = account[0].to_s
    end
end

def cls
  system "clear" or system "cls"
end
cls

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
  
  unless amount > 0
    puts "WARNING: Amount Need to be postive number"
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

def get_new_account_number
  random = 100000000 + Random.rand(100000000)
  # Check if account number is unique
  if $accounts[random.to_s].nil?
    return random.to_s
  else
    return get_new_account_number
  end
end

# ----- CUI -----
while 1
  cls
  load_file
  setup_data

  curr = ""
  input = ""

  puts "\n\nEnter your account pin."
  puts "If you are a new user, hit (c)reate, hit (e)xit"
  userpin = gets.chomp
  
  exit if userpin == 'e'

  if userpin == 'c'
    account_number = get_new_account_number
    data = Hash.new
    puts " == Create New Account =="
    puts "Your A/C: #{account_number}"
    while 1
      print "Your Pin: "
      userpin = gets.chomp
      break if (userpin.length == 4) && userpin.numeric? && (!$account_pins.key? (userpin)) # Check if number is 4 digit, is numeric, and it is unique pin (For Testing Reasons)
      puts "Pin should be 4 digit numeric."
    end
    data["pin"] = userpin
    print "Your Name: "
    data["name"] = gets.chomp
    data["balance"] = Hash.new
    data["balance"]["d"] = 0
    data["balance"]["k"] = 0
    $accounts[account_number] = data
    save_file
    setup_data
  end

  puts $account_pins[userpin]

  next if $account_pins[userpin].nil?

  account_number = $account_pins[userpin]
  $balance_dollar = $accounts[account_number]["balance"]["d"]
  $balance_shilling = $accounts[account_number]["balance"]["k"]

  cls
  while 1
    puts "\n\n"
    puts "    WELCOME  TO  JUNGSUB'S  TRUST  BANK    "
    puts "    YOUR NAME:      #{$accounts[account_number]["name"]}"
    puts "    ACCOUNT NUMBER: #{account_number}"
    puts "\n\nChoose your currency: ((d)ollars  |or|  (k)enyan shilling)"
    puts "You can always Exit by typing 'e'\n"
    curr = gets.chomp.downcase

    break if curr == "e"
    if curr == "del"
      $accounts.delete(account_number)
      save_file
      break
    end

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

    # Prepair to save_file
    $accounts[account_number]["balance"]["d"] = $balance_dollar
    $accounts[account_number]["balance"]["k"] = $balance_shilling
    save_file
  end
end
