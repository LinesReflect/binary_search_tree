class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array)
  end

  def build_tree(data, first = 0, last = data.length - 1, middle = (first + last) / 2)
    return Node.new(data) if data.length == 1

    if data.length == 2
      left = [data[first]]
      right = [data[last]]
    else
      left = data[first..(middle - 1)]
      right = data[(middle + 1)..last]
    end

    Node.new(data[middle], build_tree(left), build_tree(right))
  end
end
