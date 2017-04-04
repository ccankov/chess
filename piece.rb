require_relative 'modules.rb'
require 'singleton'

class Piece

  attr_accessor :pos

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

  def to_s
    symbol.to_s
  end

  def empty?
    false
  end

  def symbol
    :P
  end

  def valid_moves
    possible_moves = moves
    possible_moves.reject { |move| @board[move] }
  end

  private

  def move_into_check(to_pos)
    # TODO
  end
end

class King < Piece
  include SteppingPiece

  def initialize

  end
end

class Knight < Piece
  include SteppingPiece

  def initialize

  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol
    :B
  end

  protected

  def move_dirs
    diagonal_dirs
  end
end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal_dirs
  end

  def symbol
    :R
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol
    :Q
  end

end

class Pawn < Piece
  def initialize

  end
end

class NullPiece < Piece
  include Singleton

  def initialize

  end
end
