require_relative 'board.rb'
require_relative 'cursor.rb'
require 'byebug'

require 'colorize'

class Display

  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def move
    until @cursor.get_input.nil?
      render      
    end
  end

  def render
    system("clear")
    puts "   1 2 3 4 5 6 7 8"
    puts "   ---------------"
    letter_coords = ("A".."H").to_a
    @board.grid.each_with_index do |row, idx|
      print "#{letter_coords[idx]}| "
      row.each_with_index do |piece, idx2|
        label = "#{piece} "
        if @cursor.cursor_pos == [idx, idx2]
          label = label.colorize(@cursor.color)
        end
        print label
      end
      print "\n"
    end
  end
end
