class PiecesController < ApplicationController
  before_action :find_piece, :verify_player_turn, :veritfy_valid_move

  def update
    @game = @piece.game
    @piece.update_attributes(piece_params.merge(move_number: @piece.move_number + 1))
    switch_turns
    render json: {}, status: 200
  end

end
