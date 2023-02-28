class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array)
  end

  def build_tree(data)  
  end
end
