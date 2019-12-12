class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  

  def index
    @games = Game.all
    @unmatched_games = Game.where(:white_player_id => nil).where.not(:black_player_id => nil).or (Game.where.not(:white_player_id => nil).where(:black_player_id => nil))
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


  private

  def game_params

    params.require(:game).permit(:name).merge(white_player_id: current_user.id)

  end

end
