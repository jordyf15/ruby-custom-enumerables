module Enumerable
  def my_each
    self.size.times do |index|
      yield self[index]
    end
    self
  end

  def my_each_with_index
    self.size.times do |index|
      yield self[index],index
    end
    self
  end

  def my_select
    selected_result = []
    self.size.times do |index|
      selected_result << self[index] if yield self[index]
    end
    selected_result
  end

  def my_all?
    all_result = true
    self.size.times do |index|
      all_result = false unless yield self[index]
    end
    all_result
  end
end

# puts "my_each vs each"
# numbers = [1,2,3,4,5]
# p numbers.my_each {|item| p item}
# p numbers.each {|item| p item}
# puts "\n\n"

# puts "my_each_with_index vs each_with_index"
# numbers = [1,2,3,4,5]
# p numbers.my_each_with_index {|value, index| p "#{index}: #{value}"}
# p numbers.each_with_index {|value,index| p "#{index}: #{value}"}
# puts "\n\n"

# puts "my_select vs select"
# numbers = [1,2,3,4,5]
# p numbers.my_select {|value| value %2 == 0}
# p numbers.select {|value| value %2 == 0}
# p numbers.my_select {|value| value %2 != 0}
# p numbers.select {|value| value %2 != 0}
# puts "\n\n"

puts "my_all? vs all?"
numbers = [1,2,3,4,5]
correct_numbers = [2,4,6,8,10]
p numbers.my_all? {|value| value %2 == 0}
p numbers.all? {|value| value %2 == 0}
p correct_numbers.my_all? {|value| value %2 == 0}
p correct_numbers.all? {|value| value %2 == 0}
puts "\n\n"

