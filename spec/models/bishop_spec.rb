require 'rails_helper'

RSpec.describe Bishop, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }
  let(:bishop) { test_game.white.bishops.first }

  describe 'creation validation' do
    it 'should create a white bishop' do
      bishop = FactoryGirl.create(:bishop, color: 'white')
      expect(bishop.type).to eq('Bishop')
    end

    it 'should fail to create a red bishop' do
      expect { FactoryGirl.create(:bishop, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(bishop.move!(2, 7)).to eq false
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 7
      expect(bishop.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(6, 3)).to eq false
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 3
      expect(bishop.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(0, 4)).to eq false
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 3
      expect(bishop.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(6, 5)).to eq false
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 3
      expect(bishop.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(5, 5)).to eq true
      expect(bishop.x_position).to eq 5
      expect(bishop.y_position).to eq 5
      expect(bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(2, 2)).to eq true
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 2
      expect(bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(5, 5)).to eq true
      expect(bishop.x_position).to eq 5
      expect(bishop.y_position).to eq 5
      expect(bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(2, 4)).to eq true
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 4
      expect(bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(4, 2)).to eq true
      expect(bishop.x_position).to eq 4
      expect(bishop.y_position).to eq 2
      expect(bishop.moved).to eq true
    end
  end

  describe 'obstructed move' do
    it 'should return false and not update position on obstructed move' do
      expect(bishop.move!(4, 5)).to eq false
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 7
      expect(bishop.moved).to eq false
    end

    it 'should return false and not update position on obstructed move' do
      expect(bishop.move!(6, 3)).to eq false
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 7
      expect(bishop.moved).to eq false
    end

    it 'should return false and not update position on obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(5, 0)).to eq false
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 3
      expect(bishop.moved).to eq true
    end

    it 'should return false and not update position on obstructed move' do
      bishop.update(x_position: 3, y_position: 3, moved: true)
      expect(bishop.move!(6, 7)).to eq false
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 3
      expect(bishop.moved).to eq true
    end
  end
end
