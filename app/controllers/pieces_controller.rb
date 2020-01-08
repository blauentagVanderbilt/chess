class PiecesController < ApplicationController
   before_action :authenticate_user!, only: [:update]

   def update
    @piece = Piece.find(params[:id])
      if @piece.valid_move?(params[:x].to_i, params[:y].to_i)
        render json: {success: true}
      elsif
        render json: {success: false}
      else
        @piece.update_attributes(piece_params.merge(move_number: @piece.move_number + 1))
      end
   end

   private

  def verify_two_players
    return if @game.black_player_id && @game.white_player_id
    respond_to do |format|
      format.json {render :json => { message: "Need to wait for player #2!", class: "alert alert-warning"}, status: 422}
    end
  end

  def find_piece
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def switch_turns
    if @game.white_player_id == @game.current_user_id
      @game.update_attributes(turn_user_id:@game.black_player_id)
    else @game.black_player_id == @game.current_user_id
      @game.update_attributes(turn_user_id:@game.white_player_id)
    end
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :color, :id, :type)
  end
      

end
