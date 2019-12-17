class Queen < Piece

  def valid_move?(x, y)
  end

  def default_pic
    self.picture = 'whitequeen.png' if color == 'white'
    self.picture = 'blackqueen.png' if color == 'black'
  end
end