class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array)
  end

  def build_tree(array)
    return Node.new(array[0]) if array.length == 1

    if array.length == 2
      left = array[0]
      right = array[array.length - 1]
      return Node.new(left, nil, Node.new(right))
    else
      middle = (0 + array.length - 1) / 2
      left = array[0..(middle - 1)]
      right = array[(middle + 1)..array.length - 1]
    end

    Node.new(array[middle], build_tree(left), build_tree(right))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value, current_node = @root)
    return nil if value == current_node.data

    if value < current_node.data
      current_node.left_child.nil? ? current_node.left_child = Node.new(value) : insert(value, current_node.left_child)
    elsif current_node.data < value
      current_node.right_child.nil? ? current_node.right_child = Node.new(value) : insert(value, current_node.right_child)
    end
  end


  def delete(value, current_node = @root, parent_node = nil)
    if value < current_node.data
      delete(value, current_node.left_child, current_node) 
    elsif current_node.data < value
      delete(value, current_node.right_child, current_node)
    else
      return parent_node.left_child == current_node ? parent_node.left_child = nil : parent_node.right_child = nil if leaf_node?(current_node)
      return parent_node.left_child = current_node.right_child if current_node.left_child.nil?
      return parent_node.right_child = current_node.left_child if current_node.right_child.nil?

      replacement_node = current_node.right_child
      replacement_node_parent = replacement_node
      until replacement_node.left_child.nil?
        replacement_node_parent = replacement_node
        replacement_node = replacement_node.left_child
      end
      delete(replacement_node.data)
      replacement_node.left_child = current_node.left_child
      replacement_node.right_child = current_node.right_child
      return @root = replacement_node if parent_node.nil?
      parent_node.left_child == current_node ? parent_node.left_child = replacement_node : parent_node.right_child = replacement_node
    end
  end

  def leaf_node?(node)
    node.left_child.nil? && node.right_child.nil?
  end

  def find(value, current_node = @root)
    return nil if current_node.nil?
    return current_node if current_node.data == value

    value < current_node.data ? find(value, current_node.left_child) : find(value, current_node.right_child)
  end

  def height(current_node, count = -1)
    return count if current_node.nil?

    current_node = find(current_node) if current_node.instance_of? Integer
    count += 1
    height(current_node.left_child) < height(current_node.right_child) ? height(current_node.right_child, count) : height(current_node.left_child, count)
  end

  def depth(current_node, count = 0, parent_node = @root)
    return count if find(current_node) == @root

    current_node = find(current_node) if current_node.instance_of? Integer

    until parent_node.left_child == current_node || parent_node.right_child == current_node
      parent_node = current_node.data < parent_node.data ? parent_node.left_child : parent_node.right_child
    end

    count += 1
    depth(parent_node, count)
  end

  def level_order(queue = [@root])
    data = []
    until queue.length == 0 do
        queue.each do |node|
            queue.push(node.left_child) unless node.left_child.nil?
            queue.push(node.right_child) unless node.right_child.nil?
            (block_given?)? data << yield(node.data) : data << node.data
            queue.delete(node)
            break
        end
      end
      data if !(block_given?)
  end
end
