class King < Piece
  def valid_move?(new_x_position, new_y_position)
    x_distance = x_distance(new_x_position)
    y_distance = y_distance(new_y_position)

    x_distance == 1 || y_distance == 1
  end
end


