# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.all
  end

  def create
    @game = Game.create
    @game.white.update(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def join
    @game = Game.find(params[:id])
    @game.black.update(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @player = Player.find_by(user_id: current_user.id, game_id: @game.id)
  end
end
