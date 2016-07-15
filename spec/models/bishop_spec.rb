require 'rails_helper'

RSpec.describe Bishop, type: :model do

  describe "white bishop movement validation" do

    it "should return false if the bishop is not being moved from its original location" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(2,7)).to eq false
    end

    it "should return false if the bishop is moved 2 spaces to the left" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(0,7)).to eq false
    end

    it "should return false if the bishop is moved forwards one space" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(2,6)).to eq false
    end

    it "should return true if the bishop 3 spaces diagonally forward and to the right" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(5,4)).to eq true
    end

    it "should return true if the bishop 2 spaces diagonally forward and to the left" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.valid_move?(0,5)).to eq true
    end

  end

  describe "black bishop movement validation" do

    it "should return false if the bishop is not being moved from its original location" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(2,0)).to eq false
    end

    it "should return false if the bishop is moved 2 spaces to the right" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(4,0)).to eq false
    end

    it "should return false if the bishop is moved forwards one space" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(2,1)).to eq false
    end

    it "should return true if the bishop 3 spaces diagonally forward and to the right" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(5,3)).to eq true
    end

    it "should return true if the bishop 2 spaces diagonally forward and to the left" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.valid_move?(0,2)).to eq true
    end
  end

  describe "bishop creation validation" do

    it "should have a type of Bishop" do
      r = FactoryGirl.create(:bishop, color: 'white')
      expect(r.type).to eq("Bishop")
    end

    it "should not be allowed to create a red bishop" do
      expect { FactoryGirl.create(:bishop, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "bishop move method" do

    it "should return 'valid' and update the bishop's position when it makes a valid move" do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.move(3,6)).to eq "valid"
      expect(bishop.x_position).to eq 3
      expect(bishop.y_position).to eq 6
    end

    it "should return nil and not update the bishop's position when it makes an invalid move" do
      bishop = FactoryGirl.create(:bishop, :black)
      expect(bishop.move(3,0)).to eq nil
      expect(bishop.x_position).to eq 2
      expect(bishop.y_position).to eq 0
    end

  end

end
