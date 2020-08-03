class Tree
  attr_accessor :root
  
  class Node
    include Comparable
    attr_accessor :data, :left, :right
    
    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
    
    def <=>(other)
      data <=> other.data
    end
  end
  
  def initialize(ary)
    @root = build_tree(ary)
  end
  
  def build_tree(ary)
    ary = ary.sort.uniq
    return if ary.length == 0
    mid = (ary.length-1) / 2
    middle = Node.new(ary[mid])
    middle.left = build_tree(ary[0...mid])
    middle.right = build_tree(ary[mid+1..-1])
    middle
  end
    
  def insert(value)
    return if value.nil?
    node = Node.new(value)
    tree = root
    while true do
      if tree > node
        if tree.left.nil?
          tree.left = node
          break
        else
          tree = tree.left
        end
      elsif tree < node
        if tree.right.nil?
          tree.right = node
          break
        else
          tree = tree.right
        end
      end
    end
    root
  end
  
  def delete(value)
    return if value.nil?
    tree = root
    def find_next_lowest(node)
      node.left.nil? ? node : find_next_lowest(node.left)
    end
    def delete_node(tree, value)
      if !tree.nil? && tree.data == value
        if tree.left.nil? && tree.right.nil? # ROOT ZERO
          tree.data = nil
          
        elsif tree.left.nil? # ROOT ONE
          tree.data = tree.right.data
          tree.left = tree.right.left
          tree.right = tree.right.right
          
        elsif tree.right.nil? # ROOT ONE
          tree.data = tree.left.data
          tree.right = tree.left.right
          tree.left = tree.left.left
        
        else # ROOT TWO
          lowest = find_next_lowest(tree.right)
          delete_node(tree, lowest.data)
          tree.data = lowest.data
        end
        return tree
        
      elsif !tree.left.nil? && tree.left.data == value
        if tree.left.left.nil? && tree.left.right.nil? # LEFT ZERO
          tree.left = nil
        
        elsif tree.left.left.nil? # LEFT ONE
          tree.left = tree.left.right
            
        elsif tree.left.right.nil? # LEFT ONE
          tree.left = tree.left.left
        
        else # LEFT TWO
          lowest = find_next_lowest(tree.right)
          tree = delete_node(tree, lowest.data)
          tree.data = lowest.data
        end
        return tree
        
      elsif !tree.right.nil? && tree.right.data == value
        if tree.right.left.nil? && tree.right.right.nil? # RIGHT ZERO
          tree.right = nil
          
        elsif tree.right.left.nil? # RIGHT ONE
          tree.right = tree.right.right
            
        elsif tree.right.right.nil?
          tree.right = tree.right.left # RIGHT ONE
          
        elsif # RIGHT TWO
          lowest = find_next_lowest(tree.right)
          tree = delete_node(tree, lowest.data)
          tree.data = lowest.data
        end
        return tree
      end
      
      delete_node((tree.data > value ? tree.left : tree.right), value)
    end
    delete_node(tree, value)
    root
  end
  
  def find(value)
    tree = root
    while true do
      return if tree.nil?
      return tree if tree.data == value
      tree = tree.data > value ? tree.left : tree.right
    end
  end
  
  def level_order
    queue = [root]
    ary = []
    until queue.empty? do
      tree = queue.delete_at(0)
      ary << tree
      unless tree.left.nil?
        queue << tree.left
      end
      unless tree.right.nil?
        queue << tree.right
      end
    end
    ary
  end
  
  def inorder
    def order(tree, ary)
      unless tree.left.nil?
        order(tree.left, ary)
      end
      ary << tree
      unless tree.right.nil?
        order(tree.right, ary)
      end
      ary
    end
    order(root, [])
  end
  
  def preorder
    def order(tree, ary)
      ary << tree
      unless tree.left.nil?
        order(tree.left, ary)
      end
      unless tree.right.nil?
        order(tree.right, ary)
      end
      ary
    end
    order(root, [])
  end
  
  def postorder
    def order(tree, ary)
      unless tree.left.nil?
        order(tree.left, ary)
      end
      unless tree.right.nil?
        order(tree.right, ary)
      end
      ary << tree
    end
    order(root, [])
  end

  def depth(value)
    i = 0; y = 0
    queue = [self.find(value)]
    until queue.empty? do
      tree = queue.delete_at(-1)
      unless tree.left.nil?
        i += 1
        queue << tree.left
      end
      unless tree.right.nil?
        y += 1
        queue << tree.right
      end
    end
    i > y ? i : y
  end
  
  def balanced?
    def is_balanced(tree)
      lftd = tree.left.nil? ? -1 : self.depth(tree.left.data)
      rgtd = tree.right.nil? ? -1 : self.depth(tree.right.data)
      return false if (lftd - rgtd).abs > 1
      unless tree.left.nil?
        is_balanced(tree.left)
      end
      unless tree.right.nil?
        is_balanced(tree.right)
      end
      return true
    end
    is_balanced(root)
  end
  
  def rebalance
    level_order = self.level_order.map {|i| i = i.data}
    @root = build_tree(level_order)
  end

  def pretty_print(node = root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

def mapped(ary)
  return ary.map {|i| i.data}
end

random = Array.new(15) { rand(1..100) }
tree = Tree.new(random)
puts "Array:        #{random}"
puts "Sorted array: #{random.sort}"
puts
puts "Balance: #{tree.balanced?}"
puts
puts "level_order: #{mapped(tree.level_order)}"
puts "preorder:    #{mapped(tree.preorder)}"
puts "postorder:   #{mapped(tree.postorder)}"
puts "inorder:     #{mapped(tree.inorder)}"
puts
tree.pretty_print
puts

insert = []
Array.new(rand(5..10)) { rand(101..200) }.each do |i|
  insert << i
end
insert.each {|i| tree.insert(i)}
puts "Inserted: #{insert}"
puts
puts "Balance: #{tree.balanced?}"
puts "Balancing..."
puts
tree.pretty_print
puts

puts "Array: #{mapped(tree.inorder)}"
puts
tree.rebalance
puts "Balance: #{tree.balanced?}"
puts
puts "level_order: #{mapped(tree.level_order)}"
puts "preorder:    #{mapped(tree.preorder)}"
puts "postorder:   #{mapped(tree.postorder)}"
puts "inorder:     #{mapped(tree.inorder)}"
puts
tree.pretty_print
