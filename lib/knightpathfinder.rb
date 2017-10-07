require_relative "00_tree_node.rb"

class KnightPathFinder
  attr_accessor :starting_position, :root, :visited_moves

  def initialize(starting_position=[0,0])
    @starting_position = starting_position
    @root = PolyTreeNode.new(starting_position)
    @visited_moves = [starting_position]
    build_move_tree
  end

  def self.valid_moves(pos)
    x = pos.first
    y = pos.last
    moves = [[x-1,y-2],[x-2,y-1],[x-2,y+1],[x-1,y+2],
     [x+1,y-2],[x+2,y-1],[x+2,y+1],[x+1,y+2]]
    moves.select do |pair|
      pair.first.between?(0,7) && pair.last.between?(0,7)
    end
  end

  def new_move_positions(pos)
    all_pos = KnightPathFinder.valid_moves(pos)
    all_pos.reject {|xy| @visited_moves.include?(xy)}
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      valid_mov = new_move_positions(current_node.value)
      valid_mov.each do |child_pos|
        child = PolyTreeNode.new(child_pos)
        current_node.add_child(child)
      end
      @visited_moves += valid_mov
      queue.concat(current_node.children)
    end
  end

  def find_path(pos)
    result = []
    result_node = root.dfs(pos)

    queue = [root]
    until queue.empty?
      current_el = queue.shift
      queue.push(current_el.parent)
    end
    result
  end

end

knight = KnightPathFinder.new
# knight.build_move_tree

p knight.find_path([2,1])

# p knight.root.bfs([2, 4]).children.count

# p knight.visited_moves << [2,1]
#
# # p KnightPathFinder.valid_moves([0,0])
#
# p knight.new_move_positions([0,0])
