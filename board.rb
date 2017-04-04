require_relative 'piece.rb'

class Board

  attr_reader :grid


  def initialize
    @grid = make_starting_grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def dup
    # TODO
  end

  def move_piece(color, start_pos, to_pos)
    piece = self[start_pos]
    raise "Invalid move" unless piece.valid_moves.include?(to_pos)
    self[to_pos] = piece
    self[start_pos] = NullPiece.instance
    piece.pos = to_pos
  end

  def checkmate?
    # TODO
  end

  protected

  def make_starting_grid
    grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    grid[0].each_index do |row_idx|
      if row_idx == 0
        grid[0][0] = Knight.new([0, 0], self, :white)
      else
        grid[0][row_idx] = Bishop.new([0, row_idx], self, :black)
      end
    end
    grid
  end

  def find_king(color)
    # TODO
  end
end
