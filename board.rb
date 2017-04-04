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
    grid[1] = Array.new(8) { |idx| Pawn.new([1, idx], self, :black) }
    grid[6] = Array.new(8) { |idx| Pawn.new([6, idx], self, :white) }
    grid[0] = [Rook.new([0,0], self, :black), Knight.new([0,1], self, :black),
               Bishop.new([0,2], self, :black), Queen.new([0,3], self, :black),
               King.new([0,4], self, :black), Bishop.new([0,5], self, :black),
               Knight.new([0,6], self, :black), Rook.new([0,7], self, :black)]
    grid[7] = [Rook.new([7,0], self, :white), Knight.new([7,1], self, :white),
               Bishop.new([7,2], self, :white), Queen.new([7,3], self, :white),
               King.new([7,4], self, :white), Bishop.new([7,5], self, :white),
               Knight.new([7,6], self, :white), Rook.new([7,7], self, :white)]
    grid
  end

  def find_king(color)
    # TODO
  end
end
