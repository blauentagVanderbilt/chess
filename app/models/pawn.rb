class Pawn < Piece

   def default_pic
    self.picture = 'whitepawn.png' if color == 'White'
    self.picture = 'blackpawn.png' if color == 'Black'
  end
end