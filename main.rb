require_relative 'lib/tree'


#testing if balanced? goes for all nodes
tree = Tree.new([3,4,5])
tree.insert(6)
tree.insert(7)
tree.insert(2)
tree.insert(1)
tree.pretty_print
p "Is tree balanced?: #{tree.balanced?}"

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
p "Is tree balanced?: #{tree.balanced?}"
p "Level order: #{tree.level_order}"
p "Pre order: #{tree.preorder}"
p "Post order: #{tree.postorder}"
p "Inorder order: #{tree.inorder}"


tree.insert(200)
tree.insert(300)
tree.insert(400)
tree.insert(500)

tree.pretty_print
p "Is tree balanced?: #{tree.balanced?}"
tree.rebalance
tree.pretty_print
p "Is tree balanced?: #{tree.balanced?}"
p "Level order: #{tree.level_order}"
p "Pre order: #{tree.preorder}"
p "Post order: #{tree.postorder}"
p "Inorder order: #{tree.inorder}"