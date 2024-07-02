class Knight
  def initialize
    @adj_list = gen_adj_list
  end

  def knight_moves(source, destination)
    @paths = bfs(@adj_list, destination)
    nr_moves = @paths[source[0]][source[1]][:distance]
    back_track = @paths[source[0]][source[1]][:predecessor]

    puts "You made it in #{nr_moves} moves! Here's your path:"
    puts "\n#{source}"
    until back_track.nil?
      puts "#{back_track}"
      back_track = @paths[back_track[0]][back_track[1]][:predecessor]
    end
  end

  private

  # returns an adjacency list given the source ([x, y])
  def gen_adj_list
    adj_list = Array.new(8) { Array.new(8, nil) }

    adj_list.each_with_index do |_, x|
      adj_list[x].each_with_index do |_, y|
        adj_list[x][y] = gen_legal_moves([x, y])
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

  # bfs algorithm to calcualte the shortest path given a source co-ordinate
  def bfs(graph, destination)
    node_status = Array.new(8) { Array.new(8) }

    graph.each_with_index do |_, x|
      graph[x].each_with_index do |_, y|
        node_status[x][y] = { distance: nil, predecessor: nil }
      end
    end

    node_status[destination[0]][destination[1]][:distance] = 0

    queue = []
    queue << destination

    until queue.empty?
      # predecessor
      u = queue.shift

      graph[u[0]][u[1]].each_with_index do |_, i|
        # neighbour
        v = graph[u[0]][u[1]][i]

        next unless node_status[v[0]][v[1]][:distance].nil?

        node_status[v[0]][v[1]][:distance] = node_status[u[0]][u[1]][:distance] + 1
        node_status[v[0]][v[1]][:predecessor] = u
        queue << v
      end
    end
    node_status
  end
end
