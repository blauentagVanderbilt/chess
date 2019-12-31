class Pawn < Piece

  def default_pic
    self.picture = 'whitepawn.png' if color == 'white'
    self.picture = 'blackpawn.png' if color == 'black'
  end

  def valid_move?(new_x_position, new_y_position)
    x_distance = x_distance(new_x_position)
    y_distance = y_distance(new_y_position)
#---Opening Move-----#
    if y_position == 2 && color == 'white'
      x_distance == 0 && (new_y_position == 3 || new_y_position == 4)
    elsif y_position == 7 && color == 'black'
      x_distance == 0 && (new_y_position == 6 || new_y_position == 5)
#---Otherwise---#
    else
      if color == 'white'
        (x_distance == 0) && (new_y_position == (y_position + 1))
      elsif color == 'black'
        (x_distance == 0) && (new_y_position == (y_position - 1))
      end
    end
  end
        
  def en_passant?(new_x_position, new_y_position)
    return false unless ((new_y_position == y_position + 1 && color == 'black') || (new_y_position == y_position - 1 && color == 'white')) && ((new_x_position == x_position + 1) || (new_x_position == x_position - 1)) && ((new_y_position == 3 && color == 'white') || (new_y_position == 6 && color == 'black'))
    other_piece = game.pieces.where(y_position: y_position, x_position: new_x_position, type: "Pawn").first
    return false if other_piece.nil? || other_piece.move_number != 1 
    return true
  end

end