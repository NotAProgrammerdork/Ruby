class LinkedList
  attr_accessor :head, :tail, :size

  class Node
    attr_accessor :value, :next_node
    def initialize(value=nil)
      @value = value
      @next_node = nil
    end
  end

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    node = Node.new(value)
    @head.nil? ? @head = node : @tail.next_node = node
    @tail = node
    @size += 1
  end

  def pop
    if self.size > 1
      self.at(self.size-2).next_node = nil
      @tail = self.at(self.size-2)
    elsif self.size == 1
      @head = nil
      @tail = nil
    end
    @size -= 1
  end

  def prepend(value)
    node = Node.new(value)
    @head.nil? ? @tail = node : node.next_node = @head
    @head = node
    @size += 1
  end

  def at(index)
    return nil if index.nil? || index > self.size || index < 0
    def iterating(index, node=@head, i=0)
      i == index ? node : iterating(index, node.next_node, i+1)
    end
    iterating(index)
    
    # i = 0
    # node = @head
    # while i != index do
    #   node = node.next_node
    #   i += 1
    # end
    # node
  end

  def contains?(value)
    def iterating(value, node=@head, i=0)
      node.value == value || i == self.size - 1 ? node.value == value : iterating(value, node.next_node, i+1)
    end
    iterating(value)
    
    # i = 0
    # node = @head
    # while node.value != value && i < self.size - 1 do
    #   node = node.next_node
    #   i += 1
    # end
    # node.value == value
  end

  def find(value)
    def iterating(value, node=@head, i=0)
      if node.value == value
        i
      elsif i == self.size - 1
        nil
      else
        iterating(value, node.next_node, i+1)
      end
    end
    iterating(value)
    
    # i = 0
    # node = @head
    # while node.value != value && i < self.size - 1 do
    #   node = node.next_node
    #   i += 1
    # end
    # if node.value == value
    #   i
    # else
    #   nil
    # end
  end
  
  def insert_at(value, index)
    return nil if index.nil?
    if index == 0
      self.prepend(value)
    elsif index == self.size
      self.append(value)
    elsif index > 0 && index < self.size
      node = Node.new(value)
      temp = self.at(index)
      prev = self.at(index-1)
      prev.next_node = node
      node.next_node = temp
      @size += 1
    elsif index < 0
      while index < -1 do
        self.prepend(nil)
        index += 1
      end
      self.prepend(value)
      
      # def iterating(value, index)
      #   if index == -1
      #     self.prepend(value)
      #   else
      #     self.prepend(nil)
      #     iterating(value, index+1)
      #   end
      # end
      # iterating(value, index)
    elsif index > self.size
      while index > self.size do
        self.append(nil)
      end
      self.append(value)
      
      # def iterating(value, index)
      #   if index == self.size
      #     self.append(value)
      #   else
      #     self.append(nil)
      #     iterating(value, index)
      #   end
      # end
      # iterating(value, index)
    end
  end
  
  def remove_at(index)
    if index == 0
      @head = @head.next_node
      @size -= 1
    elsif index == self.size - 1
      self.pop
    elsif index > 0 && index < self.size - 1
      self.at(index-1).next_node = self.at(index+1)
      @size -= 1
    end
  end
  
  def to_s
    return self if @head == nil
    def iterating(node=@head, string="", i=0)
      string << "( #{node.value} ) -> "
      i == self.size - 1 ? string << "nil" : iterating(node.next_node, string, i+1)
    end
    iterating

    # i = 0
    # node = @head
    # string = "( #{node.value} ) -> "
    # while i != self.size - 1 do
    #   node = node.next_node
    #   string << "( #{node.value} ) -> "
    #   i += 1
    # end
    # string << "nil"
  end
end