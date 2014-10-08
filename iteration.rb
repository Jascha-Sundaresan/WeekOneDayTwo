def found?(number)
  number > 250 && number % 7 == 0
end

number = 0
number +=1 until found?(number)
puts number

def factors(number)
  result = [1]
  (2..number).each do |possible_factor| 
    if number % possible_factor == 0
      result << possible_factor
    end
  end
  result
end

def bubble_sort!(array)
  sorted = false
  until sorted
    sorted = true
    (0...array.length - 1).each do |idx|
      if array[idx] > array[idx + 1]
        sorted = false
        array[idx], array[idx + 1] = array[idx + 1], array[idx]
      end
    end
  end
  array
end

def substrings(string)
  results = []
  
  (0...string.length).each do |x|
    (x...string.length).each do |y|
      results << string[x..y] unless results.include?(string[x..y])
    end
  end
     
  results 
end

def subwords(string)
  english_words = File.readlines('dictionary.txt').map(&:chomp)
  
  english_words & substrings(string)
end

p subwords('cat')
