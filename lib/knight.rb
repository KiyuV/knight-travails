class Knight
  def initialize
    @adj_list = nil
  end

  def knight_moves(source, destination)
    @adj_list = gen_adj_list
  end

  private

  # returns an adjacency list given the source ([x, y])
  def gen_adj_list
    adj_list = Array.new(8) { Array.new(8, nil) }

    adj_list.each_with_index do |_, i|
      adj_list[i].each_with_index do |_, j|
        adj_list[i][j] = gen_legal_moves([j, i])
      end
    end
    adj_list
  end

  # returns an array of x, y pairs of all valid moves of a given vertex
  def gen_legal_moves(vertex)
    moves = []
    move_offsets = [[-1, -2], [-1, 2], [-2, -1], [-2, 1], [1, -2], [1, 2], [2, -1], [2, 1]]

    move_offsets.each do |move|
      # adds the offset to the current vertex
      moves << [vertex, move].transpose.map { |x| x.reduce(:+) }
    end
    check_legal_moves(moves)
  end

  def check_legal_moves(moves)
    legal_moves = []
    moves.each do |move|
      legal_moves << move if (0..7).include?(move[0]) && (0..7).include?(move[1])
    end
    legal_moves
  end
end
