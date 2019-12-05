class ChessPiece < ApplicationRecord
  enum color: %i[black white]
end