class PiecesController < ApplicationController
   before_action :find_piece, :verify_two_players, :verify_player_turn

   def update
    @game = @piece.game
      if @piece.valid_move?(params[:x].to_i, params[:y].to_i)
        render json: {success: true}
      else
        render json: {success: false}
      end
   end

   private

  def verify_two_players
    return if @game.black_player_id && @game.white_player_id
    respond_to do |format|
      format.json {render :json => { message: "Need to wait for player #2!", class: "alert alert-warning"}, status: 422}
    end
  end

  def switch_turns
    if @game.white_player_id == @game.turn_user_id
      @game.update_attributes(turn_user_id:@game.black_player_id)
    elsif @game.black_player_id == @game.turn_user_id
      @game.update_attributes(turn_user_id:@game.white_player_id)
    end
  end

  def find_piece
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def verify_player_turn
    return if correct_turn? && ((@piece.game.white_player_id == current_user.id && @piece.white?) || (@piece.game.black_player_id == current_user.id && piece.black?))
    respond_to do |format|
      format.json {render :json => { message: "Not your turn yet!", class: "alert alert-warning"}, status:422}
    end
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :color, :id, :type)
  end
      
end
