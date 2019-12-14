class Game < ApplicationRecord
  belongs_to :black_player, class_name: 'User', foreign_key: 'black_player_id', optional: true
  belongs_to :white_player, class_name: 'User', foreign_key: 'white_player_id', optional: true
  has_many :pieces


  def contains_piece?(x_position, y_position)
    if pieces.where("(x_position = ? AND y_position = ?)", x_position, y_position).any?
      return true
    else
      return false
    end
  end
end
