require 'rails_helper'

RSpec.describe Piece, type: :model do
      it "should allow a black rook to be created" do
      rook = Piece.create!(type: "rook", color: "black")

      expect(Rook).to eq([rook, black])
    end
end

