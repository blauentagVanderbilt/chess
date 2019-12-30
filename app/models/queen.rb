class Queen < Piece

<<<<<<< HEAD
  def valid_move?(x_destination, y_destination)
      ((x_coordinates == x_destination || y_coordinates == y_destination) ||
      ((x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs)) &&
      is_obstructed?([x_destination, y_destination])
    end
end

=======
  def valid_move?(x, y)
  end

  def default_pic
    self.picture = 'whitequeen.png' if color == 'white'
    self.picture = 'blackqueen.png' if color == 'black'
  end
end
>>>>>>> 18ac0e65279ec3769559af2ccf87f3cef1475ea9
