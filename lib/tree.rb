require_relative 'node'

class Tree

  attr_accessor :root

  def initialize(array)
    cleaned = self.clean(array)
    @root = self.build_tree(cleaned)
  end

  def build_tree(input, front = 0, back = input.length-1)
    if front>back
      return nil
    end

    mid = (front+back)/2

    root_node = Node.new(input[mid])

    root_node.left = self.build_tree(input,front,mid-1)
    root_node.right = self.build_tree(input,mid+1,back)
    return root_node
  end

  def clean(arr)
    arr = arr.uniq
    array = arr.sort
  end

  def insert(input)
    current = @root

    while current.data
      if input < current.data && current.left
        current = current.left
      elsif input > current.data && current.right
        current = current.right
      else
        break
      end
    end

    if input == current.data
      p "#{input} already exists!"
    elsif input < current.data
      current.left = Node.new(input)
    elsif input > current.data
      current.right = Node.new(input)
    else
      "error"
    end
  end

  def delete(input)
    current = @root
    parent = nil
    child_count = 0

    while current.data
      if input < current.data && current.left
        parent = current
        current = current.left
      elsif input > current.data && current.right
        parent = current
        current = current.right
      else
        break
      end
    end

    if current.left && current.right
      child_count = 2
    elsif current.left || current.right
      child_count = 1
    end

    if input != current.data
      p "#{input} is not a node"
    elsif child_count == 0
      parent.left = nil
      parent.right = nil
    elsif child_count == 1 && parent.right && (parent.right == current)
      if current.left
        parent.right = current.left
      elsif current.right
        parent.right = current.right
      end
    elsif child_count == 1 && parent.left && (parent.left.data == current.data)
      if current.left
        parent.left = current.left
      elsif current.right
        parent.left = current.right
      end
    elsif child_count == 2
      next_biggest = nil  #keep track of next biggest
      node_to_replace = current #keep track the node we are trying to replace

      parent = current
      current = current.right

      next_biggest = current
      while current.left
        parent = current #keep track of parent of next_biggest
        current = current.left
        next_biggest = current
      end
      node_to_replace.data = next_biggest.data
      if node_to_replace.right == next_biggest  #if the right node is the next biggest,
        node_to_replace.right = next_biggest.right #then replace it
      else
        parent.left = next_biggest.right  #otherwise, replace the parent of the next_biggest
      end
    else
      p "error"
    end
  end
  
  def level_order
    value_array = []
    node_array = []
    stack = [@root]

    while stack != []
      node_array << stack[0]
      value_array << stack[0].data
      if stack[0].left
        stack << stack[0].left
      end
      if stack[0].right
        stack << stack[0].right
      end
      stack.shift
    end

    if block_given?
      node_array.each do |node|
        yield node
      end
    else
    return value_array
    end
  end

  def find(value)
    current = @root

    while current && current.data != value
      if value < current.data
        current = current.left
      else
        current = current.right
      end
    end

    return current
  end

  def postorder
    result = []
    value_array = []
    postorder_rec(@root,result)
    
    if block_given?
      result.each do |node|
      yield node
      end
    else
      result.each do |value|
        value_array << value.data
      end
    end
    return value_array
  end

  def inorder
    result = []
    value_array = []
    inorder_rec(@root,result)
    
    if block_given?
      result.each do |node|
      yield node
      end
    else
      result.each do |value|
        value_array << value.data
      end
    end
    return value_array
  end

  def preorder
    result = []
    value_array = []
    preorder_rec(@root,result)
    
    if block_given?
      result.each do |node|
      yield node
      end
    else
      result.each do |value|
        value_array << value.data
      end
    end
    return value_array
  end

  def inorder_rec(root,result)
    if root
      if root.left
        inorder_rec(root.left, result)
      end
      result << root
      if root.right
        inorder_rec(root.right,result)
      end
    end
  end

  def postorder_rec(root,result)
    if root
      if root.left
        postorder_rec(root.left, result)
      end
      if root.right
        postorder_rec(root.right,result)
      end
      result << root
    end
  end

  def preorder_rec(root, result)
    if root
      result << root
      if root.left
        preorder_rec(root.left, result)
      end
      if root.right
        preorder_rec(root.right, result)
      end
    end
  end

  def height(node)
    if node == nil
      return -1
    end
    left_height = height(node.left)
    right_height = height(node.right)
    return [left_height,right_height].max+1
  end

  def depth(node)
    target_data = node.data
    current = @root
    depth = 0

    while current
      if current.data > target_data
        current = current.left
        depth += 1
      elsif current.data < target_data
        current = current.right
        depth += 1
      elsif current.data == target_data
        break
      else
        p "#{node.data} not found"
        break
      end
    end
    return depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    difference = left_height - right_height

    if (difference <= 1) &&
       (difference >= -1)
      balanced?(node.left) && balanced?(node.right)
    else
      false
    end
  end

  def rebalance
    if balanced?
      p "Tree is balanced"
      return @root
    else
      p "Tree is rebalancing..."
      array = self.inorder
      @root = self.build_tree(array)
      return @root
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end
