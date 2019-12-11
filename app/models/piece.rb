class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user



  def x_distance(new_x_position)
    (new_x_position - x_position).abs
  end

  def y_distance(new_y_position)
    (new_y_position - y_position).abs
  end





end
