require_relative 'board.rb'
require_relative 'cursor.rb'

require 'colorize'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def move(new_pos)
    # TODO
  end

  def render
    while true
      begin
        system("clear")
        puts "   1 2 3 4 5 6 7 8"
        puts "   ---------------"
        letter_coords = ("A".."H").to_a
        @board.grid.each_with_index do |row, idx|
          print "#{letter_coords[idx]}| "
          row.each_with_index do |piece, idx2|
            label = piece.is_a?(Piece) ? "#{piece} " : "_ "
            if @cursor.cursor_pos == [idx, idx2]
              label = label.colorize(@cursor.color)
            end
            print label
          end
          print "\n"
        end
        @cursor.get_input
      rescue        
        @cursor.selected_piece = nil
        retry
      end
    end
  end
end
