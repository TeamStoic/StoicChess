require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }

  describe 'game creation and population' do
    it 'should return 32 pieces for a game upon populating' do
      expect(test_game.pieces.count).to eq 32
    end
  end
end
