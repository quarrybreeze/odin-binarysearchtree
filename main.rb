require_relative 'lib/tree'

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