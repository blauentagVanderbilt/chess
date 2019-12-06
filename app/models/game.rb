class Game < ApplicationRecord
has_many :pieces

  def contains_piece?(x_coord, y_coord)
    if pieces.where("(x_position = ? AND y_position = ?)", x_position, y_position).any?
      return true
    else
      return false
    end
  end





end
