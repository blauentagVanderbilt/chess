class Piece < ApplicationRecord
belongs_to :game
belongs_to :user
end

def contains_own_piece?(x_end, y_end)
  piece = game.pieces.where("x_position = ? AND y_position = ?", x_end, y_end).first
  piece.present? && piece.white? == white?
end

def is_obstructed(x_end, y_end)
  y_change = y_position - y_end
  x_change = x_position - x_end

  obstruction_array = []
    if x_change.abs == 0
      y_change.abs.times do |i|
        obstruction_array << [x_position, y_position - (y_change/y_change.abs) * (i + 1)]
      end
    elseif y_change.abs == 0
      x_change.abs.times do |i|
        obstruction_array << [x_position - (x_change/x_change.abs) * (i + 1), y_position]
      end
    elsif y_change.abs == x_change.abs
      y_change.abs.times do |i|
        obstruction_array << [x_position - (x_change/x_change.abs) * (i +1), y_position - (y_change/y_change.abs) * (i + 1)]
      end
    end

    contains_own_piece?(x_end, y_end) && obstruction_array.any?{|square| game.contains_piece?(square[1]) == true}

end
      


