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

end
