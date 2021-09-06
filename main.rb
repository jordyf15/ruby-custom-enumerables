module Enumerable
  def my_each
    self.size.times do |index|
      yield self[index]
    end
  end
end

puts "my_each vs each"
numbers = [1,2,3,4,5]
numbers.my_each {|item| p item}
numbers.each {|item| p item}

