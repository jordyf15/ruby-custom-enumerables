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

  def my_any?
    any = false
    self.size.times do |index|
      any = true if yield self[index]
    end
    any
  end
  
  def my_none?
    none = true
    self.size.times do |index|
      none = false if yield self[index]
    end
    none
  end

  def my_count
    count = 0
    self.size.times do |index|
      count+=1 if yield self[index]
    end
    count
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

# puts "my_all? vs all?"
# numbers = [1,2,3,4,5]
# correct_numbers = [2,4,6,8,10]
# p numbers.my_all? {|value| value %2 == 0}
# p numbers.all? {|value| value %2 == 0}
# p correct_numbers.my_all? {|value| value %2 == 0}
# p correct_numbers.all? {|value| value %2 == 0}
# puts "\n\n"

# puts "my_any? vs any?"
# numbers = [1,2,3,4,5]
# wrong_numbers = [1,3,5,7,9]
# p numbers.my_any? {|value| value %2 == 0}
# p numbers.any? {|value| value %2 == 0}
# p wrong_numbers.my_any? {|value| value %2 == 0}
# p wrong_numbers.any? {|value| value %2 == 0}
# puts "\n\n"

# puts "my_none? vs none?"
# numbers = [1,2,3,4,5]
# wrong_numbers = [1,3,5,7,9]
# p numbers.my_none? {|value| value %2 == 0}
# p numbers.none? {|value| value %2 == 0}
# p wrong_numbers.my_none? {|value| value %2 == 0}
# p wrong_numbers.none? {|value| value %2 == 0}
# puts "\n\n"

puts "my_count vs count"
numbers = [1,2,3,4,5]
correct_numbers = [2,4,6,8,10]
p numbers.my_count {|value| value %2 == 0}
p numbers.count {|value| value %2 == 0}
p correct_numbers.my_count {|value| value %2 == 0}
p correct_numbers.count {|value| value %2 == 0}