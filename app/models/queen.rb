class Queen < Piece

  def valid_move?(x, y)
  end

  def default_pic
    self.picture = 'whitequeen.png' if color == 'White'
    self.picture = 'blackqueen.png' if color == 'Black'
  end
end