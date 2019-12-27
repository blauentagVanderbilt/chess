class Pawn < Piece

  def default_pic
    self.picture = 'whitepawn.png' if color == 'white'
    self.picture = 'blackpawn.png' if color == 'black'
  end

  def valid_move?(new_x_position, new_y_position)
    x_distance = x_distance(new_x_position)
    y_distance = y_distance(new_y_position)
#---Opening Move-----#
    if y_position == 2 && white
      x_distance == 0 && (new_y_position == 3 || new_y_position == 4)
    elsif y_position == 7 && black
      x_distance == 0 && (new_y_position == 6 || new_y_position == 5)
#---Otherwise---#
    else
      if white
        (x_distance == 0) && (new_y_position == (y_position + 1))
      elsif black
        (x_distance == 0) && (new_y_position == (y_position - 1))
      end
    end
  end
        

end