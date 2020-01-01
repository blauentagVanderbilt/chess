class Bishop < Piece

  def valid_move?(new_x_position, new_y_position)
    if is_obstructed?(new_x_position, new_y_position)
      return false
    else
      x_distance = x_distance(new_x_position)
      y_distance = y_distance(new_y_position)
      return x_distance == y_distance
    end
  end

  def default_pic
    self.picture = 'whitebishop.png' if color == 'white'
    self.picture = 'blackbishop.png' if color == 'black'
  end
end