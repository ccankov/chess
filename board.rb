require_relative 'piece.rb'
require 'byebug'

class Board

  attr_reader :grid


  def initialize(grid = make_starting_grid)
    @grid = grid
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
    empty_grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    new_board = Board.new(empty_grid)    
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        pos = [row_idx, col_idx]
        if piece.is_a?(NullPiece)
          new_board[pos] = piece
        else
          new_board[pos] = piece.class.new(piece.pos.dup, new_board, piece.color)
        end
      end
    end
    new_board
  end

  def move_piece(color, start_pos, to_pos)
    piece = self[start_pos]
    raise "Invalid move" unless piece.valid_moves.include?(to_pos)
    self[to_pos] = piece
    self[start_pos] = NullPiece.instance
    piece.pos = to_pos
  end

  def checkmate?
    return false unless in_check?(:white) || in_check?(:black)
    check_color = in_check?(:white) ? :white : :black
    player_pieces = @grid.flatten.find_all do |piece|
      piece.color == check_color
    end
    player_pieces.all? { |piece| piece.valid_moves == [] }
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    threatening_piece = @grid.flatten.find do |piece|
      !piece.is_a?(NullPiece) && piece.color != color &&
        piece.moves.include?(king_pos)
    end
    !threatening_piece.nil?
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
    @grid.flatten.find do |piece|
      piece.is_a?(King) && piece.color == color
    end
  end
end
