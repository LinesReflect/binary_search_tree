require_relative 'tree'
require_relative 'node'

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

puts tree.pretty_print
puts tree.balanced?

print tree.level_order
puts ''

print tree.preorder
puts ''

print tree.postorder
puts ''

print tree.inorder
puts ''

7.times do tree.insert(rand(1..100)) end

puts tree.pretty_print
puts tree.balanced?

tree.array = tree.preorder.uniq.sort
tree.rebalance
puts tree.pretty_print
puts tree.balanced?

print tree.level_order
puts ''

print tree.preorder
puts ''

print tree.postorder
puts ''

print tree.inorder
puts ''
