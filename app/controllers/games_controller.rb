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
    # ADD AUTHENTICATION FOR CORRECT USERS
  end

  def update
    @game = Game.find(params[:id])
    @piece = @game.pieces.find(params[:piece_id])
    x = params[:x_position].to_i
    y = params[:y_position].to_i
    @piece.move!(x, y)
    # MOVE TO PIECES CONTROLLER???
  end
end
