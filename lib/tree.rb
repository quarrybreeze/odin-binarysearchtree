require_relative 'node'

class Tree

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
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test = Tree.new(array)
test.pretty_print
# test.insert(2)
# test.pretty_print
# test.insert(4)
# test.insert(6)
# test.pretty_print
# test.delete(2)
# test.delete(3)

# test.delete(324)
# test.delete(67)
# test.delete(8)

test.pretty_print
