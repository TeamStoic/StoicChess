# Handles all AJAX requests coming from active games to update pieces.
class PiecesController < ApplicationController
  respond_to :json

  def move
    @piece = Piece.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    @piece.move!(x, y)
  end

  def valid_moves
    @piece = Piece.find(params[:id])
    render json: @piece.generate_valid_moves
  end

  def refresh
    @game = Game.find(params[:id])
    @player = Player.find_by(game_id: @game.id, user_id: current_user.id)
    render partial: 'game'
  end

  # def refreshboard
  #   @game = Game.find(params[:id])
  #   @player = Player.find_by(game_id: @game.id, user_id: current_user.id)
  #   render partial: 'chessboard'
  # end
end
