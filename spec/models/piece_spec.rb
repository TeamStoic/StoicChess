require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }
  let(:queen) { test_game.white.queen }

  describe 'move with capture' do
    it 'should execute move and capture against a hostile piece' do
      queen.update(x_position: 3, y_position: 3)
      victim = queen.player.enemy.pawns.find_by(x_position: 3)
      expect(queen.move!(3, 1)).to eq true
      expect(queen.x_position).to eq 3
      expect(queen.y_position).to eq 1
      victim.reload
      expect(victim.x_position).to eq nil
      expect(victim.y_position).to eq nil
      expect(victim.captured).to eq true
    end

    it 'should reject move and capture against a friendly piece' do
      queen.update(x_position: 3, y_position: 3)
      victim = queen.player.pawns.find_by(x_position: 3)
      expect(queen.move!(3, 6)).to eq false
      expect(queen.x_position).to eq 3
      expect(queen.y_position).to eq 3
      victim.reload
      expect(victim.x_position).to eq 3
      expect(victim.y_position).to eq 6
      expect(victim.captured).to eq false
    end
  end
end
