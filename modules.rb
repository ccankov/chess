module SlidingPiece
  def moves
    moves = []
    move_dirs.each do |move_dir|
      dx, dy = move_dir
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end
    moves
  end

  private

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

  def horizontal_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

  def diagonal_dirs
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    directional_moves = []
    current_pos = @pos.dup
    while current_pos[0].between?(0, 7) && current_pos[1].between?(0, 7)
      directional_moves << current_pos.dup unless current_pos == @pos
      unless @board[current_pos].is_a?(NullPiece) || current_pos == @pos
        break
      end
      current_pos[0] += dx
      current_pos[1] += dy
    end
    directional_moves
  end
end

module SteppingPiece
  def moves
    moves = []
    move_diffs.each do |move_diff|
      moves << [@pos[0] + move_diff[0], @pos[1] + move_diff[1]]
    end
    moves
  end


  private

  def move_diffs
    [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2],
     [-1, -2]]
  end
end
