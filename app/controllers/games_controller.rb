class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :join, :forfeit]
  
  

  def index
    @unmatched_games = Game.where(:black_player_id => nil).where.not(:white_player_id => nil).or (Game.where.not(:white_player_id => nil).where(:black_player_id => nil))
    @started_games = Game.where.not(:white_player_id => nil).where.not(:black_player_id => nil).where(:winner_user_id => nil)
    @completed_games = Game.where(:state => "end")
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  def show
    @game = Game.find(params[:id])
  end

  def update

  end

  def join
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @pieces.where(user_id:nil).update_all(user_id: current_user.id)
    
    @game.update_attributes(black_player_id: @game.black_player_id)
      redirect_to game_path(@game)
  end

  def forfeit
    @game = Game.find(params[:id])
    if current_user.id == @game.white_player_id
      @game.update_attributes(winner_user_id: @game.black_player_id)
    else
      @game.update_attributes(winner_user_id: @game.white_player_id)
    end
    redirect_to root_path
  end

  def destroy
    @game = Game.find(params[:id])
    @game.pieces.destroy_all
    @game.destroy
    redirect_to root_path
  end

  private

  def game_params

    params.require(:game).permit(:name).merge(white_player_id: current_user.id)

  end

  def verify_different_user
    @game = Game.find(params[:id])
    if @game.turn_user_id == current_user
      flash[:alert] = "You cannot join your own Game!"
      redirect_to game_path
    end
  end

end
