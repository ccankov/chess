require_relative 'piece.rb'

class Board
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
    raise "Invalid move" if piece.nil? #|| !piece.valid_moves.include?(to_pos)
    self[to_pos] = piece
    self[start_pos] = nil
  end

  def checkmate?
    # TODO
  end

  protected

  def make_starting_grid
    grid = Array.new(8) { Array.new(8) }
    grid[0] = Array.new(8) {Piece.new}
    # pawns = Array.new(8) { Pawn.new }
    # back_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new,
    #             Bishop.new, Knight.new, Rook.new]
    # grid[1] = pawns
    # grid[-2] = pawns.dup
    # grid.last = back_row
    # grid.first = back_row.reverse
    grid
  end

  def find_king(color)
    # TODO
  end
end
