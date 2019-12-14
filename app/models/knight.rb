class Knight < Piece
  def valid_move?(x_move, y_move)
    x_move = (x_position - x_move).abs
    y_move = (y_position - y_move).abs

    (x_distance == 2 && y_distance == 1) || (x_distance == 1 && y_distance == 2)
  end
end