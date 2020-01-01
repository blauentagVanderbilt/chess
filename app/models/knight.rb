class Knight < Piece

  def default_pic
    self.picture = 'whiteknight.png' if color == 'white'
    self.picture = 'blackknight.png' if color == 'black'
  end
end