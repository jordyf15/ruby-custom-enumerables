module Enumerable
  def my_each
    return self.to_enum unless block_given?
    if self.is_a?(Array)
      self.size.times {|index| yield self[index]}
      self
    else
      self.keys.size.times {|key_index| yield self.keys[key_index], self[self.keys[key_index]]}
      self
    end
  end

  def my_each_with_index
    return self.to_enum(:each_with_index) unless block_given?
    if self.is_a?(Array)
      self.size.times {|index| yield self[index],index}
      self
    else
      self.keys.size.times {|index| yield self.assoc(self.keys[index]), index}
      self
    end
  end

  def my_select
    return self.to_enum(:select) unless block_given?
    if self.is_a?(Array)
      selected_result = []
      self.size.times {|index| selected_result << self[index] if yield self[index]}
      selected_result
    else
      selected_result = {}
      self.keys.size.times do |index|
        if yield self.keys[index], self[self.keys[index]]
          selected_result[self.keys[index]] = self[self.keys[index]] 
        end
      end
      selected_result
    end
  end

  def my_all? pattern = nil
    all_result = true
    if pattern != nil
      self.size.times {|index| all_result = false unless pattern === self[index]}
    elsif block_given?
      self.size.times {|index| all_result = false unless yield self[index]}
    else
      self.size.times {|index| all_result = false if self[index] == false || self [index] == nil}
    end    
    all_result
  end

  def my_any? pattern = nil
    any = false
    if self.is_a?(Array)
      if pattern != nil
        self.size.times {|index| any = true if pattern === self[index]}
      elsif block_given?
        self.size.times {|index| any = true if yield self[index]}
      else
        self.size.times {|index| any = true unless self[index] == false || self[index] == nil}
      end
    else
      if pattern != nil
        self.keys.size.times {|index| any = true if self.assoc(self.keys[index]) == pattern}
      elsif block_given?
        self.keys.size.times {|index| any = true if yield self.keys[index], self[self.keys[index]]}
      else
        any = true unless self.empty?
      end
    end
    any
  end
  
  def my_none? pattern = nil
    none = true
    if pattern != nil
      self.size.times {|index| none = false if pattern === self[index]}
    elsif block_given?
      self.size.times{|index| none = false if yield self[index]}
    else
      self.size.times {|index| none = false if self[index]}
    end
    none
  end

  def my_count obj = nil
    count = 0
    if obj != nil
      self.size.times {|index| count+=1 if obj == self[index]}
    elsif block_given?
      self.size.times {|index| count+=1 if yield self[index]}
    else
      count = self.size
    end
    count
  end

  def my_map arg_proc = nil
    new_arr = []
    unless arg_proc == nil
      self.size.times do |index|
        if arg_proc.call self[index]
          new_arr << self[index]
        else
          new_arr << nil
        end
      end
      return new_arr
    end
    return self.to_enum(:map) unless block_given?
    self.size.times do |index|
      if yield self[index]
        new_arr << self[index]
      else
        new_arr << nil
      end
    end
    new_arr
  end

  def my_inject accumulator = nil
    self.size.times do |index|
      if accumulator == nil && index == 0
        accumulator = self[index]
        next
      end
      accumulator = yield accumulator, self[index]    
    end
    accumulator
  end
end

puts "my_each vs each"
numbers = [1,2,3,4,5]
p numbers.my_each {|item| p item}
p numbers.each {|item| p item}
p numbers.my_each
p numbers.each
puts "\n"
hashes = {a: 'a', b: 'b', c: 'c'}
p hashes.my_each {|key, value| puts "#{key}: #{value}"}
p hashes.each {|key, value| puts "#{key}: #{value}"}
p hashes.my_each
p hashes.each
puts "\n\n"


puts "my_each_with_index vs each_with_index"
numbers = [1,2,3,4,5]
p numbers.my_each_with_index {|value, index| p "#{index}: #{value}"}
p numbers.each_with_index {|value,index| p "#{index}: #{value}"}
p numbers.my_each_with_index
p numbers.each_with_index
puts "\n"
hashes = {a: 'a', b: 'b', c: 'c'}
p hashes.my_each_with_index {|value, index| p "#{index}: #{value}"}
p hashes.each_with_index {|value, index| p "#{index}: #{value}"}
p hashes.my_each_with_index
p hashes.each_with_index
puts "\n\n"

