class Piece < ApplicationRecord
  enum color: %i[black white]
  belongs_to :game
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  def x_distance(new_x_position)
    (new_x_position - x_position).abs
  end

  def y_distance(new_y_position)
    (new_y_position - y_position).abs
  end

  def move_to!(x, y)
    return false unless valid_move?(x, y)
    victim = occupant_piece(x, y)
    if victim
      return false unless enemy?(victim)
      capture!(victim)
    end
    return false if check_state(x, y)
    update(x_position: x, y_position: y)
  end

  def enemy?(victim)
    color != victim.color
  end

  def occupant_piece(x, y)
     game.pieces.find_by(x_position: x, y_position: y)
  end

  def check_state(x, y)
    old_x = x_position
    old_y = y_position
    update(x_position: x, y_position: y)
    result = game.in_check?
    update(x_position: old_x, y_position: old_y)
    result
  end

  def capture!(victim)
    victim.update(x_position: nil, y_position: nil, captured: true)
  end

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
    elsif y_change.abs == 0
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
 
end
      




