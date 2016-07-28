require 'rails_helper'

RSpec.describe Game, type: :model do
  g = FactoryGirl.create(:game)
  describe 'populate the board' do
    it 'should give us 32 pieces upon board population' do
      expect(g.pieces.count).to eq 32
    end
    it 'should give me the last x position of population' do
      expect(g.pieces.last.x_position).to eq 7
    end
    it 'should give me the last y position of population' do
      expect(g.pieces.last.y_position).to eq 7
    end
    it 'should give me the last piece of the population as the King' do
      expect(g.pieces.last.type).to eq 'Rook'
    end
    it 'should give me the last pieces color' do
      expect(g.pieces.last.color).to eq 'white'
    end
  end
end
