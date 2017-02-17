class LinkedList
	attr_accessor :value, :next_node
	def initialize
		@head = nil
		@tail = nil
	end

	def append(val)
		node = Node.new(val,@tail)
		traverse.next_node = node
	end

	def prepend(val)
		node = Node.new(val,@head)
		@head = node
	end

	def traverse
		loc = @head
		while loc.next_node != nil do
			yield loc if block_given?
			loc = loc.next_node
		end
		loc
	end

	def to_s
		list = ""
		traverse { |loc| list << "#{loc.value} -> "}
		list << traverse.value.to_s
	end

	def size
		number = 1
		return puts "Error, list empty!" if @head == nil
		traverse { number += 1}
		number
	end

	def head
		@head.value
	end

	def tail
		traverse.value
	end

	def at_index(index,rtn_node=false)
		number = 0
		return tail if index == self.size
		return puts "Error. Could not locate node at index #{index}" if index + 1 > self.size
		traverse do |loc|
			if number == index
				return loc if rtn_node == true
				return loc.value
			end
			number += 1
		end
	end

	def pop
		node = self.at_index(size-2, true)
		node.next_node = @tail
	end

	def contains?(val)
		return true if traverse.value == val
		traverse { |loc| return true if loc.value == val }
		false
	end

	def find(val)
		i = 0
		traverse do |loc| 
			if loc.value == val
				return i
			else
				i += 1
			end
		end
		nil
	end

	def insert_at(index, val)
		return prepend(val) if index == 0
		if index > self.size
			puts "Not enough nodes '#{val}' appended to list."
		end
		return append(val) if index >= (self.size)
		node = Node.new(val, at_index(index,true))
		traverse { |loc| loc.next_node = node if loc == at_index(index-1,true) }
	end

	def remove_at(index)
		traverse do |loc| 
			if loc == at_index(index-1,true)
				loc.next_node = at_index(index+1,true)
			end
		end
	end
end

class Node
	attr_accessor :value, :next_node
	def initialize(value=nil, next_node=nil)
			@value = value
			@next_node = next_node
	end
end

list = LinkedList.new

list.prepend("test1")
list.prepend("test2")
list.append("test3")
list.append("test4")
list.append("test5")
list.prepend("test6")
puts list.to_s
puts list.size
puts list.head
puts list.tail
puts list.at_index(2)
list.pop
puts list.to_s
puts list.contains?("test4")
puts list.find("test3")
list.insert_at(4,"test7")
puts list.to_s
list.remove_at(4)
puts list.to_s