# Requires
require 'colorize'
require 'io/console' 
# gem install colorize

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

## Classes
class Character
  @@all_characters = Array.new
  
  ### Local Functions  
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
    return @hp
  end
  
  def name
    return @name
  end
  
  def get_damage
    return @damage
  end
  
  def alive
    return @@all_characters.include? self
  end
  
  def damage_entity(damager)
    if alive
      damager.attack
      if @hp > damager.get_damage
        @hp = @hp - damager.get_damage
      else
        @hp = 0
      end
    end
    if @hp <= 0
      puts "[System] #@name is dead.".light_red
      @@all_characters.delete(self)
      # If dead, make them "went"
      if $party.include? self #If player
        $tbs_logic[self] = 1
      end
    end
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

### Arrays (Dependent on Classes)
$party = [ Warrior.new("Bob"), Warrior.new("John"), Warrior.new("Jeff"), Archer.new("Rabbit"), Magician.new("Herry") ]
$villain = [ Warrior.new("Nathan"), Archer.new("Gabriel"), Archer.new("Ethan"), Magician.new("Oliver"), Magician.new("Allen") ]

#for i in 0..50
#   $villain << Character.new(i.to_s)
#end

## TBS Logic Hashs
$tbs_logic = Hash.new(99) # default error

# Functions

def cls
  system "clear" or system "cls"
end
cls

def press_a_key
  print "Press Any Key"
  STDIN.getch
  print "            \r" # extra space to overwrite in case next sentence is short
end

def display_roscars(choose)
  arg = ["", []]
  arg = ["CURRENT", $party] if choose == "p"
  arg = ["COMPUTER", $villain] if choose == "c"
  
  puts "   === #{arg[0]} ROSCARS ===   ".light_cyan
  no = 1
  arg[1].each do |member|
    output = "    #{no}. #{member.name} (#{member.class})  "
    if !member.alive
      print output.light_red
    elsif $tbs_logic[member] % 2 != 0
      print output.cyan
    else
      print output
    end
    
    output = "HP: #{member.health}"
    if member.health < 60
      puts output.light_yellow
    else
      puts output
    end    
    no = no + 1
  end
end

def tbs_checker
  # Check if Players are done
  done_player = $tbs_logic.select{|key, status| status == 1}
  
  # Check If Game is Over
  if $villain.select{|char| char.alive == true}.length == 0
    puts "Win -- Player Won"
    exit
  end
  
  
  #If player is done
  if (done_player.length == $party.length)
    ai_turn
    puts "\n\n====== Turn is OVER ======"
    puts "Resetting Round\n\n"
    $party.each do |char|
      $tbs_logic[char] = 0 if char.alive
    end
    press_a_key
  end    
end

def ai_turn
  $villain.each do |computer|
    
    # Attack what player?
    while 1
      rand = Random.rand(0...$party.length)
      if $party[rand].alive
        puts "\n#{computer.name} decided to attack #{$party[rand].name}"
        if computer.alive
        $party[rand].damage_entity(computer)
        else
          puts "However, #{computer.name} can't attack."
        end
        break
      end
    end
    
    #If All Player are dead
    if $party.select{|char| char.alive == true}.length == 0
      puts "GameOver - All Characters are Dead"
      exit
    end
    sleep(2)
  end
  press_a_key
  cls
end

# TBS Setup

## Add Party (Player)    # 0 - not gone  || 1 - gone
$party.each do |member|
  $tbs_logic[member] = 0
end

## Add villain (Computer)    # 2 - not gone  || 3 - gone
$villain.each do |computer|
  $tbs_logic[computer] = 2
end

# CUI
while 1
  display_roscars('p')
  display_roscars('c')
  puts("🐇 TIP: Cyan means Turn is over  ||  Yellow means Low Health ")
  puts("🐇 TIP: Red means Character is dead")

  puts "\nChoose a hero (# 1-5)\nHit 'e' to exit"
  print "> "
  input = STDIN.getch
  exit if input == 'e'
  if input.numeric?
    input = input.to_i - 1
    if input < $party.length && input >= 0
      choice = $party[input]
      puts "Your hero: #{choice.name}"
      puts "\nWhat do you want to do with your hero? (C)heck health, (A)ttack"
      option = STDIN.getch.downcase
      if option == "c"
        puts
        choice.health
      elsif option == "a"
        cls
        if $tbs_logic[choice] % 2 == 0 && choice.alive # Check if character can atack       
          puts "Who do you want to attck?"
          display_roscars('c')
          input_attack = STDIN.getch
          if input_attack.numeric?
            input_attack = input_attack.to_i - 1
            if input_attack < $villain.length && input_attack >= 0
              choice_attack = $villain[input_attack]
              puts "Your attacked hero: #{choice_attack.name}"
              choice_attack.damage_entity(choice)

              $tbs_logic[choice] = 1 if $party.include? choice
              $tbs_logic[choice] = 3 if $villain.include? choice
            end
          else
            puts "\nError: Number must be numeric."
          end
        else
          puts "Your character is unable to attack."
        end
      else
        puts
        puts "Error: Incorrect Option"
      end
      tbs_checker
      press_a_key #break code
      cls
    else
      puts "\nIncorrect Argument"
    end
  else
    puts "\nError: Number must be numeric."
  end
  puts "\n"
end


