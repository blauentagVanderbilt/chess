class Game < ApplicationRecord
  has_many :pieces
  belongs_to :black_player, class_name: 'User', foreign_key: 'black_player_id', optional: true 
  belongs_to :white_player, class_name: 'User', foreign_key: 'white_player_id', optional: true

  after_create :populate_board!

  def populate_board!

    #white Pieces
    (0..7).each do |i|
      Piece.create!(game_id: self.id, type: "Pawn", x_position: i, y_position: 6, user_id: self.white_player_id, color: "white")
    end
   Piece.create!(game_id: self.id, type: "King", x_position: 3, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Queen", x_position: 4, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Rook", x_position: 0, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Rook", x_position: 7, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Knight", x_position: 1, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Knight", x_position: 6, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Bishop", x_position: 2, y_position: 7, user_id: self.white_player_id, color: "white")
   Piece.create!(game_id: self.id, type: "Bishop", x_position: 5, y_position: 7, user_id: self.white_player_id, color: "white")
    #Black Pieces
    (0..7).each do |i|
      Piece.create!(game_id: self.id, type: "Pawn", x_position: i, y_position: 1, user_id: self.black_player_id, color: "black")
    end
   Piece.create!(game_id: self.id, type: "King", x_position: 3, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Queen", x_position: 4, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Rook", x_position: 0, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Rook", x_position: 7, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Knight", x_position: 1, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Knight", x_position: 6, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Bishop", x_position: 2, y_position: 0, user_id: self.black_player_id, color: "black")
   Piece.create!(game_id: self.id, type: "Bishop", x_position: 5, y_position: 0, user_id: self.black_player_id, color: "black")
  end

  def piece_for_position(x_position, y_position)
    pieces.where("(x_position = ? AND y_position = ?)", x_position, y_position).first
  end

  def contains_piece?(x_position, y_position)
    if pieces.where("(x_position = ? AND y_position = ?)", x_position, y_position).any?
      return true
    else
      return false
    end
  end

  def in_check?(color)
    king = pieces.find_by(type: 'King', color: color)
    opponent_pieces(color).each do |p|
      return true if p.valid_move?(king.x_position, king.y_position)
    end
    false
  end

  def opponent_pieces(color)
    pieces.select { |p| p.color != color && p.captured != true }
  end

  def white_player
    User.find_by_id(white_player_id)
  end

  def black_player
    User.find_by_id(black_player_id)
  end

  def winner
    User.find_by_id(winner_player_id)
  end

  def loser
    User.find_by_id(loser_player_id)
  end
end
