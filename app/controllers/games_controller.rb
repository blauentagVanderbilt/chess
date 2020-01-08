class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :join, :forfeit]
  

  def index
    @games = Game.all
    @unmatched_games = Game.where(:black_player_id => nil).where.not(:white_player_id => nil)
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
    @game = Game.find(params[:id])
    if @game.white_player_id == current_user.id
      flash[:alert] = "You cannot play against yourself!"
      redirect_to root_path
    else
      @game.update_attributes(:black_player_id => current_user.id)
      redirect_to game_path(@game)
    end
  end

  def join
    @game = Game.find(params[:id])
    
     
    @game.update_attributes(:black_player_id => current_user.id)
    
      redirect_to game_path(@game)
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to root_path
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  private

  def game_params

    params.require(:game).permit(:name).merge(white_player_id: current_user.id)

  end

end
