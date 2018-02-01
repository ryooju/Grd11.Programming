=begin
SAMPLE OUTPUT
---------------------

---------------------------------------
first_name: Darth
last_name: Vader
address: Core HQ #133
city: Near Core Reactor
country: Death Star
postal_code: 07493-1235
---------------------------------------  
=end

output = {
  "first_name" => "Darth",
  "last_name" => "Vader",
  "address" => "Core HQ #133",
  "city" => "Near Core Reactor",
  "country" => "Death Star",
  "postal_code" => "07493-1235"
  }

output.each {|key, value| puts "#{key}: #{value}"}