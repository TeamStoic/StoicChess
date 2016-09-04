require 'rails_helper'

RSpec.describe King, type: :model do
  let(:game) { FactoryGirl.create(:game, :populated) }
  let(:empty_game) { FactoryGirl.create(:game) }
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
      expect(moved_king.move!(3, 4)).to eq true
      expect(moved_king.x_position).to eq 3
      expect(moved_king.y_position).to eq 4
      expect(moved_king.moved).to eq true
    end
  end

  describe 'check_state' do
    let(:empty_white_king) do
      empty_game.pieces.create(
        type: 'King',
        color: 'white',
        x_position: 3,
        y_position: 3,
        moved: true
      )
    end

    let(:black_queen) do
      empty_game.pieces.create(
        type: 'Queen',
        color: 'black',
        x_position: 2,
        y_position: 6,
        moved: true
      )
    end

    it 'should return true if new coords are in vertical enemy attack line' do
      expect(black_queen.move!(2, 5)).to eq true
      expect(empty_white_king.move!(2, 3)).to eq false
      expect(
        empty_white_king.check_state(2, 3, empty_white_king.color)
      ).to eq true
    end
    it 'should return true if new coords are in diagonal enemy attack line' do
      expect(black_queen.move!(2, 5)).to eq true
      expect(empty_white_king.move!(4, 3)).to eq false
      expect(
        empty_white_king.check_state(4, 3, empty_white_king.color)
      ).to eq true
    end
  end

  describe 'castling' do
    let(:white_castling_king) do
      empty_game.pieces.create(
        type: 'King',
        color: 'white',
        x_position: 4,
        y_position: 7
      )
    end
    let(:white_castling_rook) do
      empty_game.pieces.create(
        type: 'Rook',
        color: 'white',
        x_position: 7,
        y_position: 7
      )
    end
    let(:white_obstruction) do
      empty_game.pieces.create(
        type: 'Bishop',
        color: 'white',
        x_position: 1,
        y_position: 7
      )
    end
    let(:white_obstructed_rook) do
      empty_game.pieces.create(
        type: 'Rook',
        color: 'white',
        x_position: 0,
        y_position: 7
      )
    end

    let(:black_castling_king) do
      empty_game.pieces.create(
        type: 'King',
        color: 'black',
        x_position: 4,
        y_position: 0
      )
    end
    let(:black_castling_rook) do
      empty_game.pieces.create(
        type: 'Rook',
        color: 'black',
        x_position: 7,
        y_position: 0
      )
    end
    let(:black_obstruction) do
      empty_game.pieces.create(
        type: 'Bishop',
        color: 'black',
        x_position: 1,
        y_position: 0
      )
    end
    let(:black_obstructed_rook) do
      empty_game.pieces.create(
        type: 'Rook',
        color: 'black',
        x_position: 0,
        y_position: 0
      )
    end

    it 'should return true on valid white king-side castling' do
      white_castling_rook.save
      expect(white_castling_king.move!(6, 7)).to eq true
      expect(white_castling_king.x_position).to eq 6
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq true
      white_castling_rook.reload
      expect(white_castling_rook.x_position).to eq 5
      expect(white_castling_rook.y_position).to eq 7
      expect(white_castling_rook.moved).to eq true
    end

    it 'should return true on valid black king-side castling' do
      black_castling_rook.save
      expect(black_castling_king.move!(6, 0)).to eq true
      expect(black_castling_king.x_position).to eq 6
      expect(black_castling_king.y_position).to eq 0
      expect(black_castling_king.moved).to eq true
      black_castling_rook.reload
      expect(black_castling_rook.x_position).to eq 5
      expect(black_castling_rook.y_position).to eq 0
      expect(black_castling_rook.moved).to eq true
    end

    it 'should return false on obstructed white queen-side castling' do
      white_obstructed_rook.save
      white_obstruction.save
      expect(white_castling_king.move!(2, 7)).to eq false
      expect(white_castling_king.x_position).to eq 4
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq false
      expect(white_obstructed_rook.x_position).to eq 0
      expect(white_obstructed_rook.y_position).to eq 7
      expect(white_obstructed_rook.moved).to eq false
    end

    it 'should return false on obstructed black queen-side castling' do
      black_obstructed_rook.save
      black_obstruction.save
      expect(black_castling_king.move!(2, 0)).to eq false
      expect(black_castling_king.x_position).to eq 4
      expect(black_castling_king.y_position).to eq 0
      expect(black_castling_king.moved).to eq false
      expect(black_obstructed_rook.x_position).to eq 0
      expect(black_obstructed_rook.y_position).to eq 0
      expect(black_obstructed_rook.moved).to eq false
    end

    it 'should return false on castling when rook moved' do
      white_castling_rook.update(moved: true)
      expect(white_castling_king.move!(6, 7)).to eq false
      expect(white_castling_king.x_position).to eq 4
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq false
      expect(white_castling_rook.x_position).to eq 7
      expect(white_castling_rook.y_position).to eq 7
      expect(white_castling_rook.moved).to eq true
    end
  end
end
