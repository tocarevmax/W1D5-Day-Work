class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value, parent = nil, children = [])
    @value = value
    @children = children
    @parent = parent
  end

  def parent=(par)
    if @parent.nil?
      @parent = par
      par.children << self
    elsif @parent && par
      @parent.children.delete(self)
      @parent = par
      par.children << self
    elsif par.nil?
      @parent = nil
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    nil
  end
end


# p root = PolyTreeNode.new('root')
# p child1 = PolyTreeNode.new('child1')
# p child2 = PolyTreeNode.new('child2')
# p child1.parent=(root)
# p child1.parent=(nil)
# puts
# print "child1 "
# p child1.parent

#
# n1 = PolyTreeNode.new("root1")
# n2 = PolyTreeNode.new("root2")
# n3 = PolyTreeNode.new("root3")
#
# # connect n3 to n1
# n3.parent = n1
# # connect n3 to n2
# n3.parent = n2
#
# # this should work
# p n3.parent == n2
# raise "Bad parent=!" unless n3.parent == n2
# raise "Bad parent=!" unless n2.children == [n3]
#
# # this probably doesn't
# raise "Bad parent=!" unless n1.children == []
