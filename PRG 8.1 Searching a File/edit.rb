#  == REQUIRE ==
require 'nokogiri'

#  ==  FUNCTION  ==
def strip_html(str)
  #https://gist.github.com/awesome/225181
  str.gsub(/<\/?[^>]*>/, "")
end

#  == VARIBLES ==
$file_loc = "./Ruby (programming language) - Wikipedia.html"
$body = nil

#  == FUNCTIONS ==
def start
  #  == START UP ==
  file = File.open($file_loc, "r")
  doc = Nokogiri::HTML.parse(file)

  # Remove Any Comment
  # https://stackoverflow.com/questions/7879352/remove-comments-from-inner-html
  
  
  #https://stackoverflow.com/questions/19861338/remove-a-tag-but-keep-the-text?
  
  doc.xpath('//comment()').remove

  # Remove Botom Junk
  doc.xpath("//div[contains(@class, 'navbox')]").remove

  #Strip all html tags
  # body = doc.at("div.mw-parser-output").to_html
  if $body.nil?
    if doc.at("div.mw-parser-output").nil?
      $body = File.read(file)
    else
      $body = strip_html(doc.at("div.mw-parser-output").to_html)
    end
  end
  
  file.close
end

def search (s_term, s_strict)
  body = $body
  
  s_contain = body.include? s_term
  
  result = []
  puts "\nDoes master string contains the Search Term? #{s_contain}"
  
  if s_contain
    body.split.each do |word| 
      if word == s_term
        result << word
      elsif (!s_strict && (word.include? s_term))
        result << word
      end
    end
  end
  return result
end

def replace (s_term, s_strict, s_replace)
  body = $body
  
  s_contain = body.include? s_term

  if s_contain
    unless s_replace.nil?
      if s_strict
        body.gsub! /\b(#{ s_term })\b/, s_replace
      else 
        body.gsub! s_term, s_replace
      end
      return body
    end
  end
end

def save (text)
  file = File.open($file_loc, "w")
  file.puts(text)
  file.close
end

def cls
  system "clear" or system "cls"
end

##  Potential CUI
while 1
  start

  body = $body

  input = []

  ## CUI Ask

  puts "\nWhat do you want to do?"
  puts "f - find occurances  |  r - replace occurance  |  e - exit"
  input << gets.chomp  # input 0
  
  exit if input[0] == "e"

  puts "\nDo you want to find exact wrap text match? (y/n)"
  input << (gets.chomp.downcase == "y" ? true : false) # input 1

  puts "\nWhat is your search term?"
  input << gets.chomp # input 2

  if input[0] == "r"
    puts "\nWhat do you want to replace with?"
    input << gets.chomp # input 3
    body = replace(input[2], input[1], input[3])
    puts body
    puts "\n\nWould you like to save your replaces? (y/n)"
    puts "Warning: It removes all HTML tags."
    save(body) if gets.chomp.downcase == "y"
  elsif input[0] == "f"
    cls
    puts "\nResult: Found #{search(input[2], input[1]).length} entrances"
  end
end