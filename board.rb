require_relative 'piece.rb'

class Board
  def initialize
    @grid = make_starting_grid
  end

  def [](pos)
    # TODO
  end

  def []=(pos, piece)
    # TODO
  end

  def dup
    # TODO
  end

  def move_piece(color, from_pos, to_pos)
    # TODO
  end

  def checkmate?
    # TODO
  end

  protected

  def make_starting_grid
    grid = Array.new(8) { Array.new(8) }
    pawns = Array.new(8) { Pawn.new }
    back_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new,
                Bishop.new, Knight.new, Rook.new]
    grid[1] = pawns
    grid[-2] = pawns.dup
    grid.last = back_row
    grid.first = back_row.reverse
    grid
  end

  def find_king(color)
    # TODO
  end
end
