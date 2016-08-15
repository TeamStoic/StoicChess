require 'rails_helper'
RSpec.describe Bishop, type: :model do
  let(:game) { FactoryGirl.create(:game, :populated) }
  let(:bishop) do
    game.pieces.find_by(
      type: 'Bishop',
      color: 'white',
      x_position: 2,
      y_position: 7
    )
  end
  let(:moved_bishop) do
    game.pieces.create(
      type: 'Bishop',
      color: 'white',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end

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
      expect(moved_bishop.move!(6, 3)).to eq false
      expect(moved_bishop.x_position).to eq 3
      expect(moved_bishop.y_position).to eq 3
      expect(moved_bishop.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_bishop.move!(0, 4)).to eq false
      expect(moved_bishop.x_position).to eq 3
      expect(moved_bishop.y_position).to eq 3
      expect(moved_bishop.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_bishop.move!(6, 5)).to eq false
      expect(moved_bishop.x_position).to eq 3
      expect(moved_bishop.y_position).to eq 3
      expect(moved_bishop.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(5, 5)).to eq true
      expect(moved_bishop.x_position).to eq 5
      expect(moved_bishop.y_position).to eq 5
      expect(moved_bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(2, 2)).to eq true
      expect(moved_bishop.x_position).to eq 2
      expect(moved_bishop.y_position).to eq 2
      expect(moved_bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(5, 5)).to eq true
      expect(moved_bishop.x_position).to eq 5
      expect(moved_bishop.y_position).to eq 5
      expect(moved_bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(2, 4)).to eq true
      expect(moved_bishop.x_position).to eq 2
      expect(moved_bishop.y_position).to eq 4
      expect(moved_bishop.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_bishop.move!(4, 2)).to eq true
      expect(moved_bishop.x_position).to eq 4
      expect(moved_bishop.y_position).to eq 2
      expect(moved_bishop.moved).to eq true
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
      expect(moved_bishop.move!(5, 0)).to eq false
      expect(moved_bishop.x_position).to eq 3
      expect(moved_bishop.y_position).to eq 3
      expect(moved_bishop.moved).to eq true
    end

    it 'should return false and not update position on obstructed move' do
      expect(moved_bishop.move!(6, 7)).to eq false
      expect(moved_bishop.x_position).to eq 3
      expect(moved_bishop.y_position).to eq 3
      expect(moved_bishop.moved).to eq true
    end
  end
end
