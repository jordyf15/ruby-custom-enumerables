module Enumerable
  def my_each
    self.size.times do |index|
      yield self[index]
    end
  end
  def my_each_with_index
    self.size.times do |index|
      yield self[index],index
    end
  end
end

# puts "my_each vs each"
# numbers = [1,2,3,4,5]
# numbers.my_each {|item| p item}
# numbers.each {|item| p item}

puts "my_each_with_index vs each_with_index"
numbers = [1,2,3,4,5]
numbers.my_each_with_index {|value, index| p "#{index}: #{value}"}
numbers.each_with_index {|value,index| p "#{index}: #{value}"}
