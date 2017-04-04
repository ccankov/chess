require_relative 'board.rb'
require_relative 'display.rb'
#require_relative 'player.rb'

class Game

  attr_reader :display

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(board)
  end

  def play
    # TODO
  end

  private

  def notify_players
    # TODO
  end

  def swap_turn!
    # TODO
  end
end

if __FILE__ == $PROGRAM_NAME
  game1 = Game.new
  game1.display.render
end
