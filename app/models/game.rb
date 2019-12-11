class Game < ApplicationRecord
  belongs_to :black_player, class_name: 'User', foreign_key: 'black_player_id', optional: true
  belongs_to :white_player, class_name: 'User', foreign_key: 'white_player_id', optional: true
  has_many :pieces

  after_create :populate_board!

  def populate_board!
   Piece.create!(game_id: self.id, type: "King", x_position: 3, y_position: 7, player_id: self.white_player_id, color: "white")
  end

  def contains_piece?(x_position, y_position)
    if pieces.where("(x_position = ? AND y_position = ?)", x_position, y_position).any?
      return true
    else
      return false
      end
    end
  end
end
