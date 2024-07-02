# frozen_string_literal: true

require './lib/knight'

class Main
  def initialize
    @board = Knight.new
  end

  def run
    @board.knight_moves([0, 0], [7, 7])
  end
end

task = Main.new
task.run
