require 'rails_helper'

RSpec.describe Rook, type: :model do

  describe "white rook movement validation" do

    it "should return false if the rook is not being moved from its original location" do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(7,7)).to eq false
    end

    it "should return false if the rook is moved 3 spaces diagonally" do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(4,4)).to eq false
    end

    it "should return true if the rook is moved forward 3 spaces" do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(7,4)).to eq true
    end

    it "should return true if the rook is moved three spaces to the left" do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.valid_move?(4,7)).to eq true
    end

  end

  describe "black rook movement validation" do

    it "should return false if the rook is not being moved from its original location" do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(0,0)).to eq false
    end

    it "should return false if the rook is moved 3 spaces diagonally" do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(3,3)).to eq false
    end

    it "should return true if the rook is moved forward 3 spaces" do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(0,3)).to eq true
    end

    it "should return true if the rook is moved three spaces to the right" do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.valid_move?(3,0)).to eq true
    end
  end

  describe "rook creation validation" do
    it "should have a type of Rook" do
      r = FactoryGirl.create(:rook, color: 'white')
      expect(r.type).to eq("Rook")
    end

    it "should not be allowed to create a red rook" do
      expect { FactoryGirl.create(:rook, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "rook move method" do

    it "should return 'valid' and update the rook's position when it makes a valid move" do
      rook = FactoryGirl.create(:rook, :white)
      expect(rook.move(0,7)).to eq "valid"
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 7
    end

    it "should return nil and not update the rook's position when it makes an invalid move" do
      rook = FactoryGirl.create(:rook, :black)
      expect(rook.move(3,7)).to eq nil
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 0
    end

  end

end
