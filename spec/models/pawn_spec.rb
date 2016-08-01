require 'rails_helper'
require 'pry'
RSpec.describe Pawn, type: :model do
  let(:game) { FactoryGirl.create(:game) }
  let(:pawn) do
    game.pieces.find_by(
    type: 'Pawn',
    color: 'white',
    x_position: 5,
    y_position: 6
    )
  end
  let(:moved_pawn) do
    game.pieces.create(
    type: 'Pawn',
    color: 'white',
    x_position: 3,
    y_position: 4,
    moved: true
    )
  end

  describe 'creation' do
    it 'should create a white pawn' do
      pawn = FactoryGirl.create(:pawn, color: 'white')

      expect(pawn.type).to eq('Pawn')
    end

    it 'should fail to create a red pawn' do
      expect { FactoryGirl.create(:pawn, color: 'red') }.to\
      raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(pawn.move!(5, 6)).to eq false
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 6
      expect(pawn.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      expect(moved_pawn.move!(3, 2)).to eq false
      expect(moved_pawn.x_position).to eq 3
      expect(moved_pawn.y_position).to eq 4
      expect(moved_pawn.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_pawn.move!(2, 3)).to eq false
      expect(moved_pawn.x_position).to eq 3
      expect(moved_pawn.y_position).to eq 4
      expect(moved_pawn.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      expect(moved_pawn.move!(3, 5)).to eq false
      expect(moved_pawn.x_position).to eq 3
      expect(moved_pawn.y_position).to eq 4
      expect(moved_pawn.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      expect(moved_pawn.move!(3, 3)).to eq true
      expect(moved_pawn.x_position).to eq 3
      expect(moved_pawn.y_position).to eq 3
      expect(moved_pawn.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(pawn.move!(5, 5)).to eq true
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 5
      expect(pawn.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      expect(pawn.move!(5, 4)).to eq true
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 4
      expect(pawn.moved).to eq true
    end
  end

  describe 'obstructed move' do
    it 'should return false and not update position on obstructed move' do
      game.pieces.create(
      type: 'Rook',
      color: 'white',
      x_position: 5,
      y_position: 5
      )

      expect(pawn.move!(5, 4)).to eq false
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 6
      expect(pawn.moved).to eq false
    end

    it 'should return false and not update position on obstructed move' do
      game.pieces.create(
      type: 'Rook',
      color: 'white',
      x_position: 5,
      y_position: 5
      )

      expect(pawn.move!(5, 5)).to eq false
      expect(pawn.x_position).to eq 5
      expect(pawn.y_position).to eq 6
      expect(pawn.moved).to eq false
    end
  end

  describe "en_passant?" do
    it 'should return false if no piece is found adjacent to the piece' do
      expect(pawn.en_passant?(3, 4)).to eq false
    end

    it 'should return true if opponent pawn did not move 2 space in last turn' do
      white_pawn = game.pieces.find_by(
        type: 'Pawn',
        color: 'white',
        x_position: 7,
        y_position: 6
      )

      black_pawn = game.pieces.create(
        type: 'Pawn',
        color: 'black',
        x_position: 6,
        y_position: 4
      )

      white_pawn.move!(7,4)
      binding.pry
      expect(black_pawn.en_passant?(7,4)).to eq true
    end
  end
end
