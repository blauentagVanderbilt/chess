class Piece < ApplicationRecord
  enum color: %i[black white]
  belongs_to :game
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

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

  def x_distance(new_x_position)
    (new_x_position - x_position).abs
  end

  def y_distance(new_y_position)
    (new_y_position - y_position).abs
  end


end


