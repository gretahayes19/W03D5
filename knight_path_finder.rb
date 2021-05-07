require "byebug"
require "./polytree_node/lib/00_tree_node.rb"

class KnightPathFinder
  def self.valid_moves(pos)
    x, y = pos

    possible_moves = [
      [x+1, y+2],
      [x+1, y-2],
      [x+2, y+1],
      [x+2, y-1],
      [x-1, y-2],
      [x-1, y+2],
      [x-2, y+1],
      [x-2, y-1],
    ]

    valid_moves = []
    possible_moves.each do |move|
      valid_moves << move if move.all? {|coord| coord.between?(0,7)}
    end

    valid_moves
  end

  attr_accessor :considered_positions
  attr_reader :root_node

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    build_move_tree
  end

  def find_path(end_pos)
    end_node = root_node.bfs(end_pos)
    trace_back_path(end_node)
  end

  def build_move_tree
    queue = [root_node]

    until queue.empty?
      current_node = queue.shift
      new_positions = new_move_positions(current_node.value)
      add_children(current_node, new_positions)
      queue += current_node.children
    end
  end

  # private

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

  def add_children(node, child_positions)
    child_positions.each do |child_pos| 
      child_node = PolyTreeNode.new(child_pos)
      node.add_child(child_node)
    end
  end

  def trace_back_path(end_node)
    path = [end_node.value]
    current_node = end_node
    
    while current_node.parent
      path << current_node.parent_value
      current_node = current_node.parent
    end

    path
  end
end