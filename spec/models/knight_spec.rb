require 'rails_helper'

RSpec.describe Knight, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }
  let(:knight) { test_game.white.knights.last }

  describe 'creation' do
    it 'should create a white knight' do
      knight = FactoryGirl.create(:knight, color: 'white')
      expect(knight.type).to eq('Knight')
    end

    it 'should fail to create a red knight' do
      expect { FactoryGirl.create(:knight, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(knight.move!(6, 7)).to eq false
      expect(knight.x_position).to eq 6
      expect(knight.y_position).to eq 7
      expect(knight.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(6, 3)).to eq false
      expect(knight.x_position).to eq 3
      expect(knight.y_position).to eq 3
      expect(knight.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(3, 4)).to eq false
      expect(knight.x_position).to eq 3
      expect(knight.y_position).to eq 3
      expect(knight.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(0, 5)).to eq false
      expect(knight.x_position).to eq 3
      expect(knight.y_position).to eq 3
      expect(knight.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(5, 4)).to eq true
      expect(knight.x_position).to eq 5
      expect(knight.y_position).to eq 4
      expect(knight.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(1, 4)).to eq true
      expect(knight.x_position).to eq 1
      expect(knight.y_position).to eq 4
      expect(knight.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      knight.update(x_position: 3, y_position: 3, moved: true)
      expect(knight.move!(4, 5)).to eq true
      expect(knight.x_position).to eq 4
      expect(knight.y_position).to eq 5
      expect(knight.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(knight.move!(5, 5)).to eq true
      expect(knight.x_position).to eq 5
      expect(knight.y_position).to eq 5
      expect(knight.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(knight.move!(7, 5)).to eq true
      expect(knight.x_position).to eq 7
      expect(knight.y_position).to eq 5
      expect(knight.moved).to eq true
    end
  end
end
