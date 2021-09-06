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
  def my_select
    selected_result = []
    self.size.times do |index|
      selected_result << self[index] if yield self[index]
    end
    selected_result
  end
end

# puts "my_each vs each"
# numbers = [1,2,3,4,5]
# numbers.my_each {|item| p item}
# numbers.each {|item| p item}

# puts "my_each_with_index vs each_with_index"
# numbers = [1,2,3,4,5]
# numbers.my_each_with_index {|value, index| p "#{index}: #{value}"}
# numbers.each_with_index {|value,index| p "#{index}: #{value}"}

puts "my_select vs select"
numbers = [1,2,3,4,5]
p numbers.my_select {|value| value %2 == 0}
p numbers.select {|value| value %2 == 0}
p numbers.my_select {|value| value %2 != 0}
p numbers.select {|value| value %2 != 0}


