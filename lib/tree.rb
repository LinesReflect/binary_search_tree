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
end
