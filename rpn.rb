def rpn(array) 
  stack = []
  
  array.each do |unit|
    if [:+, :-, :*, :/].include?(unit.intern)
      calculate(unit.intern, stack)
    else
      stack << unit.to_i
    end
  end
  
  puts stack.first
end


# def calculate(symbol, stack)
#   case symbol
#   when :+
#     stack << (stack.pop + stack.pop)
#   when :-
#     stack << (stack.pop * - 1 + stack.pop)
#   when :*
#     stack << (stack.pop * stack.pop)
#   when :/
#     stack << (1 / stack.pop * stack.pop)
#   end
# end

def calculate(symbol, stack)
  second = stack.pop
  first = stack.pop
  stack << first.send(symbol, second)
end

if __FILE__ == $PROGRAM_NAME
   array = File.read(ARGV.first).split
   rpn(array)
end


  