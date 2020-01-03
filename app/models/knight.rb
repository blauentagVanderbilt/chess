class Knight < Piece

  def valid_move?(x_distance, y_distance)
    x_distance = (x_position - x_destination).abs
    y_distance = (y_position - y_destination).abs

    (x_distance == 2 && y_distance == 1) || (x_distance == 1 && y_distance == 2)
  end

  def default_pic
    self.picture = 'whiteknight.png' if color == 'white'
    self.picture = 'blackknight.png' if color == 'black'

  end
end