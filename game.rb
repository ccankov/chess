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
    until @board.checkmate?
      @display.render
      notify_players
      begin
        @display.move
      rescue
        @display.cursor.selected_piece = nil
        @display.render
        puts "Invalid move! #{@board.current_player.capitalize} play again."
        retry
      end
      swap_turn!
    end
  end

  private

  def notify_players
    puts "It is the #{@board.current_player} player's turn"
  end

  def swap_turn!
    player = @board.current_player
    @board.current_player = player == :white ? :black : :white
  end
end

if __FILE__ == $PROGRAM_NAME
  game1 = Game.new
  game1.play
end
