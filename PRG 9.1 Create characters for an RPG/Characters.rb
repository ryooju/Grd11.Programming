class String
  def numeric?
    Float(self) != nil rescue false
  end
end

## Classes
class Character
  @@all_characters = Array.new
  
  def initialize(name)
    # Default
    @damage = 1
    @hp = 1
    @max_hp = 1
    
    # Setter
    @name = name
    @@all_characters << self
  end
  
  def attack
    puts "Attacked with #{@damage} damage."
  end
  
  def health
    puts "#{@name} health is #{@hp}/#{@max_hp}"
  end
  
  def name
    return @name
  end
end

class Warrior < Character
  
  def initialize(name)
    super name
    @damage = 75
    @hp = 200
    @max_hp = 200
  end
  
  def attack
    puts "#{@name} attacked with his sword!"
    super
  end
end

class Archer < Character
  def initialize(name)
    super name
    @damage = 60
    @hp = 125
    @max_hp = 125
  end
  
  def attack
    puts "#{@name} shot enemies with his bow!"
    super
  end
end

class Magician < Character
  def initialize(name)
    super name
    @damage = 80
    @hp = 75
    @max_hp = 75
  end
  
  def attack
    puts "#{@name} used his wand to cast the spell!"
    super
  end
end

party = [Warrior.new("Bob"), Warrior.new("John"), Warrior.new("Jeff"), Archer.new("Rabbit"), Magician.new("Herry")]

# CUI
while 1
  puts "   === CURRENT ROSCARS ====   "
  no = 1
  party.each do |member|
    puts "    #{no}. #{member.name} (#{member.class})"
    no = no + 1
  end

  puts "\nChoose a hero (# 1-5)\nHit 'e' to exit"
  print "> "
  input = gets.chomp
  exit if input == 'e'
  if input.numeric?
    input = input.to_i - 1
    if input < party.length && input >= 0
      choice = party[input]
      puts "Your hero: #{choice.name}"
      puts "\nWhat do you want to do with your hero? (C)heck health, (A)ttack"
      option = gets.chomp.downcase
      if option == "c"
        puts
        choice.health
      elsif option == "a"
        puts
        choice.attack
      else
        puts
        puts "Error: Incorrect Option"
      end
    else
      puts "\nIncorrect Argument"
    end
  else
    puts "\nError: Number must be numeric."
  end
  puts "\n"
end


