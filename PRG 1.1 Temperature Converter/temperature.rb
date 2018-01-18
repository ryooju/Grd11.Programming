print "What is the temperature in Fahrenheit you wish to convert? "
input = gets.chomp

temp_in_fahrenheit = Integer(input)
temp_in_celsius = (temp_in_fahrenheit - 32) / 1.8
temp_in_kelvin = temp_in_celsius + 273.15

puts "Fahrenheit temp: #{temp_in_fahrenheit.round(2)}"
puts "Kelvin temp: #{temp_in_kelvin.round(2)}"
puts "Celsius temp: #{temp_in_celsius.round(2)}"

=begin
Fahrenheit temp: 32
Kelvin temp: -273.15
Celsius temp: 0.0
=end