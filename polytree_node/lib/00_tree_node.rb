#This code is awesome! 
# This code is better than awesome! Just the best code ever!
class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node

    unless node == nil || node.children.include?(self)
      node.children.push(self) 
    end
  end

  def add_child(node)
    node.parent = self unless children.include?(node)
  end

  def remove_child(node)
    if node.parent == self
      node.parent = nil
    else
      raise ArgumentError.new("Node is not a child of parent")
    end
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
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
      queue += current_node.children
    end      

    nil
  end

  def parent_value
    return parent.value
  end
end