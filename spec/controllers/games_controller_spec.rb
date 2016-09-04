require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#new' do
    it 'should redirect user to sign_in page if they are not signed_in' do
      process :create, method: :post, game: { turn: nil }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'games#create' do
    it 'should create a new game in the database' do
      process :create, method: :post, game: { turn: nil }
    end
  end

  # describe 'games#update' do
  #   let(:game) { FactoryGirl.create(:game) }
  #
  #   let(:wht_pawn) do
  #     game.pieces.find_by(
  #       type: 'Pawn',
  #       color: 'white',
  #       x_position: 7,
  #       y_position: 6
  #     )
  #   end
  #
  #   let(:blk_knight) do
  #     game.pieces.find_by(
  #       type: 'Knight',
  #       color: 'black',
  #       x_position: 1,
  #       y_position: 0
  #     )
  #   end
  #   it 'should update White Pawn if move coords are valid' do
  #     patch :update, params: { id: game.id, piece_id: wht_pawn.id,\
  #                              x_position: 7, y_position: 5 }
  #
  #     expect(response).to have_http_status(:success)
  #     wht_pawn.reload
  #     expect(wht_pawn.x_position).to eq(7)
  #     expect(wht_pawn.y_position).to eq(5)
  #   end
  #   it 'should update Black Knight if move coords are valid' do
  #     patch :update, params: { id: game.id, piece_id: blk_knight.id,\
  #                              x_position: 0, y_position: 2 }
  #
  #     expect(response).to have_http_status(:success)
  #     blk_knight.reload
  #     expect(blk_knight.x_position).to eq(0)
  #     expect(blk_knight.y_position).to eq(2)
  #   end
  #   it 'should NOT update White Pawn if move coords are invalid' do
  #     patch :update, params: { id: game.id, piece_id: wht_pawn.id,\
  #                              x_position: 6, y_position: 5 }
  #
  #     expect(response).to have_http_status(:success)
  #     wht_pawn.reload
  #     expect(wht_pawn.x_position).to eq(7)
  #     expect(wht_pawn.y_position).to eq(6)
  #   end
  #   it 'should NOT update Black Knight move coords are invalid' do
  #     patch :update, params: { id: game.id, piece_id: blk_knight.id,\
  #                              x_position: 1, y_position: 2 }
  #
  #     expect(response).to have_http_status(:success)
  #     blk_knight.reload
  #     expect(blk_knight.x_position).to eq(1)
  #     expect(blk_knight.y_position).to eq(0)
  #   end
  # end
end
