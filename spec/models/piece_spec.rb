require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:game) { FactoryGirl.create(:game) }
  let(:victim) do
    game.pieces.create(
      type: 'Queen',
      color: 'white',
      x_position: 3,
      y_position: 5
    )
  end
  let(:blk_queen) do
    game.pieces.create(
      type: 'Queen',
      color: 'black',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end
  let(:wht_king) do
    game.pieces.create(
      type: 'King',
      color: 'white',
      x_position: 6,
      y_position: 3,
      moved: true
    )
  end
  let(:wht_pawn) do
    game.pieces.create(
      type: 'Rook',
      color: 'white',
      x_position: 5,
      y_position: 3,
      moved: true
    )
  end

  describe 'move with capture' do
    it 'should return true on move against a hostile piece' do
      expect(victim.x_position).to eq 3
      expect(victim.y_position).to eq 5
      expect(blk_queen.move!(3, 5)).to eq true
      victim.reload
      expect(victim.x_position).to eq nil
      expect(victim.y_position).to eq nil
      expect(victim.captured).to eq true
    end

    it 'should return false on a move against a friendly piece' do
      expect(wht_pawn.x_position).to eq 5
      expect(wht_pawn.y_position).to eq 3
      expect(wht_king.move!(5, 3)).to eq false
      expect(wht_pawn.captured).to eq false
    end
  end
  describe 'move that opens check' do
    it 'should return false if pawn is opening a King for check' do
      expect(blk_queen.x_position).to eq 3
      expect(blk_queen.y_position).to eq 3
      expect(wht_king.x_position).to eq 6
      expect(wht_king.y_position).to eq 3
      expect(wht_pawn.x_position).to eq 5
      expect(wht_pawn.y_position).to eq 3
      expect(wht_pawn.move!(5, 2)).to eq false
      expect(wht_pawn.x_position).to eq 5
      expect(wht_pawn.y_position).to eq 3
      expect(game.check?(wht_king.color)).to eq false
    end
  end
end
