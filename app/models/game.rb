class Game < ApplicationRecord
has_many :users
has_many :pieces
end
