require 'rails_helper'

RSpec.describe King, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }
  let(:white_king) { test_game.white.king }
  let(:black_king) { test_game.black.king }

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
      expect(white_king.move!(4, 7)).to eq false
      expect(white_king.x_position).to eq 4
      expect(white_king.y_position).to eq 7
      expect(white_king.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(1, 4)).to eq false
      expect(white_king.x_position).to eq 3
      expect(white_king.y_position).to eq 3
      expect(white_king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(7, 3)).to eq false
      expect(white_king.x_position).to eq 3
      expect(white_king.y_position).to eq 3
      expect(white_king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(5, 5)).to eq false
      expect(white_king.x_position).to eq 3
      expect(white_king.y_position).to eq 3
      expect(white_king.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(3, 4)).to eq true
      expect(white_king.x_position).to eq 3
      expect(white_king.y_position).to eq 4
      expect(white_king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(2, 4)).to eq true
      expect(white_king.x_position).to eq 2
      expect(white_king.y_position).to eq 4
      expect(white_king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      white_king.update(x_position: 3, y_position: 3, moved: true)
      expect(white_king.move!(3, 4)).to eq true
      expect(white_king.x_position).to eq 3
      expect(white_king.y_position).to eq 4
      expect(white_king.moved).to eq true
    end
  end

  describe 'castling' do
    it 'should return true on valid white king-side castling' do
      test_game.white.bishops.last.destroy
      test_game.white.knights.last.destroy
      castling_rook = test_game.white.rooks.last
      expect(white_king.move!(6, 7)).to eq true
      expect(white_king.x_position).to eq 6
      expect(white_king.y_position).to eq 7
      expect(white_king.moved).to eq true
      castling_rook.reload
      expect(castling_rook.x_position).to eq 5
      expect(castling_rook.y_position).to eq 7
      expect(castling_rook.moved).to eq true
    end

    it 'should return true on valid black king-side castling' do
      test_game.black.bishops.last.destroy
      test_game.black.knights.last.destroy
      castling_rook = test_game.black.rooks.last
      expect(black_king.move!(6, 0)).to eq true
      expect(black_king.x_position).to eq 6
      expect(black_king.y_position).to eq 0
      expect(black_king.moved).to eq true
      castling_rook.reload
      expect(castling_rook.x_position).to eq 5
      expect(castling_rook.y_position).to eq 0
      expect(castling_rook.moved).to eq true
    end

    it 'should return false on obstructed white queen-side castling' do
      castling_rook = test_game.white.rooks.first
      expect(white_king.move!(2, 7)).to eq false
      expect(white_king.x_position).to eq 4
      expect(white_king.y_position).to eq 7
      expect(white_king.moved).to eq false
      castling_rook.reload
      expect(castling_rook.x_position).to eq 0
      expect(castling_rook.y_position).to eq 7
      expect(castling_rook.moved).to eq false
    end

    it 'should return false on obstructed black queen-side castling' do
      castling_rook = test_game.black.rooks.first
      expect(black_king.move!(2, 0)).to eq false
      expect(black_king.x_position).to eq 4
      expect(black_king.y_position).to eq 0
      expect(black_king.moved).to eq false
      castling_rook.reload
      expect(castling_rook.x_position).to eq 0
      expect(castling_rook.y_position).to eq 0
      expect(castling_rook.moved).to eq false
    end

    it 'should return false on castling when rook moved' do
      castling_rook = test_game.white.rooks.last
      castling_rook.update(moved: true)
      expect(white_king.move!(6, 7)).to eq false
      expect(white_king.x_position).to eq 4
      expect(white_king.y_position).to eq 7
      expect(white_king.moved).to eq false
      expect(castling_rook.x_position).to eq 7
      expect(castling_rook.y_position).to eq 7
      expect(castling_rook.moved).to eq true
    end
  end
end