puts "my_select vs select"
numbers = [1,2,3,4,5]
p numbers.my_select {|value| value %2 == 0}
p numbers.select {|value| value %2 == 0}
p numbers.my_select {|value| value %2 != 0}
p numbers.select {|value| value %2 != 0}
p numbers.my_select
p numbers.select 
puts "\n"
hashes = {a: 1, b: 2, c: 3, d: 4, e: 5}
p hashes.my_select {|key, value| value %2 == 0}
p hashes.select {|key, value| value %2 == 0}
p hashes.my_select {|key, value| value %2 != 0}
p hashes.select {|key, value| value %2 != 0}
p hashes.my_select
p hashes.select 

puts "my_all? vs all?"
numbers = [1,2,3,4,5]
correct_numbers = [2,4,6,8,10]
p numbers.my_all? {|value| value %2 == 0}
p numbers.all? {|value| value %2 == 0}
puts "\n"
p correct_numbers.my_all? {|value| value %2 == 0}
p correct_numbers.all? {|value| value %2 == 0}
puts "\n"
p numbers.my_all?(Numeric)
p numbers.all?(Numeric)
puts "\n"
p numbers.my_all?
p numbers.all?
puts "\n\n"

puts "my_any? vs any?"
numbers = [1,2,3,4,5]
wrong_numbers = [1,3,5,7,9]
p numbers.my_any? {|value| value %2 == 0}
p numbers.any? {|value| value %2 == 0}
p wrong_numbers.my_any? {|value| value %2 == 0}
p wrong_numbers.any? {|value| value %2 == 0}
puts "\n"
p numbers.my_any?
p numbers.any?
p numbers.my_any?(Integer)
p numbers.any?(Integer)
p numbers.my_any?(String)
p numbers.any?(String)
puts "\n"
hashes = {a: 1, b: 2, c: 3, d: 4, e: 5}
p hashes.any?
p hashes.my_any?
p hashes.any?([:a, 1])
p hashes.my_any?([:a, 1])
p hashes.any?([:a, 2])
p hashes.my_any?([:a, 2])
p hashes.any?{|key, value| value<5}
p hashes.my_any?{|key, value| value<5}
p hashes.any?{|key, value| value>5}
p hashes.my_any?{|key, value| value>5}
puts "\n\n"

puts "my_none? vs none?"
numbers = [1,2,3,4,5]
wrong_numbers = [1,3,5,7,9]
p numbers.my_none? {|value| value %2 == 0}
p numbers.none? {|value| value %2 == 0}
p wrong_numbers.my_none? {|value| value %2 == 0}
p wrong_numbers.none? {|value| value %2 == 0}
p [].my_none?
p [].none?
p [nil, true].my_none?
p [nil, true].none?
p [].my_none?(Float)
p [].none?(Float)
puts "\n\n"

puts "my_count vs count"
ary = [1, 2, 4, 2]
p ary.count  
p ary.my_count                    
p ary.count(2)     
p ary.my_count(2)                         
p ary.count {|x| x%2 == 0}  
p ary.my_count {|x| x%2 == 0} 
puts "\n\n"

puts "my_map vs map"
numbers = [1,2,3,4,5]
p numbers.my_map {|value| value}
p numbers.map {|value| value}
p numbers.my_map {|value| value if value %2 == 0}
p numbers.map {|value| value if value %2 == 0}
p numbers.my_map
p numbers.map 
my_proc = Proc.new {|value|value}
p numbers.my_map(my_proc)
my_proc = Proc.new {|value| value if value %2 == 0}
p numbers.my_map(my_proc)
puts "\n\n"

puts "my_inject vs inject"
numbers = [1,2,3,4,5]
p numbers.my_inject {|sum, n| sum*n } 
p numbers.inject {|sum, n| sum*n}

def multiply_els arr
  arr.my_inject {|sum, n| sum*n}
end

p multiply_els([2,4,5])