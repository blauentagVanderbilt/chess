class Piece < ApplicationRecord
  enum color: %i[black white]
  belongs_to :game
  belongs_to :user
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

  def clear_horizontal_move?(x, y)
    return false unless y_distance(y).zero?
    distance = x_distance(x)
    path_clear?(x, y, distance)
  end

  def clear_diagonal_move?(x, y)
    return false unless x_distance(x) == y_distance(y)
    distance = x_distance(x)
    path_clear?(x, y, distance)
  end

  def clear_vertical_move?(x, y)
    return false unless x_distance(x).zero?
    distance = y_distance(y)
    path_clear?(x, y, distance)
  end


  def path_clear?(x, y, distance)
    coordinates = (x, y, distance)
    coordinates.each do |coord|
      return false if game.pieces.exists?(x_position: coord[0],\
                                          y_position: coord[1])
    end
    true
  end
  
  def moved?(x, y)
    x != x_position || y != y_position
  end
end



