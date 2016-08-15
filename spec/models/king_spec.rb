require 'rails_helper'

RSpec.describe King, type: :model do
  let(:game) { FactoryGirl.create(:game, :populated) }
  let(:empty_game) { FactoryGirl.create(:game, color: 'black', turn: 2) }
  let(:king) do
    game.pieces.find_by(
      type: 'King',
      color: 'white',
      x_position: 4,
      y_position: 7
    )
  end
  let(:moved_king) do
    game.pieces.create(
      type: 'King',
      color: 'white',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end
  let(:blk_queen) do
    empty_game.pieces.create(
      type: 'Queen',
      color: 'black',
      x_position: 2,
      y_position: 6,
      moved: true
    )
  end
  let(:wht_king) do
    empty_game.pieces.create(
      type: 'King',
      color: 'white',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end

  describe 'creation' do
    it 'should create a white king' do
      king = FactoryGirl.create(:king, color: 'white')

      expect(king.type).to eq('King')
    end

    it 'should fail to create a red king' do
      expect { FactoryGirl.create(:king, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(king.move!(4, 7)).to eq false
      expect(king.x_position).to eq 4
      expect(king.y_position).to eq 7
      expect(king.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      expect(moved_king.move!(1, 4)).to eq false
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 3
      expect(moved_king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_king.move!(7, 3)).to eq false
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 3
      expect(moved_king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_king.move!(5, 5)).to eq false
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 3
      expect(moved_king.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      expect(moved_king.move!(3, 4)).to eq true
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 4
      expect(moved_king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_king.move!(2, 4)).to eq true
      expect(moved_king.x_position).to eq 2
      expect(moved_king.y_position).to eq 4
      expect(moved_king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_king.move!(4, 4)).to eq true
      expect(moved_king.x_position).to eq 4
      expect(moved_king.y_position).to eq 4
      expect(moved_king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(moved_king.move!(3, 4)).to eq true
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 4
      expect(moved_king.moved).to eq true
    end
  end

  describe 'checked_cell?' do
    it 'should return true if new coords are in vertical enemy attack line' do
      expect(blk_queen.move!(2, 5)).to eq true
      expect(wht_king.move!(2, 3)).to eq false
      expect(wht_king.checked_cell?(2, 3)).to eq true
    end
    it 'should return true if new coords are in diagonal enemy attack line' do
      expect(blk_queen.move!(2, 5)).to eq true
      expect(wht_king.move!(4, 3)).to eq false
      expect(wht_king.checked_cell?(4, 3)).to eq true
    end
  end
end
