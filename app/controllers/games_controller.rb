# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
  end

  def create
    @game = Game.create
    @game.white.update(user_id: current_user.id)
    @game.populate!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @piece_positions = Game.find(params[:id]).pieces
    if @game.in_check?('black')
      flash[:black_check] = 'Black King is under the Check!'
    elsif @game.in_check?('white')
      flash[:white_check] = 'White King is under the Check!'
    end
  end

  def update
    @game = Game.find(params[:id])
    @piece = @game.pieces.find(params[:piece_id])
    x = params[:x_position].to_i
    y = params[:y_position].to_i
    @piece.move!(x, y)
  end

  def join
    @game = Game.find(params[:id])
    @game.black.update(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game)
  end
end
