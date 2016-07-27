require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:game) { FactoryGirl.create(:game) }
  let(:queen) do
    game.pieces.find_by(
      type: 'Queen',
      color: 'white',
      x_position: 4,
      y_position: 7
    )
  end
  let(:moved_queen) do
    game.pieces.create(
      type: 'Queen',
      color: 'white',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end

  describe 'move with capture' do
    it 'should return true on move and update coordinates of captured piece' do
      victim = game.pieces.find_by(x_position: 3, y_position: 1)
      expect(moved_queen.move!(3, 1)).to eq true
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 1
      expect(moved_queen.moved).to eq true
      victim.reload
      expect(victim.x_position).to eq nil
      expect(victim.y_position).to eq nil
      expect(victim.captured).to eq true
    end
  end
end
