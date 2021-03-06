require_relative 'modules.rb'
require 'singleton'
require 'byebug'

class Piece

  attr_reader :color
  attr_accessor :pos

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def to_s
    symbol.encode('utf-8')
  end

  def empty?
    false
  end

  def symbol
    :P
  end

  def valid_moves
    possible_moves = moves
    possible_moves = possible_moves.select do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7) &&
      (@board[move].is_a?(NullPiece) || @board[move].color != @color)
    end
    #debugger
    valid_moves_avoiding_check(possible_moves)
  end

  def valid_moves_avoiding_check(possible_moves)
    possible_moves.reject do |move|
      potential_board = @board.dup
      piece = potential_board[@pos]
      potential_board[@pos] = NullPiece.instance
      piece.pos = move
      potential_board[move] = piece
      potential_board.in_check?(@color)
    end
  end

  private

  def move_into_check(to_pos)
    # TODO
  end
end

class King < Piece
  include SteppingPiece

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0],
     [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def symbol
    @color == :white ? "\u2654" : "\u265A"
  end
end

class Knight < Piece
  include SteppingPiece

  def symbol
    @color == :white ? "\u2658" : "\u265E"
  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol
    @color == :white ? "\u2657" : "\u265D"
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
    @color == :white ? "\u2656" : "\u265C"
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol
    @color == :white ? "\u2655" : "\u265B"
  end

end

class Pawn < Piece
  def symbol
    @color == :white ? "\u2659" : "\u265F"
  end

  def moves
    move_diffs = forward_step
    move_forward = []
    move_diffs.each do |diff|
      move_pos = [@pos[0] + diff[0], @pos[1]]
      break unless @board[move_pos].is_a?(NullPiece)
      move_forward << move_pos
    end
    move_forward + side_attacks
  end

  protected

  def at_start_row?
    if @color == :white
      @pos[0] == 6
    else
      @pos[0] == 1
    end
  end

  def forward_dir
    if @color == :white
      [-1, 0]
    else
      [1, 0]
    end
  end

  def forward_step
    res_arr = []
    res_arr << forward_dir
    res_arr << forward_dir.map { |n| n * 2 } if at_start_row?
    res_arr
  end

  def side_attacks
    side_att_pos = []
    if @color == :white
      side_att_pos << [@pos[0] - 1, @pos[1] - 1]
      side_att_pos << [@pos[0] - 1, @pos[1] + 1]
    else
      side_att_pos << [@pos[0] + 1, @pos[1] - 1]
      side_att_pos << [@pos[0] + 1, @pos[1] + 1]
    end
    side_att_pos.select do |att_pos|
      att_pos[0].between?(0, 7) && att_pos[1].between?(0, 7) &&
      @board[att_pos].color != @color &&
      !@board[att_pos].is_a?(NullPiece)
    end
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
  end

  def symbol
    "_"
  end

  def moves
    []
  end
end
