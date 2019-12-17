class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :join]
  

  def index
    @games = Game.all
    @unmatched_games = Game.where(:black_player_id => nil).where.not(:white_player_id => nil)
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
     
    @game.update_attributes(game_params)
    @game.white_player_id << current_user.id
      redirect_to game_path(@game)
  end


  private

  def game_params

    params.require(:game).permit(:name).merge(white_player_id: current_user.id)

  end

end
