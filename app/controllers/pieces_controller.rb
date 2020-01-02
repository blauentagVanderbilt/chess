class PiecesController < ApplicationController
   before_action :authenticate_user!, only: [:update]

   def update
    @piece = Piece.find(params[:id])
      if @piece.valid_move?(params[:x].to_i, params[:y].to_i)
        render json: {success: true}
      else
        render json: {success: false}
      end
   end
end
