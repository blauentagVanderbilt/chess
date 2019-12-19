class Pawn < Piece

   def default_pic
    self.picture = 'whitepawn.png' if color == 'white'
    self.picture = 'blackpawn.png' if color == 'black'
  end
end